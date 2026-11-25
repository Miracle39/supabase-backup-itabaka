SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict HtR867UhBaICdf1BUq4pfidgvSEedkhis3Ego7nz5TZPBbW0xowEaMrSZSpCeXO

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.12

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
00000000-0000-0000-0000-000000000000	091bbc1b-3dde-4005-af30-6e309b8fdfeb	authenticated	authenticated	itabaka@gmail.com	$2a$10$bZCffyi5CQOvJe71wmSSzO6WHMtal1lEB6/1dNSzuwqRt1TkyFCAK	2026-09-23 12:09:08.996733+00	\N		\N		\N			\N	2026-11-19 22:10:49.140439+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-09-23 12:09:08.980081+00	2026-11-24 22:00:03.277401+00	\N	\N			\N		0	\N		\N	f	\N	f
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
08eb3861-d1b6-4fdb-94d0-631ded32e7de	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-14 22:42:29.361107+00	2026-11-14 22:42:29.361107+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	104.28.250.136	\N	\N	\N	\N	\N
08d4b75b-51e9-4667-9848-9052b3601b7c	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-19 22:10:49.002212+00	2026-11-19 22:10:49.002212+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.2 Mobile/15E148 Safari/604.1	104.28.218.132	\N	\N	\N	\N	\N
9dc962d1-8299-4d87-8d0b-0c9e79f54ab2	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-19 22:10:49.110899+00	2026-11-19 22:10:49.110899+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.2 Mobile/15E148 Safari/604.1	104.28.218.132	\N	\N	\N	\N	\N
c5d53ff9-6a3b-44c1-b0e9-717faee61f7b	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-19 22:10:49.130857+00	2026-11-19 22:10:49.130857+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.2 Mobile/15E148 Safari/604.1	104.28.218.132	\N	\N	\N	\N	\N
654598b8-667e-45b3-8d35-e9ca9779a64e	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-19 22:10:49.140537+00	2026-11-19 22:10:49.140537+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.2 Mobile/15E148 Safari/604.1	104.28.218.132	\N	\N	\N	\N	\N
47785fd1-72ce-4846-a455-670cd0ab31c7	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-14 19:18:31.479372+00	2026-11-22 18:13:28.657736+00	\N	aal1	\N	2026-11-22 18:13:28.657651	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36	104.28.218.132	\N	\N	\N	\N	\N
1b2ffbf1-44df-4047-9af0-9b04cc8ba75f	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-14 19:28:00.769232+00	2026-11-24 18:48:51.973389+00	\N	aal1	\N	2026-11-24 18:48:51.973304	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36	104.28.218.132	\N	\N	\N	\N	\N
c6c89255-1eb0-494e-ba4f-9c4395c98c2e	091bbc1b-3dde-4005-af30-6e309b8fdfeb	2026-11-19 22:10:49.122076+00	2026-11-24 22:00:03.29798+00	\N	aal1	\N	2026-11-24 22:00:03.297882	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.2 Mobile/15E148 Safari/604.1	104.28.218.132	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
47785fd1-72ce-4846-a455-670cd0ab31c7	2026-11-14 19:18:31.504464+00	2026-11-14 19:18:31.504464+00	password	b6828454-0650-4f6e-82c2-9d8a27dc46d1
1b2ffbf1-44df-4047-9af0-9b04cc8ba75f	2026-11-14 19:28:00.79286+00	2026-11-14 19:28:00.79286+00	password	63db67ff-3af9-4ae8-8805-3daa882a54d7
08eb3861-d1b6-4fdb-94d0-631ded32e7de	2026-11-14 22:42:29.38289+00	2026-11-14 22:42:29.38289+00	password	355dabf3-214a-4fbf-9b75-0cc1fec78615
08d4b75b-51e9-4667-9848-9052b3601b7c	2026-11-19 22:10:49.078731+00	2026-11-19 22:10:49.078731+00	password	2ebf1781-0b6b-49ca-86a6-7a245394422a
9dc962d1-8299-4d87-8d0b-0c9e79f54ab2	2026-11-19 22:10:49.117704+00	2026-11-19 22:10:49.117704+00	password	7f2c1678-e3cc-4050-ace0-1c964b9851bd
c6c89255-1eb0-494e-ba4f-9c4395c98c2e	2026-11-19 22:10:49.127372+00	2026-11-19 22:10:49.127372+00	password	d11ed66b-cb02-41f9-928a-01f91b9a59d7
c5d53ff9-6a3b-44c1-b0e9-717faee61f7b	2026-11-19 22:10:49.136354+00	2026-11-19 22:10:49.136354+00	password	0105b2fc-5c4e-4bd4-8fc2-051fbf0cc7a9
654598b8-667e-45b3-8d35-e9ca9779a64e	2026-11-19 22:10:49.146632+00	2026-11-19 22:10:49.146632+00	password	42d7a4bb-dda1-4f5b-99dc-2400f61728cc
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

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at", "expires_at", "link_token_hash") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
00000000-0000-0000-0000-000000000000	81	uozjkcqt4zt3	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 19:18:31.49182+00	2026-11-14 20:17:02.064858+00	\N	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	82	vkkhezb7bc6g	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 19:28:00.788412+00	2026-11-14 20:26:09.914754+00	\N	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	84	ddwzaeufloki	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 20:26:09.920566+00	2026-11-14 21:24:15.398574+00	vkkhezb7bc6g	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	83	uf6mobh4ndv2	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 20:17:02.075627+00	2026-11-14 22:12:48.675223+00	uozjkcqt4zt3	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	85	qa42zrgvekpp	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 21:24:15.415327+00	2026-11-14 22:33:29.035618+00	ddwzaeufloki	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	88	bjvkjxk6wy6e	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-14 22:42:29.374258+00	2026-11-14 22:42:29.374258+00	\N	08eb3861-d1b6-4fdb-94d0-631ded32e7de
00000000-0000-0000-0000-000000000000	86	o75gfavve5zq	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 22:12:48.688374+00	2026-11-16 10:47:56.167054+00	uf6mobh4ndv2	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	90	z4cesm5szojs	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-19 22:10:49.036234+00	2026-11-19 22:10:49.036234+00	\N	08d4b75b-51e9-4667-9848-9052b3601b7c
00000000-0000-0000-0000-000000000000	91	fsn2fvtpgxaz	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-19 22:10:49.114185+00	2026-11-19 22:10:49.114185+00	\N	9dc962d1-8299-4d87-8d0b-0c9e79f54ab2
00000000-0000-0000-0000-000000000000	93	u3bpdtobq276	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-19 22:10:49.133027+00	2026-11-19 22:10:49.133027+00	\N	c5d53ff9-6a3b-44c1-b0e9-717faee61f7b
00000000-0000-0000-0000-000000000000	94	ftbnqylz7lot	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-19 22:10:49.142666+00	2026-11-19 22:10:49.142666+00	\N	654598b8-667e-45b3-8d35-e9ca9779a64e
00000000-0000-0000-0000-000000000000	92	vnvvrtjnzfpf	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-19 22:10:49.124019+00	2026-11-20 01:52:03.91296+00	\N	c6c89255-1eb0-494e-ba4f-9c4395c98c2e
00000000-0000-0000-0000-000000000000	95	nwoul56ed3aj	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-20 01:52:03.933895+00	2026-11-20 04:59:48.758806+00	vnvvrtjnzfpf	c6c89255-1eb0-494e-ba4f-9c4395c98c2e
00000000-0000-0000-0000-000000000000	89	m67fhtnncipc	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-16 10:47:56.192193+00	2026-11-22 15:05:30.375788+00	o75gfavve5zq	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	97	4es636usudds	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-22 15:05:30.397048+00	2026-11-22 17:12:45.278178+00	m67fhtnncipc	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	87	pkph5xqtbkwq	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-14 22:33:29.04294+00	2026-11-22 17:14:38.76815+00	qa42zrgvekpp	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	98	tzyugqnk74pa	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-22 17:12:45.28654+00	2026-11-22 18:13:28.631271+00	4es636usudds	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	100	odam46c3jav7	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-22 18:13:28.64325+00	2026-11-22 18:13:28.64325+00	tzyugqnk74pa	47785fd1-72ce-4846-a455-670cd0ab31c7
00000000-0000-0000-0000-000000000000	99	ra3waxys5gvo	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-22 17:14:38.770648+00	2026-11-24 15:41:15.022888+00	pkph5xqtbkwq	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	101	qpqfmuj5xh6q	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-24 15:41:15.047115+00	2026-11-24 16:44:47.815138+00	ra3waxys5gvo	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	102	5amrip2phykm	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-24 16:44:47.821941+00	2026-11-24 17:45:17.781434+00	qpqfmuj5xh6q	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	103	uvrbwbbfr4jp	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-24 17:45:17.794459+00	2026-11-24 18:48:51.924868+00	5amrip2phykm	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	104	eqypfnop3xpu	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-24 18:48:51.942815+00	2026-11-24 18:48:51.942815+00	uvrbwbbfr4jp	1b2ffbf1-44df-4047-9af0-9b04cc8ba75f
00000000-0000-0000-0000-000000000000	96	tijqj5p6bay7	091bbc1b-3dde-4005-af30-6e309b8fdfeb	t	2026-11-20 04:59:48.773648+00	2026-11-24 22:00:03.257503+00	nwoul56ed3aj	c6c89255-1eb0-494e-ba4f-9c4395c98c2e
00000000-0000-0000-0000-000000000000	105	3p4klqodmzzs	091bbc1b-3dde-4005-af30-6e309b8fdfeb	f	2026-11-24 22:00:03.271223+00	2026-11-24 22:00:03.271223+00	tijqj5p6bay7	c6c89255-1eb0-494e-ba4f-9c4395c98c2e
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at", "disabled") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format", "dedicated_scope") FROM stdin;
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

COPY "public"."orders" ("id", "invoice_no", "customer_name", "customer_email", "customer_address", "customer_phone", "payment_status", "total_amount", "paid_amount", "created_at", "updated_at", "customer_contact", "payment_plan", "payment_method", "payment_amount_due", "payment_proof_path", "payment_proof_uploaded_at", "proof_token", "delivery_method", "payment_verified_at", "notes", "subtotal_amount", "discount_amount", "promo_code", "customer_payment_status", "settlement_token", "settlement_proof_path", "settlement_proof_uploaded_at", "payment_provider", "payment_gateway_status", "payment_gateway_payment_type", "payment_gateway_bank", "payment_gateway_order_id", "payment_gateway_transaction_id", "payment_gateway_transaction_time", "payment_gateway_settlement_time") FROM stdin;
49e5e7a0-786d-46be-9dcd-be1434ae7004	ITB-PO-2026-000044	Miracle	luqmankun9029@gmail.com	Jl. Hegarmanah 1b no 164, RT 002 RW 008, Kel. gunungbatu, Kec Bogor Barat, Kota Bogor	6282134656255	DP	400000	0	2026-11-11 18:17:09.596659+00	2026-11-11 18:58:25.758664+00	6282134656255	FULL	QRIS	400000	orders/49e5e7a0-786d-46be-9dcd-be1434ae7004/64e3654b-1777-4538-af4d-11dd69b12153.png	2026-11-11 18:17:10.026673+00	64e3654b-1777-4538-af4d-11dd69b12153	SHIP_TO_ADDRESS	\N	\N	500000	100000	F4382FHS	LUNAS	c10dab21-a3fb-4fec-9d9b-156f6af8fb3f	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
f8de8b0e-342f-4bbb-a243-c36768e6213d	ITB-PO-2026-000033	luqman	luqmankun9029@gmail.com	Jl. Hegarmanah 1b no 164, RT 002 RW 008, Kel. gunungbatu, Kec Bogor Barat, Kota Bogor	134234234234234	DP	570000	0	2026-10-14 07:07:23.563872+00	2026-11-11 18:58:25.758664+00	134234234234234	FULL	QRIS	570000	orders/f8de8b0e-342f-4bbb-a243-c36768e6213d/07c31f25-97db-4d8f-9fd9-8f8b9477ebf0.jpg	2026-10-14 07:07:23.965546+00	07c31f25-97db-4d8f-9fd9-8f8b9477ebf0	SHIP_TO_ADDRESS	\N	\N	\N	0	\N	LUNAS	3041fa65-d741-4c63-a8b0-b78aa5fee364	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
da987a0d-531b-440b-b577-9db6ece48cca	ITB-PO-2026-000052	cek full paymenr	luqmankun9029@gmail.com	\N	6282134656255	DP	300000	0	2026-11-14 17:44:25.15317+00	2026-11-14 17:44:25.850639+00	6282134656255	FULL	QRIS	300000	orders/da987a0d-531b-440b-b577-9db6ece48cca/0859f737-5149-432a-a96d-209f8534b41a.jpg	2026-11-14 17:44:25.850639+00	0859f737-5149-432a-a96d-209f8534b41a	BOOTH_CF24	\N	\N	300000	0	\N	LUNAS	65897c40-72b7-42d1-85da-df041a307009	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
08e95d73-eaae-4acf-a487-2d33bdde800e	ITB-PO-2026-000046	Miracle	luqmankun9029@gmail.com	\N	6282134656255	DP	490000	0	2026-11-11 18:38:14.995355+00	2026-11-11 18:58:25.758664+00	6282134656255	FULL	QRIS	490000	orders/08e95d73-eaae-4acf-a487-2d33bdde800e/6d277eb1-bf32-4289-914a-786398fbfa0f.jpg	2026-11-11 18:38:15.400763+00	6d277eb1-bf32-4289-914a-786398fbfa0f	BOOTH_CF24	\N	\N	590000	100000	F4382FHS	LUNAS	7d2a2211-0f95-4b83-9271-1a220472b087	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
eef4b711-fba2-4ba4-8f2d-6d835685c965	ITB-PO-2026-000045	ibay	ibay@gmail.com	\N	023984029384029	DP	680000	0	2026-11-11 18:18:48.757075+00	2026-11-11 19:00:32.501317+00	023984029384029	DP	QRIS	340000	orders/eef4b711-fba2-4ba4-8f2d-6d835685c965/0407b05e-ca0c-4656-b3a1-16ddc07b83aa.png	2026-11-11 18:18:49.140658+00	0407b05e-ca0c-4656-b3a1-16ddc07b83aa	BOOTH_CF24	\N	\N	780000	100000	D4444ERK	LUNAS	4f52f320-520e-4387-bd48-6d0b30bb2f7a	settlements/eef4b711-fba2-4ba4-8f2d-6d835685c965/4f52f320-520e-4387-bd48-6d0b30bb2f7a.jpg	2026-11-11 19:00:32.501317+00	MANUAL	\N	\N	\N	\N	\N	\N	\N
c8208e68-2c38-4412-9be6-d307baa90203	ITB-PO-2026-000048	nana	luqmankun9029@gmail.com	\N	6282134656255	DP	1250000	0	2026-11-11 19:25:00.667202+00	2026-11-11 19:26:42.675284+00	6282134656255	DP	QRIS	625000	orders/c8208e68-2c38-4412-9be6-d307baa90203/5586351a-79cd-4551-be6a-fb58904cf1dd.jpg	2026-11-11 19:25:01.014073+00	5586351a-79cd-4551-be6a-fb58904cf1dd	BOOTH_CF24	\N	\N	1250000	0	\N	LUNAS	08ccc6fd-4226-40d8-b8a5-f4442eb07adf	settlements/c8208e68-2c38-4412-9be6-d307baa90203/08ccc6fd-4226-40d8-b8a5-f4442eb07adf.jpg	2026-11-11 19:26:42.675284+00	MANUAL	\N	\N	\N	\N	\N	\N	\N
73257fa3-f4f2-4e1f-afe1-0d9ab0d52016	ITB-PO-2026-000034	Miracle	luqmankun9029@gmail.com	\N	567567567575675	DP	1140000	0	2026-10-14 07:11:34.707861+00	2026-11-11 19:12:54.685165+00	567567567575675	DP	QRIS	570000	orders/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5.jpg	2026-10-14 07:11:35.052788+00	bc795ad8-e9c9-4d8b-ab89-51c5b230f0b5	BOOTH_CF24	\N	\N	\N	0	\N	LUNAS	245a691b-9097-4980-aaae-f2ab19b07d0f	settlements/73257fa3-f4f2-4e1f-afe1-0d9ab0d52016/245a691b-9097-4980-aaae-f2ab19b07d0f.jpg	2026-11-11 19:12:54.685165+00	MANUAL	\N	\N	\N	\N	\N	\N	\N
7b968ac4-d4dc-414c-95de-7f3ba48c3459	ITB-PO-2026-000054	Miracle	luqmankun9029@gmail.com	asasdasd	6282134656255	DP	2400000	0	2026-11-14 20:09:14.511923+00	2026-11-14 20:09:15.041511+00	6282134656255	FULL	QRIS	2400000	orders/7b968ac4-d4dc-414c-95de-7f3ba48c3459/b1127872-3df4-40c8-8083-b5486692ba66.jpg	2026-11-14 20:09:15.041511+00	b1127872-3df4-40c8-8083-b5486692ba66	SHIP_TO_ADDRESS	\N	\N	2500000	100000	F4382FHS	LUNAS	7be6590c-9e95-467d-a1a4-013881ace06f	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7	ITB-PO-2026-000047	Miracle	luqmankun9029@gmail.com	\N	6282134656255	DP	1000000	0	2026-11-11 19:14:46.250008+00	2026-11-11 19:38:43.051042+00	6282134656255	DP	QRIS	500000	orders/7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7/30fe04b4-5a2d-4a39-b4e0-d49946ddf4a2.jpg	2026-11-11 19:14:46.803487+00	30fe04b4-5a2d-4a39-b4e0-d49946ddf4a2	BOOTH_CF24	\N	\N	1000000	0	\N	LUNAS	ca7a5eed-a178-4d90-ae3c-0755ad1b8143	settlements/7a99e0ab-a86a-4a12-9d1b-e26eb3a2a6a7/ca7a5eed-a178-4d90-ae3c-0755ad1b8143.jpg	2026-11-11 19:38:43.051042+00	MANUAL	\N	\N	\N	\N	\N	\N	\N
a3cf662e-ee5e-4184-be06-94f3c840d8ca	ITB-PO-2026-000050	rexa	luqmankun9029@gmail.com	\N	6282134656255	DP	1310000	0	2026-11-11 19:50:02.230028+00	2026-11-11 20:00:37.199567+00	6282134656255	DP	QRIS	655000	orders/a3cf662e-ee5e-4184-be06-94f3c840d8ca/a42bf11f-855f-4b34-86fc-47b3c7207d25.jpg	2026-11-11 19:50:03.472757+00	a42bf11f-855f-4b34-86fc-47b3c7207d25	BOOTH_CF24	\N	\N	1310000	0	\N	LUNAS	1667d915-bbd2-4d24-bcc4-21eaa6a5ad89	settlements/a3cf662e-ee5e-4184-be06-94f3c840d8ca/1667d915-bbd2-4d24-bcc4-21eaa6a5ad89.png	2026-11-11 20:00:37.199567+00	MANUAL	\N	\N	\N	\N	\N	\N	\N
e12f97f9-0d82-464e-9d71-a62415142994	ITB-PO-2026-000053	ibay	ibya@gmail.com	siweouifwoefhjweoifjwoejfowefjowefjowiejfiowejfowiejfweiofwefwfwefw	359345098340598	DP	900000	0	2026-11-14 18:02:16.447865+00	2026-11-14 18:02:16.955242+00	359345098340598	FULL	QRIS	900000	orders/e12f97f9-0d82-464e-9d71-a62415142994/e435b58c-2e00-46cd-b7c3-4979a589ea7a.jpg	2026-11-14 18:02:16.955242+00	e435b58c-2e00-46cd-b7c3-4979a589ea7a	SHIP_TO_ADDRESS	\N	\N	1000000	100000	D4444ERK	LUNAS	0a9cb2df-29f9-4024-966c-14e4f06e476a	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
efa96de8-fc77-4cf8-8396-3e7929256b03	ITB-PO-2026-000051	aduy	luqmankun9029@gmail.com	\N	6282134656255	DP	1750000	0	2026-11-11 20:51:06.483173+00	2026-11-11 20:51:06.925088+00	6282134656255	DP	QRIS	875000	orders/efa96de8-fc77-4cf8-8396-3e7929256b03/4d3707e7-cc07-4d55-bdf8-f195fada366d.jpg	2026-11-11 20:51:06.925088+00	4d3707e7-cc07-4d55-bdf8-f195fada366d	BOOTH_CF24	\N	\N	1750000	0	\N	DP	da80c74d-7101-42fa-8539-e02464e11879	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
2f00dfef-b116-40a6-8150-56729c3b2ff9	ITB-PO-2026-000049	kiki	luqmankun9029@gmail.com	\N	6282134656255	DP	1370000	0	2026-11-11 19:47:21.67335+00	2026-11-11 19:48:34.39757+00	6282134656255	DP	QRIS	685000	orders/2f00dfef-b116-40a6-8150-56729c3b2ff9/154ed114-83cd-477d-ac36-8b3656db40b0.jpg	2026-11-11 19:47:22.071975+00	154ed114-83cd-477d-ac36-8b3656db40b0	BOOTH_CF24	\N	\N	1370000	0	\N	LUNAS	9cae779c-a9ea-4798-b3d5-0e484cd7ba9d	settlements/2f00dfef-b116-40a6-8150-56729c3b2ff9/9cae779c-a9ea-4798-b3d5-0e484cd7ba9d.jpg	2026-11-11 19:48:34.39757+00	MANUAL	\N	\N	\N	\N	\N	\N	\N
c614cd78-232d-4c75-a2fa-5a4e1a92ec63	ITB-PO-2026-000056	Bambang	meh@gmail.com	Alam terbuka	08819237629	DP	50000	0	2026-11-14 22:27:53.682338+00	2026-11-14 22:27:55.443381+00	08819237629	FULL	QRIS	50000	orders/c614cd78-232d-4c75-a2fa-5a4e1a92ec63/0e0f3ead-afd8-4c0a-9eb2-a59e27e59fcd.png	2026-11-14 22:27:55.443381+00	0e0f3ead-afd8-4c0a-9eb2-a59e27e59fcd	SHIP_TO_ADDRESS	\N	\N	50000	0	\N	LUNAS	377c200f-ecfb-4a3b-890f-01cde387442d	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
d5d68efd-3496-4178-af05-eab4eb5f0fe8	ITB-PO-2026-000055	Miracle	luqmankun9029@gmail.com	\N	123523452353453	DP	450000	0	2026-11-14 20:24:57.489323+00	2026-11-14 20:24:57.9135+00	123523452353453	FULL	QRIS	450000	orders/d5d68efd-3496-4178-af05-eab4eb5f0fe8/3f0e5c31-596f-4012-bc15-e4367dab6d4e.jpg	2026-11-14 20:24:57.9135+00	3f0e5c31-596f-4012-bc15-e4367dab6d4e	BOOTH_CF24	\N	\N	550000	100000	D 2556 UDN	LUNAS	4506fa8e-f4c8-4650-9d8c-29bac875ed1e	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
e37db794-9fea-4778-9e41-fcbe8684f557	ITB-PO-2026-000057	luqman	luqman@gmail.com	wefwfjweifhjsldhfneosnosncosinvslkniofseofns	039485034859083	DP	500000	0	2026-11-14 22:36:58.506948+00	2026-11-14 22:36:58.885684+00	039485034859083	FULL	QRIS	500000	orders/e37db794-9fea-4778-9e41-fcbe8684f557/83b0b91a-6032-42ee-a902-6fdb64d4bd5b.png	2026-11-14 22:36:58.885684+00	83b0b91a-6032-42ee-a902-6fdb64d4bd5b	SHIP_TO_ADDRESS	\N	\N	500000	0	\N	LUNAS	075afbbb-562e-4043-be77-f811aba11a7c	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f	ITB-PO-2026-000058	riski	asjdaslkj@gmail.com	\N	238523534905834	DP	550000	0	2026-11-14 22:42:09.492487+00	2026-11-14 22:42:09.795226+00	238523534905834	FULL	QRIS	550000	orders/dfd1e6c9-e3ca-41cc-86ac-194cb11d5a2f/58e50464-c61b-4a62-b123-aceaec910ede.jpg	2026-11-14 22:42:09.795226+00	58e50464-c61b-4a62-b123-aceaec910ede	BOOTH_CF24	\N	\N	650000	100000	D3508UCC	LUNAS	45a3b8d3-4c88-4c08-af25-3a85bd2fac3a	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
c3aa1732-887f-4c6b-91c5-0ad3d41a702c	ITB-PO-2026-000059	Luqman ahmad	39luqman.ahmad@gmail.com	Jl hegarmanah 1b	082134656255	DP	290000	0	2026-11-19 22:06:25.085527+00	2026-11-19 22:06:25.883254+00	082134656255	FULL	QRIS	290000	orders/c3aa1732-887f-4c6b-91c5-0ad3d41a702c/394f25bf-5de6-45e7-a411-6c0746b444ad.png	2026-11-19 22:06:25.883254+00	394f25bf-5de6-45e7-a411-6c0746b444ad	SHIP_TO_ADDRESS	\N	\N	390000	100000	F4382FHS	LUNAS	fa747633-9772-4613-9d06-1e94ec98c967	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
dae51826-81bb-4443-81ac-a6908de96707	ITB-PO-2026-000061	tes midtrans  va	luqmankun9029@gmail.com	\N	6282134656255	LUNAS	200000	200000	2026-11-22 18:23:07.827701+00	2026-11-22 18:23:56.150852+00	6282134656255	FULL	QRIS	200000	\N	\N	37505cb5-e991-41ed-9afe-485a2031bfb4	BOOTH_CF24	2026-11-22 18:23:56.048+00	\N	200000	0	\N	LUNAS	03e2d415-e0e2-4c84-906f-8f4536de203a	\N	\N	MIDTRANS	SETTLEMENT	bank_transfer	bca	ITB-PO-2026-000061-M1	cb5a8614-e5fd-4139-ba31-84be0d3030ff	2026-11-22 18:23:45+00	2026-11-22 18:23:55+00
88004298-8aea-4e16-9fd8-5f2f97044459	ITB-PO-2026-000064	cek midtrans payment	luqmankun9029@gmail.com	\N	6282134656255	LUNAS	120000	120000	2026-11-24 15:46:29.654671+00	2026-11-24 15:46:47.645501+00	6282134656255	FULL	QRIS	120000	\N	\N	5e6f34d3-694f-47e1-b252-9eb56b640926	BOOTH_CF24	2026-11-24 15:46:47.324+00	\N	120000	0	\N	LUNAS	08d606be-c676-48f7-9425-58f8c8eb9fee	\N	\N	MIDTRANS	SETTLEMENT	bank_transfer	bca	ITB-PO-2026-000064-M1	a04f83aa-d912-46d9-9b9b-939ef3203bf8	2026-11-24 15:46:36+00	2026-11-24 15:46:46+00
25571122-075f-47df-ae64-f0d342d2c531	ITB-PO-2026-000062	ngetes midtrans baru	luqmankun9029@gmail.com	\N	6282134656255	LUNAS	300000	300000	2026-11-24 15:41:47.170688+00	2026-11-24 15:42:20.623704+00	6282134656255	FULL	QRIS	300000	\N	\N	a5a2c21b-f32d-4a08-9f27-a7dddba43c93	BOOTH_CF24	2026-11-24 15:42:20.525+00	\N	300000	0	\N	LUNAS	a0fa879f-4301-4f60-86cf-19a83e3810f7	\N	\N	MIDTRANS	SETTLEMENT	qris	\N	ITB-PO-2026-000062-M1	7072ab45-5626-4b07-bb66-bbc44a417f55	2026-11-24 15:42:01+00	2026-11-24 15:42:18+00
f4b530ed-67cf-4212-bc27-537cb1aa9e29	ITB-PO-2026-000067	cek manual	manual@gmail.com	\N	209384023840238	DP	450000	0	2026-11-24 17:50:13.597043+00	2026-11-24 17:50:14.116643+00	209384023840238	FULL	QRIS	450000	orders/f4b530ed-67cf-4212-bc27-537cb1aa9e29/c78e2b5b-d961-40b5-aaea-70db83344939.jpg	2026-11-24 17:50:14.116643+00	c78e2b5b-d961-40b5-aaea-70db83344939	BOOTH_CF24	\N	\N	450000	0	\N	LUNAS	0f14f794-1a76-4725-bc6f-5f9e77a5e737	\N	\N	MANUAL	\N	\N	\N	\N	\N	\N	\N
a45a2d36-41a2-427e-a1c9-e191a2ff015b	ITB-PO-2026-000069	tes loading lagi	tes@gmail.com	\N	235235235234234	LUNAS	400000	400000	2026-11-24 18:03:21.776037+00	2026-11-24 18:03:32.102457+00	235235235234234	FULL	QRIS	400000	\N	\N	5e4e2768-9c54-4ea2-ba9d-e8ec57efc08a	BOOTH_CF24	2026-11-24 18:03:31.981+00	\N	400000	0	\N	LUNAS	ce5c12d3-bfc3-4371-8d82-2b6908190598	\N	\N	MIDTRANS	SETTLEMENT	bank_transfer	bca	ITB-PO-2026-000069-M1	b07e6eb7-ded9-482a-a34f-2ae8212791ba	2026-11-24 18:03:26+00	2026-11-24 18:03:31+00
221cf316-6346-414d-8a1c-8748058a3378	ITB-PO-2026-000065	nazma kauysar	nazma@gmail.com	\N	456849864756945	LUNAS	100000	100000	2026-11-24 15:54:29.473792+00	2026-11-24 15:54:48.857627+00	456849864756945	FULL	QRIS	100000	\N	\N	5b85a363-9400-4988-9329-e0fe85fda0f1	BOOTH_CF24	2026-11-24 15:54:48.738+00	\N	100000	0	\N	LUNAS	91e09fde-c8cb-4c7e-a8bf-e2f5e473de63	\N	\N	MIDTRANS	SETTLEMENT	bank_transfer	bca	ITB-PO-2026-000065-M1	9b715d23-54dd-45df-b72b-3c78e07e7bca	2026-11-24 15:54:37+00	2026-11-24 15:54:47+00
e7a749fb-cd50-451c-9819-894a05374693	ITB-PO-2026-000063	hmm cek lagi midtrans	luqmankun9029@gmail.com	\N	6282134656255	LUNAS	100000	100000	2026-11-24 15:43:04.127358+00	2026-11-24 15:44:27.11008+00	6282134656255	FULL	QRIS	100000	\N	\N	d4a9abe2-79f3-4b8b-b02b-b8b52e7f5f37	BOOTH_CF24	2026-11-24 15:44:26.996+00	\N	100000	0	\N	LUNAS	5a196e1d-a988-4dab-acee-1db8d5a73933	\N	\N	MIDTRANS	SETTLEMENT	echannel	\N	ITB-PO-2026-000063-M1	8bb46fd2-b975-412b-855a-e375dfd46516	2026-11-24 15:43:57+00	2026-11-24 15:44:25+00
728df606-6ffb-4dca-9a70-09273e69d6ff	ITB-PO-2026-000060	midtrans sandbox	luqmankun9029@gmail.com	\N	6282134656255	LUNAS	250000	250000	2026-11-22 17:26:06.16507+00	2026-11-22 18:14:07.941685+00	6282134656255	FULL	QRIS	250000	\N	\N	fcd8333e-4dec-4b73-a6f7-a2c350bd584f	BOOTH_CF24	2026-11-22 18:14:07.811+00	\N	350000	100000	F4382FHS	LUNAS	8c3ae488-ae08-42f4-8433-0d9a0cb9cb77	\N	\N	MIDTRANS	SETTLEMENT	qris	\N	ITB-PO-2026-000060-M2	e26cc6e0-540a-474a-b163-113326e4822b	2026-11-22 17:54:23+00	2026-11-22 18:14:06+00
0b4f143b-9cbe-47c2-a91b-b3e4ef72dae8	ITB-PO-2026-000070	Luqman dari hp	luqmanhp@gmail.com	\N	515181881815518	DP	400000	0	2026-11-24 22:01:56.03772+00	2026-11-24 22:02:30.469148+00	515181881815518	FULL	QRIS	400000	\N	\N	4d6a03c7-e5d7-4ea1-a476-fe88980f4623	BOOTH_CF24	\N	\N	400000	0	\N	DP	7b6c9319-2fa5-424d-bdea-e0c081319b54	\N	\N	MIDTRANS	PENDING	\N	\N	ITB-PO-2026-000070-M1	\N	\N	\N
50c2e18d-4023-4532-b667-77381d621851	ITB-PO-2026-000068	tes animasi invoice	invoice@gmail.com	\N	230028502384029	LUNAS	400000	400000	2026-11-24 17:57:57.991115+00	2026-11-24 17:58:10.627582+00	230028502384029	FULL	QRIS	400000	\N	\N	32d71f56-d205-4e7f-b2ba-fc7be482a7af	BOOTH_CF24	2026-11-24 17:58:10.54+00	\N	400000	0	\N	LUNAS	c7e194b6-add5-4fe0-9d2d-87a0cc562411	\N	\N	MIDTRANS	SETTLEMENT	bank_transfer	bca	ITB-PO-2026-000068-M1	c5a76b96-1844-4c4d-8d84-ce8e5a9bae19	2026-11-24 17:58:01+00	2026-11-24 17:58:09+00
dea31f2a-49a1-488a-bede-65a6833144b7	ITB-PO-2026-000066	tes setelah ganti layout	tes@gmail.com	\N	235235235235235	LUNAS	600000	600000	2026-11-24 17:48:14.421189+00	2026-11-24 17:48:37.562926+00	235235235235235	FULL	QRIS	600000	\N	\N	12b0d38f-dd63-4b78-9a8b-a161e7600c6f	BOOTH_CF24	2026-11-24 17:48:37.41+00	\N	700000	100000	F4382FHS	LUNAS	63882af3-7fdf-4a6c-be1d-20889a7ef9b0	\N	\N	MIDTRANS	SETTLEMENT	bank_transfer	bca	ITB-PO-2026-000066-M1	0f3b9aaf-036a-407c-bf9b-1c68a5b841d1	2026-11-24 17:48:29+00	2026-11-24 17:48:36+00
\.


--
-- Data for Name: midtrans_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."midtrans_transactions" ("id", "order_id", "midtrans_order_id", "snap_token", "redirect_url", "gross_amount", "transaction_status", "transaction_id", "payment_type", "bank", "fraud_status", "status_code", "transaction_time", "settlement_time", "notification_payload", "signature_verified_at", "created_at", "updated_at") FROM stdin;
4da2a1ec-3147-4be2-b8dd-b61ebc4a8848	728df606-6ffb-4dca-9a70-09273e69d6ff	ITB-PO-2026-000060-M1	\N	\N	250000	FAILURE	\N	\N	\N	\N	\N	\N	\N	{"error": "Unauthorized"}	\N	2026-11-22 17:37:15.024435+00	2026-11-22 17:37:15.344+00
d0f3e01b-264f-480e-af7f-c8cce55d7c20	728df606-6ffb-4dca-9a70-09273e69d6ff	ITB-PO-2026-000060-M2	9327e538-46b2-47ae-a7e7-bb4946120030	https://app.sandbox.midtrans.com/snap/v4/redirection/9327e538-46b2-47ae-a7e7-bb4946120030	250000	SETTLEMENT	e26cc6e0-540a-474a-b163-113326e4822b	qris	\N	accept	200	2026-11-22 17:54:23+00	2026-11-22 18:14:06+00	{"issuer": "gopay", "pop_id": "e022cc5e-1196-4870-a30a-8fb151f5a310", "acquirer": "gopay", "currency": "IDR", "order_id": "ITB-PO-2026-000060-M2", "expiry_time": "2026-11-24 00:54:23", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "250000.00", "payment_type": "qris", "signature_key": "f6c8a0c6a6e438a9acb72162965cc3bb1dfc743400d557b4e50dd5bd43894709a9af500ce707f00d3b43118bc4fa6d2af6adc46363583f77969ad3dceb4cf121", "status_message": "midtrans payment notification", "transaction_id": "e26cc6e0-540a-474a-b163-113326e4822b", "settlement_time": "2026-11-23 01:14:06", "customer_details": {"email": "luqmankun9029@gmail.com", "phone": "+6282134656255", "full_name": "midtrans sandbox"}, "transaction_time": "2026-11-23 00:54:23", "transaction_type": "on-us", "transaction_status": "settlement", "merchant_cross_reference_id": "01bd330b-b459-499b-b626-47f8a5dfc358"}	2026-11-22 18:14:07.811+00	2026-11-22 17:52:26.243512+00	2026-11-22 18:14:07.811+00
fdb154f9-8f70-4e9d-9792-0c56301ccbb3	dae51826-81bb-4443-81ac-a6908de96707	ITB-PO-2026-000061-M1	5bfb1ffa-47e1-443a-97cd-27bce7cab042	https://app.sandbox.midtrans.com/snap/v4/redirection/5bfb1ffa-47e1-443a-97cd-27bce7cab042	200000	SETTLEMENT	cb5a8614-e5fd-4139-ba31-84be0d3030ff	bank_transfer	bca	accept	200	2026-11-22 18:23:45+00	2026-11-22 18:23:55+00	{"currency": "IDR", "order_id": "ITB-PO-2026-000061-M1", "va_numbers": [{"bank": "bca", "va_number": "86389398589400770241820"}], "expiry_time": "2026-11-24 01:23:45", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "200000.00", "payment_type": "bank_transfer", "signature_key": "7ece305db6e0fa0d3807409e783b3dff59b01cc0dbd8a03d18c49c17c1ca32b11afa80f0622d3647c401a34f5d4003d4f31441718192daaaff34576e8353a572", "status_message": "midtrans payment notification", "transaction_id": "cb5a8614-e5fd-4139-ba31-84be0d3030ff", "payment_amounts": [], "settlement_time": "2026-11-23 01:23:55", "customer_details": {"email": "luqmankun9029@gmail.com", "phone": "+6282134656255", "full_name": "tes midtrans  va"}, "transaction_time": "2026-11-23 01:23:45", "transaction_status": "settlement"}	2026-11-22 18:23:56.048+00	2026-11-22 18:23:08.978178+00	2026-11-22 18:23:56.048+00
b0a12301-b264-41c4-81d8-62e5f4aa6d9c	e7a749fb-cd50-451c-9819-894a05374693	ITB-PO-2026-000063-M1	60766441-9f46-4ddf-bba8-d4cf71012e10	https://app.sandbox.midtrans.com/snap/v4/redirection/60766441-9f46-4ddf-bba8-d4cf71012e10	100000	SETTLEMENT	8bb46fd2-b975-412b-855a-e375dfd46516	echannel	\N	accept	200	2026-11-24 15:43:57+00	2026-11-24 15:44:25+00	{"bill_key": "578057533971", "currency": "IDR", "order_id": "ITB-PO-2026-000063-M1", "biller_code": "70012", "expiry_time": "2026-11-25 22:43:57", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "100000.00", "payment_type": "echannel", "signature_key": "b14715516009e9a687c9dcd958e53e2973aa8f0861135b33d1e4592057ffb507358646435ecc51eb5de2ca0eec12f841540a07f43ba623da3e4102374fb042dc", "status_message": "midtrans payment notification", "transaction_id": "8bb46fd2-b975-412b-855a-e375dfd46516", "settlement_time": "2026-11-24 22:44:25", "customer_details": {"email": "luqmankun9029@gmail.com", "phone": "+6282134656255", "full_name": "hmm cek lagi midtrans"}, "transaction_time": "2026-11-24 22:43:57", "transaction_status": "settlement"}	2026-11-24 15:44:26.996+00	2026-11-24 15:43:04.852089+00	2026-11-24 15:44:26.996+00
6bfe0d03-e891-434a-a841-8d198e235529	25571122-075f-47df-ae64-f0d342d2c531	ITB-PO-2026-000062-M1	3aae9a50-98ab-42b1-a954-e77976b44884	https://app.sandbox.midtrans.com/snap/v4/redirection/3aae9a50-98ab-42b1-a954-e77976b44884	300000	SETTLEMENT	7072ab45-5626-4b07-bb66-bbc44a417f55	qris	\N	accept	200	2026-11-24 15:42:01+00	2026-11-24 15:42:18+00	{"issuer": "gopay", "pop_id": "e022cc5e-1196-4870-a30a-8fb151f5a310", "acquirer": "gopay", "currency": "IDR", "order_id": "ITB-PO-2026-000062-M1", "expiry_time": "2026-11-25 22:42:01", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "300000.00", "payment_type": "qris", "signature_key": "e998d3356848faaf18b4db065d650c7e28319d8de24496a0deb82955fc409566d539ca511f47a3947d9869523dd69bb02f1ca855177965298ddd21126e44ec08", "status_message": "midtrans payment notification", "transaction_id": "7072ab45-5626-4b07-bb66-bbc44a417f55", "settlement_time": "2026-11-24 22:42:18", "customer_details": {"email": "luqmankun9029@gmail.com", "phone": "+6282134656255", "full_name": "ngetes midtrans baru"}, "transaction_time": "2026-11-24 22:42:01", "transaction_type": "on-us", "transaction_status": "settlement", "merchant_cross_reference_id": "01bd330b-b459-499b-b626-47f8a5dfc358"}	2026-11-24 15:42:20.525+00	2026-11-24 15:41:48.627883+00	2026-11-24 15:42:20.525+00
aae984a0-d633-43c5-8ec1-ae883f2711a3	88004298-8aea-4e16-9fd8-5f2f97044459	ITB-PO-2026-000064-M1	033c1f1b-9556-4819-8cc1-e426527ecdce	https://app.sandbox.midtrans.com/snap/v4/redirection/033c1f1b-9556-4819-8cc1-e426527ecdce	120000	SETTLEMENT	a04f83aa-d912-46d9-9b9b-939ef3203bf8	bank_transfer	bca	accept	200	2026-11-24 15:46:36+00	2026-11-24 15:46:46+00	{"currency": "IDR", "order_id": "ITB-PO-2026-000064-M1", "va_numbers": [{"bank": "bca", "va_number": "86389892679226316505534"}], "expiry_time": "2026-11-25 22:46:36", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "120000.00", "payment_type": "bank_transfer", "signature_key": "13ff3d8b9a2a1a70db9f09ba55781cf8a9fc261472bccf63991934076fe366858e21c8d241636fae7555993eb177d8ee946787162fdd20669b24fedb34a9d5ed", "status_message": "midtrans payment notification", "transaction_id": "a04f83aa-d912-46d9-9b9b-939ef3203bf8", "payment_amounts": [], "settlement_time": "2026-11-24 22:46:46", "customer_details": {"email": "luqmankun9029@gmail.com", "phone": "+6282134656255", "full_name": "cek midtrans payment"}, "transaction_time": "2026-11-24 22:46:36", "transaction_status": "settlement"}	2026-11-24 15:46:47.324+00	2026-11-24 15:46:30.4013+00	2026-11-24 15:46:47.324+00
4d255abc-336e-4e5d-9b36-1b0080e25a08	221cf316-6346-414d-8a1c-8748058a3378	ITB-PO-2026-000065-M1	c8aaabf0-7374-43e9-8eb9-54e6dd9d01b6	https://app.sandbox.midtrans.com/snap/v4/redirection/c8aaabf0-7374-43e9-8eb9-54e6dd9d01b6	100000	SETTLEMENT	9b715d23-54dd-45df-b72b-3c78e07e7bca	bank_transfer	bca	accept	200	2026-11-24 15:54:37+00	2026-11-24 15:54:47+00	{"currency": "IDR", "order_id": "ITB-PO-2026-000065-M1", "va_numbers": [{"bank": "bca", "va_number": "86389904119587007199312"}], "expiry_time": "2026-11-25 22:54:37", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "100000.00", "payment_type": "bank_transfer", "signature_key": "bf876fd0ae8401aeeb618d1c51fb718a7fb7e0d89517df453bc95d3ee45beda96860e41c259126f276167384949ffa23a181edba83494ece0cb9e03384872182", "status_message": "midtrans payment notification", "transaction_id": "9b715d23-54dd-45df-b72b-3c78e07e7bca", "payment_amounts": [], "settlement_time": "2026-11-24 22:54:47", "customer_details": {"email": "nazma@gmail.com", "phone": "456849864756945", "full_name": "nazma kauysar"}, "transaction_time": "2026-11-24 22:54:37", "transaction_status": "settlement"}	2026-11-24 15:54:48.738+00	2026-11-24 15:54:30.564932+00	2026-11-24 15:54:48.738+00
6706175b-b02e-478b-8714-b343886bdc51	dea31f2a-49a1-488a-bede-65a6833144b7	ITB-PO-2026-000066-M1	b1b0d4da-4909-4c6b-b12d-32c8ba00d9fd	https://app.sandbox.midtrans.com/snap/v4/redirection/b1b0d4da-4909-4c6b-b12d-32c8ba00d9fd	600000	SETTLEMENT	0f3b9aaf-036a-407c-bf9b-1c68a5b841d1	bank_transfer	bca	accept	200	2026-11-24 17:48:29+00	2026-11-24 17:48:36+00	{"currency": "IDR", "order_id": "ITB-PO-2026-000066-M1", "va_numbers": [{"bank": "bca", "va_number": "86389605409889903006956"}], "expiry_time": "2026-11-26 00:48:29", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "600000.00", "payment_type": "bank_transfer", "signature_key": "be1d6bee6ff175bdbfc3de6c698848758ed8cb263e12a54ed446a2fa6ec2b89f13fe80faa395ad89cd6a734f093445f1dd5e156b92555a31bbca3388201ea571", "status_message": "midtrans payment notification", "transaction_id": "0f3b9aaf-036a-407c-bf9b-1c68a5b841d1", "payment_amounts": [], "settlement_time": "2026-11-25 00:48:36", "customer_details": {"email": "tes@gmail.com", "phone": "235235235235235", "full_name": "tes setelah ganti layout"}, "transaction_time": "2026-11-25 00:48:29", "transaction_status": "settlement"}	2026-11-24 17:48:37.41+00	2026-11-24 17:48:15.508031+00	2026-11-24 17:48:37.41+00
eb1b3f3a-19ad-4cbb-bd67-fa1ba9e2b484	50c2e18d-4023-4532-b667-77381d621851	ITB-PO-2026-000068-M1	62adcc5f-131e-4f38-9f03-d32a0e8cde1c	https://app.sandbox.midtrans.com/snap/v4/redirection/62adcc5f-131e-4f38-9f03-d32a0e8cde1c	400000	SETTLEMENT	c5a76b96-1844-4c4d-8d84-ce8e5a9bae19	bank_transfer	bca	accept	200	2026-11-24 17:58:01+00	2026-11-24 17:58:09+00	{"currency": "IDR", "order_id": "ITB-PO-2026-000068-M1", "va_numbers": [{"bank": "bca", "va_number": "86389655017935070696889"}], "expiry_time": "2026-11-26 00:58:01", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "400000.00", "payment_type": "bank_transfer", "signature_key": "fb11fe2a3fcae1153cb0c5e7b12b98b4e5e190719bdb943110c52853e2ff1a0adc03dff377301a53ede2f10c0110d4c6eea28e798d556c0cc7a9045520b0b507", "status_message": "midtrans payment notification", "transaction_id": "c5a76b96-1844-4c4d-8d84-ce8e5a9bae19", "payment_amounts": [], "settlement_time": "2026-11-25 00:58:09", "customer_details": {"email": "invoice@gmail.com", "phone": "230028502384029", "full_name": "tes animasi invoice"}, "transaction_time": "2026-11-25 00:58:01", "transaction_status": "settlement"}	2026-11-24 17:58:10.54+00	2026-11-24 17:57:59.042192+00	2026-11-24 17:58:10.54+00
fe3307a6-fff7-4948-b05d-e3448d0ba7b9	a45a2d36-41a2-427e-a1c9-e191a2ff015b	ITB-PO-2026-000069-M1	6af9608a-f64b-4bbc-8bab-12ad2782c4c6	https://app.sandbox.midtrans.com/snap/v4/redirection/6af9608a-f64b-4bbc-8bab-12ad2782c4c6	400000	SETTLEMENT	b07e6eb7-ded9-482a-a34f-2ae8212791ba	bank_transfer	bca	accept	200	2026-11-24 18:03:26+00	2026-11-24 18:03:31+00	{"currency": "IDR", "order_id": "ITB-PO-2026-000069-M1", "va_numbers": [{"bank": "bca", "va_number": "86389262233291095779033"}], "expiry_time": "2026-11-26 01:03:26", "merchant_id": "M664486389", "status_code": "200", "fraud_status": "accept", "gross_amount": "400000.00", "payment_type": "bank_transfer", "signature_key": "8047634b5f55e5b59559b3fd184dcf449fe32d4f9dc28f5fad44178640f9d0314826eea2bc82a25cd7e3b435a79acb2c8427f2a7a74743f53938c28bc1d8a5eb", "status_message": "midtrans payment notification", "transaction_id": "b07e6eb7-ded9-482a-a34f-2ae8212791ba", "payment_amounts": [], "settlement_time": "2026-11-25 01:03:31", "customer_details": {"email": "tes@gmail.com", "phone": "235235235234234", "full_name": "tes loading lagi"}, "transaction_time": "2026-11-25 01:03:26", "transaction_status": "settlement"}	2026-11-24 18:03:31.981+00	2026-11-24 18:03:22.982372+00	2026-11-24 18:03:31.981+00
4ba71c3f-7df6-4cbf-9177-201b30addd84	0b4f143b-9cbe-47c2-a91b-b3e4ef72dae8	ITB-PO-2026-000070-M1	154eb80f-fe88-4786-91e1-463d4880689a	https://app.sandbox.midtrans.com/snap/v4/redirection/154eb80f-fe88-4786-91e1-463d4880689a	400000	PENDING	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-11-24 22:01:57.114653+00	2026-11-24 22:01:57.596+00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."products" ("id", "code", "name", "description", "price", "image_url", "stock", "active", "sort_order", "created_at", "updated_at", "category", "available_sizes", "apparel_type", "featured") FROM stdin;
7b84e2ce-3092-45b5-a88d-d442c1a3facd	ITB-004	Keychain Ichinose Asuna	Art by Oshii	30000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/b1f50c49-70be-4cff-b01d-f013db3964e3.png	0	t	0	2026-10-03 09:12:56.87318+00	2026-11-11 19:47:21.67335+00	MERCHANDISE	{}	\N	f
aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	ITB-003	C&C Sticker Pack	Art By Oshii	10000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/2aecb6c9-d2d3-410c-be71-7fbbe099470f.png	0	t	30	2026-09-23 12:03:15.698514+00	2026-11-24 15:54:29.473792+00	MERCHANDISE	{}	\N	f
03b97cd0-0eda-4b57-b740-99f2d68e5be4	ITB-005	Volkswagen Scirocco GT 24 Sunaookami Shiroko	Art by @hazaky	175000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/6c79e246-3528-4719-b5cf-92e326d3c524.png	0	t	0	2026-10-03 09:14:39.496659+00	2026-10-04 10:08:27.523227+00	MERCHANDISE	{}	\N	f
712e41e7-8d86-499d-868e-c3f28e51b5af	APP-001	Jaket ARA Biru	alskdlaskhjdlasjd	500000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/6ca79ea9-496b-446c-9857-fca79dd28143.png	0	t	0	2026-10-02 23:45:30.642821+00	2026-11-14 18:02:16.447865+00	APPAREL	{M,L,XL}	JACKET	f
c7c87c22-78b2-40ec-8a04-83c493dc0b1b	APP-004	v1	asdasd	300000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/8de82a55-65a4-4298-9c23-ca9c61b036ce.png	4	t	0	2026-11-24 16:48:28.414432+00	2026-11-24 17:48:14.421189+00	APPAREL	{M,L,XL}	HOODIE	f
a8e991fc-b5ab-487c-886a-b385eac8a3dd	ITB-008	terus produk	asdasdasda	250000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/2b30cfed-0933-4b8c-ad3c-c54cd5327b9f.png	9	t	0	2026-11-24 16:47:58.836645+00	2026-11-24 17:50:13.597043+00	MERCHANDISE	{}	\N	f
2405f07d-b40c-4df2-a4ca-fb28f03219c2	ITB-006	Keychain GR Supra	art by.........	30000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/23601b3a-ac5a-4e75-8fcc-adf6884a5983.png	0	t	0	2026-10-03 17:33:52.146386+00	2026-10-12 13:34:02.284573+00	MERCHANDISE	{}	\N	f
6cf8ac72-c00a-4577-8535-138bca761e68	APP-003	Jaket ARA Merah	sdfsdfs	500000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/1f04210e-b89c-473d-9f9a-233efef4d7b9.png	0	t	0	2026-10-03 09:15:45.064886+00	2026-11-14 20:09:14.511923+00	APPAREL	{L,XL,2XL}	JACKET	f
8a637a2e-2359-449e-80ff-69c79669730e	APP-002	Tshirt	asdasdsa	250000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/7efce189-5faf-4d2b-92d9-7333d5d56729.jpg	0	t	0	2026-10-03 09:12:05.99958+00	2026-11-22 17:26:06.16507+00	APPAREL	{M,L,XL}	TSHIRT	f
04cdbbdf-07db-44f4-bcac-e6c9d12145c1	ITB-002	Ichinose Asuna School w R125 itansha photocard	askdjhawohaowhdalshdlawhdoihawod	50000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/2c1a05e9-a9c2-4985-95a3-a6934e1e9211.png	0	t	0	2026-11-14 22:05:24.654612+00	2026-11-22 18:23:07.827701+00	MERCHANDISE	{}	\N	f
4c614771-69cf-4f8d-b4e2-3da8be684a49	ITB-001	Yvonne Acrylic Standee	Art By Hameru	140000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/3997379b-1b76-454f-a614-84d0ff871219.png	0	t	10	2026-09-23 12:03:15.698514+00	2026-11-24 15:41:47.170688+00	MERCHANDISE	{}	\N	f
e6f00df9-6ff6-4b11-8092-af24e540c29c	APP-005	v2	asdadasds	200000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/3cbcc422-2bac-4cbb-adf3-bb17aecb72dc.png	9	t	0	2026-11-24 16:48:51.148227+00	2026-11-24 18:03:21.776037+00	APPAREL	{L,XL,2XL}	HOODIE	f
1d9554b9-62e4-45aa-8505-905feaf23e5b	ITB-007	cek nambah produk aja	asasdasdasda	200000	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/product-images/products/19daacb3-a5ce-4ba9-9337-8e23e6a2ac35.jpg	4	t	0	2026-11-24 16:47:37.786204+00	2026-11-24 22:01:56.03772+00	MERCHANDISE	{}	\N	f
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
30664cee-cf85-4529-a818-e3a54455db91	c3aa1732-887f-4c6b-91c5-0ad3d41a702c	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	1	APPAREL	M	TSHIRT
5f480b3a-755a-4821-9132-b9616a3aa2a6	c3aa1732-887f-4c6b-91c5-0ad3d41a702c	4c614771-69cf-4f8d-b4e2-3da8be684a49	Yvonne Acrylic Standee	140000	1	MERCHANDISE	\N	\N
b2edff16-ede3-41c1-9277-224b59141dc0	728df606-6ffb-4dca-9a70-09273e69d6ff	04cdbbdf-07db-44f4-bcac-e6c9d12145c1	Ichinose Asuna School w R125 itansha photocard	50000	2	MERCHANDISE	\N	\N
123612b9-599a-4cee-ad54-d6511c08b305	728df606-6ffb-4dca-9a70-09273e69d6ff	8a637a2e-2359-449e-80ff-69c79669730e	Tshirt	250000	1	APPAREL	M	TSHIRT
a737d45b-5c15-400d-8a83-8d05b19da0b1	dae51826-81bb-4443-81ac-a6908de96707	04cdbbdf-07db-44f4-bcac-e6c9d12145c1	Ichinose Asuna School w R125 itansha photocard	50000	4	MERCHANDISE	\N	\N
0715de15-e751-4f99-906a-cad613db7139	25571122-075f-47df-ae64-f0d342d2c531	4c614771-69cf-4f8d-b4e2-3da8be684a49	Yvonne Acrylic Standee	140000	2	MERCHANDISE	\N	\N
78c6f0b8-50e5-4b7f-927f-47144406b7bd	25571122-075f-47df-ae64-f0d342d2c531	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	2	MERCHANDISE	\N	\N
dd2aba7e-5717-4e9a-a67a-1d63ed2d6430	e7a749fb-cd50-451c-9819-894a05374693	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	10	MERCHANDISE	\N	\N
4ee092fd-97a1-4981-bd4c-83fa4655c4b1	88004298-8aea-4e16-9fd8-5f2f97044459	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	12	MERCHANDISE	\N	\N
4def4843-2b90-4dcb-be7f-8da14309bbe2	221cf316-6346-414d-8a1c-8748058a3378	aca4e3e6-28d3-42d8-bad1-3ba8915a3bb4	C&C Sticker Pack	10000	10	MERCHANDISE	\N	\N
6765c5f2-fe99-4433-9415-fd03d6af9500	dea31f2a-49a1-488a-bede-65a6833144b7	e6f00df9-6ff6-4b11-8092-af24e540c29c	v2	200000	1	APPAREL	L	HOODIE
b3a826c4-c208-4b8b-b4f4-05a0dfde2eff	dea31f2a-49a1-488a-bede-65a6833144b7	c7c87c22-78b2-40ec-8a04-83c493dc0b1b	v1	300000	1	APPAREL	M	HOODIE
54b23627-ca7b-4696-bece-5d1b169d177d	dea31f2a-49a1-488a-bede-65a6833144b7	1d9554b9-62e4-45aa-8505-905feaf23e5b	cek nambah produk aja	200000	1	MERCHANDISE	\N	\N
be8c3831-c7da-43be-a13c-b63c98992a6e	f4b530ed-67cf-4212-bc27-537cb1aa9e29	a8e991fc-b5ab-487c-886a-b385eac8a3dd	terus produk	250000	1	MERCHANDISE	\N	\N
0a3476b0-75da-4fa3-9786-08b116b122c0	f4b530ed-67cf-4212-bc27-537cb1aa9e29	1d9554b9-62e4-45aa-8505-905feaf23e5b	cek nambah produk aja	200000	1	MERCHANDISE	\N	\N
5dcb6f7b-4375-4fe2-83db-e8e9345f8242	50c2e18d-4023-4532-b667-77381d621851	1d9554b9-62e4-45aa-8505-905feaf23e5b	cek nambah produk aja	200000	2	MERCHANDISE	\N	\N
aacb926b-1f5e-41d2-8534-056ff5ce1c1b	a45a2d36-41a2-427e-a1c9-e191a2ff015b	e6f00df9-6ff6-4b11-8092-af24e540c29c	v2	200000	2	APPAREL	L	HOODIE
dcd30826-0299-476e-99b6-3360405492ad	0b4f143b-9cbe-47c2-a91b-b3e4ef72dae8	1d9554b9-62e4-45aa-8505-905feaf23e5b	cek nambah produk aja	200000	2	MERCHANDISE	\N	\N
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
6d14e8f3-e0e4-4f62-a6db-198719b3aa44	c3aa1732-887f-4c6b-91c5-0ad3d41a702c	INITIAL	290000	290000	orders/c3aa1732-887f-4c6b-91c5-0ad3d41a702c/394f25bf-5de6-45e7-a411-6c0746b444ad.png	PENDING	\N	2026-11-19 22:06:25.883254+00	\N	\N
0b84dc59-6fb3-437a-b280-5113e27df959	f4b530ed-67cf-4212-bc27-537cb1aa9e29	INITIAL	450000	450000	orders/f4b530ed-67cf-4212-bc27-537cb1aa9e29/c78e2b5b-d961-40b5-aaea-70db83344939.jpg	PENDING	\N	2026-11-24 17:50:14.116643+00	\N	\N
\.


--
-- Data for Name: product_search_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."product_search_events" ("id", "search_term", "created_at") FROM stdin;
bfebcce9-0a66-4f3d-85cd-0cb84ccace3f	Keychain GR Supra	2026-11-24 17:37:59.774243+00
\.


--
-- Data for Name: product_view_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."product_view_events" ("id", "product_id", "created_at", "search_term") FROM stdin;
bb635713-21e9-4808-9fc0-1a9239136b37	2405f07d-b40c-4df2-a4ca-fb28f03219c2	2026-11-24 17:37:56.541943+00	\N
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
bbc7b69b-b0fc-4b2c-b4d8-21470cfe6973	F4382FHS	LUQMAN AHMAD	FIXED	100000	t	t	dea31f2a-49a1-488a-bede-65a6833144b7	2026-11-24 17:48:14.421189+00	2026-11-14 20:21:05.513538+00	2026-11-24 17:48:14.421189+00
6d57bd6d-4d8e-41bd-b878-ec889fc15326	D3508UCC	FATHUR RIZQI	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-22 17:21:34.735+00
a96d61e3-391e-4a95-83f4-3072028dd7d3	D1586YVL	ALFINDI	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
55dab504-e829-4d37-b926-5a7ed080c4d8	D4056ZCU	ERLANGGA FERDIANSYAH	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
be7885f2-c502-4be9-bda2-201259b6f9a7	D4520SBM	KLEINDA FATIMA	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
3ec0076a-e1b1-443a-be5d-25ebb3247466	D6982ZDP	MUHAMAD RIZKI	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
72772e83-c15f-4ec7-b914-bac05d387b54	D2582SBQ	HANSEL	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-14 22:26:21.303594+00
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
7cdf5a1c-c10d-4b4e-9f49-79a0692f3a10	D2556UDN	APRILIANA PURNAMA SIDIK	FIXED	100000	t	f	\N	\N	2026-11-14 20:21:05.513538+00	2026-11-22 17:21:38.457+00
\.


--
-- Data for Name: site_hero_slides; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."site_hero_slides" ("id", "image_url", "title", "subtitle", "button_text", "button_url", "sort_order", "is_active", "created_at", "updated_at") FROM stdin;
4a4ee762-2f1e-4b14-a593-31447948e95d	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/hero-slides/69cce773-3f9b-4ba4-ae73-4c5aced7cdd1.jpg					1	t	2026-11-24 18:51:29.421134+00	2026-11-24 19:14:40.906+00
624fb0fa-f528-43ce-981b-bdca2b6a323b	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/hero-slides/4d87d972-d5ea-4dca-b2ad-48dcada97b9f.jpg					2	t	2026-11-24 19:07:06.212529+00	2026-11-24 19:14:42.859+00
\.


--
-- Data for Name: site_pages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."site_pages" ("slug", "title", "content", "active", "sort_order", "updated_at") FROM stdin;
about-us	Tentang Kami	Kenali Circle Itabaka dan cerita di balik setiap koleksi kami.	t	10	2026-11-24 16:44:27.364125+00
terms-and-conditions	Terms and Conditions	Syarat dan ketentuan pemesanan akan ditampilkan di halaman ini.	t	20	2026-11-24 16:44:27.364125+00
itasha-faqs	Itasha FAQs	Temukan jawaban untuk pertanyaan seputar Itasha.	t	30	2026-11-24 16:44:27.364125+00
itazaki-akane-info	Itazaki Akane Info	Informasi mengenai Itazaki Akane akan ditampilkan di halaman ini.	t	40	2026-11-24 16:44:27.364125+00
design-print-and-wrap-services	Design, Print and Wrap Services	Informasi layanan desain, printing, dan wrapping Itabaka.	t	50	2026-11-24 16:44:27.364125+00
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."site_settings" ("id", "site_name", "site_title", "site_description", "logo_url", "banner_url", "primary_color", "accent_color", "updated_at", "qris_image_url", "bca_account_name", "bca_account_number", "dp_percentage", "full_payment_enabled", "midtrans_enabled") FROM stdin;
1	ITABAKA	Itabaka Pre-Order	Search, Add, Pay, Weeb	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/logo/248ef2ea-573d-42aa-987d-1b6ed139df5e.png	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/banner/a352ee6c-8985-4a07-84ea-9975ed98e6bc.png	#ffffff	#ff0000	2026-11-24 18:52:05.785939+00	https://zzwmrvddaegjybsskmjv.supabase.co/storage/v1/object/public/site-media/qris/36c6f124-c788-4aff-83c5-27d5b13a09e5.png	Fauzi Agung Gumelar	3462518142	50	t	t
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 105, true);


--
-- Name: order_invoice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."order_invoice_seq"', 70, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict HtR867UhBaICdf1BUq4pfidgvSEedkhis3Ego7nz5TZPBbW0xowEaMrSZSpCeXO

RESET ALL;
