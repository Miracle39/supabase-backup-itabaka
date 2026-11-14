SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict wKIjjssTqnkAPzeouuR4j2EsiUo5EdZUnBMHLrjdcg068GuXPb9xMSVYmeb0qKx

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."custom_oauth_providers" ("id", "provider_type", "identifier", "name", "client_id", "client_secret", "acceptable_client_ids", "scopes", "pkce_enabled", "attribute_mapping", "authorization_params", "enabled", "email_optional", "issuer", "discovery_url", "skip_nonce_check", "cached_discovery", "discovery_cached_at", "authorization_url", "token_url", "userinfo_url", "jwks_uri", "created_at", "updated_at", "custom_claims_allowlist") FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") FROM stdin;
00000000-0000-0000-0000-000000000000	091bbc1b-3dde-4005-af30-6e309b8fdfeb	authenticated	authenticated	itabaka@gmail.com	$2a$10$bZCffyi5CQOvJe71wmSSzO6WHMtal1lEB6/1dNSzuwqRt1TkyFCAK	2026-09-23 12:09:08.996733+00	\N		\N		\N			\N	2026-11-11 18:43:49.827474+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-09-23 12:09:08.980081+00	2026-11-11 23:37:13.279305+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
091bbc1b-3dde-4005-af30-6e309b8fdfeb	091bbc1b-3dde-4005-af30-6e309b8fdfeb	{"sub": "091bbc1b-3dde-4005-af30-6e309b8fdfeb", "email": "itabaka@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-09-23 12:09:08.991694+00	2026-09-23 12:09:08.991756+00	2026-09-23 12:09:08.991756+00	c4333ebe-3493-413d-adaa-9e239b1aadce
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_clients" ("id", "client_secret_hash", "registration_type", "redirect_uris", "grant_types", "client_name", "client_uri", "logo_uri", "created_at", "updated_at", "deleted_at", "client_type", "token_endpoint_auth_method") FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") FROM stdin;
666b04e9-78af-4c13-8d1f-b22aaa783c20	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 08:00:14.673703+00	2026-10-14 07:13:59.329467+00	\N	aal1	\N	2026-10-14 07:13:59.329336	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36	104.28.218.132	\N	\N	\N	\N	\N
e34d4c42-b2f7-4ff3-b72a-58e3d9dba6ed	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 08:45:43.892907+00	2026-10-15 04:02:55.950983+00	\N	aal1	\N	2026-10-15 04:02:55.95086	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36	114.122.68.226	\N	\N	\N	\N	\N
91cf385c-87c5-4fdf-9192-63db0d4de2fc	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 08:00:29.052669+00	2026-10-15 07:53:59.290785+00	\N	aal1	\N	2026-10-15 07:53:59.290674	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36	104.28.218.132	\N	\N	\N	\N	\N
f6e4da56-7d32-4b59-9171-4db08617f9e8	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 08:08:47.244459+00	2026-10-03 08:08:47.244459+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	103.168.46.70	\N	\N	\N	\N	\N
065eaef9-3f5f-4bad-9220-b18d464e80d3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 11:42:45.188772+00	2026-10-03 11:42:45.188772+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36	182.5.136.140	\N	\N	\N	\N	\N
31b0551e-c71b-4f6a-b764-3efcf67c0e68	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 13:40:22.893035+00	2026-10-03 13:40:22.893035+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 14; SM-A528B Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/153.0.8010.36 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/580.0.0.49.91;]	114.122.69.171	\N	\N	\N	\N	\N
c40b3e16-0b73-4a5f-b202-270389404aaf	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-11 18:43:49.828224+00	2026-11-11 18:43:49.828224+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.218.132	\N	\N	\N	\N	\N
567ba47b-c796-4e7c-ab98-3f034667fbf1	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-10 16:19:42.765108+00	2026-11-11 22:55:17.539545+00	\N	aal1	\N	2026-11-11 22:55:17.5394	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.218.132	\N	\N	\N	\N	\N
e9ea1f56-c422-4e83-9e0f-63b80ded5f38	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-11 11:41:32.888717+00	2026-11-11 23:37:13.293272+00	\N	aal1	\N	2026-11-11 23:37:13.293185	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.218.132	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
666b04e9-78af-4c13-8d1f-b22aaa783c20	2026-10-03 08:00:14.705937+00	2026-10-03 08:00:14.705937+00	password	f5751014-82a4-481b-8973-3cb4fc188f1f
91cf385c-87c5-4fdf-9192-63db0d4de2fc	2026-10-03 08:00:29.065681+00	2026-10-03 08:00:29.065681+00	password	79eac8cf-c950-4843-8d2c-cb048a07b524
f6e4da56-7d32-4b59-9171-4db08617f9e8	2026-10-03 08:08:47.26881+00	2026-10-03 08:08:47.26881+00	password	640a4f90-ba56-428a-a2b4-2338630c9b4f
e34d4c42-b2f7-4ff3-b72a-58e3d9dba6ed	2026-10-03 08:45:43.928648+00	2026-10-03 08:45:43.928648+00	password	ccbca0d1-d475-4fbd-925a-2453932d39d2
065eaef9-3f5f-4bad-9220-b18d464e80d3	2026-10-03 11:42:45.273103+00	2026-10-03 11:42:45.273103+00	password	8780daf9-cb74-4f36-9d6a-298351af5625
31b0551e-c71b-4f6a-b764-3efcf67c0e68	2026-10-03 13:40:22.95387+00	2026-10-03 13:40:22.95387+00	password	3a97e8f9-87c8-423c-953a-5f26e59753fb
567ba47b-c796-4e7c-ab98-3f034667fbf1	2026-11-10 16:19:42.823642+00	2026-11-10 16:19:42.823642+00	password	ad9ab515-1eaf-4d74-ac3f-ddfd1c6b8d37
e9ea1f56-c422-4e83-9e0f-63b80ded5f38	2026-11-11 11:41:32.960374+00	2026-11-11 11:41:32.960374+00	password	18466e0b-f98d-42f3-ad97-9448c18fab4d
c40b3e16-0b73-4a5f-b202-270389404aaf	2026-11-11 18:43:49.864525+00	2026-11-11 18:43:49.864525+00	password	3b2609a3-fc3d-47e4-9118-d96cf5b00131
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid", "last_webauthn_challenge_data") FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: mfa_recovery_code_sets; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_recovery_code_sets" ("id", "user_id", "mfa_factor_id", "failed_verification_count", "verification_locked_until", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: mfa_recovery_codes; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_recovery_codes" ("id", "mfa_recovery_code_set_id", "code_hash", "consumed_at", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_authorizations" ("id", "authorization_id", "client_id", "user_id", "redirect_uri", "scope", "state", "resource", "code_challenge", "code_challenge_method", "response_type", "status", "authorization_code", "created_at", "expires_at", "approved_at", "nonce") FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_client_states" ("id", "provider_type", "code_verifier", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_consents" ("id", "user_id", "client_id", "scopes", "granted_at", "revoked_at") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at", "expires_at") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
00000000-0000-0000-0000-000000000000	51	mzfpzryqo4pg	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-12 13:56:24.146429+00	2026-10-12 18:09:46.729251+00	rju4ejwd7bhr	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	50	biylw6t3yfab	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-12 13:53:23.584439+00	2026-10-12 18:46:42.70932+00	mti6xyvkawfg	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	52	crv3rm2n64ge	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-12 18:09:46.741565+00	2026-10-13 04:21:14.780254+00	mzfpzryqo4pg	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	53	34m2q4hatzfn	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-12 18:46:42.718303+00	2026-10-13 04:35:34.024967+00	biylw6t3yfab	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	54	bir32kgazabl	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-13 04:21:14.803106+00	2026-10-14 06:15:39.778112+00	crv3rm2n64ge	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	55	42xerdxmd75q	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-13 04:35:34.032169+00	2026-10-14 06:47:41.058171+00	34m2q4hatzfn	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	56	2q5rkfhsa6x2	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-14 06:15:39.794275+00	2026-10-14 07:13:59.294943+00	bir32kgazabl	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	58	ptrldqah7dwt	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-14 07:13:59.309281+00	2026-10-14 07:13:59.309281+00	2q5rkfhsa6x2	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	57	s2gtnpsltpql	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-14 06:47:41.075536+00	2026-10-14 19:23:51.73638+00	42xerdxmd75q	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	30	v2nulif7lum3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 11:59:46.362716+00	2026-10-15 04:02:55.89766+00	eadzq3huwo3m	e34d4c42-b2f7-4ff3-b72a-58e3d9dba6ed
00000000-0000-0000-0000-000000000000	60	vsjyooelbwsw	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-15 04:02:55.920492+00	2026-10-15 04:02:55.920492+00	v2nulif7lum3	e34d4c42-b2f7-4ff3-b72a-58e3d9dba6ed
00000000-0000-0000-0000-000000000000	59	ezfa5rj27ylq	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-14 19:23:51.757895+00	2026-10-15 07:53:59.222719+00	s2gtnpsltpql	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	61	sitea4rj4yc3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-15 07:53:59.251792+00	2026-10-15 07:53:59.251792+00	ezfa5rj27ylq	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	62	ri5jnetygqi3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-10 16:19:42.801256+00	2026-11-11 16:56:19.060755+00	\N	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	64	anqcvr5ujp6i	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 16:56:19.079232+00	2026-11-11 17:55:20.842474+00	ri5jnetygqi3	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	63	hozcvhg37rqa	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 11:41:32.927568+00	2026-11-11 18:35:18.625686+00	\N	e9ea1f56-c422-4e83-9e0f-63b80ded5f38
00000000-0000-0000-0000-000000000000	67	6k5au6bwq2tr	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-11 18:43:49.850302+00	2026-11-11 18:43:49.850302+00	\N	c40b3e16-0b73-4a5f-b202-270389404aaf
00000000-0000-0000-0000-000000000000	65	ijb4unx7bplr	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 17:55:20.857688+00	2026-11-11 18:59:31.593804+00	anqcvr5ujp6i	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	25	tothu6afqnh4	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-03 08:08:47.263362+00	2026-10-03 08:08:47.263362+00	\N	f6e4da56-7d32-4b59-9171-4db08617f9e8
00000000-0000-0000-0000-000000000000	23	txc75h6vgpzp	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 08:00:14.683964+00	2026-10-03 08:58:16.414766+00	\N	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	68	chu4ez6cj6in	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 18:59:31.599652+00	2026-11-11 19:59:42.878124+00	ijb4unx7bplr	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	27	rhlwm6nk6aix	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 08:58:16.426983+00	2026-10-03 10:02:18.978237+00	txc75h6vgpzp	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	29	hkwsdqukmbvm	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-03 11:42:45.229428+00	2026-10-03 11:42:45.229428+00	\N	065eaef9-3f5f-4bad-9220-b18d464e80d3
00000000-0000-0000-0000-000000000000	26	eadzq3huwo3m	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 08:45:43.912563+00	2026-10-03 11:59:46.35072+00	\N	e34d4c42-b2f7-4ff3-b72a-58e3d9dba6ed
00000000-0000-0000-0000-000000000000	31	i32ivjnd5fr3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-03 13:40:22.923749+00	2026-10-03 13:40:22.923749+00	\N	31b0551e-c71b-4f6a-b764-3efcf67c0e68
00000000-0000-0000-0000-000000000000	28	lu62gzpbixk4	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 10:02:19.000708+00	2026-10-03 16:21:03.584469+00	rhlwm6nk6aix	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	69	gnokyfwbrv4f	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 19:59:42.891531+00	2026-11-11 20:58:19.650034+00	chu4ez6cj6in	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	24	wtxgzurvpbcp	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 08:00:29.060753+00	2026-10-03 17:00:20.291504+00	\N	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	32	pppaa47i77l7	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 16:21:03.611582+00	2026-10-03 17:19:04.511355+00	lu62gzpbixk4	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	70	4ieveqrftoun	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 20:58:19.662596+00	2026-11-11 21:57:08.200042+00	gnokyfwbrv4f	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	34	2tbglxp7wsrh	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 17:19:04.520023+00	2026-10-03 18:17:22.369158+00	pppaa47i77l7	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	35	syc3ii4qt34a	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 18:17:22.377617+00	2026-10-04 10:06:21.948272+00	2tbglxp7wsrh	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	71	nuxiyzqvxe6e	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 21:57:08.208286+00	2026-11-11 22:55:17.491834+00	4ieveqrftoun	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	36	hjn6ijcv267i	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-04 10:06:21.974403+00	2026-10-04 13:39:13.457884+00	syc3ii4qt34a	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	72	qjb5l4c4uwf4	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-11 22:55:17.520615+00	2026-11-11 22:55:17.520615+00	nuxiyzqvxe6e	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	37	unrt7hemi7ic	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-04 13:39:13.476568+00	2026-10-04 21:18:16.438824+00	hjn6ijcv267i	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	66	zzzi65muorln	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 18:35:18.634217+00	2026-11-11 23:37:13.261598+00	hozcvhg37rqa	e9ea1f56-c422-4e83-9e0f-63b80ded5f38
00000000-0000-0000-0000-000000000000	33	ohtp2wzg4oav	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 17:00:20.306616+00	2026-10-04 21:29:12.338798+00	wtxgzurvpbcp	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	73	v6berynyx2ph	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-11 23:37:13.274716+00	2026-11-11 23:37:13.274716+00	zzzi65muorln	e9ea1f56-c422-4e83-9e0f-63b80ded5f38
00000000-0000-0000-0000-000000000000	38	ptc4jrkuupf3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-04 21:18:16.454373+00	2026-10-05 02:00:57.105874+00	unrt7hemi7ic	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	40	uz6nyclcxl4d	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-05 02:00:57.128878+00	2026-10-07 02:49:07.678169+00	ptc4jrkuupf3	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	41	g6tc3pbgic4i	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-07 02:49:07.700715+00	2026-10-08 14:47:42.651965+00	uz6nyclcxl4d	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	39	kcq5inf2antn	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-04 21:29:12.344168+00	2026-10-08 14:52:48.105651+00	ohtp2wzg4oav	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	42	o3c5hmml3l3q	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-08 14:47:42.671096+00	2026-10-08 23:27:16.276276+00	g6tc3pbgic4i	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	43	ipxn7el4ykhu	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-08 14:52:48.116444+00	2026-10-08 23:30:43.837895+00	kcq5inf2antn	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	44	td6s3qozjhoi	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-08 23:27:16.305748+00	2026-10-09 11:19:41.909036+00	o3c5hmml3l3q	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	46	qxxhmfpzxjio	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-09 11:19:41.928034+00	2026-10-09 16:25:16.683314+00	td6s3qozjhoi	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	47	mll26sp77lja	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-09 16:25:16.705323+00	2026-10-12 12:51:56.974988+00	qxxhmfpzxjio	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	45	ydzhgmxdq5vn	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-08 23:30:43.851406+00	2026-10-12 12:55:04.469515+00	ipxn7el4ykhu	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	49	mti6xyvkawfg	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-12 12:55:04.47724+00	2026-10-12 13:53:23.571227+00	ydzhgmxdq5vn	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	48	rju4ejwd7bhr	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-12 12:51:57.004485+00	2026-10-12 13:56:24.140565+00	mll26sp77lja	666b04e9-78af-4c13-8d1f-b22aaa783c20
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at", "disabled") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: scim_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."scim_tokens" ("id", "sso_provider_id", "token_hash", "prefix", "created_at", "expires_at", "revoked_at", "last_used_at") FROM stdin;
\.


--
-- Data for Name: scim_users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."scim_users" ("id", "sso_provider_id", "user_id", "resource", "created_at", "updated_at", "deleted_at") FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."webauthn_challenges" ("id", "user_id", "challenge_type", "session_data", "created_at", "expires_at") FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."webauthn_credentials" ("id", "user_id", "credential_id", "public_key", "attestation_type", "aaguid", "sign_count", "transports", "backup_eligible", "backed_up", "friendly_name", "created_at", "updated_at", "last_used_at") FROM stdin;
\.


--
-- Data for Name: apparel_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."apparel_types" ("code", "name", "is_active", "sort_order", "created_at", "updated_at") FROM stdin;
TSHIRT	Kaos	t	10	2026-11-11 21:36:31.391569+00	2026-11-11 21:36:31.391569+00
JACKET	Jaket	t	20	2026-11-11 21:36:31.391569+00	2026-11-11 21:36:31.391569+00
HOODIE	Hoodie	f	20	2026-11-11 21:46:32.990068+00	2026-11-11 21:46:32.990068+00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."orders" ("id", "invoice_no", "customer_name", "customer_email", "customer_address", "customer_phone", "payment_status", "total_amount", "paid_amount", "created_at", "updated_at", "customer_contact", "payment_plan", "payment_method", "payment_amount_due", "payment_proof_path", "payment_proof_uploaded_at", "proof_token", "delivery_method", "payment_verified_at", "notes", "subtotal_amount", "discount_amount", "promo_code", "customer_payment_status", "settlement_token", "settlement_proof_path", "settlement_proof_uploaded_at") FROM stdin;
49e5e7a0-786d-46be-9dcd-be1434ae7004	ITB-PO-2026-000044	Miracle	luqmankun9029@gmail.com	Jl. Hegarmanah 1b no 164, RT 002 RW 008, Kel. gunungbatu, Kec Bogor Barat, Kota Bogor	6282134656255	DP	400000	0	2026-11-11 18:17:09.596659+00	2026-11-11 18:58:25.758664+00	6282134656255	FULL	QRIS	400000	orders/49e5e7a0-786d-46be-9dcd-be1434ae7004/64e3654b-1777-4538-af4d-11dd69b12153.png	2026-11-11 18:17:10.026673+00	64e3654b-1777-4538-af4d-11dd69b12153	SHIP_TO_ADDRESS	\N	\N	500000	100000	F4382FHS	LUNAS	c10dab21-a3fb-4fec-9d9b-156f6af8fb3f	\N	\N
f8de8b0e-342f-4bbb-a243-c36768e6213d	ITB-PO-2026-000033	luqman	luqmankun9029@gmail.com	Jl. Hegarmanah 1b no 164, RT 002 RW 008, Kel. gunungbatu, Kec Bogor Barat, Kota Bogor	134234234234234	DP	570000	0	2026-10-14 07:07:23.563872+00	2026-11-11 18:58:25.758664+00	134234234234234	FULL	QRIS	570000	orders/f8de8b0e-342f-4bbb-a243-c36768e6213d/07c31f25-97db-4d8f-9fd9-8f8b9477ebf0.jpg	2026-10-14 07:07:23.965546+00	07c31f25-97db-4d8f-9fd9-8f8b9477ebf0	SHIP_TO_ADDRESS	\N	\N	\N	0	\N	LUNAS	3041fa65-d741-4c63-a8b0-b78aa5fee364	\N	\N
08e95d73-eaae-4acf-a487-2d33bdde800e	ITB-PO-2026-000046	Miracle	luqmankun9029@gmail.com	\N	6282134656255	DP	490000	0	2026-11-11 18:38:14.995355+00	2026-11-11 18:58:25.758664+00	6282134656255	FULL	QRIS	490000	orders/08e95d73-eaae-4acf-a487-2d33bdde800e/6d277eb1-bf32-4289-914a-786398fbfa0f.jpg	2026-11-11 18:38:15.400763+00	6d277eb1-bf32-4289-914a-786398fbfa0f	BOOTH_CF24	\N	\N	590000	100000	F4382FHS	LUNAS	7d2a2211-0f95-4b83-9271-1a220472b087	\N	\N
eef4b711-fba2-4ba4-8f2d-6d835685c965	ITB-PO-2026-000045	ibay	ibay@gmail.com	\N	023984029384029	DP	680000	0	2026-11-11 18:18:48.757075+00	2026-11-11 19:00:32.501317+00	023984029384029	DP	QRIS	340000	orders/eef4b711-fba2-4ba4-8f2d-6d835685c965/0407b05e-ca0c-4656-b3a1-16ddc07b83aa.png	2026-11-11 18:18:49.140658+00	0407b05e-ca0c-4656-b3a1-16ddc07b83aa	BOOTH_CF24	\N	\N	780000	100000	D4444ERK	LUNAS	4f52f320-520e-4387-bd48-6d0b30bb2f7a	settlements/eef4b711-fba2-4ba4-8f2d-6d835685c965/4f52f320-520e-4387-bd48-6d0b30bb2f7a.jpg	2026-11-11 19:00:32.501317+00
c8208e68-2c38-4412-9be6-d307baa90203	ITB-PO-2026-000048	nana	luqmankun9029@gmail.com	\N	6282134656255	DP	1250000	0	2026-11-11 19:25:00.667202+00	2026-11-11 19:26:42.675284+00	6282134656255	DP	QRIS	625000	orders/c8208e68-2c38-4412-9be6-d307baa90203/5586351a-79cd-4551-be6a-fb58904cf1dd.jpg	2026-11-11 19:25:01.014073+00	5586351a-79cd-4551-be6a-fb58904cf1dd	BOOTH_CF24	\N	\N	1250000	0	\N	LUNAS	08ccc6fd-4226-40d8-b8a5-f4442eb07adf	settlements/c8208e68-2c38-4412-9be6-d307baa90203/08ccc6fd-4226-40d8-b8a5-f4442eb07adf.jpg	2026-11-11 19:26:42.675284+00
73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	ITB-PO-2026-000034	Miracle	luqmankun9029@gmail.com	\N	567567567575675	DP	1140000	0	2026-10-14 07:11:34.707861+00	2026-11-11 19:12:54.685165+00	567567567575675	DP	QRIS	570000	orders/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5.jpg	2026-10-14 07:11:35.052788+00	bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5	BOOTH_CF24	\N	\N	\N	0	\N	LUNAS	245a691b-9097-4980-aaae-f2ab19b07d0f	settlements/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/245a691b-9097-4980-aaae-f2ab19b07d0f.jpg	2026-11-11 19:12:54.685165+00
7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7	ITB-PO-2026-000047	Miracle	luqmankun9029@gmail.com	\N	6282134656255	DP	1000000	0	2026-11-11 19:14:46.250008+00	2026-11-11 19:38:43.051042+00	6282134656255	DP	QRIS	500000	orders/7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7/30fe04b4-5a2d-4a39-b4e0-d49946ddf4a2.jpg	2026-11-11 19:14:46.803487+00	30fe04b4-5a2d-4a39-b4e0-d49946ddf4a2	BOOTH_CF24	\N	\N	1000000	0	\N	LUNAS	ca7a5eed-a178-4d90-ae3c-0755ad1b8143	settlements/7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7/ca7a5eed-a178-4d90-ae3c-0755ad1b8143.jpg	2026-11-11 19:38:43.051042+00
a3cf662e-ee5e-4184-be06-94f3c840d8ca	ITB-PO-2026-000050	rexa	luqmankun9029@gmail.com	\N	6282134656255	DP	1310000	0	2026-11-11 19:50:02.230028+00	2026-11-11 20:00:37.199567+00	6282134656255	DP	QRIS	655000	orders/a3cf662e-ee5e-4184-be06-94f3c840d8ca/a42bf11f-855f-4b34-86fc-47b3c7207d25.jpg	2026-11-11 19:50:03.472757+00	a42bf11f-855f-4b34-86fc-47b3c7207d25	BOOTH_CF24	\N	\N	1310000	0	\N	LUNAS	1667d915-bbd2-4d24-bcc4-21eaa6a5ad89	settlements/a3cf662e-ee5e-4184-be06-94f3c840d8ca/1667d915-bbd2-4d24-bcc4-21eaa6a5ad89.png	2026-11-11 20:00:37.199567+00
efa96de8-fc77-4cf8-8396-3e7929256b03	ITB-PO-2026-000051	aduy	luqmankun9029@gmail.com	\N	6282134656255	DP	1750000	0	2026-11-11 20:51:06.483173+00	2026-11-11 20:51:06.925088+00	6282134656255	DP	QRIS	875000	orders/efa96de8-fc77-4cf8-8396-3e7929256b03/4d3707e7-cc07-4d55-bdf8-f195fada366d.jpg	2026-11-11 20:51:06.925088+00	4d3707e7-cc07-4d55-bdf8-f195fada366d	BOOTH_CF24	\N	\N	1750000	0	\N	DP	da80c74d-7101-42fa-8539-e02464e11879	\N	\N
2f00dfef-b116-40a6-8150-56729c3b2ff9	ITB-PO-2026-000049	kiki	luqmankun9029@gmail.com	\N	6282134656255	DP	1370000	0	2026-11-11 19:47:21.67335+00	2026-11-11 19:48:34.39757+00	6282134656255	DP	QRIS	685000	orders/2f00dfef-b116-40a6-8150-56729c3b2ff9/154ed114-83cd-477d-ac36-8b3656db40b0.jpg	2026-11-11 19:47:22.071975+00	154ed114-83cd-477d-ac36-8b3656db40b0	BOOTH_CF24	\N	\N	1370000	0	\N	LUNAS	9cae779c-a9ea-4798-b3d5-0e484cd7ba9d	settlements/2f00dfef-b116-40a6-8150-56729c3b2ff9/9cae779c-a9ea-4798-b3d5-0e484cd7ba9d.jpg	2026-11-11 19:48:34.39757+00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."products" ("id", "code", "name", "description", "price", "image_url", "stock", "active", "sort_order", "created_at", "updated_at", "category", "available_sizes", "apparel_type") FROM stdin;
7b84e2ce-3092-45b5-a88d-d442c1a3facd	ITB-004	Keychain Ichinose Asuna	Art by Oshii	30000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/b1f50c49-70be-4cff-b01d-f013db3964e3.png	0	t	0	2026-10-03 09:12:56.87318+00	2026-11-11 19:47:21.67335+00	MERCHANDISE	{}	\N
712e41e7-8d86-499d-868e-c3f28e51b5af	APP-001	Jaket ARA Biru	alskdlaskhjdlasjd	500000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/6ca79ea9-496b-446c-9857-fca79dd28143.png	2	t	0	2026-10-02 23:45:30.642821+00	2026-11-11 21:27:10.693633+00	APPAREL	{M,L,XL}	JACKET
6cf8ac72-c00a-4577-8535-138bca761e68	APP-003	Jaket ARA Merah	sdfsdfs	500000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/1f04210e-b89c-473d-9f9a-233efef4d7b9.png	5	t	0	2026-10-03 09:15:45.064886+00	2026-11-11 21:27:10.693633+00	APPAREL	{L,XL,2XL}	JACKET
8a637a2e-2359-449e-80ff-69c79669730e	APP-002	Tshirt	asdasdsa	250000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/7efce189-5faf-4d2b-92d9-7333d5d56729.jpg	7	t	0	2026-10-03 09:12:05.99958+00	2026-11-11 21:27:10.693633+00	APPAREL	{M,L,XL}	TSHIRT
aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	ITB-003	C&C Sticker Pack	Art By Oshii	10000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/2aecb6c9-d2d3-410c-be71-7fbbe099470f.png	38	t	30	2026-09-23 12:03:15.698514+00	2026-11-11 19:50:02.230028+00	MERCHANDISE	{}	\N
03b97cd0-0eda-4b57-b740-99f2d68e5be4	ITB-005	Volkswagen Scirocco GT 24 Sunaookami Shiroko	Art by @hazaky	175000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/6c79e246-3528-4719-b5cf-92e326d3c524.png	0	t	0	2026-10-03 09:14:39.496659+00	2026-10-04 10:08:27.523227+00	MERCHANDISE	{}	\N
4c614771-69cf-4f8d-b4e2-3da8be684a49	ITB-001	Yvonne Acrylic Standee	Art By Hameru	140000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/3997379b-1b76-454f-a614-84d0ff871219.png	7	t	10	2026-09-23 12:03:15.698514+00	2026-10-14 07:11:34.707861+00	MERCHANDISE	{}	\N
2405f07d-b40c-4df2-a4ca-fb28f03219c2	ITB-006	Keychain GR Supra	art by.........	30000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/23601b3a-ac5a-4e75-8fcc-adf6884a5983.png	0	t	0	2026-10-03 17:33:52.146386+00	2026-10-12 13:34:02.284573+00	MERCHANDISE	{}	\N
5fcd1542-709e-4ee0-b011-f27a9e928c67	ITB-002	Asuma Toki (Armed) Standee	art by rlayuta	140000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/d704779a-bb52-453b-9cff-9cb08994757e.png	0	t	20	2026-09-23 12:03:15.698514+00	2026-10-12 13:43:13.25542+00	MERCHANDISE	{}	\N
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."order_items" ("id", "order_id", "product_id", "product_name", "unit_price", "quantity", "product_category", "size", "apparel_type") FROM stdin;
ae717c4e-543a-49cc-8b16-218031d5c9ea	73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	4c614771-69cf-4f8d-b4e2-3da8be684a49	Yvonne Acrylic Standee	140000	1	MERCHANDISE	\N	\N
c3b690cf-d896-4add-8a4a-f9471aa6230a	f8de8b0e-342f-4bbb-a243-c36768e6213d	7b84e2ce-3092-45b5-a88d-d442c1a3facd	Keychain Ichinose Asuna	30000	2	MERCHANDISE	\N	\N
d34f0e41-a2d0-4353-ab15-f3bb461b79ba	f8de8b0e-342f-4bbb-a243-c36768e6213d	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	1	MERCHANDISE	\N	\N
6bb44ca7-6663-451a-b8ca-b1e2fc91be57	eef4b711-fba2-4ba4-8f2d-6d835685c965	7b84e2ce-3092-45b5-a88d-d442c1a3facd	Keychain Ichinose Asuna	30000	1	MERCHANDISE	\N	\N
53c4ba14-ef01-4547-bdaf-e43067f19b8e	08e95d73-eaae-4acf-a487-2d33bdde800e	7b84e2ce-3092-45b5-a88d-d442c1a3facd	Keychain Ichinose Asuna	30000	3	MERCHANDISE	\N	\N
8856ddd0-6fa9-4e0b-a002-63b7df261e25	2f00dfef-b116-40a6-8150-56729c3b2ff9	7b84e2ce-3092-45b5-a88d-d442c1a3facd	Keychain Ichinose Asuna	30000	4	MERCHANDISE	\N	\N
16e7cc2a-8e09-4b54-b419-90cd143c0f59	a3cf662e-ee5e-4184-be06-94f3c840d8ca	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	6	MERCHANDISE	\N	\N
820a0404-83d4-4a59-8016-c8aaff27ebf4	73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M	JACKET
5ab32739-fd5b-4b7e-a7a4-9a0ef4157ea4	73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	JACKET	L	JACKET
53abf889-181a-4f5e-a205-1979e167cb6d	f8de8b0e-342f-4bbb-a243-c36768e6213d	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M	JACKET
289e8988-51c5-4171-90a6-27f3c9170b8b	49e5e7a0-786d-46be-9dcd-be1434ae7004	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	L	JACKET
dfd5ac8e-d13f-4b44-8206-0461cb74fc17	eef4b711-fba2-4ba4-8f2d-6d835685c965	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	JACKET	L	JACKET
f1f53a76-a7cf-451f-80cd-2d9e34d764eb	eef4b711-fba2-4ba4-8f2d-6d835685c965	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	1	TSHIRT	M	TSHIRT
544bab27-1b62-4e4c-a71f-11d26139c444	08e95d73-eaae-4acf-a487-2d33bdde800e	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M	JACKET
5f267d23-f554-460e-964e-2581e6abdbe8	7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M	JACKET
082b24dd-6ea4-48e0-a780-4b1f2d606b27	7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	JACKET	L	JACKET
7fe69918-6e89-473f-9bcc-749af765d3f5	c8208e68-2c38-4412-9be6-d307baa90203	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	1	TSHIRT	M	TSHIRT
861ef3f5-d7cf-44b8-abc6-d6f8d3bcfa6b	c8208e68-2c38-4412-9be6-d307baa90203	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	JACKET	L	JACKET
c0112e61-3193-4aa3-a7a1-334b1f486ec9	c8208e68-2c38-4412-9be6-d307baa90203	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M	JACKET
4a6232b2-c305-4343-8947-9d6195c1c4c2	2f00dfef-b116-40a6-8150-56729c3b2ff9	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M	JACKET
c0b13e24-2c5c-4fff-a78d-29803318f81a	2f00dfef-b116-40a6-8150-56729c3b2ff9	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	JACKET	L	JACKET
ddb3207c-36ea-4d58-8282-a6a2d6622643	2f00dfef-b116-40a6-8150-56729c3b2ff9	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	1	TSHIRT	M	TSHIRT
e0259456-4feb-4408-b2ac-a957461f34fb	a3cf662e-ee5e-4184-be06-94f3c840d8ca	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M	JACKET
088717c4-4091-49e1-a9c1-1542f9d969c4	a3cf662e-ee5e-4184-be06-94f3c840d8ca	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	JACKET	L	JACKET
cc8ac40e-c6ac-4ffb-89ef-afaaae5ae536	a3cf662e-ee5e-4184-be06-94f3c840d8ca	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	1	TSHIRT	M	TSHIRT
165e97c6-68f1-472b-9d62-2952566f955b	efa96de8-fc77-4cf8-8396-3e7929256b03	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	2	JACKET	M	JACKET
6dd2f870-af6b-4b9b-9eb8-18afda3a8a65	efa96de8-fc77-4cf8-8396-3e7929256b03	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	JACKET	L	JACKET
ff9a8545-1bbe-4c50-86c1-aedbdda7483f	efa96de8-fc77-4cf8-8396-3e7929256b03	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	1	TSHIRT	M	TSHIRT
\.


--
-- Data for Name: order_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."order_payments" ("id", "order_id", "payment_type", "expected_amount", "reported_amount", "proof_path", "internal_status", "internal_note", "uploaded_at", "checked_at", "checked_by") FROM stdin;
83e77d9e-303e-43b9-afa1-47fab99a4a3e	49e5e7a0-786d-46be-9dcd-be1434ae7004	INITIAL	400000	400000	orders/49e5e7a0-786d-46be-9dcd-be1434ae7004/64e3654b-1777-4538-af4d-11dd69b12153.png	PENDING	\N	2026-11-11 18:58:25.758664+00	\N	\N
5a3a4669-e27f-43c3-adc9-7bfc64123415	eef4b711-fba2-4ba4-8f2d-6d835685c965	INITIAL	340000	340000	orders/eef4b711-fba2-4ba4-8f2d-6d835685c965/0407b05e-ca0c-4656-b3a1-16ddc07b83aa.png	PENDING	\N	2026-11-11 18:58:25.758664+00	\N	\N
99d16c25-a62b-4b9f-8993-c08ff67ade76	f8de8b0e-342f-4bbb-a243-c36768e6213d	INITIAL	570000	570000	orders/f8de8b0e-342f-4bbb-a243-c36768e6213d/07c31f25-97db-4d8f-9fd9-8f8b9477ebf0.jpg	PENDING	\N	2026-11-11 18:58:25.758664+00	\N	\N
3d45878d-2189-4a5c-a610-dddd1b214102	73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	INITIAL	570000	570000	orders/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5.jpg	PENDING	\N	2026-11-11 18:58:25.758664+00	\N	\N
1c12e722-4fb1-4c8c-8ba5-8622196d1772	08e95d73-eaae-4acf-a487-2d33bdde800e	INITIAL	490000	490000	orders/08e95d73-eaae-4acf-a487-2d33bdde800e/6d277eb1-bf32-4289-914a-786398fbfa0f.jpg	PENDING	\N	2026-11-11 18:58:25.758664+00	\N	\N
47ad0b09-6376-4de8-a92c-795e3d918072	eef4b711-fba2-4ba4-8f2d-6d835685c965	SETTLEMENT	340000	340000	settlements/eef4b711-fba2-4ba4-8f2d-6d835685c965/4f52f320-520e-4387-bd48-6d0b30bb2f7a.jpg	PENDING	\N	2026-11-11 19:00:32.501317+00	\N	\N
646c2de7-1499-464d-8d14-b17486279dd6	73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	SETTLEMENT	570000	570000	settlements/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/245a691b-9097-4980-aaae-f2ab19b07d0f.jpg	PENDING	\N	2026-11-11 19:12:54.685165+00	\N	\N
65fd68f0-1b67-4f12-be42-06bf7b116ce2	7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7	INITIAL	500000	500000	orders/7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7/30fe04b4-5a2d-4a39-b4e0-d49946ddf4a2.jpg	PENDING	\N	2026-11-11 19:14:46.803487+00	\N	\N
b2718735-e696-4434-8444-7308ddb2427c	c8208e68-2c38-4412-9be6-d307baa90203	INITIAL	625000	625000	orders/c8208e68-2c38-4412-9be6-d307baa90203/5586351a-79cd-4551-be6a-fb58904cf1dd.jpg	PENDING	\N	2026-11-11 19:25:01.014073+00	\N	\N
ea956c01-be50-48f0-8911-8baf2dd64152	c8208e68-2c38-4412-9be6-d307baa90203	SETTLEMENT	625000	625000	settlements/c8208e68-2c38-4412-9be6-d307baa90203/08ccc6fd-4226-40d8-b8a5-f4442eb07adf.jpg	PENDING	\N	2026-11-11 19:26:42.675284+00	\N	\N
995d8e86-0287-42c2-a33f-429ab7062fba	7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7	SETTLEMENT	500000	500000	settlements/7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7/ca7a5eed-a178-4d90-ae3c-0755ad1b8143.jpg	PENDING	\N	2026-11-11 19:38:43.051042+00	\N	\N
71b44a8e-6d71-4d9e-ba11-c7fc82f9b7d2	2f00dfef-b116-40a6-8150-56729c3b2ff9	INITIAL	685000	685000	orders/2f00dfef-b116-40a6-8150-56729c3b2ff9/154ed114-83cd-477d-ac36-8b3656db40b0.jpg	PENDING	\N	2026-11-11 19:47:22.071975+00	\N	\N
dc53ef39-ac13-4be8-87df-961127b22115	2f00dfef-b116-40a6-8150-56729c3b2ff9	SETTLEMENT	685000	685000	settlements/2f00dfef-b116-40a6-8150-56729c3b2ff9/9cae779c-a9ea-4798-b3d5-0e484cd7ba9d.jpg	PENDING	\N	2026-11-11 19:48:34.39757+00	\N	\N
ff6f92cd-095c-4bfe-9f2d-9dd8ebba4898	a3cf662e-ee5e-4184-be06-94f3c840d8ca	INITIAL	655000	655000	orders/a3cf662e-ee5e-4184-be06-94f3c840d8ca/a42bf11f-855f-4b34-86fc-47b3c7207d25.jpg	PENDING	\N	2026-11-11 19:50:03.472757+00	\N	\N
d3483e8a-c788-42cc-9295-56bd81346394	a3cf662e-ee5e-4184-be06-94f3c840d8ca	SETTLEMENT	655000	655000	settlements/a3cf662e-ee5e-4184-be06-94f3c840d8ca/1667d915-bbd2-4d24-bcc4-21eaa6a5ad89.png	PENDING	\N	2026-11-11 20:00:37.199567+00	\N	\N
eed08f85-01e9-483d-b03d-8ee3e0ca54ad	efa96de8-fc77-4cf8-8396-3e7929256b03	INITIAL	875000	875000	orders/efa96de8-fc77-4cf8-8396-3e7929256b03/4d3707e7-cc07-4d55-bdf8-f195fada366d.jpg	PENDING	\N	2026-11-11 20:51:06.925088+00	\N	\N
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."profiles" ("id", "role", "display_name", "created_at") FROM stdin;
091bbc1b-3dde-4005-af30-6e309b8fdfeb	admin	itabaka@gmail.com	2026-09-23 12:09:08.977778+00
\.


--
-- Data for Name: promo_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."promo_members" ("id", "plate_code", "member_name", "discount_type", "discount_value", "is_active", "is_used", "used_order_id", "used_at", "created_at", "updated_at") FROM stdin;
9cbd8347-6bb2-41d1-8d34-4c13cf3a3213	D4444ERK	ibay	FIXED	100000	t	f	\N	\N	2026-11-11 18:18:31.1808+00	2026-11-11 18:35:48.069+00
a318a00a-884b-44e7-a8a1-4a6bb0ca0803	F4382FHS	Luqman Ahmad	FIXED	100000	t	t	08e95d73-eaae-4acf-a487-2d33bdde800e	2026-11-11 18:38:14.995355+00	2026-11-11 16:57:29.160192+00	2026-11-11 18:38:14.995355+00
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."site_settings" ("id", "site_name", "site_title", "site_description", "logo_url", "banner_url", "primary_color", "accent_color", "updated_at", "qris_image_url", "bca_account_name", "bca_account_number", "dp_percentage") FROM stdin;
1	ITABAKA	Pre-Order Itabaka CF24-A53	><><><><><><><><><><><	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/logo/248ef2ea-573d-42aa-987d-1b6ed139df5e.png	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/banner/435458b7-e93e-4132-a800-c1e251034d3d.png	#001eff	#ff0000	2026-10-12 13:53:36.554305+00	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/qris/36c6f124-c788-4aff-83c5-27d5b13a09e5.png	Fauzi Agung Gumelar	3462518142	50
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 73, true);


--
-- Name: order_invoice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."order_invoice_seq"', 51, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict wKIjjssTqnkAPzeouuR4j2EsiUo5EdZUnBMHLrjdcg068GuXPb9xMSVYmeb0qKx

RESET ALL;
