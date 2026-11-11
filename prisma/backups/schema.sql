


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE SCHEMA IF NOT EXISTS "private";


ALTER SCHEMA "private" OWNER TO "postgres";


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "private"."enforce_transaction_note_length"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
BEGIN
  IF TG_OP = 'INSERT' OR NEW.note IS DISTINCT FROM OLD.note THEN
    IF NEW.note IS NOT NULL AND pg_catalog.char_length(NEW.note) > 200 THEN
      RAISE EXCEPTION USING
        ERRCODE = 'P0001',
        MESSAGE = 'transaction_note_too_long';
    END IF;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "private"."enforce_transaction_note_length"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "private"."enforce_transaction_submission_rules"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
DECLARE
  v_now timestamptz;
  v_today date;
  v_last_submitted_at timestamptz;
  v_is_recurring_generation boolean := false;
BEGIN
  v_now := pg_catalog.clock_timestamp();
  v_today := (v_now AT TIME ZONE 'Asia/Jakarta')::date;

  -- Enforce the minimum on inserts and whenever an amount is changed.
  IF NEW.amount IS NULL THEN
    RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_minimum_amount';
  ELSIF (TG_OP = 'INSERT' OR NEW.amount IS DISTINCT FROM OLD.amount) AND NEW.amount < 50 THEN
    RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_minimum_amount';
  END IF;

  IF TG_OP = 'INSERT' THEN
    IF NEW.user_id IS NULL THEN
      RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_user_required';
    END IF;

    -- Only a pending run row created by generate_recurring_transaction can mark
    -- the transaction as a recurring instance. Run rows have no client INSERT policy.
    -- Match owner, month, scheduled day, type, category, amount and payment method.
    SELECT EXISTS (
      SELECT 1
      FROM public.recurring_transaction_runs AS rr
      JOIN public.recurring_transactions AS rt
        ON rt.id = rr.recurring_transaction_id
       AND rt.user_id = rr.user_id
      WHERE rr.user_id = NEW.user_id
        AND rr.transaction_id IS NULL
        AND rr.month = pg_catalog.date_trunc('month', NEW.transaction_date)::date
        AND rt.active = true
        AND NEW.transaction_date = pg_catalog.make_date(
          pg_catalog.date_part('year', rr.month::timestamp)::integer,
          pg_catalog.date_part('month', rr.month::timestamp)::integer,
          LEAST(
            rt.day_of_month,
            pg_catalog.date_part('day', (rr.month + interval '1 month - 1 day'))::integer
          )
        )
        AND NEW.transaction_date <= v_today
        AND NEW.transaction_date >= rt.start_date
        AND (rt.end_date IS NULL OR NEW.transaction_date <= rt.end_date)
        AND NEW.type = rt.type
        AND NEW.category = rt.category
        AND NEW.amount = rt.amount
        AND COALESCE(NEW.payment_method, '') = COALESCE(rt.payment_method, '')
    ) INTO v_is_recurring_generation;

    IF v_is_recurring_generation THEN
      -- Scheduled recurring transactions can legitimately be older than 7 days.
      -- They do not consume the manual-entry 3-second cooldown.
      NEW.created_at := v_now;
      RETURN NEW;
    END IF;

    -- Regular/manual transactions retain the original date-window restriction.
    PERFORM pg_catalog.pg_advisory_xact_lock(
      pg_catalog.hashtextextended(NEW.user_id::text, 0::bigint)
    );

    v_now := pg_catalog.clock_timestamp();
    v_today := (v_now AT TIME ZONE 'Asia/Jakarta')::date;

    IF NEW.transaction_date IS NULL
       OR NEW.transaction_date < v_today - 7
       OR NEW.transaction_date > v_today THEN
      RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_date_out_of_range';
    END IF;

    SELECT limits.last_submitted_at
      INTO v_last_submitted_at
      FROM public.transaction_submission_limits AS limits
     WHERE limits.user_id = NEW.user_id
     FOR UPDATE;

    IF v_last_submitted_at IS NOT NULL
       AND v_last_submitted_at > v_now - INTERVAL '3 seconds' THEN
      RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_cooldown';
    END IF;

    INSERT INTO public.transaction_submission_limits (user_id, last_submitted_at)
    VALUES (NEW.user_id, v_now)
    ON CONFLICT (user_id) DO UPDATE SET last_submitted_at = EXCLUDED.last_submitted_at;

    NEW.created_at := v_now;

  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.user_id IS DISTINCT FROM OLD.user_id THEN
      RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_user_immutable';
    END IF;

    -- A legacy transaction older than seven days can be edited only without changing its date.
    IF OLD.transaction_date < v_today - 7
       AND NEW.transaction_date IS DISTINCT FROM OLD.transaction_date THEN
      RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_legacy_date_immutable';
    END IF;

    IF NEW.transaction_date IS NULL OR NEW.transaction_date > v_today THEN
      RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_date_out_of_range';
    END IF;

    IF NEW.transaction_date IS DISTINCT FROM OLD.transaction_date
       AND NEW.transaction_date < v_today - 7 THEN
      RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'transaction_date_out_of_range';
    END IF;

    NEW.created_at := OLD.created_at;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "private"."enforce_transaction_submission_rules"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "private"."release_recurring_run_on_transaction_delete"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
BEGIN
  DELETE FROM public.recurring_transaction_runs AS rr
   WHERE rr.transaction_id = OLD.id
     AND rr.user_id = OLD.user_id;
  RETURN OLD;
END;
$$;


ALTER FUNCTION "private"."release_recurring_run_on_transaction_delete"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."add_user_category"("p_user_id" "uuid", "p_name" "text", "p_type" "text") RETURNS bigint
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
DECLARE
  v_name text := btrim(p_name);
  v_category_id bigint;
  v_is_default boolean;
  v_old_custom_name text;
  v_old_name text;
  v_old_type text;
  v_is_hidden boolean;
BEGIN
  IF auth.uid() IS DISTINCT FROM p_user_id THEN
    RAISE EXCEPTION 'not_authorized';
  END IF;
  IF v_name IS NULL OR char_length(v_name) < 2 THEN
    RAISE EXCEPTION 'category_name_too_short';
  END IF;
  IF p_type NOT IN ('income', 'expense', 'both') THEN
    RAISE EXCEPTION 'invalid_category_type';
  END IF;

  PERFORM pg_catalog.pg_advisory_xact_lock(pg_catalog.hashtextextended(p_user_id::text, 0));

  IF EXISTS (
    SELECT 1
    FROM public.user_categories AS uc
    JOIN public.category_catalog AS cc ON cc.id = uc.category_id
    WHERE uc.user_id = p_user_id
      AND NOT uc.is_hidden
      AND lower(btrim(COALESCE(uc.custom_name, cc.name))) = lower(v_name)
  ) THEN
    RAISE EXCEPTION 'category_exists' USING ERRCODE = '23505';
  END IF;

  INSERT INTO public.category_catalog (name, is_default, sort_order)
  VALUES (v_name, false, 1000)
  ON CONFLICT (normalized_name) DO UPDATE
    SET name = public.category_catalog.name
  RETURNING id, is_default INTO v_category_id, v_is_default;

  -- A hidden default already has a pivot row. Re-adding its base name restores
  -- that row rather than making a duplicate. If it had been renamed, move this
  -- user's historical text references back to the restored base name atomically.
  SELECT uc.is_hidden, uc.custom_name, uc.type
  INTO v_is_hidden, v_old_custom_name, v_old_type
  FROM public.user_categories AS uc
  WHERE uc.user_id = p_user_id AND uc.category_id = v_category_id
  FOR UPDATE;

  IF FOUND THEN
    IF NOT v_is_hidden THEN
      RAISE EXCEPTION 'category_exists' USING ERRCODE = '23505';
    END IF;

    IF v_is_default AND v_old_custom_name IS NOT NULL
       AND v_old_custom_name <> v_name THEN
      v_old_name := v_old_custom_name;
      UPDATE public.transactions AS t
      SET category = v_name
      WHERE t.user_id = p_user_id
        AND lower(btrim(t.category)) = lower(btrim(v_old_name))
        AND (v_old_type = 'both' OR t.type = v_old_type);

      IF v_old_type IN ('expense', 'both') THEN
        UPDATE public.budgets AS b
        SET category = v_name
        WHERE b.user_id = p_user_id
          AND lower(btrim(b.category)) = lower(btrim(v_old_name));
      END IF;

      UPDATE public.recurring_transactions AS rt
      SET category = v_name
      WHERE rt.user_id = p_user_id
        AND lower(btrim(rt.category)) = lower(btrim(v_old_name))
        AND (v_old_type = 'both' OR rt.type = v_old_type);
    END IF;

    UPDATE public.user_categories AS uc
    SET is_hidden = false,
        custom_name = NULL,
        type = CASE WHEN v_is_default THEN 'both' ELSE p_type END,
        is_default = v_is_default
    WHERE uc.user_id = p_user_id AND uc.category_id = v_category_id;
    RETURN v_category_id;
  END IF;

  INSERT INTO public.user_categories
    (user_id, category_id, type, is_default, is_hidden)
  VALUES
    (p_user_id, v_category_id, CASE WHEN v_is_default THEN 'both' ELSE p_type END, v_is_default, false);

  RETURN v_category_id;
END;
$$;


ALTER FUNCTION "public"."add_user_category"("p_user_id" "uuid", "p_name" "text", "p_type" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."category_default_type"("p_name" "text") RETURNS "text"
    LANGUAGE "sql" IMMUTABLE
    SET "search_path" TO ''
    AS $$
  SELECT CASE pg_catalog.lower(pg_catalog.btrim(p_name))
    WHEN 'gaji' THEN 'income'
    WHEN 'bonus' THEN 'income'
    ELSE 'expense'
  END;
$$;


ALTER FUNCTION "public"."category_default_type"("p_name" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."enforce_text_only_category_name"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $_$
DECLARE
  v_name text;
BEGIN
  IF TG_TABLE_NAME = 'category_catalog' THEN
    -- Installed for INSERT only, so legacy catalogue names with punctuation
    -- are not revalidated during unrelated updates.
    v_name := NEW.name;
  ELSIF TG_TABLE_NAME = 'user_categories' THEN
    IF NEW.custom_name IS NOT NULL THEN
      v_name := NEW.custom_name;
    ELSIF TG_OP = 'UPDATE'
       AND OLD.custom_name IS NOT NULL
       AND NEW.custom_name IS NULL
       -- Re-adding a previously hidden default category should continue to
       -- work even if its original built-in display name contains punctuation.
       AND NOT (OLD.is_hidden AND NOT NEW.is_hidden) THEN
      -- A direct rename from a custom name back to an invalid master name must
      -- not bypass validation by setting custom_name to NULL.
      SELECT cc.name
        INTO v_name
      FROM public.category_catalog AS cc
      WHERE cc.id = NEW.category_id;
      IF NOT FOUND THEN
        RETURN NEW;
      END IF;
    ELSE
      -- NULL means this user's visible name is inherited from a master/default
      -- category and this statement is not changing an explicit custom name.
      RETURN NEW;
    END IF;
  ELSE
    RETURN NEW;
  END IF;

  IF v_name IS NULL
     OR v_name <> pg_catalog.btrim(v_name)
     OR pg_catalog.char_length(pg_catalog.btrim(v_name)) < 2
     OR v_name !~ '^[[:alpha:] ]+$' THEN
    RAISE EXCEPTION 'invalid_category_name'
      USING ERRCODE = '22023',
            DETAIL = 'Category names may contain letters and ordinary spaces only.';
  END IF;

  RETURN NEW;
END;
$_$;


ALTER FUNCTION "public"."enforce_text_only_category_name"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."ensure_user_category_defaults"("p_user_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
BEGIN
  IF auth.uid() IS DISTINCT FROM p_user_id THEN
    RAISE EXCEPTION 'not_authorized';
  END IF;

  INSERT INTO public.user_categories (user_id, category_id, type, is_default, is_hidden)
  SELECT p_user_id, cc.id, 'both', true, false
  FROM public.category_catalog AS cc
  WHERE cc.is_default
  ON CONFLICT (user_id, category_id) DO NOTHING;
END;
$$;


ALTER FUNCTION "public"."ensure_user_category_defaults"("p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_recurring_transaction"("p_recurring_id" bigint, "p_month" "date") RETURNS bigint
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
DECLARE
  r public.recurring_transactions%rowtype;
  v_month date;
  v_last_day integer;
  v_day integer;
  v_target_date date;
  v_run_id bigint;
  v_transaction_id bigint;
  v_note text;
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'Not authenticated';
  END IF;

  v_month := pg_catalog.date_trunc('month', p_month)::date;

  SELECT * INTO r
    FROM public.recurring_transactions
   WHERE id = p_recurring_id
     AND user_id = auth.uid();

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Recurring transaction not found';
  END IF;

  IF NOT r.active THEN
    RETURN NULL;
  END IF;

  v_last_day := pg_catalog.date_part('day', (v_month + interval '1 month - 1 day'))::integer;
  v_day := LEAST(r.day_of_month, v_last_day);
  v_target_date := pg_catalog.make_date(
    pg_catalog.date_part('year', v_month::timestamp)::integer,
    pg_catalog.date_part('month', v_month::timestamp)::integer,
    v_day
  );

  IF v_target_date < r.start_date OR (r.end_date IS NOT NULL AND v_target_date > r.end_date) THEN
    RETURN NULL;
  END IF;

  -- Preserve semantics: only the current/past schedule can generate an entry.
  IF v_target_date > (pg_catalog.clock_timestamp() AT TIME ZONE 'Asia/Jakarta')::date THEN
    RETURN -2;
  END IF;

  INSERT INTO public.recurring_transaction_runs (user_id, recurring_transaction_id, month)
  VALUES (auth.uid(), r.id, v_month)
  ON CONFLICT (recurring_transaction_id, month) DO NOTHING
  RETURNING id INTO v_run_id;

  IF v_run_id IS NULL THEN
    RETURN -1;
  END IF;

  v_note := CASE
    WHEN r.note IS NULL OR pg_catalog.btrim(r.note) = ''
      THEN 'Transaksi berulang: ' || r.name
    ELSE r.note || ' • Transaksi berulang: ' || r.name
  END;
  v_note := pg_catalog.left(v_note, 200);

  INSERT INTO public.transactions (
    user_id, transaction_date, type, category, amount, payment_method, note
  ) VALUES (
    auth.uid(), v_target_date, r.type, r.category, r.amount, r.payment_method, v_note
  ) RETURNING id INTO v_transaction_id;

  UPDATE public.recurring_transaction_runs
     SET transaction_id = v_transaction_id
   WHERE id = v_run_id;

  RETURN v_transaction_id;
END;
$$;


ALTER FUNCTION "public"."generate_recurring_transaction"("p_recurring_id" bigint, "p_month" "date") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin
  insert into public.profiles (id, username)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'username', split_part(new.email, '@', 1))
  )
  on conflict (id) do nothing;

  perform public.seed_default_categories(new.id);
  return new;
end;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."lookup_login_email"("p_username" "text") RETURNS "text"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select au.email
  from auth.users au
  join public.profiles p on p.id = au.id
  where lower(trim(p.username)) = lower(trim(p_username))
  limit 1;
$$;


ALTER FUNCTION "public"."lookup_login_email"("p_username" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."normalize_default_user_category_type"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
DECLARE
  v_master_name text;
BEGIN
  IF NEW.is_default AND NEW.type = 'both' THEN
    SELECT cc.name
    INTO v_master_name
    FROM public.category_catalog AS cc
    WHERE cc.id = NEW.category_id;

    IF FOUND THEN
      NEW.type := public.category_default_type(v_master_name);
    END IF;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."normalize_default_user_category_type"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."remove_user_category"("p_user_id" "uuid", "p_category_id" bigint) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
DECLARE
  v_is_default boolean;
BEGIN
  IF auth.uid() IS DISTINCT FROM p_user_id THEN
    RAISE EXCEPTION 'not_authorized';
  END IF;

  PERFORM pg_catalog.pg_advisory_xact_lock(pg_catalog.hashtextextended(p_user_id::text, 0));

  SELECT uc.is_default INTO v_is_default
  FROM public.user_categories AS uc
  WHERE uc.user_id = p_user_id
    AND uc.category_id = p_category_id
    AND NOT uc.is_hidden
  FOR UPDATE;

  IF NOT FOUND THEN RAISE EXCEPTION 'category_not_found'; END IF;

  IF v_is_default THEN
    UPDATE public.user_categories
    SET is_hidden = true
    WHERE user_id = p_user_id AND category_id = p_category_id;
  ELSE
    DELETE FROM public.user_categories
    WHERE user_id = p_user_id AND category_id = p_category_id;
  END IF;
END;
$$;


ALTER FUNCTION "public"."remove_user_category"("p_user_id" "uuid", "p_category_id" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rename_user_category"("p_user_id" "uuid", "p_category_id" bigint, "p_new_name" "text") RETURNS integer
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
DECLARE
  v_new_name text := btrim(p_new_name);
  v_master_name text;
  v_old_name text;
  v_type text;
  v_updated integer := 0;
  v_expected integer := 0;
BEGIN
  IF auth.uid() IS DISTINCT FROM p_user_id THEN
    RAISE EXCEPTION 'not_authorized';
  END IF;
  IF v_new_name IS NULL OR char_length(v_new_name) < 2 THEN
    RAISE EXCEPTION 'category_name_too_short';
  END IF;

  PERFORM pg_catalog.pg_advisory_xact_lock(pg_catalog.hashtextextended(p_user_id::text, 0));

  SELECT cc.name, COALESCE(uc.custom_name, cc.name), uc.type
  INTO v_master_name, v_old_name, v_type
  FROM public.user_categories AS uc
  JOIN public.category_catalog AS cc ON cc.id = uc.category_id
  WHERE uc.user_id = p_user_id
    AND uc.category_id = p_category_id
    AND NOT uc.is_hidden
  FOR UPDATE OF uc;

  IF NOT FOUND THEN RAISE EXCEPTION 'category_not_found'; END IF;

  IF EXISTS (
    SELECT 1
    FROM public.user_categories AS other_uc
    JOIN public.category_catalog AS other_cc ON other_cc.id = other_uc.category_id
    WHERE other_uc.user_id = p_user_id
      AND other_uc.category_id <> p_category_id
      AND NOT other_uc.is_hidden
      AND lower(btrim(COALESCE(other_uc.custom_name, other_cc.name))) = lower(v_new_name)
  ) THEN
    RAISE EXCEPTION 'category_exists' USING ERRCODE = '23505';
  END IF;

  SELECT count(*)::integer INTO v_expected
  FROM public.transactions AS t
  WHERE t.user_id = p_user_id
    AND lower(btrim(t.category)) = lower(btrim(v_old_name))
    AND (v_type = 'both' OR t.type = v_type);

  UPDATE public.transactions AS t
  SET category = v_new_name
  WHERE t.user_id = p_user_id
    AND lower(btrim(t.category)) = lower(btrim(v_old_name))
    AND (v_type = 'both' OR t.type = v_type);
  GET DIAGNOSTICS v_updated = ROW_COUNT;
  IF v_updated <> v_expected THEN RAISE EXCEPTION 'transaction_history_update_failed'; END IF;

  IF v_type IN ('expense', 'both') THEN
    UPDATE public.budgets AS b
    SET category = v_new_name
    WHERE b.user_id = p_user_id
      AND lower(btrim(b.category)) = lower(btrim(v_old_name));
  END IF;

  UPDATE public.recurring_transactions AS rt
  SET category = v_new_name
  WHERE rt.user_id = p_user_id
    AND lower(btrim(rt.category)) = lower(btrim(v_old_name))
    AND (v_type = 'both' OR rt.type = v_type);

  UPDATE public.user_categories AS uc
  SET custom_name = CASE WHEN v_new_name = v_master_name THEN NULL ELSE v_new_name END
  WHERE uc.user_id = p_user_id AND uc.category_id = p_category_id;

  RETURN v_updated;
END;
$$;


ALTER FUNCTION "public"."rename_user_category"("p_user_id" "uuid", "p_category_id" bigint, "p_new_name" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."seed_default_categories"("target_user_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin
  insert into public.categories (user_id, name) values
    (target_user_id, 'Gaji'),
    (target_user_id, 'Bonus'),
    (target_user_id, 'Makanan'),
    (target_user_id, 'Transportasi'),
    (target_user_id, 'Tagihan'),
    (target_user_id, 'Belanja'),
    (target_user_id, 'Hiburan'),
    (target_user_id, 'Kesehatan'),
    (target_user_id, 'Pendidikan'),
    (target_user_id, 'Investasi'),
    (target_user_id, 'Lainnya')
  on conflict (user_id, name) do nothing;
end;
$$;


ALTER FUNCTION "public"."seed_default_categories"("target_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."seed_default_user_categories_on_signup"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
BEGIN
  INSERT INTO public.user_categories (user_id, category_id, type, is_default, is_hidden)
  SELECT NEW.id, cc.id, 'both', true, false
  FROM public.category_catalog AS cc
  WHERE cc.is_default
  ON CONFLICT (user_id, category_id) DO NOTHING;
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."seed_default_user_categories_on_signup"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_user_category_type"("p_user_id" "uuid", "p_category_id" bigint, "p_type" "text") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
BEGIN
  IF auth.uid() IS DISTINCT FROM p_user_id THEN
    RAISE EXCEPTION 'not_authorized';
  END IF;

  IF p_type NOT IN ('income', 'expense') THEN
    RAISE EXCEPTION 'invalid_category_type';
  END IF;

  PERFORM pg_catalog.pg_advisory_xact_lock(pg_catalog.hashtextextended(p_user_id::text, 0));

  UPDATE public.user_categories
  SET type = p_type
  WHERE user_id = p_user_id
    AND category_id = p_category_id
    AND NOT is_hidden;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'category_not_found';
  END IF;
END;
$$;


ALTER FUNCTION "public"."set_user_category_type"("p_user_id" "uuid", "p_category_id" bigint, "p_type" "text") OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."budgets" (
    "id" bigint NOT NULL,
    "user_id" "uuid" NOT NULL,
    "month" "date" NOT NULL,
    "category" "text" NOT NULL,
    "amount" numeric(14,2) NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "budgets_amount_check" CHECK (("amount" > (0)::numeric)),
    CONSTRAINT "budgets_month_first_day" CHECK (("month" = ("date_trunc"('month'::"text", ("month")::timestamp with time zone))::"date"))
);


ALTER TABLE "public"."budgets" OWNER TO "postgres";


ALTER TABLE "public"."budgets" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."budgets_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."categories" (
    "id" bigint NOT NULL,
    "user_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."categories" OWNER TO "postgres";


ALTER TABLE "public"."categories" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."categories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."category_catalog" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "normalized_name" "text" GENERATED ALWAYS AS ("lower"("btrim"("name"))) STORED,
    "is_default" boolean DEFAULT false NOT NULL,
    "sort_order" integer DEFAULT 1000 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "category_catalog_name_length_check" CHECK (("char_length"("btrim"("name")) >= 2))
);


ALTER TABLE "public"."category_catalog" OWNER TO "postgres";


ALTER TABLE "public"."category_catalog" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."category_catalog_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."financial_goals" (
    "id" bigint NOT NULL,
    "user_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "target_amount" numeric(14,2) NOT NULL,
    "saved_amount" numeric(14,2) DEFAULT 0 NOT NULL,
    "target_date" "date" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "financial_goals_name_not_blank" CHECK (("length"(TRIM(BOTH FROM "name")) >= 2)),
    CONSTRAINT "financial_goals_saved_amount_check" CHECK (("saved_amount" >= (0)::numeric)),
    CONSTRAINT "financial_goals_target_amount_check" CHECK (("target_amount" > (0)::numeric))
);


ALTER TABLE "public"."financial_goals" OWNER TO "postgres";


ALTER TABLE "public"."financial_goals" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."financial_goals_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "username" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."recurring_transaction_runs" (
    "id" bigint NOT NULL,
    "user_id" "uuid" NOT NULL,
    "recurring_transaction_id" bigint NOT NULL,
    "month" "date" NOT NULL,
    "transaction_id" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "recurring_run_month_first_day" CHECK (("month" = ("date_trunc"('month'::"text", ("month")::timestamp with time zone))::"date"))
);


ALTER TABLE "public"."recurring_transaction_runs" OWNER TO "postgres";


ALTER TABLE "public"."recurring_transaction_runs" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."recurring_transaction_runs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."recurring_transactions" (
    "id" bigint NOT NULL,
    "user_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "type" "text" NOT NULL,
    "category" "text" NOT NULL,
    "amount" numeric(14,2) NOT NULL,
    "payment_method" "text",
    "note" "text",
    "day_of_month" integer NOT NULL,
    "start_date" "date" NOT NULL,
    "end_date" "date",
    "active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "recurring_date_range" CHECK ((("end_date" IS NULL) OR ("end_date" >= "start_date"))),
    CONSTRAINT "recurring_name_not_blank" CHECK (("length"(TRIM(BOTH FROM "name")) >= 2)),
    CONSTRAINT "recurring_transactions_amount_check" CHECK (("amount" > (0)::numeric)),
    CONSTRAINT "recurring_transactions_day_of_month_check" CHECK ((("day_of_month" >= 1) AND ("day_of_month" <= 31))),
    CONSTRAINT "recurring_transactions_type_check" CHECK (("type" = ANY (ARRAY['income'::"text", 'expense'::"text"])))
);


ALTER TABLE "public"."recurring_transactions" OWNER TO "postgres";


ALTER TABLE "public"."recurring_transactions" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."recurring_transactions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."transaction_submission_limits" (
    "user_id" "uuid" NOT NULL,
    "last_submitted_at" timestamp with time zone NOT NULL
);


ALTER TABLE "public"."transaction_submission_limits" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."transactions" (
    "id" bigint NOT NULL,
    "user_id" "uuid" NOT NULL,
    "transaction_date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "type" "text" NOT NULL,
    "category" "text" NOT NULL,
    "amount" numeric(14,2) NOT NULL,
    "payment_method" "text",
    "note" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "transactions_amount_check" CHECK (("amount" > (0)::numeric)),
    CONSTRAINT "transactions_type_check" CHECK (("type" = ANY (ARRAY['income'::"text", 'expense'::"text"])))
);


ALTER TABLE "public"."transactions" OWNER TO "postgres";


ALTER TABLE "public"."transactions" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."transactions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."user_categories" (
    "user_id" "uuid" NOT NULL,
    "category_id" bigint NOT NULL,
    "custom_name" "text",
    "type" "text" DEFAULT 'both'::"text" NOT NULL,
    "is_default" boolean DEFAULT false NOT NULL,
    "is_hidden" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "user_categories_custom_name_check" CHECK ((("custom_name" IS NULL) OR ("char_length"("btrim"("custom_name")) >= 2))),
    CONSTRAINT "user_categories_type_check" CHECK (("type" = ANY (ARRAY['income'::"text", 'expense'::"text", 'both'::"text"])))
);


ALTER TABLE "public"."user_categories" OWNER TO "postgres";


ALTER TABLE ONLY "public"."budgets"
    ADD CONSTRAINT "budgets_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."budgets"
    ADD CONSTRAINT "budgets_user_month_category_unique" UNIQUE ("user_id", "month", "category");



ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_user_name_unique" UNIQUE ("user_id", "name");



ALTER TABLE ONLY "public"."category_catalog"
    ADD CONSTRAINT "category_catalog_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."financial_goals"
    ADD CONSTRAINT "financial_goals_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_username_key" UNIQUE ("username");



ALTER TABLE ONLY "public"."recurring_transaction_runs"
    ADD CONSTRAINT "recurring_run_unique" UNIQUE ("recurring_transaction_id", "month");



ALTER TABLE ONLY "public"."recurring_transaction_runs"
    ADD CONSTRAINT "recurring_transaction_runs_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."recurring_transactions"
    ADD CONSTRAINT "recurring_transactions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."transaction_submission_limits"
    ADD CONSTRAINT "transaction_submission_limits_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_categories"
    ADD CONSTRAINT "user_categories_pkey" PRIMARY KEY ("user_id", "category_id");



CREATE INDEX "budgets_user_month_idx" ON "public"."budgets" USING "btree" ("user_id", "month");



CREATE INDEX "categories_user_name_idx" ON "public"."categories" USING "btree" ("user_id", "name");



CREATE UNIQUE INDEX "category_catalog_normalized_name_uidx" ON "public"."category_catalog" USING "btree" ("normalized_name");



CREATE INDEX "financial_goals_user_idx" ON "public"."financial_goals" USING "btree" ("user_id", "target_date");



CREATE INDEX "recurring_runs_user_month_idx" ON "public"."recurring_transaction_runs" USING "btree" ("user_id", "month");



CREATE INDEX "recurring_transactions_user_active_idx" ON "public"."recurring_transactions" USING "btree" ("user_id", "active", "day_of_month");



CREATE INDEX "transactions_user_date_idx" ON "public"."transactions" USING "btree" ("user_id", "transaction_date" DESC);



CREATE INDEX "user_categories_user_visible_idx" ON "public"."user_categories" USING "btree" ("user_id", "is_hidden", "category_id");



CREATE OR REPLACE TRIGGER "category_catalog_text_only_name_insert" BEFORE INSERT ON "public"."category_catalog" FOR EACH ROW EXECUTE FUNCTION "public"."enforce_text_only_category_name"();



CREATE OR REPLACE TRIGGER "normalize_default_user_category_type_trigger" BEFORE INSERT OR UPDATE ON "public"."user_categories" FOR EACH ROW EXECUTE FUNCTION "public"."normalize_default_user_category_type"();



CREATE OR REPLACE TRIGGER "transactions_enforce_note_length" BEFORE INSERT OR UPDATE OF "note" ON "public"."transactions" FOR EACH ROW EXECUTE FUNCTION "private"."enforce_transaction_note_length"();



CREATE OR REPLACE TRIGGER "transactions_enforce_submission_rules" BEFORE INSERT OR UPDATE ON "public"."transactions" FOR EACH ROW EXECUTE FUNCTION "private"."enforce_transaction_submission_rules"();



CREATE OR REPLACE TRIGGER "transactions_release_recurring_run_before_delete" BEFORE DELETE ON "public"."transactions" FOR EACH ROW EXECUTE FUNCTION "private"."release_recurring_run_on_transaction_delete"();



CREATE OR REPLACE TRIGGER "user_categories_text_only_custom_name" BEFORE INSERT OR UPDATE OF "custom_name" ON "public"."user_categories" FOR EACH ROW EXECUTE FUNCTION "public"."enforce_text_only_category_name"();



ALTER TABLE ONLY "public"."budgets"
    ADD CONSTRAINT "budgets_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."financial_goals"
    ADD CONSTRAINT "financial_goals_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."recurring_transaction_runs"
    ADD CONSTRAINT "recurring_transaction_runs_recurring_transaction_id_fkey" FOREIGN KEY ("recurring_transaction_id") REFERENCES "public"."recurring_transactions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."recurring_transaction_runs"
    ADD CONSTRAINT "recurring_transaction_runs_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES "public"."transactions"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."recurring_transaction_runs"
    ADD CONSTRAINT "recurring_transaction_runs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."recurring_transactions"
    ADD CONSTRAINT "recurring_transactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_categories"
    ADD CONSTRAINT "user_categories_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."category_catalog"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."user_categories"
    ADD CONSTRAINT "user_categories_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Users can delete their own budgets" ON "public"."budgets" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own categories" ON "public"."categories" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own financial goals" ON "public"."financial_goals" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own recurring transactions" ON "public"."recurring_transactions" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own transactions" ON "public"."transactions" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own budgets" ON "public"."budgets" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own categories" ON "public"."categories" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own financial goals" ON "public"."financial_goals" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own profile" ON "public"."profiles" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "Users can insert their own recurring transactions" ON "public"."recurring_transactions" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own transactions" ON "public"."transactions" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own budgets" ON "public"."budgets" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own categories" ON "public"."categories" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own financial goals" ON "public"."financial_goals" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own profile" ON "public"."profiles" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "id")) WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "Users can update their own recurring transactions" ON "public"."recurring_transactions" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own transactions" ON "public"."transactions" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own budgets" ON "public"."budgets" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own categories" ON "public"."categories" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own financial goals" ON "public"."financial_goals" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own profile" ON "public"."profiles" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can view their own recurring runs" ON "public"."recurring_transaction_runs" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own recurring transactions" ON "public"."recurring_transactions" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own transactions" ON "public"."transactions" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."budgets" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."categories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."category_catalog" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "category_catalog_authenticated_read" ON "public"."category_catalog" FOR SELECT TO "authenticated" USING (("is_default" OR (EXISTS ( SELECT 1
   FROM "public"."user_categories" "uc"
  WHERE (("uc"."category_id" = "category_catalog"."id") AND ("uc"."user_id" = ( SELECT "auth"."uid"() AS "uid")))))));



ALTER TABLE "public"."financial_goals" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."recurring_transaction_runs" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."recurring_transactions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."transaction_submission_limits" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."transactions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_categories" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_categories_select_own" ON "public"."user_categories" FOR SELECT TO "authenticated" USING (("user_id" = ( SELECT "auth"."uid"() AS "uid")));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































REVOKE ALL ON FUNCTION "private"."enforce_transaction_note_length"() FROM PUBLIC;



REVOKE ALL ON FUNCTION "private"."enforce_transaction_submission_rules"() FROM PUBLIC;



REVOKE ALL ON FUNCTION "private"."release_recurring_run_on_transaction_delete"() FROM PUBLIC;



REVOKE ALL ON FUNCTION "public"."add_user_category"("p_user_id" "uuid", "p_name" "text", "p_type" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."add_user_category"("p_user_id" "uuid", "p_name" "text", "p_type" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."add_user_category"("p_user_id" "uuid", "p_name" "text", "p_type" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_user_category"("p_user_id" "uuid", "p_name" "text", "p_type" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."category_default_type"("p_name" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."category_default_type"("p_name" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."category_default_type"("p_name" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."category_default_type"("p_name" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."enforce_text_only_category_name"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."enforce_text_only_category_name"() TO "anon";
GRANT ALL ON FUNCTION "public"."enforce_text_only_category_name"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enforce_text_only_category_name"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."ensure_user_category_defaults"("p_user_id" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."ensure_user_category_defaults"("p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."ensure_user_category_defaults"("p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."ensure_user_category_defaults"("p_user_id" "uuid") TO "service_role";



REVOKE ALL ON FUNCTION "public"."generate_recurring_transaction"("p_recurring_id" bigint, "p_month" "date") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."generate_recurring_transaction"("p_recurring_id" bigint, "p_month" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_recurring_transaction"("p_recurring_id" bigint, "p_month" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."lookup_login_email"("p_username" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."lookup_login_email"("p_username" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."lookup_login_email"("p_username" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."lookup_login_email"("p_username" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."normalize_default_user_category_type"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."normalize_default_user_category_type"() TO "anon";
GRANT ALL ON FUNCTION "public"."normalize_default_user_category_type"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."normalize_default_user_category_type"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."remove_user_category"("p_user_id" "uuid", "p_category_id" bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."remove_user_category"("p_user_id" "uuid", "p_category_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."remove_user_category"("p_user_id" "uuid", "p_category_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."remove_user_category"("p_user_id" "uuid", "p_category_id" bigint) TO "service_role";



REVOKE ALL ON FUNCTION "public"."rename_user_category"("p_user_id" "uuid", "p_category_id" bigint, "p_new_name" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."rename_user_category"("p_user_id" "uuid", "p_category_id" bigint, "p_new_name" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."rename_user_category"("p_user_id" "uuid", "p_category_id" bigint, "p_new_name" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."rename_user_category"("p_user_id" "uuid", "p_category_id" bigint, "p_new_name" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."seed_default_categories"("target_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."seed_default_categories"("target_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."seed_default_categories"("target_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."seed_default_user_categories_on_signup"() TO "anon";
GRANT ALL ON FUNCTION "public"."seed_default_user_categories_on_signup"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."seed_default_user_categories_on_signup"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."set_user_category_type"("p_user_id" "uuid", "p_category_id" bigint, "p_type" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."set_user_category_type"("p_user_id" "uuid", "p_category_id" bigint, "p_type" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."set_user_category_type"("p_user_id" "uuid", "p_category_id" bigint, "p_type" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_user_category_type"("p_user_id" "uuid", "p_category_id" bigint, "p_type" "text") TO "service_role";


















GRANT ALL ON TABLE "public"."budgets" TO "anon";
GRANT ALL ON TABLE "public"."budgets" TO "authenticated";
GRANT ALL ON TABLE "public"."budgets" TO "service_role";



GRANT ALL ON SEQUENCE "public"."budgets_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."budgets_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."budgets_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."categories" TO "anon";
GRANT ALL ON TABLE "public"."categories" TO "authenticated";
GRANT ALL ON TABLE "public"."categories" TO "service_role";



GRANT ALL ON SEQUENCE "public"."categories_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."categories_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."categories_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."category_catalog" TO "anon";
GRANT ALL ON TABLE "public"."category_catalog" TO "authenticated";
GRANT ALL ON TABLE "public"."category_catalog" TO "service_role";



GRANT ALL ON SEQUENCE "public"."category_catalog_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."category_catalog_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."category_catalog_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."financial_goals" TO "anon";
GRANT ALL ON TABLE "public"."financial_goals" TO "authenticated";
GRANT ALL ON TABLE "public"."financial_goals" TO "service_role";



GRANT ALL ON SEQUENCE "public"."financial_goals_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."financial_goals_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."financial_goals_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."recurring_transaction_runs" TO "anon";
GRANT ALL ON TABLE "public"."recurring_transaction_runs" TO "authenticated";
GRANT ALL ON TABLE "public"."recurring_transaction_runs" TO "service_role";



GRANT ALL ON SEQUENCE "public"."recurring_transaction_runs_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."recurring_transaction_runs_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."recurring_transaction_runs_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."recurring_transactions" TO "anon";
GRANT ALL ON TABLE "public"."recurring_transactions" TO "authenticated";
GRANT ALL ON TABLE "public"."recurring_transactions" TO "service_role";



GRANT ALL ON SEQUENCE "public"."recurring_transactions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."recurring_transactions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."recurring_transactions_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."transaction_submission_limits" TO "service_role";



GRANT ALL ON TABLE "public"."transactions" TO "anon";
GRANT ALL ON TABLE "public"."transactions" TO "authenticated";
GRANT ALL ON TABLE "public"."transactions" TO "service_role";



GRANT ALL ON SEQUENCE "public"."transactions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."transactions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."transactions_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."user_categories" TO "anon";
GRANT ALL ON TABLE "public"."user_categories" TO "authenticated";
GRANT ALL ON TABLE "public"."user_categories" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































