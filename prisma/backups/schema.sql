


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


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."attach_payment_proof"("p_order_id" "uuid", "p_proof_token" "uuid", "p_proof_path" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $_$
begin
  if p_proof_path !~ '^orders/[0-9a-fA-F-]{36}/[0-9a-fA-F-]{36}\.(png|jpg|jpeg|webp|pdf)$' then
    raise exception 'Path bukti pembayaran tidak valid';
  end if;

  if split_part(p_proof_path, '/', 2)::uuid <> p_order_id then
    raise exception 'Path tidak cocok dengan order';
  end if;

  if split_part(split_part(p_proof_path, '/', 3), '.', 1)::uuid <> p_proof_token then
    raise exception 'Token bukti pembayaran tidak cocok';
  end if;

  update public.orders
  set payment_proof_path = p_proof_path,
      payment_proof_uploaded_at = now()
  where id = p_order_id
    and proof_token = p_proof_token
    and payment_proof_path is null;

  if not found then
    raise exception 'Order atau token bukti pembayaran tidak valid';
  end if;

  return true;
end;
$_$;


ALTER FUNCTION "public"."attach_payment_proof"("p_order_id" "uuid", "p_proof_token" "uuid", "p_proof_path" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."attach_settlement_proof"("p_invoice_no" "text", "p_customer_phone" "text", "p_settlement_token" "text", "p_proof_path" "text", "p_reported_amount" bigint) RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $_$
DECLARE
  v_order public.orders%ROWTYPE;
  v_expected_amount bigint;
BEGIN
  IF p_reported_amount IS NULL OR p_reported_amount <= 0 THEN
    RAISE EXCEPTION 'Nominal pelunasan tidak valid.';
  END IF;

  SELECT *
  INTO v_order
  FROM public.orders o
  WHERE upper(trim(o.invoice_no)) = upper(trim(p_invoice_no))
    AND regexp_replace(coalesce(o.customer_phone, ''), '\D', '', 'g')
        = regexp_replace(coalesce(p_customer_phone, ''), '\D', '', 'g')
    AND o.settlement_token::text = trim(p_settlement_token)
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Pesanan atau token pelunasan tidak valid.';
  END IF;

  IF upper(coalesce(v_order.payment_plan, 'DP')) <> 'DP' THEN
    RAISE EXCEPTION 'Pesanan Full Payment tidak memerlukan bukti pelunasan.';
  END IF;

  IF v_order.settlement_proof_path IS NOT NULL THEN
    RAISE EXCEPTION 'Bukti pelunasan sudah pernah dikirim.';
  END IF;

  v_expected_amount :=
    greatest(
      coalesce(v_order.total_amount, 0)
      - coalesce(v_order.payment_amount_due, 0),
      0
    );

  IF v_expected_amount <= 0 THEN
    RAISE EXCEPTION 'Tidak ada sisa pembayaran.';
  END IF;

  IF p_reported_amount > v_order.total_amount THEN
    RAISE EXCEPTION 'Nominal pelunasan melebihi total pesanan.';
  END IF;

  IF p_proof_path !~ (
    '^settlements/' || v_order.id::text || '/' ||
    v_order.settlement_token::text || '\.(png|jpg|jpeg|webp|pdf)$'
  ) THEN
    RAISE EXCEPTION 'Lokasi atau format file bukti tidak valid.';
  END IF;

  INSERT INTO public.order_payments (
    order_id,
    payment_type,
    expected_amount,
    reported_amount,
    proof_path,
    internal_status,
    uploaded_at
  )
  VALUES (
    v_order.id,
    'SETTLEMENT',
    v_expected_amount,
    p_reported_amount,
    p_proof_path,
    'PENDING',
    now()
  );

  UPDATE public.orders
  SET
    settlement_proof_path = p_proof_path,
    settlement_proof_uploaded_at = now(),
    customer_payment_status = 'LUNAS'
  WHERE id = v_order.id;

  RETURN jsonb_build_object(
    'success', true,
    'invoice_no', v_order.invoice_no,
    'customer_payment_status', 'LUNAS',
    'reported_amount', p_reported_amount,
    'expected_amount', v_expected_amount,
    'message', 'Bukti pelunasan berhasil disimpan.'
  );
END;
$_$;


ALTER FUNCTION "public"."attach_settlement_proof"("p_invoice_no" "text", "p_customer_phone" "text", "p_settlement_token" "text", "p_proof_path" "text", "p_reported_amount" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."capture_initial_order_payment"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
BEGIN
  IF NEW.payment_proof_path IS NULL THEN
    RETURN NEW;
  END IF;

  IF TG_OP = 'UPDATE' AND OLD.payment_proof_path IS NOT DISTINCT FROM NEW.payment_proof_path THEN
    RETURN NEW;
  END IF;

  INSERT INTO public.order_payments (
    order_id, payment_type, expected_amount, reported_amount, proof_path
  )
  VALUES (
    NEW.id,
    'INITIAL',
    GREATEST(COALESCE(NEW.payment_amount_due, NEW.total_amount), 1),
    GREATEST(COALESCE(NEW.payment_amount_due, NEW.total_amount), 1),
    NEW.payment_proof_path
  )
  ON CONFLICT (order_id, payment_type) DO UPDATE
    SET proof_path = EXCLUDED.proof_path;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."capture_initial_order_payment"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_items" "jsonb") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_order_id uuid:=gen_random_uuid(); v_invoice_no text:=public.next_invoice_no(); v_total bigint:=0; v_item jsonb; v_product public.products%rowtype; v_requested integer; v_result jsonb;
begin
  if length(trim(coalesce(p_customer_name,''))) not between 1 and 120 then raise exception 'Nama pemesan tidak valid'; end if;
  if length(trim(coalesce(p_customer_email,''))) not between 3 and 160 then raise exception 'Email pemesan tidak valid'; end if;
  if length(trim(coalesce(p_customer_address,''))) not between 1 and 500 then raise exception 'Alamat pemesan tidak valid'; end if;
  if length(trim(coalesce(p_customer_phone,''))) not between 3 and 30 then raise exception 'Nomor HP pemesan tidak valid'; end if;
  if jsonb_typeof(p_items)<>'array' or jsonb_array_length(p_items)=0 then raise exception 'Pesanan harus memiliki minimal satu produk'; end if;

  for v_item in select value from jsonb_array_elements(p_items) loop
    v_requested:=(v_item->>'quantity')::integer;
    if v_requested is null or v_requested<=0 then raise exception 'Jumlah produk harus lebih dari 0'; end if;
    select * into v_product from public.products where id=(v_item->>'product_id')::uuid and active=true for update;
    if not found then raise exception 'Produk tidak ditemukan atau tidak aktif'; end if;
    if v_product.stock is not null then
      if v_requested>v_product.stock then raise exception 'Stok produk % tidak mencukupi',v_product.name; end if;
      update public.products set stock=stock-v_requested where id=v_product.id;
    end if;
    v_total:=v_total+(v_product.price*v_requested);
  end loop;
  if v_total<=0 then raise exception 'Total pesanan harus lebih dari 0'; end if;

  insert into public.orders(id,invoice_no,customer_name,customer_email,customer_address,customer_phone,payment_status,total_amount,paid_amount)
  values(v_order_id,v_invoice_no,trim(p_customer_name),lower(trim(p_customer_email)),trim(p_customer_address),trim(p_customer_phone),'DP',v_total,0);

  for v_item in select value from jsonb_array_elements(p_items) loop
    select * into v_product from public.products where id=(v_item->>'product_id')::uuid;
    insert into public.order_items(order_id,product_id,product_name,unit_price,quantity) values(v_order_id,v_product.id,v_product.name,v_product.price,(v_item->>'quantity')::integer);
  end loop;

  select jsonb_build_object('id',o.id,'invoice_no',o.invoice_no,'customer_name',o.customer_name,'customer_email',o.customer_email,'customer_address',o.customer_address,'customer_phone',o.customer_phone,'payment_status',o.payment_status,'total_amount',o.total_amount,'paid_amount',o.paid_amount,'remaining_amount',o.remaining_amount,'created_at',o.created_at,'items',coalesce((select jsonb_agg(jsonb_build_object('name',oi.product_name,'quantity',oi.quantity,'unit_price',oi.unit_price,'subtotal',oi.subtotal) order by oi.id) from public.order_items oi where oi.order_id=o.id),'[]'::jsonb)) into v_result from public.orders o where o.id=v_order_id;
  return v_result;
end; $$;


ALTER FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_items" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
declare
  v_order_id uuid := gen_random_uuid();
  v_invoice_no text;
  v_total bigint := 0;
  v_payment_due bigint := 0;
  v_dp_percentage integer := 50;
  v_item jsonb;
  v_product public.products%rowtype;
  v_requested integer;
  v_result jsonb;
  v_proof_token uuid := gen_random_uuid();
begin
  if length(trim(coalesce(p_customer_name,''))) not between 1 and 120 then
    raise exception 'Nama pemesan tidak valid';
  end if;

  if length(trim(coalesce(p_customer_email,''))) not between 3 and 160 then
    raise exception 'Email pemesan tidak valid';
  end if;

  if length(trim(coalesce(p_customer_address,''))) not between 1 and 500 then
    raise exception 'Alamat pemesan tidak valid';
  end if;

  if length(trim(coalesce(p_customer_phone,''))) not between 5 and 30 then
    raise exception 'Nomor HP tidak valid';
  end if;

  if p_payment_plan not in ('DP','FULL') then
    raise exception 'Rencana pembayaran harus DP atau FULL';
  end if;

  if p_payment_method not in ('QRIS','BCA_TRANSFER') then
    raise exception 'Metode pembayaran tidak valid';
  end if;

  if jsonb_typeof(p_items) <> 'array' or jsonb_array_length(p_items) = 0 then
    raise exception 'Pesanan harus memiliki minimal satu produk';
  end if;

  select coalesce(dp_percentage, 50)
  into v_dp_percentage
  from public.site_settings
  where id = 1;

  for v_item in select value from jsonb_array_elements(p_items) loop
    if not (v_item ? 'product_id') then
      raise exception 'product_id wajib diisi';
    end if;

    v_requested := coalesce((v_item->>'quantity')::integer, 0);
    if v_requested <= 0 then
      raise exception 'Jumlah produk harus lebih dari 0';
    end if;

    select *
    into v_product
    from public.products
    where id = (v_item->>'product_id')::uuid
      and active = true
    for update;

    if not found then
      raise exception 'Produk tidak ditemukan atau tidak aktif';
    end if;

    if v_product.stock is not null then
      if v_requested > v_product.stock then
        raise exception 'Stok produk % tidak mencukupi', v_product.name;
      end if;
      update public.products
      set stock = stock - v_requested
      where id = v_product.id;
    end if;

    v_total := v_total + (v_product.price * v_requested);
  end loop;

  if v_total <= 0 then
    raise exception 'Total pesanan harus lebih dari 0';
  end if;

  if p_payment_plan = 'FULL' then
    v_payment_due := v_total;
  else
    v_payment_due := greatest(1, ceil(v_total::numeric * v_dp_percentage / 100))::bigint;
  end if;

  v_invoice_no := format(
    'ITB-PO-%s-%s',
    to_char(now() at time zone 'Asia/Jakarta','YYYY'),
    lpad(nextval('public.order_invoice_seq')::text, 6, '0')
  );

  insert into public.orders (
    id,
    invoice_no,
    customer_name,
    customer_contact,
    customer_email,
    customer_address,
    customer_phone,
    pickup_method,
    notes,
    payment_status,
    payment_plan,
    payment_method,
    payment_amount_due,
    paid_amount,
    proof_token
  )
  values (
    v_order_id,
    v_invoice_no,
    trim(p_customer_name),
    trim(p_customer_phone),
    trim(p_customer_email),
    trim(p_customer_address),
    trim(p_customer_phone),
    'Ambil di CF24',
    null,
    'DP',
    p_payment_plan,
    p_payment_method,
    v_payment_due,
    0,
    v_proof_token
  );

  for v_item in select value from jsonb_array_elements(p_items) loop
    select * into v_product
    from public.products
    where id = (v_item->>'product_id')::uuid;

    insert into public.order_items (
      order_id, product_id, product_name, unit_price, quantity
    )
    values (
      v_order_id,
      v_product.id,
      v_product.name,
      v_product.price,
      (v_item->>'quantity')::integer
    );
  end loop;

  select jsonb_build_object(
    'id', o.id,
    'invoice_no', o.invoice_no,
    'customer_name', o.customer_name,
    'customer_email', o.customer_email,
    'customer_address', o.customer_address,
    'customer_phone', o.customer_phone,
    'payment_status', o.payment_status,
    'payment_plan', o.payment_plan,
    'payment_method', o.payment_method,
    'payment_amount_due', o.payment_amount_due,
    'paid_amount', o.paid_amount,
    'remaining_amount', o.remaining_amount,
    'created_at', o.created_at,
    'proof_token', o.proof_token,
    'items',
      coalesce(
        (
          select jsonb_agg(
            jsonb_build_object(
              'name', oi.product_name,
              'quantity', oi.quantity,
              'unit_price', oi.unit_price,
              'subtotal', oi.subtotal
            )
            order by oi.id
          )
          from public.order_items oi
          where oi.order_id = o.id
        ),
        '[]'::jsonb
      )
  )
  into v_result
  from public.orders o
  where o.id = v_order_id;

  return v_result;
end;
$$;


ALTER FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
declare
  v_order_id uuid := gen_random_uuid();
  v_invoice_no text;
  v_total bigint := 0;
  v_payment_due bigint := 0;
  v_dp_percentage integer := 50;
  v_item jsonb;
  v_product public.products%rowtype;
  v_requested integer;
  v_size text;
  v_result jsonb;
  v_proof_token uuid := gen_random_uuid();
  v_address text := nullif(trim(coalesce(p_customer_address,'')), '');
begin
  if length(trim(coalesce(p_customer_name,''))) not between 1 and 120 then
    raise exception 'Nama pemesan tidak valid';
  end if;

  if length(trim(coalesce(p_customer_email,''))) not between 3 and 160 then
    raise exception 'Email pemesan tidak valid';
  end if;

  if length(trim(coalesce(p_customer_phone,''))) not between 5 and 30 then
    raise exception 'Nomor HP tidak valid';
  end if;

  if p_delivery_method not in ('BOOTH_CF24','SHIP_TO_ADDRESS') then
    raise exception 'Pilihan pengambilan/pengiriman tidak valid';
  end if;

  if p_delivery_method = 'SHIP_TO_ADDRESS' and v_address is null then
    raise exception 'Alamat pengiriman wajib diisi';
  end if;

  if p_payment_plan not in ('DP','FULL') then
    raise exception 'Rencana pembayaran harus DP atau FULL';
  end if;

  if p_payment_method not in ('QRIS','BCA_TRANSFER') then
    raise exception 'Metode pembayaran tidak valid';
  end if;

  if jsonb_typeof(p_items) <> 'array' or jsonb_array_length(p_items) = 0 then
    raise exception 'Pesanan harus memiliki minimal satu produk';
  end if;

  select coalesce(dp_percentage,50)
  into v_dp_percentage
  from public.site_settings
  where id=1;

  for v_item in select value from jsonb_array_elements(p_items) loop
    v_requested := coalesce((v_item->>'quantity')::integer,0);
    if v_requested <= 0 then
      raise exception 'Jumlah produk harus lebih dari 0';
    end if;

    select *
    into v_product
    from public.products
    where id=(v_item->>'product_id')::uuid
      and active=true
    for update;

    if not found then
      raise exception 'Produk tidak ditemukan atau tidak aktif';
    end if;

    if v_product.category in ('TSHIRT','JACKET') then
      v_size := nullif(upper(trim(coalesce(v_item->>'size',''))),'');
      if v_size is null then
        raise exception 'Ukuran wajib dipilih untuk %', v_product.name;
      end if;

      if not (v_size = any(v_product.available_sizes)) then
        raise exception 'Ukuran % tidak tersedia untuk %', v_size, v_product.name;
      end if;
    else
      v_size := null;
    end if;

    if v_product.stock is not null then
      if v_requested > v_product.stock then
        raise exception 'Stok produk % tidak mencukupi', v_product.name;
      end if;
      update public.products set stock=stock-v_requested where id=v_product.id;
    end if;

    v_total := v_total + (v_product.price*v_requested);
  end loop;

  if v_total <= 0 then
    raise exception 'Total pesanan harus lebih dari 0';
  end if;

  if p_payment_plan='FULL' then
    v_payment_due := v_total;
  else
    v_payment_due := greatest(1,ceil(v_total::numeric*v_dp_percentage/100))::bigint;
  end if;

  v_invoice_no := format(
    'ITB-PO-%s-%s',
    to_char(now() at time zone 'Asia/Jakarta','YYYY'),
    lpad(nextval('public.order_invoice_seq')::text,6,'0')
  );

  insert into public.orders (
    id,invoice_no,customer_name,customer_email,customer_address,
    customer_phone,customer_contact,payment_status,total_amount,paid_amount,
    delivery_method,payment_plan,payment_method,payment_amount_due,
    payment_proof_path,payment_proof_uploaded_at,proof_token
  )
  values (
    v_order_id,v_invoice_no,trim(p_customer_name),trim(p_customer_email),
    v_address,trim(p_customer_phone),trim(p_customer_phone),'DP',v_total,0,
    p_delivery_method,p_payment_plan,p_payment_method,v_payment_due,
    null,null,v_proof_token
  );

  for v_item in select value from jsonb_array_elements(p_items) loop
    select * into v_product
    from public.products
    where id=(v_item->>'product_id')::uuid;

    if v_product.category in ('TSHIRT','JACKET') then
      v_size := nullif(upper(trim(coalesce(v_item->>'size',''))),'');
    else
      v_size := null;
    end if;

    insert into public.order_items (
      order_id,product_id,product_name,product_category,size,unit_price,quantity
    )
    values (
      v_order_id,v_product.id,v_product.name,v_product.category,v_size,
      v_product.price,(v_item->>'quantity')::integer
    );
  end loop;

  select jsonb_build_object(
    'id',o.id,
    'invoice_no',o.invoice_no,
    'customer_name',o.customer_name,
    'customer_email',o.customer_email,
    'customer_address',o.customer_address,
    'customer_phone',o.customer_phone,
    'delivery_method',o.delivery_method,
    'payment_status',o.payment_status,
    'payment_plan',o.payment_plan,
    'payment_method',o.payment_method,
    'payment_amount_due',o.payment_amount_due,
    'paid_amount',o.paid_amount,
    'remaining_amount',o.remaining_amount,
    'created_at',o.created_at,
    'proof_token',o.proof_token,
    'items',coalesce((
      select jsonb_agg(jsonb_build_object(
        'name',oi.product_name,
        'quantity',oi.quantity,
        'unit_price',oi.unit_price,
        'subtotal',oi.subtotal,
        'category',oi.product_category,
        'size',oi.size
      ) order by oi.id)
      from public.order_items oi
      where oi.order_id=o.id
    ),'[]'::jsonb)
  )
  into v_result
  from public.orders o
  where o.id=v_order_id;

  return v_result;
end;
$$;


ALTER FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_promo_code" "text", "p_items" "jsonb") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
DECLARE
  v_code text := upper(regexp_replace(trim(coalesce(p_promo_code,'')), '\s+', ' ', 'g'));
  v_member public.promo_members%rowtype;
  v_result jsonb;
  v_subtotal bigint := 0;
  v_discount bigint := 0;
  v_final_total bigint := 0;
  v_payment_due bigint := 0;
  v_dp_percentage integer := 50;
  v_order_id uuid;
BEGIN
  IF v_code <> '' THEN
    SELECT * INTO v_member
    FROM public.promo_members
    WHERE plate_code = v_code
    FOR UPDATE;

    IF NOT FOUND OR NOT v_member.is_active THEN
      RAISE EXCEPTION 'Kode promo tidak ditemukan atau sedang nonaktif';
    END IF;
    IF v_member.is_used THEN
      RAISE EXCEPTION 'Kode promo ini sudah pernah digunakan';
    END IF;
  END IF;

  v_result := public.create_public_order(
    p_customer_name, p_customer_email, p_customer_address, p_customer_phone,
    p_delivery_method, p_payment_plan, p_payment_method, p_items
  );

  v_order_id := (v_result->>'id')::uuid;
  SELECT o.total_amount INTO v_subtotal
  FROM public.orders o WHERE o.id = v_order_id;

  IF v_subtotal IS NULL OR v_subtotal <= 0 THEN
    RAISE EXCEPTION 'Subtotal pesanan tidak valid';
  END IF;

  IF v_code <> '' THEN
    IF v_member.discount_type = 'PERCENT' THEN
      v_discount := round(v_subtotal::numeric * v_member.discount_value / 100)::bigint;
    ELSE
      v_discount := v_member.discount_value;
    END IF;
    v_discount := least(greatest(v_discount,0),greatest(v_subtotal-1,0));
  END IF;

  v_final_total := v_subtotal - v_discount;
  IF v_final_total <= 0 THEN
    RAISE EXCEPTION 'Total setelah diskon harus lebih dari 0';
  END IF;

  SELECT coalesce(dp_percentage,50) INTO v_dp_percentage
  FROM public.site_settings WHERE id = 1;
  v_dp_percentage := greatest(1,least(99,coalesce(v_dp_percentage,50)));

  IF p_payment_plan = 'FULL' THEN
    v_payment_due := v_final_total;
  ELSIF p_payment_plan = 'DP' THEN
    v_payment_due := greatest(1,ceil(v_final_total::numeric * v_dp_percentage / 100))::bigint;
  ELSE
    RAISE EXCEPTION 'Rencana pembayaran harus DP atau FULL';
  END IF;

  UPDATE public.orders
  SET subtotal_amount = v_subtotal,
      discount_amount = v_discount,
      promo_code = nullif(v_code,''),
      total_amount = v_final_total,
      payment_amount_due = v_payment_due,
      customer_payment_status = CASE WHEN p_payment_plan = 'FULL' THEN 'LUNAS' ELSE 'DP' END
  WHERE id = v_order_id;

  IF v_code <> '' THEN
    UPDATE public.promo_members
    SET is_used = true,
        used_order_id = v_order_id,
        used_at = now(),
        updated_at = now()
    WHERE id = v_member.id;
  END IF;

  v_result := jsonb_set(v_result,'{subtotal_amount}',to_jsonb(v_subtotal),true);
  v_result := jsonb_set(v_result,'{discount_amount}',to_jsonb(v_discount),true);
  v_result := jsonb_set(v_result,'{promo_code}',coalesce(to_jsonb(nullif(v_code,'')),'null'::jsonb),true);
  v_result := jsonb_set(v_result,'{total_amount}',to_jsonb(v_final_total),true);
  v_result := jsonb_set(v_result,'{payment_amount_due}',to_jsonb(v_payment_due),true);
  v_result := jsonb_set(v_result,'{remaining_amount}',to_jsonb(greatest(v_final_total - 0,0)),true);
  v_result := jsonb_set(v_result,'{customer_payment_status}',to_jsonb(CASE WHEN p_payment_plan = 'FULL' THEN 'LUNAS' ELSE 'DP' END),true);
  RETURN v_result;
END;
$$;


ALTER FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_promo_code" "text", "p_items" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin insert into public.profiles(id,display_name) values(new.id,coalesce(new.raw_user_meta_data->>'full_name',new.email)) on conflict(id) do nothing; return new; end; $$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists(select 1 from public.profiles where id=auth.uid() and role='admin');
$$;


ALTER FUNCTION "public"."is_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_valid_proof_path"("object_path" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $_$
declare
  v_order_id uuid;
  v_token uuid;
  v_name text;
  v_token_text text;
begin
  if object_path is null or object_path !~ '^orders/[0-9a-fA-F-]{36}/[0-9a-fA-F-]{36}\.(png|jpg|jpeg|webp|pdf)$' then
    return false;
  end if;

  v_order_id := split_part(object_path, '/', 2)::uuid;
  v_name := split_part(object_path, '/', 3);
  v_token_text := split_part(v_name, '.', 1);
  v_token := v_token_text::uuid;

  return exists (
    select 1
    from public.orders o
    where o.id = v_order_id
      and o.proof_token = v_token
      and o.payment_proof_path is null
  );
exception
  when others then
    return false;
end;
$_$;


ALTER FUNCTION "public"."is_valid_proof_path"("object_path" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_valid_settlement_proof_path"("object_path" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $_$
DECLARE
  v_order_id uuid;
  v_token uuid;
BEGIN
  IF object_path IS NULL OR object_path !~ '^settlements/[0-9a-fA-F-]{36}/[0-9a-fA-F-]{36}\.(png|jpg|jpeg|webp|pdf)$' THEN
    RETURN false;
  END IF;
  v_order_id := split_part(object_path, '/', 2)::uuid;
  v_token := split_part(split_part(object_path, '/', 3), '.', 1)::uuid;
  RETURN EXISTS (
    SELECT 1 FROM public.orders o
    WHERE o.id = v_order_id
      AND o.settlement_token = v_token
      AND o.payment_plan = 'DP'
      AND o.customer_payment_status = 'DP'
      AND o.settlement_proof_path IS NULL
  );
EXCEPTION WHEN OTHERS THEN
  RETURN false;
END;
$_$;


ALTER FUNCTION "public"."is_valid_settlement_proof_path"("object_path" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."lookup_public_order"("p_invoice_no" "text", "p_customer_phone" "text") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
DECLARE
  v_order public.orders%rowtype;
  v_phone text := regexp_replace(COALESCE(p_customer_phone, ''), '\D', '', 'g');
  v_items jsonb;
  v_payments jsonb;
  v_can_settle boolean;
BEGIN
  IF length(v_phone) < 8 OR length(trim(COALESCE(p_invoice_no, ''))) < 5 THEN
    RAISE EXCEPTION 'Nomor invoice atau nomor HP tidak valid';
  END IF;

  SELECT * INTO v_order
  FROM public.orders o
  WHERE upper(trim(o.invoice_no)) = upper(trim(p_invoice_no))
    AND regexp_replace(COALESCE(o.customer_phone, o.customer_contact, ''), '\D', '', 'g') = v_phone
  LIMIT 1;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Pesanan tidak ditemukan. Periksa nomor invoice dan nomor HP.';
  END IF;

  v_can_settle := v_order.payment_plan = 'DP'
    AND v_order.customer_payment_status = 'DP'
    AND v_order.settlement_proof_path IS NULL
    AND EXISTS (
      SELECT 1
      FROM public.order_payments op
      WHERE op.order_id = v_order.id
        AND op.payment_type = 'INITIAL'
    );

  SELECT COALESCE(
    jsonb_agg(
      jsonb_build_object(
        'name', oi.product_name,
        'category', oi.product_category,
        'size', oi.size,
        'quantity', oi.quantity,
        'unit_price', oi.unit_price,
        'subtotal', COALESCE(oi.subtotal, oi.unit_price * oi.quantity)
      )
      ORDER BY oi.id
    ),
    '[]'::jsonb
  )
  INTO v_items
  FROM public.order_items oi
  WHERE oi.order_id = v_order.id;

  SELECT COALESCE(
    jsonb_agg(
      jsonb_build_object(
        'id', op.id,
        'payment_type', op.payment_type,
        'expected_amount', op.expected_amount,
        'reported_amount', op.reported_amount,
        'uploaded_at', op.uploaded_at,
        'has_proof', true
      )
      ORDER BY op.uploaded_at
    ),
    '[]'::jsonb
  )
  INTO v_payments
  FROM public.order_payments op
  WHERE op.order_id = v_order.id;

  RETURN jsonb_build_object(
    'order', jsonb_build_object(
      'id', v_order.id,
      'invoice_no', v_order.invoice_no,
      'created_at', v_order.created_at,
      'customer_name', v_order.customer_name,
      'customer_email', v_order.customer_email,
      'customer_phone', COALESCE(v_order.customer_phone, v_order.customer_contact),
      'delivery_method', v_order.delivery_method,
      'customer_address', v_order.customer_address,
      'payment_plan', v_order.payment_plan,
      'customer_payment_status', v_order.customer_payment_status,
      'payment_method', v_order.payment_method,
      'total_amount', v_order.total_amount,
      'subtotal_amount', COALESCE(v_order.subtotal_amount, v_order.total_amount),
      'discount_amount', v_order.discount_amount,
      'promo_code', v_order.promo_code,
      'payment_amount_due', v_order.payment_amount_due,
      'remaining_amount', v_order.remaining_amount,
      'settlement_available', v_can_settle,
      'settlement_token', CASE
        WHEN v_can_settle THEN v_order.settlement_token
        ELSE NULL
      END,
      'settlement_uploaded_at', v_order.settlement_proof_uploaded_at
    ),
    'items', v_items,
    'payments', v_payments
  );
END;
$$;


ALTER FUNCTION "public"."lookup_public_order"("p_invoice_no" "text", "p_customer_phone" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."next_invoice_no"() RETURNS "text"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin return format('ITB-PO-%s-%s',to_char(now() at time zone 'Asia/Jakarta','YYYY'),lpad(nextval('public.order_invoice_seq')::text,6,'0')); end; $$;


ALTER FUNCTION "public"."next_invoice_no"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."preview_public_promo"("p_code" "text", "p_subtotal" bigint) RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
declare
  v_code text := upper(regexp_replace(trim(coalesce(p_code,'')), '\s+', ' ', 'g'));
  v_member public.promo_members%rowtype;
  v_discount bigint := 0;
begin
  if v_code = '' then
    return jsonb_build_object('valid',false,'message','Masukkan kode promo member.');
  end if;

  select * into v_member
  from public.promo_members
  where plate_code = v_code;

  if not found or not v_member.is_active then
    return jsonb_build_object('valid',false,'message','Kode promo tidak ditemukan atau sedang nonaktif.');
  end if;
  if v_member.is_used then
    return jsonb_build_object('valid',false,'message','Kode promo ini sudah pernah digunakan. Hubungi admin jika ada kekeliruan.');
  end if;
  if coalesce(p_subtotal,0) <= 0 then
    return jsonb_build_object('valid',false,'message','Subtotal pesanan tidak valid.');
  end if;

  if v_member.discount_type = 'PERCENT' then
    v_discount := round(p_subtotal::numeric * v_member.discount_value / 100)::bigint;
  else
    v_discount := v_member.discount_value;
  end if;
  v_discount := least(greatest(v_discount,0),greatest(p_subtotal-1,0));

  return jsonb_build_object(
    'valid',true,
    'code',v_member.plate_code,
    'discount_type',v_member.discount_type,
    'discount_value',v_member.discount_value,
    'discount_amount',v_discount
  );
end;
$$;


ALTER FUNCTION "public"."preview_public_promo"("p_code" "text", "p_subtotal" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$ begin new.updated_at=now(); return new; end; $$;


ALTER FUNCTION "public"."set_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_order_payment_verification"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
DECLARE
  v_order_id uuid;
  v_total bigint;
  v_paid bigint;
BEGIN
  IF TG_OP = 'DELETE' THEN
    v_order_id := OLD.order_id;
  ELSE
    v_order_id := NEW.order_id;
  END IF;
  SELECT total_amount INTO v_total
  FROM public.orders WHERE id = v_order_id;

  IF v_total IS NULL THEN
    RETURN NULL;
  END IF;

  SELECT COALESCE(SUM(reported_amount), 0)::bigint INTO v_paid
  FROM public.order_payments
  WHERE order_id = v_order_id AND internal_status = 'MATCHED';

  v_paid := LEAST(GREATEST(v_paid, 0), v_total);

  UPDATE public.orders
  SET paid_amount = v_paid,
      payment_status = CASE WHEN v_paid = v_total THEN 'LUNAS' ELSE 'DP' END,
      payment_verified_at = CASE WHEN v_paid > 0 THEN now() ELSE NULL END
  WHERE id = v_order_id;

  RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."sync_order_payment_verification"() OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."order_invoice_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."order_invoice_seq" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."order_items" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "product_id" "uuid" NOT NULL,
    "product_name" "text" NOT NULL,
    "unit_price" bigint NOT NULL,
    "quantity" integer NOT NULL,
    "subtotal" bigint GENERATED ALWAYS AS (("unit_price" * "quantity")) STORED,
    "product_category" "text" DEFAULT 'MERCHANDISE'::"text" NOT NULL,
    "size" "text",
    CONSTRAINT "order_items_quantity_check" CHECK (("quantity" > 0)),
    CONSTRAINT "order_items_unit_price_check" CHECK (("unit_price" >= 0))
);


ALTER TABLE "public"."order_items" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."order_payments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "payment_type" "text" NOT NULL,
    "expected_amount" bigint NOT NULL,
    "reported_amount" bigint NOT NULL,
    "proof_path" "text" NOT NULL,
    "internal_status" "text" DEFAULT 'PENDING'::"text" NOT NULL,
    "internal_note" "text",
    "uploaded_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "checked_at" timestamp with time zone,
    "checked_by" "uuid",
    CONSTRAINT "order_payments_expected_amount_check" CHECK (("expected_amount" > 0)),
    CONSTRAINT "order_payments_internal_status_check" CHECK (("internal_status" = ANY (ARRAY['PENDING'::"text", 'MATCHED'::"text", 'CONTACT'::"text"]))),
    CONSTRAINT "order_payments_payment_type_check" CHECK (("payment_type" = ANY (ARRAY['INITIAL'::"text", 'SETTLEMENT'::"text"]))),
    CONSTRAINT "order_payments_reported_amount_check" CHECK (("reported_amount" > 0))
);


ALTER TABLE "public"."order_payments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."orders" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "invoice_no" "text" NOT NULL,
    "customer_name" "text" NOT NULL,
    "customer_email" "text" NOT NULL,
    "customer_address" "text",
    "customer_phone" "text" NOT NULL,
    "payment_status" "text" DEFAULT 'DP'::"text" NOT NULL,
    "total_amount" bigint NOT NULL,
    "paid_amount" bigint DEFAULT 0 NOT NULL,
    "remaining_amount" bigint GENERATED ALWAYS AS (("total_amount" - "paid_amount")) STORED,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "customer_contact" "text",
    "payment_plan" "text",
    "payment_method" "text",
    "payment_amount_due" bigint,
    "payment_proof_path" "text",
    "payment_proof_uploaded_at" timestamp with time zone,
    "proof_token" "uuid" DEFAULT "gen_random_uuid"(),
    "delivery_method" "text",
    "payment_verified_at" timestamp with time zone,
    "notes" "text",
    "subtotal_amount" bigint,
    "discount_amount" bigint DEFAULT 0 NOT NULL,
    "promo_code" "text",
    "customer_payment_status" "text" DEFAULT 'DP'::"text" NOT NULL,
    "settlement_token" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "settlement_proof_path" "text",
    "settlement_proof_uploaded_at" timestamp with time zone,
    CONSTRAINT "orders_customer_address_check" CHECK ((("customer_address" IS NULL) OR (("char_length"("btrim"("customer_address")) >= 1) AND ("char_length"("btrim"("customer_address")) <= 500)))),
    CONSTRAINT "orders_customer_email_check" CHECK ((("char_length"(TRIM(BOTH FROM "customer_email")) >= 3) AND ("char_length"(TRIM(BOTH FROM "customer_email")) <= 160))),
    CONSTRAINT "orders_customer_name_check" CHECK ((("char_length"(TRIM(BOTH FROM "customer_name")) >= 1) AND ("char_length"(TRIM(BOTH FROM "customer_name")) <= 120))),
    CONSTRAINT "orders_customer_payment_status_check" CHECK (("customer_payment_status" = ANY (ARRAY['DP'::"text", 'LUNAS'::"text"]))),
    CONSTRAINT "orders_customer_phone_check" CHECK ((("char_length"(TRIM(BOTH FROM "customer_phone")) >= 3) AND ("char_length"(TRIM(BOTH FROM "customer_phone")) <= 30))),
    CONSTRAINT "orders_delivery_method_check" CHECK (("delivery_method" = ANY (ARRAY['BOOTH_CF24'::"text", 'SHIP_TO_ADDRESS'::"text"]))),
    CONSTRAINT "orders_paid_amount_check" CHECK (("paid_amount" >= 0)),
    CONSTRAINT "orders_payment_due_check" CHECK ((("payment_amount_due" IS NULL) OR (("payment_amount_due" > 0) AND ("payment_amount_due" <= "total_amount")))),
    CONSTRAINT "orders_payment_method_check" CHECK ((("payment_method" IS NULL) OR ("payment_method" = ANY (ARRAY['QRIS'::"text", 'BCA_TRANSFER'::"text"])))),
    CONSTRAINT "orders_payment_plan_check" CHECK ((("payment_plan" IS NULL) OR ("payment_plan" = ANY (ARRAY['DP'::"text", 'FULL'::"text"])))),
    CONSTRAINT "orders_payment_status_check" CHECK (((("payment_status" = 'DP'::"text") AND ("paid_amount" >= 0) AND ("paid_amount" < "total_amount")) OR (("payment_status" = 'LUNAS'::"text") AND ("paid_amount" = "total_amount")))),
    CONSTRAINT "orders_total_amount_check" CHECK (("total_amount" > 0))
);


ALTER TABLE "public"."orders" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."products" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "code" "text" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "price" bigint NOT NULL,
    "image_url" "text",
    "stock" integer,
    "active" boolean DEFAULT true NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "category" "text" DEFAULT 'MERCHANDISE'::"text" NOT NULL,
    "available_sizes" "text"[] DEFAULT '{}'::"text"[] NOT NULL,
    CONSTRAINT "products_category_check" CHECK (("category" = ANY (ARRAY['MERCHANDISE'::"text", 'TSHIRT'::"text", 'JACKET'::"text"]))),
    CONSTRAINT "products_price_check" CHECK (("price" >= 0)),
    CONSTRAINT "products_stock_check" CHECK ((("stock" IS NULL) OR ("stock" >= 0)))
);


ALTER TABLE "public"."products" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "role" "text" DEFAULT 'staff'::"text" NOT NULL,
    "display_name" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "profiles_role_check" CHECK (("role" = ANY (ARRAY['admin'::"text", 'staff'::"text"])))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."promo_members" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "plate_code" "text" NOT NULL,
    "member_name" "text" NOT NULL,
    "discount_type" "text" NOT NULL,
    "discount_value" bigint NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "is_used" boolean DEFAULT false NOT NULL,
    "used_order_id" "uuid",
    "used_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "promo_members_discount_type_check" CHECK (("discount_type" = ANY (ARRAY['PERCENT'::"text", 'FIXED'::"text"]))),
    CONSTRAINT "promo_members_discount_value_check" CHECK (("discount_value" > 0)),
    CONSTRAINT "promo_members_percent_range" CHECK ((("discount_type" <> 'PERCENT'::"text") OR (("discount_value" >= 1) AND ("discount_value" <= 99)))),
    CONSTRAINT "promo_members_plate_code_format" CHECK (("plate_code" = "upper"("regexp_replace"(TRIM(BOTH FROM "plate_code"), '\s+'::"text", ' '::"text", 'g'::"text"))))
);


ALTER TABLE "public"."promo_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."site_settings" (
    "id" integer DEFAULT 1 NOT NULL,
    "site_name" "text" DEFAULT 'Circle Itabaka'::"text" NOT NULL,
    "site_title" "text" DEFAULT 'Pre-Order CF24'::"text" NOT NULL,
    "site_description" "text",
    "logo_url" "text",
    "banner_url" "text",
    "primary_color" "text" DEFAULT '#111111'::"text" NOT NULL,
    "accent_color" "text" DEFAULT '#ffffff'::"text" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "qris_image_url" "text",
    "bca_account_name" "text",
    "bca_account_number" "text",
    "dp_percentage" integer,
    CONSTRAINT "site_settings_id_check" CHECK (("id" = 1))
);


ALTER TABLE "public"."site_settings" OWNER TO "postgres";


ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."order_payments"
    ADD CONSTRAINT "order_payments_order_id_payment_type_key" UNIQUE ("order_id", "payment_type");



ALTER TABLE ONLY "public"."order_payments"
    ADD CONSTRAINT "order_payments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_invoice_no_key" UNIQUE ("invoice_no");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."promo_members"
    ADD CONSTRAINT "promo_members_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."promo_members"
    ADD CONSTRAINT "promo_members_plate_code_key" UNIQUE ("plate_code");



ALTER TABLE ONLY "public"."site_settings"
    ADD CONSTRAINT "site_settings_pkey" PRIMARY KEY ("id");



CREATE INDEX "order_items_category_size_idx" ON "public"."order_items" USING "btree" ("product_category", "size");



CREATE INDEX "products_category_idx" ON "public"."products" USING "btree" ("category");



CREATE OR REPLACE TRIGGER "order_payments_sync_verification" AFTER INSERT OR DELETE OR UPDATE OF "internal_status", "reported_amount" ON "public"."order_payments" FOR EACH ROW EXECUTE FUNCTION "public"."sync_order_payment_verification"();



CREATE OR REPLACE TRIGGER "orders_capture_initial_payment" AFTER INSERT OR UPDATE OF "payment_proof_path" ON "public"."orders" FOR EACH ROW EXECUTE FUNCTION "public"."capture_initial_order_payment"();



CREATE OR REPLACE TRIGGER "orders_set_updated_at" BEFORE UPDATE ON "public"."orders" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "products_set_updated_at" BEFORE UPDATE ON "public"."products" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "settings_set_updated_at" BEFORE UPDATE ON "public"."site_settings" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."order_payments"
    ADD CONSTRAINT "order_payments_checked_by_fkey" FOREIGN KEY ("checked_by") REFERENCES "auth"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."order_payments"
    ADD CONSTRAINT "order_payments_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."promo_members"
    ADD CONSTRAINT "promo_members_used_order_id_fkey" FOREIGN KEY ("used_order_id") REFERENCES "public"."orders"("id") ON DELETE SET NULL;



ALTER TABLE "public"."order_items" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "order_items_admin_select" ON "public"."order_items" FOR SELECT TO "authenticated" USING ("public"."is_admin"());



ALTER TABLE "public"."order_payments" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "order_payments_admin_select" ON "public"."order_payments" FOR SELECT TO "authenticated" USING ("public"."is_admin"());



CREATE POLICY "order_payments_admin_update" ON "public"."order_payments" FOR UPDATE TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



ALTER TABLE "public"."orders" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "orders_admin_select" ON "public"."orders" FOR SELECT TO "authenticated" USING ("public"."is_admin"());



CREATE POLICY "orders_admin_update" ON "public"."orders" FOR UPDATE TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



ALTER TABLE "public"."products" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "products_admin_delete" ON "public"."products" FOR DELETE TO "authenticated" USING ("public"."is_admin"());



CREATE POLICY "products_admin_insert" ON "public"."products" FOR INSERT TO "authenticated" WITH CHECK ("public"."is_admin"());



CREATE POLICY "products_admin_update" ON "public"."products" FOR UPDATE TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "products_public_select" ON "public"."products" FOR SELECT TO "authenticated", "anon" USING ((("active" = true) OR "public"."is_admin"()));



ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "profiles_self_select" ON "public"."profiles" FOR SELECT TO "authenticated" USING ((("id" = "auth"."uid"()) OR "public"."is_admin"()));



ALTER TABLE "public"."promo_members" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "promo_members_admin_delete" ON "public"."promo_members" FOR DELETE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = 'admin'::"text")))));



CREATE POLICY "promo_members_admin_insert" ON "public"."promo_members" FOR INSERT TO "authenticated" WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = 'admin'::"text")))));



CREATE POLICY "promo_members_admin_select" ON "public"."promo_members" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = 'admin'::"text")))));



CREATE POLICY "promo_members_admin_update" ON "public"."promo_members" FOR UPDATE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = 'admin'::"text"))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = 'admin'::"text")))));



CREATE POLICY "settings_admin_insert" ON "public"."site_settings" FOR INSERT TO "authenticated" WITH CHECK ("public"."is_admin"());



CREATE POLICY "settings_admin_update" ON "public"."site_settings" FOR UPDATE TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "settings_public_select" ON "public"."site_settings" FOR SELECT TO "authenticated", "anon" USING (true);



ALTER TABLE "public"."site_settings" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "site_settings_admin_insert" ON "public"."site_settings" FOR INSERT TO "authenticated" WITH CHECK ("public"."is_admin"());



CREATE POLICY "site_settings_admin_update" ON "public"."site_settings" FOR UPDATE TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "site_settings_public_select" ON "public"."site_settings" FOR SELECT TO "authenticated", "anon" USING (true);





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































REVOKE ALL ON FUNCTION "public"."attach_payment_proof"("p_order_id" "uuid", "p_proof_token" "uuid", "p_proof_path" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."attach_payment_proof"("p_order_id" "uuid", "p_proof_token" "uuid", "p_proof_path" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."attach_payment_proof"("p_order_id" "uuid", "p_proof_token" "uuid", "p_proof_path" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."attach_payment_proof"("p_order_id" "uuid", "p_proof_token" "uuid", "p_proof_path" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."attach_settlement_proof"("p_invoice_no" "text", "p_customer_phone" "text", "p_settlement_token" "text", "p_proof_path" "text", "p_reported_amount" bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."attach_settlement_proof"("p_invoice_no" "text", "p_customer_phone" "text", "p_settlement_token" "text", "p_proof_path" "text", "p_reported_amount" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."attach_settlement_proof"("p_invoice_no" "text", "p_customer_phone" "text", "p_settlement_token" "text", "p_proof_path" "text", "p_reported_amount" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."attach_settlement_proof"("p_invoice_no" "text", "p_customer_phone" "text", "p_settlement_token" "text", "p_proof_path" "text", "p_reported_amount" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."capture_initial_order_payment"() TO "anon";
GRANT ALL ON FUNCTION "public"."capture_initial_order_payment"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."capture_initial_order_payment"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_items" "jsonb") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_items" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_items" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_items" "jsonb") TO "service_role";



REVOKE ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") TO "service_role";



REVOKE ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_items" "jsonb") TO "service_role";



REVOKE ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_promo_code" "text", "p_items" "jsonb") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_promo_code" "text", "p_items" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_promo_code" "text", "p_items" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_public_order"("p_customer_name" "text", "p_customer_email" "text", "p_customer_address" "text", "p_customer_phone" "text", "p_delivery_method" "text", "p_payment_plan" "text", "p_payment_method" "text", "p_promo_code" "text", "p_items" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."is_valid_proof_path"("object_path" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."is_valid_proof_path"("object_path" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."is_valid_proof_path"("object_path" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_valid_proof_path"("object_path" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."is_valid_settlement_proof_path"("object_path" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."is_valid_settlement_proof_path"("object_path" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."is_valid_settlement_proof_path"("object_path" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_valid_settlement_proof_path"("object_path" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."lookup_public_order"("p_invoice_no" "text", "p_customer_phone" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."lookup_public_order"("p_invoice_no" "text", "p_customer_phone" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."lookup_public_order"("p_invoice_no" "text", "p_customer_phone" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."lookup_public_order"("p_invoice_no" "text", "p_customer_phone" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."next_invoice_no"() TO "anon";
GRANT ALL ON FUNCTION "public"."next_invoice_no"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."next_invoice_no"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."preview_public_promo"("p_code" "text", "p_subtotal" bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."preview_public_promo"("p_code" "text", "p_subtotal" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."preview_public_promo"("p_code" "text", "p_subtotal" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."preview_public_promo"("p_code" "text", "p_subtotal" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_order_payment_verification"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_order_payment_verification"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_order_payment_verification"() TO "service_role";


















GRANT ALL ON SEQUENCE "public"."order_invoice_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."order_invoice_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."order_invoice_seq" TO "service_role";



GRANT ALL ON TABLE "public"."order_items" TO "authenticated";
GRANT ALL ON TABLE "public"."order_items" TO "service_role";



GRANT ALL ON TABLE "public"."order_payments" TO "authenticated";
GRANT ALL ON TABLE "public"."order_payments" TO "service_role";



GRANT ALL ON TABLE "public"."orders" TO "authenticated";
GRANT ALL ON TABLE "public"."orders" TO "service_role";



GRANT ALL ON TABLE "public"."products" TO "anon";
GRANT ALL ON TABLE "public"."products" TO "authenticated";
GRANT ALL ON TABLE "public"."products" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."promo_members" TO "anon";
GRANT ALL ON TABLE "public"."promo_members" TO "authenticated";
GRANT ALL ON TABLE "public"."promo_members" TO "service_role";



GRANT ALL ON TABLE "public"."site_settings" TO "anon";
GRANT ALL ON TABLE "public"."site_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."site_settings" TO "service_role";









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































