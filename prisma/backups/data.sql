SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict Uoym4KfApJStm5IVAxy1ODn6qfWtBtg5rDhyCoWc98f3DidhF0ww8xumdwopNNY

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
00000000-0000-0000-0000-000000000000	091bbc1b-3dde-4005-af30-6e309b8fdfeb	authenticated	authenticated	itabaka@gmail.com	$2a$10$bZCffyi5CQOvJe71wmSSzO6WHMtal1lEB6/1dNSzuwqRt1TkyFCAK	2026-09-23 12:09:08.996733+00	\N		\N		\N			\N	2026-11-11 11:41:32.888004+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-09-23 12:09:08.980081+00	2026-11-11 17:55:20.865244+00	\N	\N			\N		0	\N		\N	f	\N	f
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
e9ea1f56-c422-4e83-9e0f-63b80ded5f38	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-11 11:41:32.888717+00	2026-11-11 11:41:32.888717+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.218.134	\N	\N	\N	\N	\N
f6e4da56-7d32-4b59-9171-4db08617f9e8	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 08:08:47.244459+00	2026-10-03 08:08:47.244459+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	103.168.46.70	\N	\N	\N	\N	\N
567ba47b-c796-4e7c-ab98-3f034667fbf1	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-10 16:19:42.765108+00	2026-11-11 17:55:20.875249+00	\N	aal1	\N	2026-11-11 17:55:20.875169	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.218.132	\N	\N	\N	\N	\N
065eaef9-3f5f-4bad-9220-b18d464e80d3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 11:42:45.188772+00	2026-10-03 11:42:45.188772+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36	182.5.136.140	\N	\N	\N	\N	\N
31b0551e-c71b-4f6a-b764-3efcf67c0e68	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-10-03 13:40:22.893035+00	2026-10-03 13:40:22.893035+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 14; SM-A528B Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/153.0.8010.36 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/580.0.0.49.91;]	114.122.69.171	\N	\N	\N	\N	\N
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
00000000-0000-0000-0000-000000000000	63	hozcvhg37rqa	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-11 11:41:32.927568+00	2026-11-11 11:41:32.927568+00	\N	e9ea1f56-c422-4e83-9e0f-63b80ded5f38
00000000-0000-0000-0000-000000000000	62	ri5jnetygqi3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-10 16:19:42.801256+00	2026-11-11 16:56:19.060755+00	\N	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	64	anqcvr5ujp6i	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-11 16:56:19.079232+00	2026-11-11 17:55:20.842474+00	ri5jnetygqi3	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	65	ijb4unx7bplr	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-11 17:55:20.857688+00	2026-11-11 17:55:20.857688+00	anqcvr5ujp6i	567ba47b-c796-4e7c-ab98-3f034667fbf1
00000000-0000-0000-0000-000000000000	25	tothu6afqnh4	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-03 08:08:47.263362+00	2026-10-03 08:08:47.263362+00	\N	f6e4da56-7d32-4b59-9171-4db08617f9e8
00000000-0000-0000-0000-000000000000	23	txc75h6vgpzp	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 08:00:14.683964+00	2026-10-03 08:58:16.414766+00	\N	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	27	rhlwm6nk6aix	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 08:58:16.426983+00	2026-10-03 10:02:18.978237+00	txc75h6vgpzp	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	29	hkwsdqukmbvm	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-03 11:42:45.229428+00	2026-10-03 11:42:45.229428+00	\N	065eaef9-3f5f-4bad-9220-b18d464e80d3
00000000-0000-0000-0000-000000000000	26	eadzq3huwo3m	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 08:45:43.912563+00	2026-10-03 11:59:46.35072+00	\N	e34d4c42-b2f7-4ff3-b72a-58e3d9dba6ed
00000000-0000-0000-0000-000000000000	31	i32ivjnd5fr3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-10-03 13:40:22.923749+00	2026-10-03 13:40:22.923749+00	\N	31b0551e-c71b-4f6a-b764-3efcf67c0e68
00000000-0000-0000-0000-000000000000	28	lu62gzpbixk4	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 10:02:19.000708+00	2026-10-03 16:21:03.584469+00	rhlwm6nk6aix	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	24	wtxgzurvpbcp	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 08:00:29.060753+00	2026-10-03 17:00:20.291504+00	\N	91cf385c-87c5-4fdf-9192-63db0d4de2fc
00000000-0000-0000-0000-000000000000	32	pppaa47i77l7	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 16:21:03.611582+00	2026-10-03 17:19:04.511355+00	lu62gzpbixk4	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	34	2tbglxp7wsrh	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 17:19:04.520023+00	2026-10-03 18:17:22.369158+00	pppaa47i77l7	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	35	syc3ii4qt34a	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 18:17:22.377617+00	2026-10-04 10:06:21.948272+00	2tbglxp7wsrh	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	36	hjn6ijcv267i	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-04 10:06:21.974403+00	2026-10-04 13:39:13.457884+00	syc3ii4qt34a	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	37	unrt7hemi7ic	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-04 13:39:13.476568+00	2026-10-04 21:18:16.438824+00	hjn6ijcv267i	666b04e9-78af-4c13-8d1f-b22aaa783c20
00000000-0000-0000-0000-000000000000	33	ohtp2wzg4oav	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-10-03 17:00:20.306616+00	2026-10-04 21:29:12.338798+00	wtxgzurvpbcp	91cf385c-87c5-4fdf-9192-63db0d4de2fc
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
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."orders" ("id", "invoice_no", "customer_name", "customer_email", "customer_address", "customer_phone", "payment_status", "total_amount", "paid_amount", "created_at", "updated_at", "customer_contact", "payment_plan", "payment_method", "payment_amount_due", "payment_proof_path", "payment_proof_uploaded_at", "proof_token", "delivery_method", "payment_verified_at", "notes", "subtotal_amount", "discount_amount", "promo_code") FROM stdin;
f8de8b0e-342f-4bbb-a243-c36768e6213d	ITB-PO-2026-000033	luqman	luqmankun9029@gmail.com	Jl. Hegarmanah 1b no 164, RT 002 RW 008, Kel. gunungbatu, Kec Bogor Barat, Kota Bogor	134234234234234	DP	570000	0	2026-10-14 07:07:23.563872+00	2026-10-14 07:07:23.965546+00	134234234234234	FULL	QRIS	570000	orders/f8de8b0e-342f-4bbb-a243-c36768e6213d/07c31f25-97db-4d8f-9fd9-8f8b9477ebf0.jpg	2026-10-14 07:07:23.965546+00	07c31f25-97db-4d8f-9fd9-8f8b9477ebf0	SHIP_TO_ADDRESS	\N	\N	\N	0	\N
73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	ITB-PO-2026-000034	Miracle	luqmankun9029@gmail.com	\N	567567567575675	DP	1140000	0	2026-10-14 07:11:34.707861+00	2026-10-14 07:11:35.052788+00	567567567575675	DP	QRIS	570000	orders/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5.jpg	2026-10-14 07:11:35.052788+00	bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5	BOOTH_CF24	\N	\N	\N	0	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."products" ("id", "code", "name", "description", "price", "image_url", "stock", "active", "sort_order", "created_at", "updated_at", "category", "available_sizes") FROM stdin;
8a637a2e-2359-449e-80ff-69c79669730e	APP-002	Tshirt	asdasdsa	250000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/7efce189-5faf-4d2b-92d9-7333d5d56729.jpg	12	t	0	2026-10-03 09:12:05.99958+00	2026-10-14 06:57:06.271074+00	TSHIRT	{M,L,XL}
7b84e2ce-3092-45b5-a88d-d442c1a3facd	ITB-004	Keychain Ichinose Asuna	Art by Oshii	30000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/b1f50c49-70be-4cff-b01d-f013db3964e3.png	8	t	0	2026-10-03 09:12:56.87318+00	2026-10-14 07:07:23.563872+00	MERCHANDISE	{}
aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	ITB-003	C&C Sticker Pack	Art By Oshii	10000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/2aecb6c9-d2d3-410c-be71-7fbbe099470f.png	44	t	30	2026-09-23 12:03:15.698514+00	2026-10-14 07:07:23.563872+00	MERCHANDISE	{}
712e41e7-8d86-499d-868e-c3f28e51b5af	APP-001	Jaket ARA Biru	alskdlaskhjdlasjd	500000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/6ca79ea9-496b-446c-9857-fca79dd28143.png	10	t	0	2026-10-02 23:45:30.642821+00	2026-10-14 07:11:34.707861+00	JACKET	{M,L,XL}
03b97cd0-0eda-4b57-b740-99f2d68e5be4	ITB-005	Volkswagen Scirocco GT 24 Sunaookami Shiroko	Art by @hazaky	175000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/6c79e246-3528-4719-b5cf-92e326d3c524.png	0	t	0	2026-10-03 09:14:39.496659+00	2026-10-04 10:08:27.523227+00	MERCHANDISE	{}
6cf8ac72-c00a-4577-8535-138bca761e68	APP-003	Jaket ARA Merah	sdfsdfs	500000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/1f04210e-b89c-473d-9f9a-233efef4d7b9.png	11	t	0	2026-10-03 09:15:45.064886+00	2026-10-14 07:11:34.707861+00	JACKET	{L,XL,2XL}
4c614771-69cf-4f8d-b4e2-3da8be684a49	ITB-001	Yvonne Acrylic Standee	Art By Hameru	140000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/3997379b-1b76-454f-a614-84d0ff871219.png	7	t	10	2026-09-23 12:03:15.698514+00	2026-10-14 07:11:34.707861+00	MERCHANDISE	{}
2405f07d-b40c-4df2-a4ca-fb28f03219c2	ITB-006	Keychain GR Supra	art by.........	30000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/23601b3a-ac5a-4e75-8fcc-adf6884a5983.png	0	t	0	2026-10-03 17:33:52.146386+00	2026-10-12 13:34:02.284573+00	MERCHANDISE	{}
5fcd1542-709e-4ee0-b011-f27a9e928c67	ITB-002	Asuma Toki (Armed) Standee	art by rlayuta	140000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/d704779a-bb52-453b-9cff-9cb08994757e.png	0	t	20	2026-09-23 12:03:15.698514+00	2026-10-12 13:43:13.25542+00	MERCHANDISE	{}
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."order_items" ("id", "order_id", "product_id", "product_name", "unit_price", "quantity", "product_category", "size") FROM stdin;
820a0404-83d4-4a59-8016-c8aaff27ebf4	73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M
5ab32739-fd5b-4b7e-a7a4-9a0ef4157ea4	73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	JACKET	L
ae717c4e-543a-49cc-8b16-218031d5c9ea	73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	4c614771-69cf-4f8d-b4e2-3da8be684a49	Yvonne Acrylic Standee	140000	1	MERCHANDISE	\N
53abf889-181a-4f5e-a205-1979e167cb6d	f8de8b0e-342f-4bbb-a243-c36768e6213d	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	1	JACKET	M
c3b690cf-d896-4add-8a4a-f9471aa6230a	f8de8b0e-342f-4bbb-a243-c36768e6213d	7b84e2ce-3092-45b5-a88d-d442c1a3facd	Keychain Ichinose Asuna	30000	2	MERCHANDISE	\N
d34f0e41-a2d0-4353-ab15-f3bb461b79ba	f8de8b0e-342f-4bbb-a243-c36768e6213d	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	1	MERCHANDISE	\N
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
a318a00a-884b-44e7-a8a1-4a6bb0ca0803	F4382FHS	Luqman Ahmad	FIXED	100000	t	f	\N	\N	2026-11-11 16:57:29.160192+00	2026-11-11 17:00:29.264+00
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

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 65, true);


--
-- Name: order_invoice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."order_invoice_seq"', 39, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict Uoym4KfApJStm5IVAxy1ODn6qfWtBtg5rDhyCoWc98f3DidhF0ww8xumdwopNNY

RESET ALL;
