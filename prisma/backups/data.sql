SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict Vub9bKqjHEB1F9Mbfi2CyPtW1GAZr2p7UpdDTBmdIkDVBZFqFCnwOltREgfcFz3

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
00000000-0000-0000-0000-000000000000	091bbc1b-3dde-4005-af30-6e309b8fdfeb	authenticated	authenticated	itabaka@gmail.com	$2a$10$bZCffyi5CQOvJe71wmSSzO6WHMtal1lEB6/1dNSzuwqRt1TkyFCAK	2026-09-23 12:09:08.996733+00	\N		\N		\N			\N	2026-11-14 22:42:29.359055+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-09-23 12:09:08.980081+00	2026-11-14 22:42:29.375921+00	\N	\N			\N		0	\N		\N	f	\N	f
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
47785fd1-72ce-4846-a455-670cd0ab31c7	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-14 19:18:31.479372+00	2026-11-14 22:12:48.711518+00	\N	aal1	\N	2026-11-14 22:12:48.711437	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.250.136	\N	\N	\N	\N	\N
1b2ffbf1-44df-4047-9af0-9b04cc8ba75f	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-14 19:28:00.769232+00	2026-11-14 22:33:29.066204+00	\N	aal1	\N	2026-11-14 22:33:29.066109	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.250.136	\N	\N	\N	\N	\N
08eb3861-d1b6-4fdb-94d0-631ded32e7de	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-14 22:42:29.361107+00	2026-11-14 22:42:29.361107+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.250.136	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
47785fd1-72ce-4846-a455-670cd0ab31c7	2026-11-14 19:18:31.504464+00	2026-11-14 19:18:31.504464+00	password	b6828454-0650-4f6e-82c2-9d8a27dc46d1
1b2ffbf1-44df-4047-9af0-9b04cc8ba75f	2026-11-14 19:28:00.79286+00	2026-11-14 19:28:00.79286+00	password	63db67ff-3af9-4ae8-8805-3daa882a54d7
08eb3861-d1b6-4fdb-94d0-631ded32e7de	2026-11-14 22:42:29.38289+00	2026-11-14 22:42:29.38289+00	password	355dabf3-214a-4fbf-9b75-0cc1fec78615
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
00000000-0000-0000-0000-000000000000	81	uozjkcqt4zt3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 19:18:31.49182+00	2026-11-14 20:17:02.064858+00	\N	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	82	vkkhezb7bc6g	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 19:28:00.788412+00	2026-11-14 20:26:09.914754+00	\N	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	84	ddwzaeufloki	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 20:26:09.920566+00	2026-11-14 21:24:15.398574+00	vkkhezb7bc6g	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	83	uf6mobh4ndv2	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 20:17:02.075627+00	2026-11-14 22:12:48.675223+00	uozjkcqt4zt3	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	86	o75gfavve5zq	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-14 22:12:48.688374+00	2026-11-14 22:12:48.688374+00	uf6mobh4ndv2	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	85	qa42zrgvekpp	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 21:24:15.415327+00	2026-11-14 22:33:29.035618+00	ddwzaeufloki	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	87	pkph5xqtbkwq	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-14 22:33:29.04294+00	2026-11-14 22:33:29.04294+00	qa42zrgvekpp	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	88	bjvkjxk6wy6e	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-14 22:42:29.374258+00	2026-11-14 22:42:29.374258+00	\N	08eb3861-d1b6-4fdb-94d0-631ded32e7de
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
HOODIE	Hoodie	t	20	2026-11-11 21:46:32.990068+00	2026-11-11 21:46:32.990068+00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."orders" ("id", "invoice_no", "customer_name", "customer_email", "customer_address", "customer_phone", "payment_status", "total_amount", "paid_amount", "created_at", "updated_at", "customer_contact", "payment_plan", "payment_method", "payment_amount_due", "payment_proof_path", "payment_proof_uploaded_at", "proof_token", "delivery_method", "payment_verified_at", "notes", "subtotal_amount", "discount_amount", "promo_code", "customer_payment_status", "settlement_token", "settlement_proof_path", "settlement_proof_uploaded_at") FROM stdin;
49e5e7a0-786d-46be-9dcd-be1434ae7004	ITB-PO-2026-000044	Miracle	luqmankun9029@gmail.com	Jl. Hegarmanah 1b no 164, RT 002 RW 008, Kel. gunungbatu, Kec Bogor Barat, Kota Bogor	6282134656255	DP	400000	0	2026-11-11 18:17:09.596659+00	2026-11-11 18:58:25.758664+00	6282134656255	FULL	QRIS	400000	orders/49e5e7a0-786d-46be-9dcd-be1434ae7004/64e3654b-1777-4538-af4d-11dd69b12153.png	2026-11-11 18:17:10.026673+00	64e3654b-1777-4538-af4d-11dd69b12153	SHIP_TO_ADDRESS	\N	\N	500000	100000	F4382FHS	LUNAS	c10dab21-a3fb-4fec-9d9b-156f6af8fb3f	\N	\N
f8de8b0e-342f-4bbb-a243-c36768e6213d	ITB-PO-2026-000033	luqman	luqmankun9029@gmail.com	Jl. Hegarmanah 1b no 164, RT 002 RW 008, Kel. gunungbatu, Kec Bogor Barat, Kota Bogor	134234234234234	DP	570000	0	2026-10-14 07:07:23.563872+00	2026-11-11 18:58:25.758664+00	134234234234234	FULL	QRIS	570000	orders/f8de8b0e-342f-4bbb-a243-c36768e6213d/07c31f25-97db-4d8f-9fd9-8f8b9477ebf0.jpg	2026-10-14 07:07:23.965546+00	07c31f25-97db-4d8f-9fd9-8f8b9477ebf0	SHIP_TO_ADDRESS	\N	\N	\N	0	\N	LUNAS	3041fa65-d741-4c63-a8b0-b78aa5fee364	\N	\N
da987a0d-531b-440b-b577-9db6ece48cca	ITB-PO-2026-000052	cek full paymenr	luqmankun9029@gmail.com	\N	6282134656255	DP	300000	0	2026-11-14 17:44:25.15317+00	2026-11-14 17:44:25.850639+00	6282134656255	FULL	QRIS	300000	orders/da987a0d-531b-440b-b577-9db6ece48cca/0859f737-5149-432a-a96d-209f8534b41a.jpg	2026-11-14 17:44:25.850639+00	0859f737-5149-432a-a96d-209f8534b41a	BOOTH_CF24	\N	\N	300000	0	\N	LUNAS	65897c40-72b7-42d1-85da-df041a307009	\N	\N
08e95d73-eaae-4acf-a487-2d33bdde800e	ITB-PO-2026-000046	Miracle	luqmankun9029@gmail.com	\N	6282134656255	DP	490000	0	2026-11-11 18:38:14.995355+00	2026-11-11 18:58:25.758664+00	6282134656255	FULL	QRIS	490000	orders/08e95d73-eaae-4acf-a487-2d33bdde800e/6d277eb1-bf32-4289-914a-786398fbfa0f.jpg	2026-11-11 18:38:15.400763+00	6d277eb1-bf32-4289-914a-786398fbfa0f	BOOTH_CF24	\N	\N	590000	100000	F4382FHS	LUNAS	7d2a2211-0f95-4b83-9271-1a220472b087	\N	\N
eef4b711-fba2-4ba4-8f2d-6d835685c965	ITB-PO-2026-000045	ibay	ibay@gmail.com	\N	023984029384029	DP	680000	0	2026-11-11 18:18:48.757075+00	2026-11-11 19:00:32.501317+00	023984029384029	DP	QRIS	340000	orders/eef4b711-fba2-4ba4-8f2d-6d835685c965/0407b05e-ca0c-4656-b3a1-16ddc07b83aa.png	2026-11-11 18:18:49.140658+00	0407b05e-ca0c-4656-b3a1-16ddc07b83aa	BOOTH_CF24	\N	\N	780000	100000	D4444ERK	LUNAS	4f52f320-520e-4387-bd48-6d0b30bb2f7a	settlements/eef4b711-fba2-4ba4-8f2d-6d835685c965/4f52f320-520e-4387-bd48-6d0b30bb2f7a.jpg	2026-11-11 19:00:32.501317+00
c8208e68-2c38-4412-9be6-d307baa90203	ITB-PO-2026-000048	nana	luqmankun9029@gmail.com	\N	6282134656255	DP	1250000	0	2026-11-11 19:25:00.667202+00	2026-11-11 19:26:42.675284+00	6282134656255	DP	QRIS	625000	orders/c8208e68-2c38-4412-9be6-d307baa90203/5586351a-79cd-4551-be6a-fb58904cf1dd.jpg	2026-11-11 19:25:01.014073+00	5586351a-79cd-4551-be6a-fb58904cf1dd	BOOTH_CF24	\N	\N	1250000	0	\N	LUNAS	08ccc6fd-4226-40d8-b8a5-f4442eb07adf	settlements/c8208e68-2c38-4412-9be6-d307baa90203/08ccc6fd-4226-40d8-b8a5-f4442eb07adf.jpg	2026-11-11 19:26:42.675284+00
73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	ITB-PO-2026-000034	Miracle	luqmankun9029@gmail.com	\N	567567567575675	DP	1140000	0	2026-10-14 07:11:34.707861+00	2026-11-11 19:12:54.685165+00	567567567575675	DP	QRIS	570000	orders/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5.jpg	2026-10-14 07:11:35.052788+00	bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5	BOOTH_CF24	\N	\N	\N	0	\N	LUNAS	245a691b-9097-4980-aaae-f2ab19b07d0f	settlements/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/245a691b-9097-4980-aaae-f2ab19b07d0f.jpg	2026-11-11 19:12:54.685165+00
7b968ac4-d4dc-414c-95de-7f3ba48c3459	ITB-PO-2026-000054	Miracle	luqmankun9029@gmail.com	asasdasd	6282134656255	DP	2400000	0	2026-11-14 20:09:14.511923+00	2026-11-14 20:09:15.041511+00	6282134656255	FULL	QRIS	2400000	orders/7b968ac4-d4dc-414c-95de-7f3ba48c3459/b1127872-3df4-40c8-8083-b5486692ba66.jpg	2026-11-14 20:09:15.041511+00	b1127872-3df4-40c8-8083-b5486692ba66	SHIP_TO_ADDRESS	\N	\N	2500000	100000	F4382FHS	LUNAS	7be6590c-9e95-467d-a1a4-013881ace06f	\N	\N
7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7	ITB-PO-2026-000047	Miracle	luqmankun9029@gmail.com	\N	6282134656255	DP	1000000	0	2026-11-11 19:14:46.250008+00	2026-11-11 19:38:43.051042+00	6282134656255	DP	QRIS	500000	orders/7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7/30fe04b4-5a2d-4a39-b4e0-d49946ddf4a2.jpg	2026-11-11 19:14:46.803487+00	30fe04b4-5a2d-4a39-b4e0-d49946ddf4a2	BOOTH_CF24	\N	\N	1000000	0	\N	LUNAS	ca7a5eed-a178-4d90-ae3c-0755ad1b8143	settlements/7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7/ca7a5eed-a178-4d90-ae3c-0755ad1b8143.jpg	2026-11-11 19:38:43.051042+00
a3cf662e-ee5e-4184-be06-94f3c840d8ca	ITB-PO-2026-000050	rexa	luqmankun9029@gmail.com	\N	6282134656255	DP	1310000	0	2026-11-11 19:50:02.230028+00	2026-11-11 20:00:37.199567+00	6282134656255	DP	QRIS	655000	orders/a3cf662e-ee5e-4184-be06-94f3c840d8ca/a42bf11f-855f-4b34-86fc-47b3c7207d25.jpg	2026-11-11 19:50:03.472757+00	a42bf11f-855f-4b34-86fc-47b3c7207d25	BOOTH_CF24	\N	\N	1310000	0	\N	LUNAS	1667d915-bbd2-4d24-bcc4-21eaa6a5ad89	settlements/a3cf662e-ee5e-4184-be06-94f3c840d8ca/1667d915-bbd2-4d24-bcc4-21eaa6a5ad89.png	2026-11-11 20:00:37.199567+00
e12f97f9-0d82-464e-9d71-a62415142994	ITB-PO-2026-000053	ibay	ibya@gmail.com	siweouifwoefhjweoifjwoejfowefjowefjowiejfiowejfowiejfweiofwefwfwefw	359345098340598	DP	900000	0	2026-11-14 18:02:16.447865+00	2026-11-14 18:02:16.955242+00	359345098340598	FULL	QRIS	900000	orders/e12f97f9-0d82-464e-9d71-a62415142994/e435b58c-2e00-46cd-b7c3-4979a589ea7a.jpg	2026-11-14 18:02:16.955242+00	e435b58c-2e00-46cd-b7c3-4979a589ea7a	SHIP_TO_ADDRESS	\N	\N	1000000	100000	D4444ERK	LUNAS	0a9cb2df-29f9-4024-966c-14e4f06e476a	\N	\N
efa96de8-fc77-4cf8-8396-3e7929256b03	ITB-PO-2026-000051	aduy	luqmankun9029@gmail.com	\N	6282134656255	DP	1750000	0	2026-11-11 20:51:06.483173+00	2026-11-11 20:51:06.925088+00	6282134656255	DP	QRIS	875000	orders/efa96de8-fc77-4cf8-8396-3e7929256b03/4d3707e7-cc07-4d55-bdf8-f195fada366d.jpg	2026-11-11 20:51:06.925088+00	4d3707e7-cc07-4d55-bdf8-f195fada366d	BOOTH_CF24	\N	\N	1750000	0	\N	DP	da80c74d-7101-42fa-8539-e02464e11879	\N	\N
2f00dfef-b116-40a6-8150-56729c3b2ff9	ITB-PO-2026-000049	kiki	luqmankun9029@gmail.com	\N	6282134656255	DP	1370000	0	2026-11-11 19:47:21.67335+00	2026-11-11 19:48:34.39757+00	6282134656255	DP	QRIS	685000	orders/2f00dfef-b116-40a6-8150-56729c3b2ff9/154ed114-83cd-477d-ac36-8b3656db40b0.jpg	2026-11-11 19:47:22.071975+00	154ed114-83cd-477d-ac36-8b3656db40b0	BOOTH_CF24	\N	\N	1370000	0	\N	LUNAS	9cae779c-a9ea-4798-b3d5-0e484cd7ba9d	settlements/2f00dfef-b116-40a6-8150-56729c3b2ff9/9cae779c-a9ea-4798-b3d5-0e484cd7ba9d.jpg	2026-11-11 19:48:34.39757+00
c614cd78-232d-4c75-a2fa-5a4e1a92ec63	ITB-PO-2026-000056	Bambang	meh@gmail.com	Alam terbuka	08819237629	DP	50000	0	2026-11-14 22:27:53.682338+00	2026-11-14 22:27:55.443381+00	08819237629	FULL	QRIS	50000	orders/c614cd78-232d-4c75-a2fa-5a4e1a92ec63/0e0f3ead-afd8-4c0a-9eb2-a59e27e59fcd.png	2026-11-14 22:27:55.443381+00	0e0f3ead-afd8-4c0a-9eb2-a59e27e59fcd	SHIP_TO_ADDRESS	\N	\N	50000	0	\N	LUNAS	377c200f-ecfb-4a3b-890f-01cde387442d	\N	\N
d5d68efd-3496-4178-af05-eab4eb5f0fe8	ITB-PO-2026-000055	Miracle	luqmankun9029@gmail.com	\N	123523452353453	DP	450000	0	2026-11-14 20:24:57.489323+00	2026-11-14 20:24:57.9135+00	123523452353453	FULL	QRIS	450000	orders/d5d68efd-3496-4178-af05-eab4eb5f0fe8/3f0e5c31-596f-4012-bc15-e4367dab6d4e.jpg	2026-11-14 20:24:57.9135+00	3f0e5c31-596f-4012-bc15-e4367dab6d4e	BOOTH_CF24	\N	\N	550000	100000	D 2556 UDN	LUNAS	4506fa8e-f4c8-4650-9d8c-29bac875ed1e	\N	\N
e37db794-9fea-4778-9e41-fcbe8684f557	ITB-PO-2026-000057	luqman	luqman@gmail.com	wefwfjweifhjsldhfneosnosncosinvslkniofseofns	039485034859083	DP	500000	0	2026-11-14 22:36:58.506948+00	2026-11-14 22:36:58.885684+00	039485034859083	FULL	QRIS	500000	orders/e37db794-9fea-4778-9e41-fcbe8684f557/83b0b91a-6032-42ee-a902-6fdb64d4bd5b.png	2026-11-14 22:36:58.885684+00	83b0b91a-6032-42ee-a902-6fdb64d4bd5b	SHIP_TO_ADDRESS	\N	\N	500000	0	\N	LUNAS	075afbbb-562e-4043-be77-f811aba11a7c	\N	\N
dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f	ITB-PO-2026-000058	riski	asjdaslkj@gmail.com	\N	238523534905834	DP	550000	0	2026-11-14 22:42:09.492487+00	2026-11-14 22:42:09.795226+00	238523534905834	FULL	QRIS	550000	orders/dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f/58e50464-c61b-4a62-b123-aceaec910ede.jpg	2026-11-14 22:42:09.795226+00	58e50464-c61b-4a62-b123-aceaec910ede	BOOTH_CF24	\N	\N	650000	100000	D3508UCC	LUNAS	45a3b8d3-4c88-4c08-af25-3a85bd2fac3a	\N	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."products" ("id", "code", "name", "description", "price", "image_url", "stock", "active", "sort_order", "created_at", "updated_at", "category", "available_sizes", "apparel_type") FROM stdin;
7b84e2ce-3092-45b5-a88d-d442c1a3facd	ITB-004	Keychain Ichinose Asuna	Art by Oshii	30000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/b1f50c49-70be-4cff-b01d-f013db3964e3.png	0	t	0	2026-10-03 09:12:56.87318+00	2026-11-11 19:47:21.67335+00	MERCHANDISE	{}	\N
aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	ITB-003	C&C Sticker Pack	Art By Oshii	10000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/2aecb6c9-d2d3-410c-be71-7fbbe099470f.png	34	t	30	2026-09-23 12:03:15.698514+00	2026-11-14 20:24:57.489323+00	MERCHANDISE	{}	\N
03b97cd0-0eda-4b57-b740-99f2d68e5be4	ITB-005	Volkswagen Scirocco GT 24 Sunaookami Shiroko	Art by @hazaky	175000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/6c79e246-3528-4719-b5cf-92e326d3c524.png	0	t	0	2026-10-03 09:14:39.496659+00	2026-10-04 10:08:27.523227+00	MERCHANDISE	{}	\N
712e41e7-8d86-499d-868e-c3f28e51b5af	APP-001	Jaket ARA Biru	alskdlaskhjdlasjd	500000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/6ca79ea9-496b-446c-9857-fca79dd28143.png	0	t	0	2026-10-02 23:45:30.642821+00	2026-11-14 18:02:16.447865+00	APPAREL	{M,L,XL}	JACKET
04cdbbdf-07db-44f4-bcac-e6c9d12145c1	ITB-002	Ichinose Asuna School w R125 itansha photocard	askdjhawohaowhdalshdlawhdoihawod	50000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/2c1a05e9-a9c2-4985-95a3-a6934e1e9211.png	6	t	0	2026-11-14 22:05:24.654612+00	2026-11-14 22:42:09.492487+00	MERCHANDISE	{}	\N
8a637a2e-2359-449e-80ff-69c79669730e	APP-002	Tshirt	asdasdsa	250000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/7efce189-5faf-4d2b-92d9-7333d5d56729.jpg	2	t	0	2026-10-03 09:12:05.99958+00	2026-11-14 22:42:09.492487+00	APPAREL	{M,L,XL}	TSHIRT
2405f07d-b40c-4df2-a4ca-fb28f03219c2	ITB-006	Keychain GR Supra	art by.........	30000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/23601b3a-ac5a-4e75-8fcc-adf6884a5983.png	0	t	0	2026-10-03 17:33:52.146386+00	2026-10-12 13:34:02.284573+00	MERCHANDISE	{}	\N
6cf8ac72-c00a-4577-8535-138bca761e68	APP-003	Jaket ARA Merah	sdfsdfs	500000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/1f04210e-b89c-473d-9f9a-233efef4d7b9.png	0	t	0	2026-10-03 09:15:45.064886+00	2026-11-14 20:09:14.511923+00	APPAREL	{L,XL,2XL}	JACKET
4c614771-69cf-4f8d-b4e2-3da8be684a49	ITB-001	Yvonne Acrylic Standee	Art By Hameru	140000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/3997379b-1b76-454f-a614-84d0ff871219.png	3	t	10	2026-09-23 12:03:15.698514+00	2026-11-14 20:24:57.489323+00	MERCHANDISE	{}	\N
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
ea5d4c78-1f71-440b-a35d-7ff8e65a8216	da987a0d-531b-440b-b577-9db6ece48cca	4c614771-69cf-4f8d-b4e2-3da8be684a49	Yvonne Acrylic Standee	140000	2	MERCHANDISE	\N	\N
24cff061-da1d-442e-a45d-1836b253b416	da987a0d-531b-440b-b577-9db6ece48cca	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	2	MERCHANDISE	\N	\N
7cab88d0-dfdb-4b7e-9fb3-8afec00fdb77	e12f97f9-0d82-464e-9d71-a62415142994	712e41e7-8d86-499d-868e-c3f28e51b5af	Jaket ARA Biru	500000	2	APPAREL	M	JACKET
06683718-5105-4553-a0d1-44efc369d70a	7b968ac4-d4dc-414c-95de-7f3ba48c3459	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	APPAREL	L	JACKET
e68a1602-b91b-42b5-972d-aeea5b859da9	7b968ac4-d4dc-414c-95de-7f3ba48c3459	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	1	APPAREL	XL	JACKET
ea7da499-7b7e-46f9-9c7f-a8faae087b13	7b968ac4-d4dc-414c-95de-7f3ba48c3459	6cf8ac72-c00a-4577-8535-138bca761e68	Jaket ARA Merah	500000	3	APPAREL	2XL	JACKET
7ae71575-b872-4ef0-af71-c677cce1de24	d5d68efd-3496-4178-af05-eab4eb5f0fe8	4c614771-69cf-4f8d-b4e2-3da8be684a49	Yvonne Acrylic Standee	140000	2	MERCHANDISE	\N	\N
82c3d351-1155-4492-a4cc-839bea8b7e70	d5d68efd-3496-4178-af05-eab4eb5f0fe8	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	2	MERCHANDISE	\N	\N
b8135bbf-75d4-4fde-8819-67bbe51506ee	d5d68efd-3496-4178-af05-eab4eb5f0fe8	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	1	APPAREL	M	TSHIRT
c7f40813-507e-4cd9-99df-dedf0df4957d	c614cd78-232d-4c75-a2fa-5a4e1a92ec63	04cdbbdf-07db-44f4-bcac-e6c9d12145c1	Ichinose Asuna School w R125 itansha photocard	50000	1	MERCHANDISE	\N	\N
3bdbe7af-d835-4474-bee0-337050cca85c	e37db794-9fea-4778-9e41-fcbe8684f557	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	2	APPAREL	M	TSHIRT
2dff6ef0-a9a6-4329-8038-ef2d92ce011c	dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f	04cdbbdf-07db-44f4-bcac-e6c9d12145c1	Ichinose Asuna School w R125 itansha photocard	50000	3	MERCHANDISE	\N	\N
32b91c81-0a2f-4c36-9acb-9d03b88b7d40	dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	2	APPAREL	M	TSHIRT
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
e65e4c5f-20d7-420c-b1ec-9cb4b3d07382	da987a0d-531b-440b-b577-9db6ece48cca	INITIAL	300000	300000	orders/da987a0d-531b-440b-b577-9db6ece48cca/0859f737-5149-432a-a96d-209f8534b41a.jpg	PENDING	\N	2026-11-14 17:44:25.850639+00	\N	\N
21c6e156-9f54-47fe-b15a-301c63bcabcc	e12f97f9-0d82-464e-9d71-a62415142994	INITIAL	900000	900000	orders/e12f97f9-0d82-464e-9d71-a62415142994/e435b58c-2e00-46cd-b7c3-4979a589ea7a.jpg	PENDING	\N	2026-11-14 18:02:16.955242+00	\N	\N
3d0bc373-4107-4c93-91c0-78db335a7fab	7b968ac4-d4dc-414c-95de-7f3ba48c3459	INITIAL	2400000	2400000	orders/7b968ac4-d4dc-414c-95de-7f3ba48c3459/b1127872-3df4-40c8-8083-b5486692ba66.jpg	PENDING	\N	2026-11-14 20:09:15.041511+00	\N	\N
e227cddc-43b1-445a-a39e-201c5ba9461b	d5d68efd-3496-4178-af05-eab4eb5f0fe8	INITIAL	450000	450000	orders/d5d68efd-3496-4178-af05-eab4eb5f0fe8/3f0e5c31-596f-4012-bc15-e4367dab6d4e.jpg	PENDING	\N	2026-11-14 20:24:57.9135+00	\N	\N
f65bead9-39ea-4116-8719-497cc2139689	c614cd78-232d-4c75-a2fa-5a4e1a92ec63	INITIAL	50000	50000	orders/c614cd78-232d-4c75-a2fa-5a4e1a92ec63/0e0f3ead-afd8-4c0a-9eb2-a59e27e59fcd.png	PENDING	\N	2026-11-14 22:27:55.443381+00	\N	\N
462a419b-38e5-4575-b510-273bb8a588e9	e37db794-9fea-4778-9e41-fcbe8684f557	INITIAL	500000	500000	orders/e37db794-9fea-4778-9e41-fcbe8684f557/83b0b91a-6032-42ee-a902-6fdb64d4bd5b.png	PENDING	\N	2026-11-14 22:36:58.885684+00	\N	\N
509a924b-3313-472e-b6f8-9a6e7e7edafd	dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f	INITIAL	550000	550000	orders/dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f/58e50464-c61b-4a62-b123-aceaec910ede.jpg	PENDING	\N	2026-11-14 22:42:09.795226+00	\N	\N
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
6d57bd6d-4d8e-41bd-b878-ec889fc15326	D3508UCC	FATHUR RIZQI	FIXED	100000	t	t	dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f	2026-11-14 22:42:09.492487+00	2026-11-14 20:21:05.513538+00	2026-11-14 22:42:09.492487+00
a96d61e3-391e-4a95-83f4-3072028dd7d3	D1586YVL	ALFINDI	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
55dab504-e829-4d37-b926-5a7ed080c4d8	D4056ZCU	ERLANGGA FERDIANSYAH	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
be7885f2-c502-4be9-bda2-201259b6f9a7	D4520SBM	KLEINDA FATIMA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
3ec0076a-e1b1-443a-be5d-25ebb3247466	D6982ZDP	MUHAMAD RIZKI	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
72772e83-c15f-4ec7-b914-bac05d387b54	D2582SBQ	HANSEL	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
bbc7b69b-b0fc-4b2c-b4d8-21470cfe6973	F4382FHS	LUQMAN AHMAD	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
1f43e2ad-2e6d-4584-88a5-5529c5cfb9dd	D6087ZTT	MUHAMMAD IQBAL MAULANA FIRDAUS	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
9009f605-62f7-44fd-94bd-bbc9aa40cb9a	D2445SBE	MURTI LABIB MUSLIM	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
46fe7bcc-0c00-421c-8a2c-6d8b38ea611d	D4142ACP	RAKHA DITIA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
a970f41b-8d14-4870-b852-34d0d0a756e1	D3614AAA	ANDRI SETIAWAN	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
a7ffb24e-98db-4438-bf26-b958a089d865	D1341YTX	FAUZI AGUNG	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
1d90bb59-1d56-42a4-811c-51027c1552d4	D3965AEL	PRATA YUDA NUGRAHA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
46342eee-b048-45b7-ae84-974ae582ca43	D5903VCZ	WRINDHA IYANA H	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
6f0ca245-f3ff-49f3-988b-e98b5e6de502	D2627AEL	JONATHAN	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
947fdd9d-d5d4-4180-89cf-0bd34dd7ced2	D2958AEE	ALVIN ADITYA RENALDI	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
6fcb5ebe-393e-4944-9d35-63c6f4fb5268	D3074ZCC	SOFYAN CHOERUDIN	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
9378cf33-d146-4764-bd3c-cd28f1885f9c	D5247ADL	NAZMA KAUTSAR	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
a16c0789-8682-4540-9a97-668e792ef3e7	D6948FT	MUHAMAD RIZKY, M.HUM., M.H	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
25023048-cdc4-420b-8b55-c395f146ae07	D5453ABO	ADAM RAMADHAN	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
911fc6c7-df71-41d5-a2fc-bc83f5c9707a	D3812HK	JEFFRY	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
893ee952-2086-4db7-9b4a-a8c970daeffa	D6487VCJ	EGATAMMA NUGRAHA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
84c34a60-c647-4640-9c72-fe371f251eb4	D2058AAW	THEOFILLUS ARDITYA KURNIADI Y	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
40d102f2-41aa-4872-b670-77990e9c16a1	D6312UDT	YULIUS WILLIAM	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
9708d523-fe80-49cb-a848-7f8fcdcd895b	D4156ZFC	SANSAN FIRMANSYAH	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
001ed6ff-3d18-44f8-9896-084b83d06391	D6680OF	ABDILLAH AZIZ RIZKILILLAH	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
62f4539d-1bb4-4154-9f4d-eb98d65b7ee2	D4850VBX	RIZAL MAULANA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
a4be6059-1ab7-4110-b562-d8cb8929803e	D4873SGR	KEVIN DIAZ PRATAMA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
18e58e12-68a1-4498-8ddc-232970774d38	D2415ABH	WAHYU DWI NUGRAHA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
96ad9db5-38f7-4cfa-bce9-7b540e170a81	D4287ZFN	MOCH. REYZHA ADRIANSYAH	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
7febab39-2d3e-45e5-8d77-61636364da8f	D3527II	YUDHA NUGRAHA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
a1a7a17b-8a13-4357-8699-d45979050024	D4112GW	PANGESTU MUHAMAD RIZKI	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
68b81dde-81d2-49e0-8d5b-9af1197085ae	D4904GT	RICHARD MARTIN IBRAHIM	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
7cdf5a1c-c10d-4b4e-9f49-79a0692f3a10	D2556UDN	APRILIANA PURNAMA SIDIK	FIXED	100000	t	t	d5d68efd-3496-4178-af05-eab4eb5f0fe8	2026-11-14 20:24:57.489323+00	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."site_settings" ("id", "site_name", "site_title", "site_description", "logo_url", "banner_url", "primary_color", "accent_color", "updated_at", "qris_image_url", "bca_account_name", "bca_account_number", "dp_percentage", "full_payment_enabled") FROM stdin;
1	ITABAKA	Pre-Order Itabaka CF24-A53		https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/logo/248ef2ea-573d-42aa-987d-1b6ed139df5e.png	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/banner/a352ee6c-8985-4a07-84ea-9975ed98e6bc.png	#ffffff	#ff0000	2026-11-14 22:02:14.088856+00	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/qris/36c6f124-c788-4aff-83c5-27d5b13a09e5.png	Fauzi Agung Gumelar	3462518142	50	t
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 88, true);


--
-- Name: order_invoice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."order_invoice_seq"', 58, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict Vub9bKqjHEB1F9Mbfi2CyPtW1GAZr2p7UpdDTBmdIkDVBZFqFCnwOltREgfcFz3

RESET ALL;
