--
-- PostgreSQL database dump
--

\restrict lNrfyVFfAOIbXBXuT1ES0QOdOfQCduydcCIX2wrCJs21oTotl480F1niBTaLSot

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-02 09:58:39

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
-- TOC entry 2 (class 3079 OID 16506)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16391)
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    admin_id integer NOT NULL,
    role character varying(50) NOT NULL,
    last_login timestamp without time zone,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: admin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_admin_id_seq OWNER TO postgres;

--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 220
-- Name: admin_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_admin_id_seq OWNED BY public.admin.admin_id;


--
-- TOC entry 229 (class 1259 OID 16450)
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    log_id integer NOT NULL,
    action character varying(100) NOT NULL,
    reference_id integer,
    performed_by character varying(100),
    status character varying(50),
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16449)
-- Name: logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_log_id_seq OWNER TO postgres;

--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 228
-- Name: logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_log_id_seq OWNED BY public.logs.log_id;


--
-- TOC entry 227 (class 1259 OID 16428)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    message_id integer NOT NULL,
    content text NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    result_id integer,
    language character varying(50) DEFAULT 'Unknown'::character varying,
    CONSTRAINT messages_language_check CHECK (((language)::text = ANY ((ARRAY['Arabic'::character varying, 'English'::character varying, 'ar'::character varying, 'en'::character varying])::text[])))
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16427)
-- Name: messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_message_id_seq OWNER TO postgres;

--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 226
-- Name: messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_message_id_seq OWNED BY public.messages.message_id;


--
-- TOC entry 223 (class 1259 OID 16401)
-- Name: trusted_senders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trusted_senders (
    sender_id integer NOT NULL,
    alphanumeric_sender_id character varying(50),
    sender_phone character varying(20),
    sender_email character varying(100),
    is_trusted boolean DEFAULT false,
    verification_date timestamp without time zone,
    verified_by_admin integer
);


ALTER TABLE public.trusted_senders OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16400)
-- Name: trusted_senders_sender_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trusted_senders_sender_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trusted_senders_sender_id_seq OWNER TO postgres;

--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 222
-- Name: trusted_senders_sender_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trusted_senders_sender_id_seq OWNED BY public.trusted_senders.sender_id;


--
-- TOC entry 225 (class 1259 OID 16417)
-- Name: verification_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification_results (
    result_id integer NOT NULL,
    status character varying(50) NOT NULL,
    fraud_score numeric(5,2),
    reason text
);


ALTER TABLE public.verification_results OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16416)
-- Name: verification_results_result_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.verification_results_result_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.verification_results_result_id_seq OWNER TO postgres;

--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 224
-- Name: verification_results_result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.verification_results_result_id_seq OWNED BY public.verification_results.result_id;


--
-- TOC entry 4914 (class 2604 OID 16394)
-- Name: admin admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN admin_id SET DEFAULT nextval('public.admin_admin_id_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 16453)
-- Name: logs log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs ALTER COLUMN log_id SET DEFAULT nextval('public.logs_log_id_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 16431)
-- Name: messages message_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN message_id SET DEFAULT nextval('public.messages_message_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 16404)
-- Name: trusted_senders sender_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trusted_senders ALTER COLUMN sender_id SET DEFAULT nextval('public.trusted_senders_sender_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 16420)
-- Name: verification_results result_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification_results ALTER COLUMN result_id SET DEFAULT nextval('public.verification_results_result_id_seq'::regclass);


--
-- TOC entry 5086 (class 0 OID 16391)
-- Dependencies: 221
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (admin_id, role, last_login, username, password) FROM stdin;
1	SuperAdmin	2025-10-05 12:38:32.734961	admin_ai1	$2a$06$0tJjeA7oVMi/xJVNxsrVJOMJeYgRQia/13jf2hQ5PHDTZqhzTTo9K
\.


--
-- TOC entry 5094 (class 0 OID 16450)
-- Dependencies: 229
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (log_id, action, reference_id, performed_by, status, "timestamp") FROM stdin;
\.


--
-- TOC entry 5092 (class 0 OID 16428)
-- Dependencies: 227
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (message_id, content, "timestamp", result_id, language) FROM stdin;
2	Security alert: unauthorized login. Enter code 641938 to secure account.	2025-11-10 00:00:00	0	en
8	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 989403.	2025-11-10 00:00:00	0	ar
10	We detected unusual activity on your account. Confirm your identity with OTP: 966834	2025-11-10 00:00:00	0	en
12	تنبيه: تم إجراء عملية شراء بمبلغ 254.34. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
13	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
14	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
15	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 770346 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
18	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
19	مهم: بطاقتك المنتهية بالرقم 4594 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
20	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 508291	2025-11-10 00:00:00	0	ar
24	تنبيه: تم إجراء عملية شراء بمبلغ 4071.97. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
25	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
26	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
29	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
31	مهم: بطاقتك المنتهية بالرقم 2978 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
33	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
34	Security alert: unauthorized login. Enter code 707745 to secure account.	2025-11-10 00:00:00	0	en
36	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
38	Important: Your debit card ending with 4816 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
39	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 368655	2025-11-10 00:00:00	0	ar
45	Security alert: unauthorized login. Enter code 360564 to secure account.	2025-11-10 00:00:00	0	en
47	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
48	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
52	تم تحويل مبلغ 7040.52 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
53	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
56	We couldn't process your recent payment. Confirm by entering OTP 757109 now.	2025-11-10 00:00:00	0	en
58	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
59	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
638	Security alert: unauthorized login. Enter code 320527 to secure account.	2025-11-10 00:00:00	0	en
60	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 775560	2025-11-10 00:00:00	0	ar
61	A transfer of $7045.25 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
64	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
71	تم تحويل مبلغ 4978.21 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
73	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 999132.	2025-11-10 00:00:00	0	ar
74	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
80	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 979913 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
81	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
82	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
84	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
85	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
88	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
90	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
91	Important: Your debit card ending with 8811 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
92	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
95	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
98	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
99	A transfer of $376.06 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
100	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
103	Confirm your payment of $276.10 using code 218564. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
106	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
107	تم تحويل مبلغ 6083.90 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
108	A transfer of $2826.75 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
110	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 890556 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
111	A transfer of $8682.97 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
113	مهم: بطاقتك المنتهية بالرقم 5472 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
116	Security alert: unauthorized login. Enter code 759856 to secure account.	2025-11-10 00:00:00	0	en
117	We couldn't process your recent payment. Confirm by entering OTP 462226 now.	2025-11-10 00:00:00	0	en
118	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
122	We detected unusual activity on your account. Confirm your identity with OTP: 305362	2025-11-10 00:00:00	0	en
123	Confirm your payment of $5721.26 using code 860628. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
126	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
127	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
128	تم تحويل مبلغ 5367.49 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
131	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 347979 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
133	A transfer of $7486.62 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
134	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
136	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
138	Important: Your debit card ending with 8832 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
140	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
145	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
147	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
149	تنبيه: تم إجراء عملية شراء بمبلغ 7257.27. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
151	Important: Your debit card ending with 1969 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
152	تم تحويل مبلغ 305.14 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
154	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
155	We couldn't process your recent payment. Confirm by entering OTP 806863 now.	2025-11-10 00:00:00	0	en
156	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
157	We couldn't process your recent payment. Confirm by entering OTP 539368 now.	2025-11-10 00:00:00	0	en
161	مهم: بطاقتك المنتهية بالرقم 6513 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
162	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
164	مهم: بطاقتك المنتهية بالرقم 3090 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
165	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
166	Confirm your payment of $7155.61 using code 925793. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
167	Confirm your payment of $9022.08 using code 177982. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
171	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 674624	2025-11-10 00:00:00	0	ar
172	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
173	We detected unusual activity on your account. Confirm your identity with OTP: 788962	2025-11-10 00:00:00	0	en
175	A transfer of $9185.30 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
178	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
179	We detected unusual activity on your account. Confirm your identity with OTP: 789221	2025-11-10 00:00:00	0	en
180	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
184	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 147273.	2025-11-10 00:00:00	0	ar
186	We couldn't process your recent payment. Confirm by entering OTP 945407 now.	2025-11-10 00:00:00	0	en
187	Security alert: unauthorized login. Enter code 773851 to secure account.	2025-11-10 00:00:00	0	en
188	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
192	Confirm your payment of $5424.43 using code 556124. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
194	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 757093.	2025-11-10 00:00:00	0	ar
195	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 575570.	2025-11-10 00:00:00	0	ar
196	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
197	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
198	Important: Your debit card ending with 6176 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
200	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
202	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
204	تم تحويل مبلغ 3110.10 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
205	تنبيه: تم إجراء عملية شراء بمبلغ 2947.69. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
208	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
209	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
214	Confirm your payment of $3212.38 using code 217129. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
217	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 914794	2025-11-10 00:00:00	0	ar
219	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 230965 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
221	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
224	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
225	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
226	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
228	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
230	تنبيه: تم إجراء عملية شراء بمبلغ 4440.65. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
231	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
232	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
233	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 937415	2025-11-10 00:00:00	0	ar
234	تنبيه: تم إجراء عملية شراء بمبلغ 5880.68. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
235	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
236	We couldn't process your recent payment. Confirm by entering OTP 523806 now.	2025-11-10 00:00:00	0	en
237	تنبيه: تم إجراء عملية شراء بمبلغ 7214.19. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
241	We couldn't process your recent payment. Confirm by entering OTP 586565 now.	2025-11-10 00:00:00	0	en
245	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
248	Security alert: unauthorized login. Enter code 887413 to secure account.	2025-11-10 00:00:00	0	en
253	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
258	A transfer of $2235.59 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
263	We couldn't process your recent payment. Confirm by entering OTP 879270 now.	2025-11-10 00:00:00	0	en
267	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 345891 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
270	Security alert: unauthorized login. Enter code 559339 to secure account.	2025-11-10 00:00:00	0	en
271	A transfer of $1302.87 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
273	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
274	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
275	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
276	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
281	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
282	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
284	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
285	مهم: بطاقتك المنتهية بالرقم 8296 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
286	We couldn't process your recent payment. Confirm by entering OTP 745867 now.	2025-11-10 00:00:00	0	en
287	Important: Your debit card ending with 3766 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
290	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
294	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
300	A transfer of $2322.51 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
305	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
312	تنبيه: تم إجراء عملية شراء بمبلغ 8811.69. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
315	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
318	A transfer of $464.07 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
319	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
330	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
331	Security alert: unauthorized login. Enter code 971578 to secure account.	2025-11-10 00:00:00	0	en
334	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
335	We detected unusual activity on your account. Confirm your identity with OTP: 300294	2025-11-10 00:00:00	0	en
336	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
337	We couldn't process your recent payment. Confirm by entering OTP 160808 now.	2025-11-10 00:00:00	0	en
339	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
341	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
343	A transfer of $3549.31 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
344	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
348	Confirm your payment of $9981.53 using code 623731. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
352	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 138844 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
353	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
356	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 295189 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
358	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 918078 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
359	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 369660.	2025-11-10 00:00:00	0	ar
360	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 125418	2025-11-10 00:00:00	0	ar
361	Security alert: unauthorized login. Enter code 644592 to secure account.	2025-11-10 00:00:00	0	en
363	A transfer of $2847.11 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
364	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
369	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
371	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 766406 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
372	تم تحويل مبلغ 8936.44 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
373	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 739502 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
374	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
379	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 144579 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
381	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
386	We detected unusual activity on your account. Confirm your identity with OTP: 721289	2025-11-10 00:00:00	0	en
387	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
388	تنبيه: تم إجراء عملية شراء بمبلغ 4778.43. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
389	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
392	Important: Your debit card ending with 8836 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
393	Security alert: unauthorized login. Enter code 862336 to secure account.	2025-11-10 00:00:00	0	en
394	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
397	We detected unusual activity on your account. Confirm your identity with OTP: 383273	2025-11-10 00:00:00	0	en
398	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
399	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
400	مهم: بطاقتك المنتهية بالرقم 9535 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
402	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
404	A transfer of $8607.68 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
406	مهم: بطاقتك المنتهية بالرقم 1701 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
409	We couldn't process your recent payment. Confirm by entering OTP 685384 now.	2025-11-10 00:00:00	0	en
410	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
413	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 972681 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
416	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
417	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
420	A transfer of $8791.07 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
426	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
427	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
428	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
429	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
431	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 320414	2025-11-10 00:00:00	0	ar
433	We detected unusual activity on your account. Confirm your identity with OTP: 560102	2025-11-10 00:00:00	0	en
435	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
436	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
437	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 590660.	2025-11-10 00:00:00	0	ar
439	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
440	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
442	We detected unusual activity on your account. Confirm your identity with OTP: 682679	2025-11-10 00:00:00	0	en
444	تنبيه: تم إجراء عملية شراء بمبلغ 4648.85. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
446	مهم: بطاقتك المنتهية بالرقم 1324 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
451	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
456	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
457	تم تحويل مبلغ 3952.59 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
458	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
459	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 187543 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
460	Important: Your debit card ending with 1593 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
461	A transfer of $8151.77 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
463	Security alert: unauthorized login. Enter code 444780 to secure account.	2025-11-10 00:00:00	0	en
464	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
465	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 922061	2025-11-10 00:00:00	0	ar
471	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
473	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
474	تم تحويل مبلغ 6463.11 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
475	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
479	تم تحويل مبلغ 4715.56 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
480	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
484	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
485	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 953604 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
487	Confirm your payment of $1143.28 using code 901598. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
488	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
489	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
491	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 508273	2025-11-10 00:00:00	0	ar
492	تم تحويل مبلغ 5840.33 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
494	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
495	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
496	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 226907.	2025-11-10 00:00:00	0	ar
497	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
500	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
501	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
502	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
503	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 785575.	2025-11-10 00:00:00	0	ar
504	Important: Your debit card ending with 6826 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
505	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
506	تم تحويل مبلغ 8533.35 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
509	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
510	Security alert: unauthorized login. Enter code 819341 to secure account.	2025-11-10 00:00:00	0	en
511	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
515	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
518	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
520	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
521	Important: Your debit card ending with 8428 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
524	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
525	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 666431	2025-11-10 00:00:00	0	ar
528	مهم: بطاقتك المنتهية بالرقم 6901 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
529	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
530	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
533	مهم: بطاقتك المنتهية بالرقم 1856 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
534	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
536	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
537	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
540	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
548	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
550	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
558	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 158408 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
561	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
562	تنبيه: تم إجراء عملية شراء بمبلغ 7009.62. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
564	We detected unusual activity on your account. Confirm your identity with OTP: 548427	2025-11-10 00:00:00	0	en
565	تم تحويل مبلغ 2658.71 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
566	A transfer of $124.04 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
568	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
571	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
572	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
575	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
578	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 607781.	2025-11-10 00:00:00	0	ar
579	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
580	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
582	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
583	تنبيه: تم إجراء عملية شراء بمبلغ 2953.25. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
584	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
585	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
587	مهم: بطاقتك المنتهية بالرقم 7497 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
588	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
592	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
593	مهم: بطاقتك المنتهية بالرقم 5228 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
594	Confirm your payment of $7982.42 using code 444005. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
595	تنبيه: تم إجراء عملية شراء بمبلغ 3794.61. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
601	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
602	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
603	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
612	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
613	A transfer of $2738.23 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
614	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 464901 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
615	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
618	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 165274 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
619	We detected unusual activity on your account. Confirm your identity with OTP: 493975	2025-11-10 00:00:00	0	en
620	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
621	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
622	Confirm your payment of $5795.39 using code 242833. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
623	We detected unusual activity on your account. Confirm your identity with OTP: 797238	2025-11-10 00:00:00	0	en
626	Security alert: unauthorized login. Enter code 805938 to secure account.	2025-11-10 00:00:00	0	en
628	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
629	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
631	مهم: بطاقتك المنتهية بالرقم 6420 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
633	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
634	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 137522.	2025-11-10 00:00:00	0	ar
637	Important: Your debit card ending with 6787 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
639	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
640	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
644	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
648	تنبيه: تم إجراء عملية شراء بمبلغ 2600.22. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
653	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
655	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
658	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
659	مهم: بطاقتك المنتهية بالرقم 9448 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
662	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
664	We detected unusual activity on your account. Confirm your identity with OTP: 887908	2025-11-10 00:00:00	0	en
667	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 154901	2025-11-10 00:00:00	0	ar
668	مهم: بطاقتك المنتهية بالرقم 6895 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
669	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
674	تم تحويل مبلغ 1449.27 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
680	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
681	تم تحويل مبلغ 39.89 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
682	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
685	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
688	تم تحويل مبلغ 8644.37 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
690	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 427156.	2025-11-10 00:00:00	0	ar
691	Important: Your debit card ending with 4307 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
693	Confirm your payment of $1124.33 using code 360615. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
694	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
207	Notification: Your card ending with 6380 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
696	Confirm your payment of $6602.43 using code 398614. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
702	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
705	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
706	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
708	Important: Your debit card ending with 8997 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
709	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
711	We detected unusual activity on your account. Confirm your identity with OTP: 766770	2025-11-10 00:00:00	0	en
713	تنبيه: تم إجراء عملية شراء بمبلغ 814.54. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
714	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
717	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
719	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
720	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
721	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
724	Security alert: unauthorized login. Enter code 736246 to secure account.	2025-11-10 00:00:00	0	en
728	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
729	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 715609.	2025-11-10 00:00:00	0	ar
737	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
738	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
741	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
742	مهم: بطاقتك المنتهية بالرقم 9739 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
743	تنبيه: تم إجراء عملية شراء بمبلغ 6221.32. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
744	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 429086.	2025-11-10 00:00:00	0	ar
745	Security alert: unauthorized login. Enter code 690833 to secure account.	2025-11-10 00:00:00	0	en
746	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
747	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 759059 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
751	We detected unusual activity on your account. Confirm your identity with OTP: 243634	2025-11-10 00:00:00	0	en
754	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 473502 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
756	A transfer of $5089.00 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
757	تنبيه: تم إجراء عملية شراء بمبلغ 3570.75. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
761	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
762	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 742915.	2025-11-10 00:00:00	0	ar
763	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
765	Important: Your debit card ending with 4239 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
769	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
774	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
777	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
780	Important: Your debit card ending with 2338 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
781	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
784	We couldn't process your recent payment. Confirm by entering OTP 342047 now.	2025-11-10 00:00:00	0	en
786	A transfer of $3287.50 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
787	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
788	تم تحويل مبلغ 7691.34 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
791	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 693028	2025-11-10 00:00:00	0	ar
792	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 819766 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
794	A transfer of $9587.41 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
796	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
798	We detected unusual activity on your account. Confirm your identity with OTP: 492221	2025-11-10 00:00:00	0	en
799	Security alert: unauthorized login. Enter code 998812 to secure account.	2025-11-10 00:00:00	0	en
800	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
802	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
804	We detected unusual activity on your account. Confirm your identity with OTP: 769338	2025-11-10 00:00:00	0	en
807	We couldn't process your recent payment. Confirm by entering OTP 915517 now.	2025-11-10 00:00:00	0	en
808	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
812	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
813	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
815	Confirm your payment of $9125.58 using code 838340. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
817	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 608636	2025-11-10 00:00:00	0	ar
818	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
819	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
822	We couldn't process your recent payment. Confirm by entering OTP 398779 now.	2025-11-10 00:00:00	0	en
824	A transfer of $7592.51 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
825	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
831	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
832	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
834	Confirm your payment of $129.23 using code 912549. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
837	Confirm your payment of $669.43 using code 182892. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
838	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
840	A transfer of $4123.21 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
841	Security alert: unauthorized login. Enter code 617174 to secure account.	2025-11-10 00:00:00	0	en
843	تنبيه: تم إجراء عملية شراء بمبلغ 2324.57. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
850	Important: Your debit card ending with 6177 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
851	تم تحويل مبلغ 7041.01 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
852	Security alert: unauthorized login. Enter code 269640 to secure account.	2025-11-10 00:00:00	0	en
855	مهم: بطاقتك المنتهية بالرقم 3740 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
856	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
859	We detected unusual activity on your account. Confirm your identity with OTP: 362559	2025-11-10 00:00:00	0	en
861	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
863	Security alert: unauthorized login. Enter code 419810 to secure account.	2025-11-10 00:00:00	0	en
868	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
308	Your OTP for transaction is 594970. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
869	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
870	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
876	We detected unusual activity on your account. Confirm your identity with OTP: 196041	2025-11-10 00:00:00	0	en
877	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
880	تنبيه: تم إجراء عملية شراء بمبلغ 5695.38. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
881	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
887	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
890	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
891	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
893	A transfer of $6262.87 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
897	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
899	Confirm your payment of $7712.88 using code 338696. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
900	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
904	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 310529 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
906	تم تحويل مبلغ 4146.26 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
908	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
909	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
910	تنبيه: تم إجراء عملية شراء بمبلغ 1094.56. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
915	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
916	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
917	تنبيه: تم إجراء عملية شراء بمبلغ 8468.96. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
922	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
923	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 566303.	2025-11-10 00:00:00	0	ar
926	We detected unusual activity on your account. Confirm your identity with OTP: 308644	2025-11-10 00:00:00	0	en
929	تنبيه: تم إجراء عملية شراء بمبلغ 1076.04. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
932	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
935	تم تحويل مبلغ 4119.82 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
937	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 459141	2025-11-10 00:00:00	0	ar
939	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
940	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 725214.	2025-11-10 00:00:00	0	ar
941	تم تحويل مبلغ 4413.63 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
942	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
944	تم تحويل مبلغ 9064.23 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
951	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
953	A transfer of $252.27 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
954	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
955	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
957	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 208907 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
959	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
964	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 776183 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
966	We detected unusual activity on your account. Confirm your identity with OTP: 756500	2025-11-10 00:00:00	0	en
968	مهم: بطاقتك المنتهية بالرقم 2479 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
969	تنبيه: تم إجراء عملية شراء بمبلغ 475.75. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
970	Important: Your debit card ending with 1118 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
972	مهم: بطاقتك المنتهية بالرقم 6335 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
973	We couldn't process your recent payment. Confirm by entering OTP 770786 now.	2025-11-10 00:00:00	0	en
975	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
976	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
978	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
979	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
980	Important: Your debit card ending with 2332 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
983	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
985	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
986	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 123333 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
989	مهم: بطاقتك المنتهية بالرقم 8732 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
990	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
991	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
992	Important: Your debit card ending with 2081 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
995	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
996	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
997	Security alert: unauthorized login. Enter code 113630 to secure account.	2025-11-10 00:00:00	0	en
998	We couldn't process your recent payment. Confirm by entering OTP 128431 now.	2025-11-10 00:00:00	0	en
1001	We detected unusual activity on your account. Confirm your identity with OTP: 664793	2025-11-10 00:00:00	0	en
1002	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1003	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 835030.	2025-11-10 00:00:00	0	ar
1004	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1005	تنبيه: تم إجراء عملية شراء بمبلغ 7378.30. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1006	Important: Your debit card ending with 5564 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1007	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1008	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1012	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1013	تم تحويل مبلغ 8263.77 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1014	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1016	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1017	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1018	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1021	Confirm your payment of $6430.44 using code 294700. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1022	تم تحويل مبلغ 5609.93 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1024	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1025	Security alert: unauthorized login. Enter code 924429 to secure account.	2025-11-10 00:00:00	0	en
1026	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1028	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1029	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 565212	2025-11-10 00:00:00	0	ar
1033	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1034	تنبيه: تم إجراء عملية شراء بمبلغ 265.77. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1036	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 563793.	2025-11-10 00:00:00	0	ar
1041	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1042	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1047	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1048	مهم: بطاقتك المنتهية بالرقم 2272 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1050	مهم: بطاقتك المنتهية بالرقم 7329 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1051	We detected unusual activity on your account. Confirm your identity with OTP: 139413	2025-11-10 00:00:00	0	en
1052	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1055	مهم: بطاقتك المنتهية بالرقم 5774 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1057	مهم: بطاقتك المنتهية بالرقم 8726 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1062	مهم: بطاقتك المنتهية بالرقم 1017 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1064	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 894304	2025-11-10 00:00:00	0	ar
1069	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1070	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1071	A transfer of $3477.10 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1072	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 196854.	2025-11-10 00:00:00	0	ar
1073	We detected unusual activity on your account. Confirm your identity with OTP: 207260	2025-11-10 00:00:00	0	en
1074	We detected unusual activity on your account. Confirm your identity with OTP: 236946	2025-11-10 00:00:00	0	en
1075	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1076	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 119162	2025-11-10 00:00:00	0	ar
1077	We detected unusual activity on your account. Confirm your identity with OTP: 247892	2025-11-10 00:00:00	0	en
1079	A transfer of $8312.47 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1085	Security alert: unauthorized login. Enter code 191643 to secure account.	2025-11-10 00:00:00	0	en
1086	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1087	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1089	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1092	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 661204	2025-11-10 00:00:00	0	ar
1095	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1097	مهم: بطاقتك المنتهية بالرقم 4805 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1058	Reminder: Your loan payment of $2949.37 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1099	A transfer of $8437.87 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1101	Confirm your payment of $9222.09 using code 350760. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1102	Important: Your debit card ending with 6072 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1104	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1107	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1110	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1111	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1112	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1114	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1118	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 781087 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1121	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1122	تنبيه: تم إجراء عملية شراء بمبلغ 4052.50. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1125	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1126	Important: Your debit card ending with 2041 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1132	Important: Your debit card ending with 9072 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1134	We couldn't process your recent payment. Confirm by entering OTP 260166 now.	2025-11-10 00:00:00	0	en
1137	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 600628.	2025-11-10 00:00:00	0	ar
1138	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1140	Important: Your debit card ending with 6241 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1147	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 111993	2025-11-10 00:00:00	0	ar
1148	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1152	We detected unusual activity on your account. Confirm your identity with OTP: 283235	2025-11-10 00:00:00	0	en
1155	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1156	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1157	Security alert: unauthorized login. Enter code 272228 to secure account.	2025-11-10 00:00:00	0	en
1159	تنبيه: تم إجراء عملية شراء بمبلغ 1263.85. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1160	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1161	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1164	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1165	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1167	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1168	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1170	تم تحويل مبلغ 5056.77 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1171	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1173	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1174	We detected unusual activity on your account. Confirm your identity with OTP: 276158	2025-11-10 00:00:00	0	en
1176	A transfer of $3023.89 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1178	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1179	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1180	تنبيه: تم إجراء عملية شراء بمبلغ 5490.88. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1182	A transfer of $7550.19 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1183	We detected unusual activity on your account. Confirm your identity with OTP: 887397	2025-11-10 00:00:00	0	en
1185	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1189	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1193	تنبيه: تم إجراء عملية شراء بمبلغ 6465.07. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1196	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1198	A transfer of $917.92 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1200	Security alert: unauthorized login. Enter code 111434 to secure account.	2025-11-10 00:00:00	0	en
1201	We detected unusual activity on your account. Confirm your identity with OTP: 892361	2025-11-10 00:00:00	0	en
1202	تنبيه: تم إجراء عملية شراء بمبلغ 2503.82. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1203	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1205	تم تحويل مبلغ 3434.13 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1208	تم تحويل مبلغ 43.91 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1209	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1210	مهم: بطاقتك المنتهية بالرقم 7839 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1213	Security alert: unauthorized login. Enter code 720767 to secure account.	2025-11-10 00:00:00	0	en
1175	Your scheduled transfer completed successfully. Ref: 8547.	2025-11-10 00:00:00	\N	en
1215	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 871303	2025-11-10 00:00:00	0	ar
1218	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 129759	2025-11-10 00:00:00	0	ar
1219	We couldn't process your recent payment. Confirm by entering OTP 515932 now.	2025-11-10 00:00:00	0	en
1220	Security alert: unauthorized login. Enter code 162649 to secure account.	2025-11-10 00:00:00	0	en
1221	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1222	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 308115	2025-11-10 00:00:00	0	ar
1224	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1227	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1228	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1231	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1235	مهم: بطاقتك المنتهية بالرقم 3296 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1236	A transfer of $8823.68 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1239	Important: Your debit card ending with 4942 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1241	تم تحويل مبلغ 2783.76 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1245	مهم: بطاقتك المنتهية بالرقم 6395 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1248	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1251	Important: Your debit card ending with 4574 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1253	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1254	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1258	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1261	تم تحويل مبلغ 5234.83 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1262	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1263	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1264	مهم: بطاقتك المنتهية بالرقم 5160 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1266	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1267	Important: Your debit card ending with 7246 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1268	A transfer of $38.49 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1271	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1272	A transfer of $7704.72 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1274	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1276	Security alert: unauthorized login. Enter code 350055 to secure account.	2025-11-10 00:00:00	0	en
1278	We detected unusual activity on your account. Confirm your identity with OTP: 572917	2025-11-10 00:00:00	0	en
1282	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1283	We detected unusual activity on your account. Confirm your identity with OTP: 776507	2025-11-10 00:00:00	0	en
1290	Security alert: unauthorized login. Enter code 444436 to secure account.	2025-11-10 00:00:00	0	en
1292	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1294	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1300	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 969176.	2025-11-10 00:00:00	0	ar
1303	A transfer of $3646.94 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1304	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1306	مهم: بطاقتك المنتهية بالرقم 8393 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1307	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1308	Confirm your payment of $4355.30 using code 784002. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1311	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 957115.	2025-11-10 00:00:00	0	ar
1312	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1314	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1315	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1317	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 204824 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1319	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1320	Confirm your payment of $5549.49 using code 147165. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1322	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1324	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1327	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1333	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1334	تم تحويل مبلغ 865.15 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1341	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1343	Security alert: unauthorized login. Enter code 822991 to secure account.	2025-11-10 00:00:00	0	en
1344	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1346	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1350	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1351	تنبيه: تم إجراء عملية شراء بمبلغ 3808.32. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1354	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1355	Important: Your debit card ending with 9604 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1358	Confirm your payment of $7686.91 using code 992086. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1359	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1360	Confirm your payment of $2615.49 using code 601981. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1361	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1363	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 571490.	2025-11-10 00:00:00	0	ar
1367	تم تحويل مبلغ 5136.72 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1369	Security alert: unauthorized login. Enter code 204721 to secure account.	2025-11-10 00:00:00	0	en
1371	We couldn't process your recent payment. Confirm by entering OTP 106606 now.	2025-11-10 00:00:00	0	en
1373	We couldn't process your recent payment. Confirm by entering OTP 204857 now.	2025-11-10 00:00:00	0	en
1375	A transfer of $402.85 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1378	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1379	We detected unusual activity on your account. Confirm your identity with OTP: 969807	2025-11-10 00:00:00	0	en
1380	Security alert: unauthorized login. Enter code 266815 to secure account.	2025-11-10 00:00:00	0	en
1382	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1386	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 759673 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1387	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 119900 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1389	Confirm your payment of $1144.17 using code 513799. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1390	We detected unusual activity on your account. Confirm your identity with OTP: 214248	2025-11-10 00:00:00	0	en
1393	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1394	تم تحويل مبلغ 5432.65 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1395	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1396	تم تحويل مبلغ 5336.89 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1399	A transfer of $3671.93 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1400	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1401	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1405	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1406	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1408	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1409	تم تحويل مبلغ 9776.33 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1410	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 139303 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1412	Security alert: unauthorized login. Enter code 374661 to secure account.	2025-11-10 00:00:00	0	en
1416	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 411484 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1417	تم تحويل مبلغ 4389.93 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1420	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1422	تم تحويل مبلغ 5850.95 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1425	مهم: بطاقتك المنتهية بالرقم 9875 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1428	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1429	Confirm your payment of $712.85 using code 487189. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1430	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1432	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 217969 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1433	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1436	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1437	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1444	تنبيه: تم إجراء عملية شراء بمبلغ 4138.02. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1446	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1449	تنبيه: تم إجراء عملية شراء بمبلغ 7992.31. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1452	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1453	A transfer of $6249.49 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1454	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1455	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1456	تم تحويل مبلغ 717.45 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1458	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1459	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1460	مهم: بطاقتك المنتهية بالرقم 3916 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1461	تم تحويل مبلغ 4139.37 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1462	A transfer of $5196.03 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1463	مهم: بطاقتك المنتهية بالرقم 7823 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1471	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1472	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1475	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 579269.	2025-11-10 00:00:00	0	ar
1476	تنبيه: تم إجراء عملية شراء بمبلغ 4518.71. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1481	Important: Your debit card ending with 9063 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1482	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1484	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 183193.	2025-11-10 00:00:00	0	ar
1486	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1487	We detected unusual activity on your account. Confirm your identity with OTP: 610105	2025-11-10 00:00:00	0	en
1488	Security alert: unauthorized login. Enter code 490835 to secure account.	2025-11-10 00:00:00	0	en
1492	We detected unusual activity on your account. Confirm your identity with OTP: 445495	2025-11-10 00:00:00	0	en
1493	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1494	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1495	مهم: بطاقتك المنتهية بالرقم 5251 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1496	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1497	Confirm your payment of $8081.64 using code 826027. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1502	Confirm your payment of $4721.73 using code 413809. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1503	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1505	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1511	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1512	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1513	تم تحويل مبلغ 3652.54 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1514	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1515	We couldn't process your recent payment. Confirm by entering OTP 456683 now.	2025-11-10 00:00:00	0	en
1516	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 757935.	2025-11-10 00:00:00	0	ar
1518	تم تحويل مبلغ 674.69 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1523	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 610623	2025-11-10 00:00:00	0	ar
1524	Confirm your payment of $5324.10 using code 826357. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1525	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1527	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 694920.	2025-11-10 00:00:00	0	ar
1529	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1530	مهم: بطاقتك المنتهية بالرقم 6761 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1531	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 977553.	2025-11-10 00:00:00	0	ar
1535	We couldn't process your recent payment. Confirm by entering OTP 279321 now.	2025-11-10 00:00:00	0	en
1536	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1542	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 601996 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1543	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1546	Confirm your payment of $4870.29 using code 672352. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1549	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1550	We couldn't process your recent payment. Confirm by entering OTP 581823 now.	2025-11-10 00:00:00	0	en
1556	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1561	We detected unusual activity on your account. Confirm your identity with OTP: 908326	2025-11-10 00:00:00	0	en
1562	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 508416.	2025-11-10 00:00:00	0	ar
1563	Security alert: unauthorized login. Enter code 532112 to secure account.	2025-11-10 00:00:00	0	en
1568	مهم: بطاقتك المنتهية بالرقم 5123 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1569	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1572	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1573	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1576	A transfer of $811.22 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1577	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1578	A transfer of $1390.24 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1579	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1583	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1584	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1586	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1587	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1588	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1589	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1591	مهم: بطاقتك المنتهية بالرقم 7979 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1592	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1593	تم تحويل مبلغ 6092.54 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1594	Confirm your payment of $7844.57 using code 931213. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1595	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1598	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1601	تم تحويل مبلغ 4680.38 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1602	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1603	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1604	We couldn't process your recent payment. Confirm by entering OTP 330692 now.	2025-11-10 00:00:00	0	en
1606	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 696800	2025-11-10 00:00:00	0	ar
1609	We detected unusual activity on your account. Confirm your identity with OTP: 131840	2025-11-10 00:00:00	0	en
1613	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1615	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1616	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1617	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1618	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1619	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1623	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1624	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1625	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1628	تنبيه: تم إجراء عملية شراء بمبلغ 3778.64. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1629	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1630	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1635	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1636	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1638	A transfer of $2179.93 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1639	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1641	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1643	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1645	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 623183.	2025-11-10 00:00:00	0	ar
1649	Important: Your debit card ending with 3758 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1651	We couldn't process your recent payment. Confirm by entering OTP 126298 now.	2025-11-10 00:00:00	0	en
1652	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1653	تم تحويل مبلغ 3397.10 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1654	We couldn't process your recent payment. Confirm by entering OTP 563956 now.	2025-11-10 00:00:00	0	en
1655	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 423853	2025-11-10 00:00:00	0	ar
1656	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 163524	2025-11-10 00:00:00	0	ar
1657	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1663	Important: Your debit card ending with 9812 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1665	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1666	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 819336	2025-11-10 00:00:00	0	ar
1671	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 720374 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1675	مهم: بطاقتك المنتهية بالرقم 4275 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1677	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1678	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1679	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1680	We couldn't process your recent payment. Confirm by entering OTP 897958 now.	2025-11-10 00:00:00	0	en
1681	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1683	تنبيه: تم إجراء عملية شراء بمبلغ 8298.78. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1684	تم تحويل مبلغ 4649.12 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1688	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1690	We couldn't process your recent payment. Confirm by entering OTP 881098 now.	2025-11-10 00:00:00	0	en
1692	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1697	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1709	Security alert: unauthorized login. Enter code 570262 to secure account.	2025-11-10 00:00:00	0	en
1711	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1712	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1717	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1718	Important: Your debit card ending with 5855 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1719	مهم: بطاقتك المنتهية بالرقم 8261 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1720	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1722	A transfer of $1811.53 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1725	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1726	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 656832	2025-11-10 00:00:00	0	ar
1727	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1731	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1732	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1733	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
419	Your scheduled transfer completed successfully. Ref: 9158.	2025-11-10 00:00:00	\N	en
1738	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1739	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1740	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1742	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 283335.	2025-11-10 00:00:00	0	ar
1743	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1746	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1749	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1750	مهم: بطاقتك المنتهية بالرقم 8442 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1752	تم تحويل مبلغ 7890.31 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1754	We detected unusual activity on your account. Confirm your identity with OTP: 415289	2025-11-10 00:00:00	0	en
1756	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1758	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1759	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 212160.	2025-11-10 00:00:00	0	ar
1762	A transfer of $9366.87 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1764	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1766	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1772	تم تحويل مبلغ 6758.26 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1773	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 129260.	2025-11-10 00:00:00	0	ar
1779	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1782	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 668134 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1783	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1784	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1785	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1786	تم تحويل مبلغ 711.30 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1787	تم تحويل مبلغ 2333.26 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1790	مهم: بطاقتك المنتهية بالرقم 3856 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1794	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1795	Security alert: unauthorized login. Enter code 901615 to secure account.	2025-11-10 00:00:00	0	en
1804	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1810	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1814	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 940005 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1815	تنبيه: تم إجراء عملية شراء بمبلغ 5012.67. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1818	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1819	تم تحويل مبلغ 6907.69 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1820	Important: Your debit card ending with 9724 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1821	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 435106.	2025-11-10 00:00:00	0	ar
1822	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1826	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1827	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1828	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1829	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1831	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1832	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1833	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1834	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1837	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1838	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1841	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1842	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1843	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1844	تم تحويل مبلغ 4469.67 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1845	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1849	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1850	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 547358	2025-11-10 00:00:00	0	ar
1851	مهم: بطاقتك المنتهية بالرقم 1672 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1852	We couldn't process your recent payment. Confirm by entering OTP 526600 now.	2025-11-10 00:00:00	0	en
1855	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1857	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 270023	2025-11-10 00:00:00	0	ar
1859	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 705050	2025-11-10 00:00:00	0	ar
1861	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1862	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1864	مهم: بطاقتك المنتهية بالرقم 5224 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1872	تم تحويل مبلغ 2658.54 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1874	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
1875	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 388265.	2025-11-10 00:00:00	0	ar
1876	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1878	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 178637 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
1879	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
1880	A transfer of $8376.17 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1885	مهم: بطاقتك المنتهية بالرقم 7367 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1892	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1893	Confirm your payment of $1735.20 using code 418813. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1894	Confirm your payment of $3730.84 using code 633620. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1895	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
1896	We couldn't process your recent payment. Confirm by entering OTP 556582 now.	2025-11-10 00:00:00	0	en
1897	We detected unusual activity on your account. Confirm your identity with OTP: 123672	2025-11-10 00:00:00	0	en
1902	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1905	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1906	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1909	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1913	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1914	Important: Your debit card ending with 5885 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1915	تم تحويل مبلغ 1787.85 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1916	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1918	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1919	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1920	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1922	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
1923	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1924	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1925	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1927	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1929	مهم: بطاقتك المنتهية بالرقم 8540 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1930	Security alert: unauthorized login. Enter code 967519 to secure account.	2025-11-10 00:00:00	0	en
1931	تم تحويل مبلغ 1452.50 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1932	تم تحويل مبلغ 2818.38 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1933	A transfer of $377.39 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1934	مهم: بطاقتك المنتهية بالرقم 2378 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
1936	We detected unusual activity on your account. Confirm your identity with OTP: 388534	2025-11-10 00:00:00	0	en
1938	We couldn't process your recent payment. Confirm by entering OTP 875461 now.	2025-11-10 00:00:00	0	en
1942	We couldn't process your recent payment. Confirm by entering OTP 424154 now.	2025-11-10 00:00:00	0	en
1943	Confirm your payment of $6897.17 using code 770197. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
1944	Important: Your debit card ending with 7858 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
1945	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
1948	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1949	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1951	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
1953	Security alert: unauthorized login. Enter code 471039 to secure account.	2025-11-10 00:00:00	0	en
1957	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1962	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 893056	2025-11-10 00:00:00	0	ar
1963	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1969	تنبيه: تم إجراء عملية شراء بمبلغ 3601.93. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
1972	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 409153.	2025-11-10 00:00:00	0	ar
1973	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1975	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
1976	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1977	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
1982	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
1984	A transfer of $1168.61 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1989	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
1990	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
1993	تم تحويل مبلغ 6582.69 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1996	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 543341	2025-11-10 00:00:00	0	ar
1997	تم تحويل مبلغ 5679.27 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
1998	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
1999	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 259802.	2025-11-10 00:00:00	0	ar
2000	Important: Your debit card ending with 6493 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2001	We detected unusual activity on your account. Confirm your identity with OTP: 311279	2025-11-10 00:00:00	0	en
2003	تنبيه: تم إجراء عملية شراء بمبلغ 583.22. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2004	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2006	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2007	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2008	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 177428 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2010	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2013	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2014	We detected unusual activity on your account. Confirm your identity with OTP: 167924	2025-11-10 00:00:00	0	en
2019	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 670553 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2022	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2024	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2025	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2028	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2029	A transfer of $7688.05 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2034	A transfer of $782.55 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2035	We detected unusual activity on your account. Confirm your identity with OTP: 602267	2025-11-10 00:00:00	0	en
2036	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2037	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 912763	2025-11-10 00:00:00	0	ar
2038	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2039	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 836064	2025-11-10 00:00:00	0	ar
2040	Security alert: unauthorized login. Enter code 681643 to secure account.	2025-11-10 00:00:00	0	en
2041	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2044	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 474272 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2045	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2046	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2049	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2050	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2051	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2052	تنبيه: تم إجراء عملية شراء بمبلغ 5732.17. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2055	مهم: بطاقتك المنتهية بالرقم 5280 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2057	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2059	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2063	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2064	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2067	مهم: بطاقتك المنتهية بالرقم 5704 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2070	مهم: بطاقتك المنتهية بالرقم 3760 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2071	تم تحويل مبلغ 2571.24 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2074	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2076	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2077	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 333291	2025-11-10 00:00:00	0	ar
2080	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2081	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2082	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2084	We couldn't process your recent payment. Confirm by entering OTP 422130 now.	2025-11-10 00:00:00	0	en
2085	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2089	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2090	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 439187	2025-11-10 00:00:00	0	ar
2091	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2094	مهم: بطاقتك المنتهية بالرقم 9954 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2096	تنبيه: تم إجراء عملية شراء بمبلغ 8095.47. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2097	تم تحويل مبلغ 4442.48 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2098	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2099	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 414080	2025-11-10 00:00:00	0	ar
2100	Important: Your debit card ending with 2828 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2101	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2102	Security alert: unauthorized login. Enter code 979650 to secure account.	2025-11-10 00:00:00	0	en
2103	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2104	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2106	تم تحويل مبلغ 840.18 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2110	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2111	We detected unusual activity on your account. Confirm your identity with OTP: 409151	2025-11-10 00:00:00	0	en
2114	Security alert: unauthorized login. Enter code 524232 to secure account.	2025-11-10 00:00:00	0	en
2115	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2116	مهم: بطاقتك المنتهية بالرقم 6003 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2118	Security alert: unauthorized login. Enter code 747638 to secure account.	2025-11-10 00:00:00	0	en
2121	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2122	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2124	Security alert: unauthorized login. Enter code 432303 to secure account.	2025-11-10 00:00:00	0	en
2126	We couldn't process your recent payment. Confirm by entering OTP 306654 now.	2025-11-10 00:00:00	0	en
2130	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 590346.	2025-11-10 00:00:00	0	ar
2132	مهم: بطاقتك المنتهية بالرقم 3713 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2133	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2135	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 194879 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2136	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2137	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2138	مهم: بطاقتك المنتهية بالرقم 5323 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2139	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2140	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2141	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2142	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2146	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2148	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2152	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2153	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 356640.	2025-11-10 00:00:00	0	ar
2155	Security alert: unauthorized login. Enter code 392294 to secure account.	2025-11-10 00:00:00	0	en
2157	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2159	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 582488.	2025-11-10 00:00:00	0	ar
2162	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 648847.	2025-11-10 00:00:00	0	ar
2163	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2166	Security alert: unauthorized login. Enter code 794787 to secure account.	2025-11-10 00:00:00	0	en
2169	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 824386 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2170	We couldn't process your recent payment. Confirm by entering OTP 697787 now.	2025-11-10 00:00:00	0	en
2171	A transfer of $9348.48 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2172	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2173	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2175	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 548245 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2176	We couldn't process your recent payment. Confirm by entering OTP 847086 now.	2025-11-10 00:00:00	0	en
2177	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2179	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2180	Confirm your payment of $1704.48 using code 486480. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2183	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 895272.	2025-11-10 00:00:00	0	ar
2184	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2186	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 979485 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2188	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2189	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 455176.	2025-11-10 00:00:00	0	ar
2191	مهم: بطاقتك المنتهية بالرقم 9252 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2193	Security alert: unauthorized login. Enter code 647344 to secure account.	2025-11-10 00:00:00	0	en
2196	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2198	A transfer of $8236.87 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2199	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2200	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2202	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2203	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2205	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2210	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2213	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2215	Important: Your debit card ending with 7442 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2217	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2224	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2225	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2227	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2228	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 118719.	2025-11-10 00:00:00	0	ar
2229	مهم: بطاقتك المنتهية بالرقم 5562 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2230	مهم: بطاقتك المنتهية بالرقم 6771 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2231	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2232	Important: Your debit card ending with 3084 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2233	Confirm your payment of $9558.12 using code 766949. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2235	تم تحويل مبلغ 2446.03 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2238	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 785948 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2239	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 353231.	2025-11-10 00:00:00	0	ar
2240	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2242	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2245	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2246	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2250	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
421	Your scheduled transfer completed successfully. Ref: 9652.	2025-11-10 00:00:00	\N	en
2254	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2255	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2257	We detected unusual activity on your account. Confirm your identity with OTP: 796118	2025-11-10 00:00:00	0	en
2260	Confirm your payment of $5219.42 using code 382273. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2261	Important: Your debit card ending with 7738 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2264	تنبيه: تم إجراء عملية شراء بمبلغ 175.67. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2266	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2268	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2270	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2271	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 803755.	2025-11-10 00:00:00	0	ar
2275	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2277	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2279	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 169358 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2280	تنبيه: تم إجراء عملية شراء بمبلغ 4554.47. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2282	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 961519.	2025-11-10 00:00:00	0	ar
2283	مهم: بطاقتك المنتهية بالرقم 4542 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2284	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2285	Security alert: unauthorized login. Enter code 614218 to secure account.	2025-11-10 00:00:00	0	en
2288	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 385866	2025-11-10 00:00:00	0	ar
2289	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2291	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2294	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2297	A transfer of $1706.96 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2298	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2302	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 410038	2025-11-10 00:00:00	0	ar
2303	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 933384 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2304	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 975620.	2025-11-10 00:00:00	0	ar
2305	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2309	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2312	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2315	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2318	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2319	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2320	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2321	مهم: بطاقتك المنتهية بالرقم 2709 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2324	A transfer of $5413.16 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2326	We detected unusual activity on your account. Confirm your identity with OTP: 803320	2025-11-10 00:00:00	0	en
2328	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 958740 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2329	تنبيه: تم إجراء عملية شراء بمبلغ 5006.03. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2331	مهم: بطاقتك المنتهية بالرقم 7621 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2335	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2336	A transfer of $9683.80 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2337	Important: Your debit card ending with 5078 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2338	Important: Your debit card ending with 8891 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2339	Confirm your payment of $6345.49 using code 100012. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2340	Confirm your payment of $3220.23 using code 766073. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2341	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 878161	2025-11-10 00:00:00	0	ar
2345	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2347	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 933338.	2025-11-10 00:00:00	0	ar
2351	We detected unusual activity on your account. Confirm your identity with OTP: 798341	2025-11-10 00:00:00	0	en
2354	Important: Your debit card ending with 9278 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2355	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2357	A transfer of $4438.50 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2358	Confirm your payment of $4544.47 using code 773971. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2359	A transfer of $4198.17 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2360	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2362	Important: Your debit card ending with 3863 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2363	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2364	مهم: بطاقتك المنتهية بالرقم 1037 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
422	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2368	We couldn't process your recent payment. Confirm by entering OTP 716571 now.	2025-11-10 00:00:00	0	en
2370	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 763742 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2372	Confirm your payment of $7440.52 using code 781255. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2377	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2378	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2384	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2386	Important: Your debit card ending with 9659 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2387	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2388	A transfer of $4108.90 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2391	Confirm your payment of $363.91 using code 846439. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2392	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2394	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2397	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2398	We couldn't process your recent payment. Confirm by entering OTP 859526 now.	2025-11-10 00:00:00	0	en
2399	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2402	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2403	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2404	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2405	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 434360.	2025-11-10 00:00:00	0	ar
2406	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2407	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2408	مهم: بطاقتك المنتهية بالرقم 2600 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2410	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2412	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2414	مهم: بطاقتك المنتهية بالرقم 2626 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2416	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 387756 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2417	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2419	A transfer of $2331.02 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2420	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2422	A transfer of $8854.51 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2423	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 306249	2025-11-10 00:00:00	0	ar
2426	Important: Your debit card ending with 4591 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2427	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2429	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 288191	2025-11-10 00:00:00	0	ar
2430	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2433	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 519000	2025-11-10 00:00:00	0	ar
2436	A transfer of $8224.84 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2438	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2442	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2443	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2447	مهم: بطاقتك المنتهية بالرقم 2975 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2449	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2450	A transfer of $8586.66 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2454	Important: Your debit card ending with 8863 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2456	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2459	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 297134 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2460	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 491685.	2025-11-10 00:00:00	0	ar
2461	تنبيه: تم إجراء عملية شراء بمبلغ 9512.28. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2463	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2464	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2466	Important: Your debit card ending with 7382 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2467	We couldn't process your recent payment. Confirm by entering OTP 573646 now.	2025-11-10 00:00:00	0	en
2468	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2471	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2473	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2474	We detected unusual activity on your account. Confirm your identity with OTP: 654477	2025-11-10 00:00:00	0	en
2475	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2476	مهم: بطاقتك المنتهية بالرقم 6143 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2477	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 611357 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2479	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2480	A transfer of $651.60 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2482	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2483	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2487	مهم: بطاقتك المنتهية بالرقم 7949 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2489	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2490	تنبيه: تم إجراء عملية شراء بمبلغ 9494.83. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2491	مهم: بطاقتك المنتهية بالرقم 4478 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2492	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2494	مهم: بطاقتك المنتهية بالرقم 8604 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2496	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2498	Confirm your payment of $8125.50 using code 638079. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2500	تم تحويل مبلغ 2479.89 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2501	تنبيه: تم إجراء عملية شراء بمبلغ 793.93. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2503	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2504	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 954542 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2507	A transfer of $5711.79 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2509	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2511	A transfer of $7726.42 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2516	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2518	تم تحويل مبلغ 2870.72 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2523	Important: Your debit card ending with 9061 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2524	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2528	تم تحويل مبلغ 6559.44 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2530	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2531	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2532	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2535	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2542	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 614050.	2025-11-10 00:00:00	0	ar
2543	مهم: بطاقتك المنتهية بالرقم 2306 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2546	تم تحويل مبلغ 5125.11 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2547	Confirm your payment of $6781.00 using code 553927. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2549	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2551	We couldn't process your recent payment. Confirm by entering OTP 155054 now.	2025-11-10 00:00:00	0	en
2554	Important: Your debit card ending with 6829 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2555	Security alert: unauthorized login. Enter code 794281 to secure account.	2025-11-10 00:00:00	0	en
2556	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 623860.	2025-11-10 00:00:00	0	ar
2558	Security alert: unauthorized login. Enter code 131113 to secure account.	2025-11-10 00:00:00	0	en
2561	We detected unusual activity on your account. Confirm your identity with OTP: 665346	2025-11-10 00:00:00	0	en
2565	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2567	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2568	A transfer of $555.08 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2572	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2573	تم تحويل مبلغ 288.49 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2574	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2575	Confirm your payment of $7871.48 using code 733784. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2576	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2577	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 852742 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2581	Confirm your payment of $6830.95 using code 485582. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2582	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2583	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2584	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2585	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 763690 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2586	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2588	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2590	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2592	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 325927	2025-11-10 00:00:00	0	ar
2594	Confirm your payment of $7592.53 using code 686611. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2595	A transfer of $7244.18 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2597	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2598	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2601	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2608	مهم: بطاقتك المنتهية بالرقم 9615 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2609	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2610	Confirm your payment of $6604.61 using code 828194. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2612	We detected unusual activity on your account. Confirm your identity with OTP: 315407	2025-11-10 00:00:00	0	en
2614	We couldn't process your recent payment. Confirm by entering OTP 639400 now.	2025-11-10 00:00:00	0	en
2615	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2617	We detected unusual activity on your account. Confirm your identity with OTP: 142711	2025-11-10 00:00:00	0	en
2618	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 249134	2025-11-10 00:00:00	0	ar
2620	تم تحويل مبلغ 5057.48 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2621	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2622	تنبيه: تم إجراء عملية شراء بمبلغ 4977.63. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2623	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 277900.	2025-11-10 00:00:00	0	ar
2626	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2627	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2629	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2636	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2638	مهم: بطاقتك المنتهية بالرقم 9982 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2640	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2641	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2642	We detected unusual activity on your account. Confirm your identity with OTP: 296767	2025-11-10 00:00:00	0	en
2643	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2644	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 988465.	2025-11-10 00:00:00	0	ar
2646	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2655	تم تحويل مبلغ 5095.77 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2658	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2659	We detected unusual activity on your account. Confirm your identity with OTP: 206358	2025-11-10 00:00:00	0	en
2660	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2662	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 912580.	2025-11-10 00:00:00	0	ar
2663	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2664	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2666	Security alert: unauthorized login. Enter code 300280 to secure account.	2025-11-10 00:00:00	0	en
2667	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2670	تنبيه: تم إجراء عملية شراء بمبلغ 9031.60. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2671	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2672	A transfer of $8398.39 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2673	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2676	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2677	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2678	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 908756.	2025-11-10 00:00:00	0	ar
2680	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2681	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2682	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 688911	2025-11-10 00:00:00	0	ar
2688	تنبيه: تم إجراء عملية شراء بمبلغ 9466.22. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2693	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2694	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 943523 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2696	Confirm your payment of $2817.57 using code 404992. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2698	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2702	Confirm your payment of $182.67 using code 113528. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2703	Confirm your payment of $3707.64 using code 985347. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2704	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2707	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2708	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2711	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2712	We detected unusual activity on your account. Confirm your identity with OTP: 545462	2025-11-10 00:00:00	0	en
2716	Confirm your payment of $747.50 using code 763572. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2719	تنبيه: تم إجراء عملية شراء بمبلغ 6703.17. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2727	Important: Your debit card ending with 3641 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2729	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2732	مهم: بطاقتك المنتهية بالرقم 8606 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2736	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2737	We detected unusual activity on your account. Confirm your identity with OTP: 452602	2025-11-10 00:00:00	0	en
2738	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2739	تم تحويل مبلغ 2536.04 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2740	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2742	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 689620.	2025-11-10 00:00:00	0	ar
2747	تم تحويل مبلغ 7414.31 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2748	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2749	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2750	مهم: بطاقتك المنتهية بالرقم 2302 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2752	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2753	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2754	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2755	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2757	Important: Your debit card ending with 9783 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2758	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2761	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2763	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2764	Security alert: unauthorized login. Enter code 167357 to secure account.	2025-11-10 00:00:00	0	en
2765	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2766	We detected unusual activity on your account. Confirm your identity with OTP: 580304	2025-11-10 00:00:00	0	en
2771	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 742882	2025-11-10 00:00:00	0	ar
2772	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 649440 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2773	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2774	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2775	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 435392 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2777	تم تحويل مبلغ 2814.37 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2778	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 967349.	2025-11-10 00:00:00	0	ar
2780	Important: Your debit card ending with 9481 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2781	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2782	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2783	مهم: بطاقتك المنتهية بالرقم 3723 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2784	تم تحويل مبلغ 6454.94 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
2785	We couldn't process your recent payment. Confirm by entering OTP 636725 now.	2025-11-10 00:00:00	0	en
2786	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2787	مهم: بطاقتك المنتهية بالرقم 1960 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2790	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2791	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2793	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2797	Important: Your debit card ending with 4272 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2798	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2799	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2802	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2811	تنبيه: تم إجراء عملية شراء بمبلغ 1055.19. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2812	تنبيه: تم إجراء عملية شراء بمبلغ 8604.12. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2813	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2814	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2816	مهم: بطاقتك المنتهية بالرقم 6703 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2819	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 491376	2025-11-10 00:00:00	0	ar
2820	تنبيه: تم إجراء عملية شراء بمبلغ 166.75. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2821	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2822	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2826	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
2827	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 607156 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2829	A transfer of $447.47 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2831	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2832	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2835	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2841	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2843	Security alert: unauthorized login. Enter code 514832 to secure account.	2025-11-10 00:00:00	0	en
2844	We detected unusual activity on your account. Confirm your identity with OTP: 430669	2025-11-10 00:00:00	0	en
2845	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2847	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2850	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2854	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 540766	2025-11-10 00:00:00	0	ar
2856	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 408986	2025-11-10 00:00:00	0	ar
2858	Important: Your debit card ending with 8919 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2863	We detected unusual activity on your account. Confirm your identity with OTP: 814009	2025-11-10 00:00:00	0	en
2864	Security alert: unauthorized login. Enter code 541662 to secure account.	2025-11-10 00:00:00	0	en
2865	مهم: بطاقتك المنتهية بالرقم 6532 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2867	تنبيه: تم إجراء عملية شراء بمبلغ 7115.79. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2869	We detected unusual activity on your account. Confirm your identity with OTP: 511766	2025-11-10 00:00:00	0	en
2873	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2874	Security alert: unauthorized login. Enter code 915634 to secure account.	2025-11-10 00:00:00	0	en
2876	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2877	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2879	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2882	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2884	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2887	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2888	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 122149.	2025-11-10 00:00:00	0	ar
2889	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2891	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2892	تنبيه: تم إجراء عملية شراء بمبلغ 5249.62. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2893	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2894	Important: Your debit card ending with 7405 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2895	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2896	Confirm your payment of $9137.29 using code 695487. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
2898	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2899	A transfer of $8211.02 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2900	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2901	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2904	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2905	Security alert: unauthorized login. Enter code 943134 to secure account.	2025-11-10 00:00:00	0	en
2907	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
2908	مهم: بطاقتك المنتهية بالرقم 3884 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2909	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2912	Important: Your debit card ending with 2739 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2913	تنبيه: تم إجراء عملية شراء بمبلغ 3605.35. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2914	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2919	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 621967.	2025-11-10 00:00:00	0	ar
2920	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2921	تنبيه: تم إجراء عملية شراء بمبلغ 6247.80. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2923	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
2926	مهم: بطاقتك المنتهية بالرقم 4523 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2928	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 114374 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2931	We detected unusual activity on your account. Confirm your identity with OTP: 511185	2025-11-10 00:00:00	0	en
2932	Important: Your debit card ending with 6971 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
2933	مهم: بطاقتك المنتهية بالرقم 5926 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2935	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2938	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 447639.	2025-11-10 00:00:00	0	ar
2940	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
2941	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2942	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2943	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 245146.	2025-11-10 00:00:00	0	ar
2945	مهم: بطاقتك المنتهية بالرقم 2795 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2947	Security alert: unauthorized login. Enter code 963661 to secure account.	2025-11-10 00:00:00	0	en
2948	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
2950	تنبيه: تم إجراء عملية شراء بمبلغ 719.67. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
2951	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 571835.	2025-11-10 00:00:00	0	ar
2954	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
2956	A transfer of $6155.04 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2958	مهم: بطاقتك المنتهية بالرقم 9265 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
2962	We couldn't process your recent payment. Confirm by entering OTP 311217 now.	2025-11-10 00:00:00	0	en
2964	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2965	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
2966	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2969	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2970	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
2971	Security alert: unauthorized login. Enter code 678048 to secure account.	2025-11-10 00:00:00	0	en
2974	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 876897 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
2975	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2977	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
2978	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2979	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
2981	We detected unusual activity on your account. Confirm your identity with OTP: 182859	2025-11-10 00:00:00	0	en
2982	A transfer of $8782.92 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
2983	We detected unusual activity on your account. Confirm your identity with OTP: 119221	2025-11-10 00:00:00	0	en
2985	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
2986	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
2990	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2996	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
2999	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3000	مهم: بطاقتك المنتهية بالرقم 1699 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3002	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3003	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3005	مهم: بطاقتك المنتهية بالرقم 2846 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
423	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3008	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3010	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3011	Important: Your debit card ending with 4981 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3012	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3013	A transfer of $8883.74 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3014	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3015	We detected unusual activity on your account. Confirm your identity with OTP: 279287	2025-11-10 00:00:00	0	en
3016	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3020	تنبيه: تم إجراء عملية شراء بمبلغ 657.41. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3023	تنبيه: تم إجراء عملية شراء بمبلغ 2796.51. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3024	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3026	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 301094	2025-11-10 00:00:00	0	ar
3028	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3029	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3030	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3031	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3032	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3034	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3035	Security alert: unauthorized login. Enter code 441747 to secure account.	2025-11-10 00:00:00	0	en
3036	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3038	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3039	مهم: بطاقتك المنتهية بالرقم 3326 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3042	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 131731	2025-11-10 00:00:00	0	ar
3045	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3049	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3051	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3056	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 992327 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3059	Important: Your debit card ending with 6566 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3062	Important: Your debit card ending with 9527 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3064	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3068	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 153920.	2025-11-10 00:00:00	0	ar
3071	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3072	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3073	A transfer of $3688.02 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3075	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 400328.	2025-11-10 00:00:00	0	ar
3076	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3079	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3081	A transfer of $5922.45 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3082	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 246112	2025-11-10 00:00:00	0	ar
3084	تم تحويل مبلغ 9172.43 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3085	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3090	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 441857 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3091	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3092	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3093	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3095	A transfer of $8286.79 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3097	Important: Your debit card ending with 6121 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3098	Security alert: unauthorized login. Enter code 632290 to secure account.	2025-11-10 00:00:00	0	en
3099	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3100	تنبيه: تم إجراء عملية شراء بمبلغ 8155.75. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3101	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 969299 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3102	Important: Your debit card ending with 5754 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3103	Important: Your debit card ending with 7246 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3105	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3106	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3108	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3109	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3111	A transfer of $2452.41 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3114	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3115	We couldn't process your recent payment. Confirm by entering OTP 472718 now.	2025-11-10 00:00:00	0	en
3116	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3117	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 601559.	2025-11-10 00:00:00	0	ar
3118	تم تحويل مبلغ 8896.10 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3119	تنبيه: تم إجراء عملية شراء بمبلغ 4320.01. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3120	We detected unusual activity on your account. Confirm your identity with OTP: 466315	2025-11-10 00:00:00	0	en
3121	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3070	Your transaction of $3126.19 at STORE was successful. Ref: 3995.	2025-11-10 00:00:00	\N	en
3124	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3125	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3130	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3132	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3133	Security alert: unauthorized login. Enter code 225168 to secure account.	2025-11-10 00:00:00	0	en
3135	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3138	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 452866	2025-11-10 00:00:00	0	ar
3139	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 264235 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3140	We couldn't process your recent payment. Confirm by entering OTP 163946 now.	2025-11-10 00:00:00	0	en
3141	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3144	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3145	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3151	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3152	تم تحويل مبلغ 3928.29 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3154	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3156	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3157	Confirm your payment of $5378.77 using code 988848. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3159	Confirm your payment of $4745.40 using code 878733. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3160	We detected unusual activity on your account. Confirm your identity with OTP: 167255	2025-11-10 00:00:00	0	en
3161	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3171	Important: Your debit card ending with 2381 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3174	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3175	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3176	We detected unusual activity on your account. Confirm your identity with OTP: 937478	2025-11-10 00:00:00	0	en
3178	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3188	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3192	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3193	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3194	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3196	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3197	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3200	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3202	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3203	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 554180.	2025-11-10 00:00:00	0	ar
3205	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3206	We couldn't process your recent payment. Confirm by entering OTP 386694 now.	2025-11-10 00:00:00	0	en
3209	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3212	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3213	مهم: بطاقتك المنتهية بالرقم 6782 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3217	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3218	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 184893.	2025-11-10 00:00:00	0	ar
3220	Security alert: unauthorized login. Enter code 486040 to secure account.	2025-11-10 00:00:00	0	en
3223	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 121927	2025-11-10 00:00:00	0	ar
3224	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3225	تم تحويل مبلغ 1949.10 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3227	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3228	تم تحويل مبلغ 490.79 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3234	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 610307.	2025-11-10 00:00:00	0	ar
3238	We couldn't process your recent payment. Confirm by entering OTP 942319 now.	2025-11-10 00:00:00	0	en
3243	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3244	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3247	مهم: بطاقتك المنتهية بالرقم 9624 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3250	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3251	Security alert: unauthorized login. Enter code 936440 to secure account.	2025-11-10 00:00:00	0	en
3252	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 206387.	2025-11-10 00:00:00	0	ar
3256	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3257	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 307609.	2025-11-10 00:00:00	0	ar
3258	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3259	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3260	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3262	Important: Your debit card ending with 5890 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3266	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3267	Important: Your debit card ending with 1612 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3269	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3270	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3271	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 834969.	2025-11-10 00:00:00	0	ar
3272	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3273	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3275	We detected unusual activity on your account. Confirm your identity with OTP: 659544	2025-11-10 00:00:00	0	en
3276	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3277	مهم: بطاقتك المنتهية بالرقم 8444 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3278	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3279	مهم: بطاقتك المنتهية بالرقم 6582 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3280	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3281	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3282	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 479223 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3284	تنبيه: تم إجراء عملية شراء بمبلغ 5049.00. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3287	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 924613	2025-11-10 00:00:00	0	ar
3288	We detected unusual activity on your account. Confirm your identity with OTP: 344039	2025-11-10 00:00:00	0	en
3293	تم تحويل مبلغ 3985.01 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3240	Your scheduled transfer completed successfully. Ref: 7005.	2025-11-10 00:00:00	\N	en
3295	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3297	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3299	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3300	مهم: بطاقتك المنتهية بالرقم 7417 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3301	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3304	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3306	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3309	A transfer of $9261.82 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3310	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 373701.	2025-11-10 00:00:00	0	ar
3312	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3313	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3314	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3316	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3318	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3319	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3320	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3322	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 973844 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3324	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3325	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3327	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3328	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3330	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 701775 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3332	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3335	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 516226	2025-11-10 00:00:00	0	ar
3336	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3338	Security alert: unauthorized login. Enter code 148554 to secure account.	2025-11-10 00:00:00	0	en
3341	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3344	مهم: بطاقتك المنتهية بالرقم 2084 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3350	We couldn't process your recent payment. Confirm by entering OTP 338815 now.	2025-11-10 00:00:00	0	en
3351	A transfer of $1336.70 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3354	مهم: بطاقتك المنتهية بالرقم 4897 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3355	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3356	We detected unusual activity on your account. Confirm your identity with OTP: 857181	2025-11-10 00:00:00	0	en
3358	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3359	We detected unusual activity on your account. Confirm your identity with OTP: 542188	2025-11-10 00:00:00	0	en
3360	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3361	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3365	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 259192 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3367	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 917535 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3368	Security alert: unauthorized login. Enter code 613346 to secure account.	2025-11-10 00:00:00	0	en
3373	مهم: بطاقتك المنتهية بالرقم 2183 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3375	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3376	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 578544.	2025-11-10 00:00:00	0	ar
3377	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3379	Important: Your debit card ending with 8907 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3380	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3381	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3382	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3383	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3386	A transfer of $7144.46 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3392	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 741995.	2025-11-10 00:00:00	0	ar
3393	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 671656	2025-11-10 00:00:00	0	ar
3394	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3396	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3397	Security alert: unauthorized login. Enter code 852596 to secure account.	2025-11-10 00:00:00	0	en
3399	تم تحويل مبلغ 5418.77 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3400	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3401	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3402	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 364278 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3404	A transfer of $4064.53 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3405	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3409	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3353	Your transaction of $3728.21 at STORE was successful. Ref: 5811.	2025-11-10 00:00:00	\N	en
3412	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3413	Security alert: unauthorized login. Enter code 374431 to secure account.	2025-11-10 00:00:00	0	en
3418	مهم: بطاقتك المنتهية بالرقم 6121 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3419	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 279850	2025-11-10 00:00:00	0	ar
3420	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3421	تم تحويل مبلغ 4554.15 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3422	تنبيه: تم إجراء عملية شراء بمبلغ 7465.26. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3426	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 141152 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3427	A transfer of $3516.18 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3429	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3431	تم تحويل مبلغ 5863.06 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3432	We detected unusual activity on your account. Confirm your identity with OTP: 661886	2025-11-10 00:00:00	0	en
3434	A transfer of $6062.23 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3435	Confirm your payment of $9181.89 using code 845541. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3436	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3437	We couldn't process your recent payment. Confirm by entering OTP 877841 now.	2025-11-10 00:00:00	0	en
3438	Important: Your debit card ending with 3046 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3440	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 912194 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3445	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3446	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3449	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 733102.	2025-11-10 00:00:00	0	ar
3451	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3452	Security alert: unauthorized login. Enter code 449407 to secure account.	2025-11-10 00:00:00	0	en
3453	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3454	We couldn't process your recent payment. Confirm by entering OTP 255173 now.	2025-11-10 00:00:00	0	en
3459	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 294700.	2025-11-10 00:00:00	0	ar
3461	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3464	We detected unusual activity on your account. Confirm your identity with OTP: 942949	2025-11-10 00:00:00	0	en
3465	Confirm your payment of $9696.52 using code 267054. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3468	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3469	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3470	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 403162 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3471	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3472	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3477	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3478	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 380099.	2025-11-10 00:00:00	0	ar
3480	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3482	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3484	Confirm your payment of $5816.68 using code 300136. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3485	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 896484.	2025-11-10 00:00:00	0	ar
3487	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3488	Confirm your payment of $6508.98 using code 876602. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3490	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 586860.	2025-11-10 00:00:00	0	ar
3491	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 876511	2025-11-10 00:00:00	0	ar
3496	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3497	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3501	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3502	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3503	Important: Your debit card ending with 3815 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3504	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3505	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3506	We couldn't process your recent payment. Confirm by entering OTP 244765 now.	2025-11-10 00:00:00	0	en
3507	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3509	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3513	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3514	We detected unusual activity on your account. Confirm your identity with OTP: 278353	2025-11-10 00:00:00	0	en
3515	Security alert: unauthorized login. Enter code 328736 to secure account.	2025-11-10 00:00:00	0	en
3516	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3517	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3522	تنبيه: تم إجراء عملية شراء بمبلغ 4557.27. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3524	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3534	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3535	We couldn't process your recent payment. Confirm by entering OTP 828815 now.	2025-11-10 00:00:00	0	en
3536	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3537	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3538	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3540	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 657314	2025-11-10 00:00:00	0	ar
3543	We couldn't process your recent payment. Confirm by entering OTP 531123 now.	2025-11-10 00:00:00	0	en
3544	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3545	مهم: بطاقتك المنتهية بالرقم 9517 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3547	Important: Your debit card ending with 2749 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3548	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3549	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3551	تم تحويل مبلغ 2710.49 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3556	Confirm your payment of $8397.53 using code 594079. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3557	Confirm your payment of $2101.94 using code 410219. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3559	مهم: بطاقتك المنتهية بالرقم 1208 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3561	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3565	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3566	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 503849 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3570	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3571	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3572	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3573	We detected unusual activity on your account. Confirm your identity with OTP: 154441	2025-11-10 00:00:00	0	en
3574	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 496886	2025-11-10 00:00:00	0	ar
3575	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3576	Confirm your payment of $1658.61 using code 969136. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3581	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3584	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3585	Important: Your debit card ending with 6831 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3586	A transfer of $4593.36 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3588	A transfer of $4751.86 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3589	تنبيه: تم إجراء عملية شراء بمبلغ 7909.39. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3590	تم تحويل مبلغ 2576.03 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3592	Confirm your payment of $5489.52 using code 807919. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3594	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3598	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3607	تم تحويل مبلغ 4870.82 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3610	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3616	We couldn't process your recent payment. Confirm by entering OTP 367250 now.	2025-11-10 00:00:00	0	en
3617	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3619	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3620	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3621	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3624	تم تحويل مبلغ 2156.01 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3625	مهم: بطاقتك المنتهية بالرقم 3211 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3633	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3634	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3636	Important: Your debit card ending with 1782 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3641	We couldn't process your recent payment. Confirm by entering OTP 183489 now.	2025-11-10 00:00:00	0	en
3642	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3643	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
424	Your OTP for transaction is 602606. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3645	Important: Your debit card ending with 2473 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3647	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3650	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3655	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3656	Security alert: unauthorized login. Enter code 525553 to secure account.	2025-11-10 00:00:00	0	en
3659	تنبيه: تم إجراء عملية شراء بمبلغ 1581.58. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3660	Important: Your debit card ending with 7110 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3663	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3667	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3669	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3670	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3675	تم تحويل مبلغ 4871.77 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3676	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3677	We couldn't process your recent payment. Confirm by entering OTP 483204 now.	2025-11-10 00:00:00	0	en
3678	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 235023 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3679	A transfer of $5843.08 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3680	A transfer of $6579.15 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3681	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3684	Security alert: unauthorized login. Enter code 827448 to secure account.	2025-11-10 00:00:00	0	en
3685	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3687	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3688	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3690	A transfer of $3312.85 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3693	Important: Your debit card ending with 1917 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3694	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3696	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3697	تنبيه: تم إجراء عملية شراء بمبلغ 3505.20. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3698	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 124403	2025-11-10 00:00:00	0	ar
3699	A transfer of $2972.10 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3700	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3702	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3703	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3705	Confirm your payment of $6656.04 using code 429774. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3706	Important: Your debit card ending with 5128 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3708	تنبيه: تم إجراء عملية شراء بمبلغ 58.23. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3709	We couldn't process your recent payment. Confirm by entering OTP 921916 now.	2025-11-10 00:00:00	0	en
3711	مهم: بطاقتك المنتهية بالرقم 5197 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3715	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3716	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3717	Important: Your debit card ending with 5311 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3718	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3720	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3722	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3723	Security alert: unauthorized login. Enter code 471056 to secure account.	2025-11-10 00:00:00	0	en
3728	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 842956	2025-11-10 00:00:00	0	ar
3729	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3730	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3732	Confirm your payment of $591.12 using code 978131. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3733	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3734	Important: Your debit card ending with 9525 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3736	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3738	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 121116 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3739	A transfer of $9267.09 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3740	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3742	Confirm your payment of $352.24 using code 930143. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3747	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3749	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3750	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 872331	2025-11-10 00:00:00	0	ar
3751	A transfer of $7178.69 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3752	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3753	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3755	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3756	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3757	A transfer of $1120.92 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
425	Dear customer, your account balance is $7489.31. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3758	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 198904 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3760	تم تحويل مبلغ 1132.18 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3762	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3763	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3765	Confirm your payment of $2562.28 using code 694225. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3766	مهم: بطاقتك المنتهية بالرقم 2936 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3767	تم تحويل مبلغ 5795.90 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3768	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3769	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3770	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3773	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3775	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3776	تم تحويل مبلغ 4959.43 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3778	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3780	تم تحويل مبلغ 9816.27 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3781	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3782	Important: Your debit card ending with 2891 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3783	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3784	تم تحويل مبلغ 8560.94 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3786	Security alert: unauthorized login. Enter code 657355 to secure account.	2025-11-10 00:00:00	0	en
3788	Important: Your debit card ending with 8263 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3789	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3792	Confirm your payment of $9448.16 using code 447117. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3793	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 298396	2025-11-10 00:00:00	0	ar
3795	تنبيه: تم إجراء عملية شراء بمبلغ 4309.00. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3796	Important: Your debit card ending with 5048 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3799	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3800	A transfer of $2118.10 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3806	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3808	Important: Your debit card ending with 4389 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3811	Confirm your payment of $6822.49 using code 624595. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3812	Security alert: unauthorized login. Enter code 610399 to secure account.	2025-11-10 00:00:00	0	en
3813	تم تحويل مبلغ 9681.39 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3814	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3816	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3817	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3819	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
3827	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3830	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 929666 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3831	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 513373 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3832	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 627339.	2025-11-10 00:00:00	0	ar
3833	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 814499	2025-11-10 00:00:00	0	ar
3834	Security alert: unauthorized login. Enter code 760338 to secure account.	2025-11-10 00:00:00	0	en
3835	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3836	Security alert: unauthorized login. Enter code 896062 to secure account.	2025-11-10 00:00:00	0	en
3838	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3841	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 432145.	2025-11-10 00:00:00	0	ar
3846	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3847	Important: Your debit card ending with 2659 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3849	Important: Your debit card ending with 6684 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3850	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3854	تم تحويل مبلغ 7573.60 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3855	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 676079.	2025-11-10 00:00:00	0	ar
3856	We detected unusual activity on your account. Confirm your identity with OTP: 942125	2025-11-10 00:00:00	0	en
3858	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3860	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 848052 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3863	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
3864	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
3868	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3869	Important: Your debit card ending with 6118 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3870	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
3871	Security alert: unauthorized login. Enter code 907957 to secure account.	2025-11-10 00:00:00	0	en
3875	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 916418.	2025-11-10 00:00:00	0	ar
3876	مهم: بطاقتك المنتهية بالرقم 9701 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3885	A transfer of $670.11 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3886	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3894	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3895	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 860667 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3896	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3898	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3900	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
3901	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3902	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3903	Important: Your debit card ending with 3700 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3904	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3905	A transfer of $1872.13 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3906	We couldn't process your recent payment. Confirm by entering OTP 192052 now.	2025-11-10 00:00:00	0	en
3907	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3911	تنبيه: تم إجراء عملية شراء بمبلغ 7372.63. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3912	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3915	We couldn't process your recent payment. Confirm by entering OTP 468535 now.	2025-11-10 00:00:00	0	en
3920	تنبيه: تم إجراء عملية شراء بمبلغ 9989.45. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3922	تنبيه: تم إجراء عملية شراء بمبلغ 5795.91. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3923	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3926	تم تحويل مبلغ 8865.82 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3927	تم تحويل مبلغ 6713.72 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3932	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 266633 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3933	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
3934	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3936	تم تحويل مبلغ 3078.80 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3937	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3939	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3940	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 531221 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3941	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 697472 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
3942	We detected unusual activity on your account. Confirm your identity with OTP: 390632	2025-11-10 00:00:00	0	en
3943	تم تحويل مبلغ 6272.85 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3944	Confirm your payment of $3596.58 using code 259673. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
3945	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 294661.	2025-11-10 00:00:00	0	ar
3949	A transfer of $7236.56 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
3951	We couldn't process your recent payment. Confirm by entering OTP 120928 now.	2025-11-10 00:00:00	0	en
3954	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3956	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3957	تم تحويل مبلغ 4319.26 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3958	Important: Your debit card ending with 1557 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3959	We detected unusual activity on your account. Confirm your identity with OTP: 398853	2025-11-10 00:00:00	0	en
3962	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
3963	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3964	We detected unusual activity on your account. Confirm your identity with OTP: 484534	2025-11-10 00:00:00	0	en
3965	مهم: بطاقتك المنتهية بالرقم 7694 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3967	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
3970	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
3971	Security alert: unauthorized login. Enter code 950606 to secure account.	2025-11-10 00:00:00	0	en
3973	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 803759	2025-11-10 00:00:00	0	ar
3974	تنبيه: تم إجراء عملية شراء بمبلغ 9356.69. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
3975	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3977	Security alert: unauthorized login. Enter code 522513 to secure account.	2025-11-10 00:00:00	0	en
3984	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
3988	تم تحويل مبلغ 5189.14 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
3990	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
3991	Important: Your debit card ending with 8832 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
3994	مهم: بطاقتك المنتهية بالرقم 1470 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
3996	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
3997	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
3999	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4002	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4004	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4005	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4010	مهم: بطاقتك المنتهية بالرقم 5143 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4011	Confirm your payment of $1240.26 using code 806870. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4012	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4014	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4015	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4018	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4023	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4026	Important: Your debit card ending with 4685 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4028	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4030	مهم: بطاقتك المنتهية بالرقم 5662 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4037	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4039	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4040	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4043	We detected unusual activity on your account. Confirm your identity with OTP: 486186	2025-11-10 00:00:00	0	en
4044	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4045	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4048	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4049	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4050	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4054	تم تحويل مبلغ 3928.28 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4055	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4057	A transfer of $7667.40 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4061	We couldn't process your recent payment. Confirm by entering OTP 525103 now.	2025-11-10 00:00:00	0	en
4065	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4069	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4070	مهم: بطاقتك المنتهية بالرقم 5935 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4072	Security alert: unauthorized login. Enter code 539945 to secure account.	2025-11-10 00:00:00	0	en
4073	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4077	Important: Your debit card ending with 8631 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4078	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4079	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4081	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4082	We couldn't process your recent payment. Confirm by entering OTP 208678 now.	2025-11-10 00:00:00	0	en
4083	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4086	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4088	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 688694 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4091	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4094	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 388154	2025-11-10 00:00:00	0	ar
4095	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 286844.	2025-11-10 00:00:00	0	ar
4096	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4100	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4102	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4103	Important: Your debit card ending with 9739 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4105	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4107	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4108	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 142966	2025-11-10 00:00:00	0	ar
4109	Confirm your payment of $2377.86 using code 920143. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4110	A transfer of $599.74 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4111	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4114	تم تحويل مبلغ 1279.68 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4117	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4118	Security alert: unauthorized login. Enter code 122689 to secure account.	2025-11-10 00:00:00	0	en
4120	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4121	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 107454.	2025-11-10 00:00:00	0	ar
4122	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4123	تنبيه: تم إجراء عملية شراء بمبلغ 1061.23. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4126	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4127	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4128	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 851995.	2025-11-10 00:00:00	0	ar
4129	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4130	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4132	We detected unusual activity on your account. Confirm your identity with OTP: 856016	2025-11-10 00:00:00	0	en
4134	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 805062	2025-11-10 00:00:00	0	ar
4136	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4138	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4139	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4140	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4141	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4142	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4143	Security alert: unauthorized login. Enter code 896235 to secure account.	2025-11-10 00:00:00	0	en
4144	Important: Your debit card ending with 6533 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4145	تنبيه: تم إجراء عملية شراء بمبلغ 1193.95. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4148	Security alert: unauthorized login. Enter code 839522 to secure account.	2025-11-10 00:00:00	0	en
4149	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4150	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4153	Confirm your payment of $5660.65 using code 949527. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4154	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4155	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4156	A transfer of $4419.90 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4157	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4159	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4161	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4163	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4164	Important: Your debit card ending with 9245 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4165	A transfer of $9635.61 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4166	We detected unusual activity on your account. Confirm your identity with OTP: 747738	2025-11-10 00:00:00	0	en
4167	Security alert: unauthorized login. Enter code 873572 to secure account.	2025-11-10 00:00:00	0	en
4169	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4170	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4171	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4172	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4174	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4175	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4178	We couldn't process your recent payment. Confirm by entering OTP 920351 now.	2025-11-10 00:00:00	0	en
4179	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4180	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4182	تنبيه: تم إجراء عملية شراء بمبلغ 5582.40. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4183	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4187	Confirm your payment of $6788.98 using code 578677. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4189	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 626440	2025-11-10 00:00:00	0	ar
4193	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 605329.	2025-11-10 00:00:00	0	ar
4195	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 830426.	2025-11-10 00:00:00	0	ar
4196	Important: Your debit card ending with 9273 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4198	تنبيه: تم إجراء عملية شراء بمبلغ 8126.96. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4199	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4200	تنبيه: تم إجراء عملية شراء بمبلغ 3388.97. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4201	تم تحويل مبلغ 5053.94 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4202	We detected unusual activity on your account. Confirm your identity with OTP: 587311	2025-11-10 00:00:00	0	en
4205	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 517048 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4206	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4207	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4208	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 705464 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4215	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 777184	2025-11-10 00:00:00	0	ar
4219	We detected unusual activity on your account. Confirm your identity with OTP: 593855	2025-11-10 00:00:00	0	en
4220	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4222	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4223	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 909926	2025-11-10 00:00:00	0	ar
4225	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4226	A transfer of $9789.45 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4231	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4234	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4236	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4237	A transfer of $7.85 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4238	Important: Your debit card ending with 2605 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4239	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4240	تم تحويل مبلغ 6976.90 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4244	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4245	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4247	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4251	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4253	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4254	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4255	Security alert: unauthorized login. Enter code 192675 to secure account.	2025-11-10 00:00:00	0	en
4258	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 835357 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4259	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 245644 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4260	Important: Your debit card ending with 5837 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4261	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4266	تنبيه: تم إجراء عملية شراء بمبلغ 4274.90. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4269	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4271	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4274	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4276	تنبيه: تم إجراء عملية شراء بمبلغ 5029.35. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4277	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4224	Your scheduled transfer completed successfully. Ref: 2659.	2025-11-10 00:00:00	\N	en
4286	تم تحويل مبلغ 9099.59 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4287	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4291	We detected unusual activity on your account. Confirm your identity with OTP: 673398	2025-11-10 00:00:00	0	en
4293	تم تحويل مبلغ 887.42 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4296	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4302	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 917851.	2025-11-10 00:00:00	0	ar
4304	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4305	We couldn't process your recent payment. Confirm by entering OTP 453163 now.	2025-11-10 00:00:00	0	en
4307	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 810263 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4308	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4310	تنبيه: تم إجراء عملية شراء بمبلغ 2408.39. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4311	Important: Your debit card ending with 3679 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4313	Security alert: unauthorized login. Enter code 830816 to secure account.	2025-11-10 00:00:00	0	en
4314	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4315	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4317	تنبيه: تم إجراء عملية شراء بمبلغ 6889.85. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4318	Security alert: unauthorized login. Enter code 653172 to secure account.	2025-11-10 00:00:00	0	en
4319	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4320	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4321	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4322	Confirm your payment of $5367.55 using code 743270. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4323	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4324	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 633830.	2025-11-10 00:00:00	0	ar
4332	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4333	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4334	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4336	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4337	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4338	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4340	مهم: بطاقتك المنتهية بالرقم 8595 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4342	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4344	We couldn't process your recent payment. Confirm by entering OTP 410854 now.	2025-11-10 00:00:00	0	en
4346	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 114474	2025-11-10 00:00:00	0	ar
4348	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4352	We couldn't process your recent payment. Confirm by entering OTP 355045 now.	2025-11-10 00:00:00	0	en
4354	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4355	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4357	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4358	Confirm your payment of $3270.45 using code 437026. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4359	Security alert: unauthorized login. Enter code 760639 to secure account.	2025-11-10 00:00:00	0	en
4364	A transfer of $259.55 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4367	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4368	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4369	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 197422	2025-11-10 00:00:00	0	ar
4371	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4372	We detected unusual activity on your account. Confirm your identity with OTP: 624801	2025-11-10 00:00:00	0	en
4374	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4375	Important: Your debit card ending with 9737 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4378	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4383	We couldn't process your recent payment. Confirm by entering OTP 865976 now.	2025-11-10 00:00:00	0	en
4384	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 123161 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4387	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4389	تم تحويل مبلغ 5949.63 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4391	A transfer of $8333.79 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4392	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4393	تنبيه: تم إجراء عملية شراء بمبلغ 9193.03. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4394	تم تحويل مبلغ 5646.91 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
430	Your scheduled transfer completed successfully. Ref: 1316.	2025-11-10 00:00:00	\N	en
4396	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4397	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4399	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 778726	2025-11-10 00:00:00	0	ar
4401	Important: Your debit card ending with 8473 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4402	A transfer of $6301.07 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4403	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4405	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4406	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4407	تنبيه: تم إجراء عملية شراء بمبلغ 9740.76. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4411	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4412	We detected unusual activity on your account. Confirm your identity with OTP: 549409	2025-11-10 00:00:00	0	en
4414	تم تحويل مبلغ 9893.99 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4416	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4417	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4418	We detected unusual activity on your account. Confirm your identity with OTP: 125195	2025-11-10 00:00:00	0	en
4422	مهم: بطاقتك المنتهية بالرقم 9570 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4426	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 156946.	2025-11-10 00:00:00	0	ar
4427	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 924169.	2025-11-10 00:00:00	0	ar
4428	مهم: بطاقتك المنتهية بالرقم 3470 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4429	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4430	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4433	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4435	مهم: بطاقتك المنتهية بالرقم 9226 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4436	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4438	تم تحويل مبلغ 3864.05 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4439	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4440	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 731778.	2025-11-10 00:00:00	0	ar
4442	تنبيه: تم إجراء عملية شراء بمبلغ 2128.05. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4445	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 792999.	2025-11-10 00:00:00	0	ar
4446	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4449	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4450	We detected unusual activity on your account. Confirm your identity with OTP: 888374	2025-11-10 00:00:00	0	en
4451	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4452	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4410	Your transaction of $3066.46 at STORE was successful. Ref: 2357.	2025-11-10 00:00:00	\N	en
4456	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4457	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4458	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4459	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4460	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 361327 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4461	مهم: بطاقتك المنتهية بالرقم 8375 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4462	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4464	تنبيه: تم إجراء عملية شراء بمبلغ 8193.63. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4466	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4468	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4479	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4480	We detected unusual activity on your account. Confirm your identity with OTP: 396620	2025-11-10 00:00:00	0	en
4481	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 643859	2025-11-10 00:00:00	0	ar
4482	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 524073 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4483	تنبيه: تم إجراء عملية شراء بمبلغ 6841.41. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4484	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4485	Confirm your payment of $8649.94 using code 412789. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4486	Confirm your payment of $7797.90 using code 129129. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4487	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4490	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4497	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4499	We detected unusual activity on your account. Confirm your identity with OTP: 685331	2025-11-10 00:00:00	0	en
4501	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4504	We couldn't process your recent payment. Confirm by entering OTP 641437 now.	2025-11-10 00:00:00	0	en
4506	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4507	Security alert: unauthorized login. Enter code 544407 to secure account.	2025-11-10 00:00:00	0	en
4508	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4511	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4512	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4513	Important: Your debit card ending with 1144 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4514	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 900969	2025-11-10 00:00:00	0	ar
4517	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4520	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4521	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4524	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4529	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4531	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4541	We couldn't process your recent payment. Confirm by entering OTP 327344 now.	2025-11-10 00:00:00	0	en
4542	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4546	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4547	A transfer of $7622.72 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4551	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 700008 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4552	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4554	تم تحويل مبلغ 9414.88 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4555	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 734452.	2025-11-10 00:00:00	0	ar
4556	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 219808.	2025-11-10 00:00:00	0	ar
4557	We detected unusual activity on your account. Confirm your identity with OTP: 987504	2025-11-10 00:00:00	0	en
4562	مهم: بطاقتك المنتهية بالرقم 2343 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4563	We couldn't process your recent payment. Confirm by entering OTP 284513 now.	2025-11-10 00:00:00	0	en
4564	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 958702	2025-11-10 00:00:00	0	ar
4565	Security alert: unauthorized login. Enter code 704263 to secure account.	2025-11-10 00:00:00	0	en
4566	تنبيه: تم إجراء عملية شراء بمبلغ 2682.30. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4567	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 596186.	2025-11-10 00:00:00	0	ar
4568	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 866878 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4570	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4574	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 293785 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4579	We couldn't process your recent payment. Confirm by entering OTP 924738 now.	2025-11-10 00:00:00	0	en
4580	مهم: بطاقتك المنتهية بالرقم 5951 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4582	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4584	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4587	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4588	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4589	Confirm your payment of $3810.35 using code 202039. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4590	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4592	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4593	مهم: بطاقتك المنتهية بالرقم 7217 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4595	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4597	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4602	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4603	تم تحويل مبلغ 6554.32 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4604	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4606	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 404919 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4611	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 737411 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4615	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4616	مهم: بطاقتك المنتهية بالرقم 7563 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4618	تنبيه: تم إجراء عملية شراء بمبلغ 1378.49. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4620	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 455649	2025-11-10 00:00:00	0	ar
4622	تنبيه: تم إجراء عملية شراء بمبلغ 7324.55. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4624	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8776	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 549639 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4626	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4627	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4628	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 500174.	2025-11-10 00:00:00	0	ar
4630	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 380945.	2025-11-10 00:00:00	0	ar
4635	مهم: بطاقتك المنتهية بالرقم 2767 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4637	مهم: بطاقتك المنتهية بالرقم 1463 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4643	Important: Your debit card ending with 8461 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4646	تنبيه: تم إجراء عملية شراء بمبلغ 6134.59. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4648	مهم: بطاقتك المنتهية بالرقم 5763 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4650	مهم: بطاقتك المنتهية بالرقم 1204 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4652	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4653	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4655	تنبيه: تم إجراء عملية شراء بمبلغ 8723.27. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4656	Security alert: unauthorized login. Enter code 894093 to secure account.	2025-11-10 00:00:00	0	en
4661	Important: Your debit card ending with 8481 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4662	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 922107.	2025-11-10 00:00:00	0	ar
4665	Important: Your debit card ending with 6483 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4666	We couldn't process your recent payment. Confirm by entering OTP 676760 now.	2025-11-10 00:00:00	0	en
4667	We couldn't process your recent payment. Confirm by entering OTP 532622 now.	2025-11-10 00:00:00	0	en
4668	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4669	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 845607	2025-11-10 00:00:00	0	ar
4670	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4671	تنبيه: تم إجراء عملية شراء بمبلغ 2653.33. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4673	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4674	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 681747 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4677	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4678	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4681	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4683	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4684	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4686	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4687	Confirm your payment of $6062.79 using code 154217. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4688	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4689	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 272393.	2025-11-10 00:00:00	0	ar
4690	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4691	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 816989	2025-11-10 00:00:00	0	ar
4692	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4694	Confirm your payment of $2072.14 using code 917039. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4695	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4698	A transfer of $382.82 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4699	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 241520	2025-11-10 00:00:00	0	ar
4700	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4701	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4705	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4708	We detected unusual activity on your account. Confirm your identity with OTP: 178043	2025-11-10 00:00:00	0	en
4709	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4711	Important: Your debit card ending with 7136 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4713	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4715	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4716	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4717	Important: Your debit card ending with 3747 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4719	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4720	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 796149.	2025-11-10 00:00:00	0	ar
4722	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4723	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4724	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4726	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 524682	2025-11-10 00:00:00	0	ar
4728	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4729	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4732	We detected unusual activity on your account. Confirm your identity with OTP: 236889	2025-11-10 00:00:00	0	en
4734	تم تحويل مبلغ 4454.36 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4735	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4736	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4737	Confirm your payment of $3741.43 using code 935737. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4738	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4739	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4741	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4742	We detected unusual activity on your account. Confirm your identity with OTP: 897801	2025-11-10 00:00:00	0	en
4746	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4750	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4752	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4753	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
4754	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 321733	2025-11-10 00:00:00	0	ar
4756	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4757	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4759	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 830691.	2025-11-10 00:00:00	0	ar
4760	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4762	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 366344	2025-11-10 00:00:00	0	ar
4763	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4768	We couldn't process your recent payment. Confirm by entering OTP 526015 now.	2025-11-10 00:00:00	0	en
4772	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4774	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4775	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4776	تنبيه: تم إجراء عملية شراء بمبلغ 279.09. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4779	تم تحويل مبلغ 6170.72 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4780	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4781	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4783	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 712809.	2025-11-10 00:00:00	0	ar
4784	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4788	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 183431 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4789	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 613485 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4791	We detected unusual activity on your account. Confirm your identity with OTP: 853466	2025-11-10 00:00:00	0	en
4792	Important: Your debit card ending with 9170 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4798	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4799	Security alert: unauthorized login. Enter code 777312 to secure account.	2025-11-10 00:00:00	0	en
4800	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4801	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4803	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4804	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4805	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4806	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4809	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4813	We couldn't process your recent payment. Confirm by entering OTP 864978 now.	2025-11-10 00:00:00	0	en
4815	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4816	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4817	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4820	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4821	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 453302 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4822	Important: Your debit card ending with 3349 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4823	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4824	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4825	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 879566 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4826	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 356559.	2025-11-10 00:00:00	0	ar
4827	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4828	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 462134 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4829	تم تحويل مبلغ 4947.11 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4830	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4832	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4834	تنبيه: تم إجراء عملية شراء بمبلغ 4696.32. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4835	تم تحويل مبلغ 4343.39 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4837	مهم: بطاقتك المنتهية بالرقم 8917 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4838	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4842	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4843	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4845	تنبيه: تم إجراء عملية شراء بمبلغ 5385.15. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4846	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4847	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4848	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4849	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4850	We detected unusual activity on your account. Confirm your identity with OTP: 435704	2025-11-10 00:00:00	0	en
4854	Important: Your debit card ending with 5243 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4856	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 593648	2025-11-10 00:00:00	0	ar
4858	We couldn't process your recent payment. Confirm by entering OTP 793124 now.	2025-11-10 00:00:00	0	en
4859	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 214792 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4862	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4867	Security alert: unauthorized login. Enter code 923101 to secure account.	2025-11-10 00:00:00	0	en
4869	We couldn't process your recent payment. Confirm by entering OTP 463305 now.	2025-11-10 00:00:00	0	en
4870	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4874	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4877	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 689685	2025-11-10 00:00:00	0	ar
4878	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4879	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4884	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4886	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4887	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4888	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4891	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4895	تنبيه: تم إجراء عملية شراء بمبلغ 6231.35. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4896	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 140481	2025-11-10 00:00:00	0	ar
4897	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 542402	2025-11-10 00:00:00	0	ar
4898	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4899	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 959719	2025-11-10 00:00:00	0	ar
4900	تم تحويل مبلغ 4252.04 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4904	تنبيه: تم إجراء عملية شراء بمبلغ 1490.42. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4906	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4907	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4909	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4912	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
4914	A transfer of $6412.92 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4915	We detected unusual activity on your account. Confirm your identity with OTP: 258189	2025-11-10 00:00:00	0	en
4916	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4918	Important: Your debit card ending with 1816 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4919	تم تحويل مبلغ 2662.02 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4920	We couldn't process your recent payment. Confirm by entering OTP 804559 now.	2025-11-10 00:00:00	0	en
4921	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4922	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
4923	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4927	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
4928	Important: Your debit card ending with 4969 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4931	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4934	Important: Your debit card ending with 8471 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4936	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
4937	Security alert: unauthorized login. Enter code 891491 to secure account.	2025-11-10 00:00:00	0	en
4938	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4939	A transfer of $988.02 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4941	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
4942	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4943	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4944	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4948	Confirm your payment of $5603.85 using code 907758. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4949	Security alert: unauthorized login. Enter code 347058 to secure account.	2025-11-10 00:00:00	0	en
4950	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4951	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 802953	2025-11-10 00:00:00	0	ar
4953	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4957	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 578250 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4960	تم تحويل مبلغ 2516.10 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4961	We detected unusual activity on your account. Confirm your identity with OTP: 502529	2025-11-10 00:00:00	0	en
4962	تم تحويل مبلغ 9073.38 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
4963	Confirm your payment of $7621.07 using code 333444. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
4965	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4967	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
4969	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
4970	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4972	We detected unusual activity on your account. Confirm your identity with OTP: 880286	2025-11-10 00:00:00	0	en
4973	A transfer of $8321.79 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
4975	تنبيه: تم إجراء عملية شراء بمبلغ 5676.17. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4976	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4977	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
4978	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
4980	تنبيه: تم إجراء عملية شراء بمبلغ 3855.58. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4982	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 374899	2025-11-10 00:00:00	0	ar
4984	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4985	We detected unusual activity on your account. Confirm your identity with OTP: 929054	2025-11-10 00:00:00	0	en
4987	مهم: بطاقتك المنتهية بالرقم 9056 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
4988	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
4989	تنبيه: تم إجراء عملية شراء بمبلغ 9278.65. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
4990	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 604033 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
4991	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
4994	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
4998	Important: Your debit card ending with 3011 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
4999	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5000	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5003	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5004	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5008	Security alert: unauthorized login. Enter code 340928 to secure account.	2025-11-10 00:00:00	0	en
5011	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 574976 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5014	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 926320.	2025-11-10 00:00:00	0	ar
5015	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5016	A transfer of $1253.84 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5017	Important: Your debit card ending with 9626 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5020	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5024	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5032	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5036	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5038	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 454650 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5039	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5041	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5042	We couldn't process your recent payment. Confirm by entering OTP 151560 now.	2025-11-10 00:00:00	0	en
5047	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5051	A transfer of $444.38 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5052	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5054	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5055	Important: Your debit card ending with 4607 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5057	Important: Your debit card ending with 8338 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5058	تم تحويل مبلغ 8058.56 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5059	تم تحويل مبلغ 3725.97 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5061	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5062	مهم: بطاقتك المنتهية بالرقم 5325 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5064	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5066	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5068	تنبيه: تم إجراء عملية شراء بمبلغ 124.64. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5070	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5071	We couldn't process your recent payment. Confirm by entering OTP 971571 now.	2025-11-10 00:00:00	0	en
5072	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 610706.	2025-11-10 00:00:00	0	ar
5074	A transfer of $9762.83 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5081	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5085	Important: Your debit card ending with 3065 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5088	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5089	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5090	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5091	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5092	تنبيه: تم إجراء عملية شراء بمبلغ 2988.12. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5093	Important: Your debit card ending with 4502 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5097	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5098	تم تحويل مبلغ 7398.91 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5104	تم تحويل مبلغ 5076.38 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5106	تنبيه: تم إجراء عملية شراء بمبلغ 6096.14. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5107	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5108	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5109	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 231782 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5112	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5113	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5115	We couldn't process your recent payment. Confirm by entering OTP 987365 now.	2025-11-10 00:00:00	0	en
5116	A transfer of $1971.75 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5117	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 915338	2025-11-10 00:00:00	0	ar
5118	Important: Your debit card ending with 5319 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5119	We couldn't process your recent payment. Confirm by entering OTP 542217 now.	2025-11-10 00:00:00	0	en
5120	We detected unusual activity on your account. Confirm your identity with OTP: 541610	2025-11-10 00:00:00	0	en
5122	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 617354	2025-11-10 00:00:00	0	ar
5125	مهم: بطاقتك المنتهية بالرقم 3379 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5129	تم تحويل مبلغ 1727.38 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5133	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5135	Important: Your debit card ending with 2588 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5136	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5139	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5145	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5146	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5147	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 131845	2025-11-10 00:00:00	0	ar
5148	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5150	We detected unusual activity on your account. Confirm your identity with OTP: 232001	2025-11-10 00:00:00	0	en
5151	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5152	Important: Your debit card ending with 4756 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5153	We detected unusual activity on your account. Confirm your identity with OTP: 382575	2025-11-10 00:00:00	0	en
5157	We couldn't process your recent payment. Confirm by entering OTP 894522 now.	2025-11-10 00:00:00	0	en
5160	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5161	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5162	We detected unusual activity on your account. Confirm your identity with OTP: 615712	2025-11-10 00:00:00	0	en
5163	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5164	A transfer of $643.03 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5165	تنبيه: تم إجراء عملية شراء بمبلغ 9021.50. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5167	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5168	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5169	Confirm your payment of $7659.13 using code 510360. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5171	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5175	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5179	تنبيه: تم إجراء عملية شراء بمبلغ 822.00. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5182	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5185	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5187	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5188	We couldn't process your recent payment. Confirm by entering OTP 877124 now.	2025-11-10 00:00:00	0	en
5189	We detected unusual activity on your account. Confirm your identity with OTP: 321640	2025-11-10 00:00:00	0	en
5191	تم تحويل مبلغ 3432.68 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5194	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 915529	2025-11-10 00:00:00	0	ar
5196	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 385321	2025-11-10 00:00:00	0	ar
5197	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5198	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5199	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5202	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5203	We couldn't process your recent payment. Confirm by entering OTP 560442 now.	2025-11-10 00:00:00	0	en
5205	We couldn't process your recent payment. Confirm by entering OTP 221560 now.	2025-11-10 00:00:00	0	en
5207	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5208	تم تحويل مبلغ 7634.72 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5209	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 495912	2025-11-10 00:00:00	0	ar
5211	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 996106	2025-11-10 00:00:00	0	ar
5213	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 524005 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5214	مهم: بطاقتك المنتهية بالرقم 2951 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5215	We couldn't process your recent payment. Confirm by entering OTP 879326 now.	2025-11-10 00:00:00	0	en
5217	Important: Your debit card ending with 1058 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5218	تنبيه: تم إجراء عملية شراء بمبلغ 6679.47. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5219	Security alert: unauthorized login. Enter code 557543 to secure account.	2025-11-10 00:00:00	0	en
5222	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5226	تنبيه: تم إجراء عملية شراء بمبلغ 924.90. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5227	تم تحويل مبلغ 4904.72 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5230	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5234	Confirm your payment of $4279.39 using code 623444. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5235	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5237	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5238	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5239	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5240	Important: Your debit card ending with 2773 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5241	Confirm your payment of $8231.68 using code 901490. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5242	تم تحويل مبلغ 8883.93 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5244	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5245	A transfer of $3115.44 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5246	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5248	We detected unusual activity on your account. Confirm your identity with OTP: 899691	2025-11-10 00:00:00	0	en
5252	مهم: بطاقتك المنتهية بالرقم 8266 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5253	Important: Your debit card ending with 1063 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5255	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5257	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5258	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5261	مهم: بطاقتك المنتهية بالرقم 1475 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5263	Important: Your debit card ending with 7879 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5265	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5266	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5267	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 431657 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5272	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5273	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5275	We couldn't process your recent payment. Confirm by entering OTP 420677 now.	2025-11-10 00:00:00	0	en
5277	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5279	We couldn't process your recent payment. Confirm by entering OTP 915580 now.	2025-11-10 00:00:00	0	en
5281	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5286	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5287	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5288	تم تحويل مبلغ 2868.07 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5290	Important: Your debit card ending with 7520 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5291	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5294	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5295	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5296	We couldn't process your recent payment. Confirm by entering OTP 824915 now.	2025-11-10 00:00:00	0	en
5297	مهم: بطاقتك المنتهية بالرقم 2709 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5298	We couldn't process your recent payment. Confirm by entering OTP 117581 now.	2025-11-10 00:00:00	0	en
5299	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5301	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 541810	2025-11-10 00:00:00	0	ar
5305	تم تحويل مبلغ 5750.02 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5306	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5307	Security alert: unauthorized login. Enter code 593082 to secure account.	2025-11-10 00:00:00	0	en
5308	Confirm your payment of $6380.09 using code 729393. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5309	We couldn't process your recent payment. Confirm by entering OTP 311323 now.	2025-11-10 00:00:00	0	en
5310	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5312	Confirm your payment of $977.60 using code 538908. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5314	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 175164.	2025-11-10 00:00:00	0	ar
5316	تنبيه: تم إجراء عملية شراء بمبلغ 8517.05. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5317	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 189676 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5322	A transfer of $7195.97 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5323	Confirm your payment of $9878.39 using code 963136. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5324	مهم: بطاقتك المنتهية بالرقم 8934 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5328	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 142066 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5330	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5331	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5335	Confirm your payment of $5964.88 using code 722872. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5337	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5338	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5339	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5340	تم تحويل مبلغ 6113.15 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5341	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5343	Important: Your debit card ending with 1408 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5344	Important: Your debit card ending with 4169 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5351	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5353	Security alert: unauthorized login. Enter code 524989 to secure account.	2025-11-10 00:00:00	0	en
5354	A transfer of $7539.01 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5357	Security alert: unauthorized login. Enter code 650272 to secure account.	2025-11-10 00:00:00	0	en
5358	We couldn't process your recent payment. Confirm by entering OTP 740819 now.	2025-11-10 00:00:00	0	en
5361	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5362	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5363	Important: Your debit card ending with 5921 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5364	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5367	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5368	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5373	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5374	We couldn't process your recent payment. Confirm by entering OTP 672254 now.	2025-11-10 00:00:00	0	en
5378	تنبيه: تم إجراء عملية شراء بمبلغ 4094.35. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5380	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 752918.	2025-11-10 00:00:00	0	ar
5382	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5388	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5390	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5394	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5397	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5398	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 838905.	2025-11-10 00:00:00	0	ar
5400	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5404	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5406	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 468984.	2025-11-10 00:00:00	0	ar
5407	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5408	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5410	تنبيه: تم إجراء عملية شراء بمبلغ 5796.33. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5412	We detected unusual activity on your account. Confirm your identity with OTP: 391495	2025-11-10 00:00:00	0	en
5415	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 263803	2025-11-10 00:00:00	0	ar
5417	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5422	A transfer of $7324.89 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5425	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5427	تم تحويل مبلغ 8882.53 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5379	Your scheduled transfer completed successfully. Ref: 4572.	2025-11-10 00:00:00	\N	en
5429	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5431	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5434	Confirm your payment of $3469.53 using code 601348. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5438	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5439	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 712818 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5440	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5441	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5445	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5449	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5450	Security alert: unauthorized login. Enter code 394572 to secure account.	2025-11-10 00:00:00	0	en
5451	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5453	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5454	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5457	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 466882.	2025-11-10 00:00:00	0	ar
5458	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5460	تنبيه: تم إجراء عملية شراء بمبلغ 163.09. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5462	A transfer of $320.76 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5465	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5469	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5471	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5473	Important: Your debit card ending with 1339 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5475	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5477	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5478	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5479	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5481	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5482	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 858534 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5484	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5486	We couldn't process your recent payment. Confirm by entering OTP 443136 now.	2025-11-10 00:00:00	0	en
5489	We detected unusual activity on your account. Confirm your identity with OTP: 762803	2025-11-10 00:00:00	0	en
5494	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5495	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5496	Security alert: unauthorized login. Enter code 713674 to secure account.	2025-11-10 00:00:00	0	en
5500	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5501	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5503	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 515626	2025-11-10 00:00:00	0	ar
5505	Security alert: unauthorized login. Enter code 583853 to secure account.	2025-11-10 00:00:00	0	en
5508	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5510	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5518	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5519	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5520	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5521	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5522	Confirm your payment of $6229.91 using code 621846. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5525	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5526	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5531	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5532	We couldn't process your recent payment. Confirm by entering OTP 314740 now.	2025-11-10 00:00:00	0	en
5540	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5541	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5547	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5502	Your scheduled transfer completed successfully. Ref: 5710.	2025-11-10 00:00:00	\N	en
5550	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5552	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5553	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5554	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5561	We detected unusual activity on your account. Confirm your identity with OTP: 359059	2025-11-10 00:00:00	0	en
5562	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 646980.	2025-11-10 00:00:00	0	ar
5565	We couldn't process your recent payment. Confirm by entering OTP 782179 now.	2025-11-10 00:00:00	0	en
5566	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5570	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5571	مهم: بطاقتك المنتهية بالرقم 3819 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5573	Security alert: unauthorized login. Enter code 119017 to secure account.	2025-11-10 00:00:00	0	en
5574	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5575	We couldn't process your recent payment. Confirm by entering OTP 826862 now.	2025-11-10 00:00:00	0	en
5578	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5581	تنبيه: تم إجراء عملية شراء بمبلغ 4643.17. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5588	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5590	Security alert: unauthorized login. Enter code 710236 to secure account.	2025-11-10 00:00:00	0	en
5591	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5593	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5594	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5595	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5598	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5602	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5605	Confirm your payment of $9559.53 using code 488954. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5611	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5612	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5615	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5617	Important: Your debit card ending with 2955 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5618	We detected unusual activity on your account. Confirm your identity with OTP: 165624	2025-11-10 00:00:00	0	en
5620	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 755646.	2025-11-10 00:00:00	0	ar
5621	Important: Your debit card ending with 4761 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5623	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5625	تنبيه: تم إجراء عملية شراء بمبلغ 7420.18. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5630	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5631	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5634	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5636	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5639	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5643	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5645	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 789157	2025-11-10 00:00:00	0	ar
5646	مهم: بطاقتك المنتهية بالرقم 4587 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5647	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5648	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 425485	2025-11-10 00:00:00	0	ar
5652	تم تحويل مبلغ 2736.20 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5653	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5654	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5656	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5657	We detected unusual activity on your account. Confirm your identity with OTP: 669979	2025-11-10 00:00:00	0	en
5660	We couldn't process your recent payment. Confirm by entering OTP 764081 now.	2025-11-10 00:00:00	0	en
5661	مهم: بطاقتك المنتهية بالرقم 3319 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5663	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5665	Confirm your payment of $7918.77 using code 198901. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5666	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5667	تنبيه: تم إجراء عملية شراء بمبلغ 9423.82. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
555	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5668	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5671	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5672	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5673	Confirm your payment of $9686.80 using code 119733. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5674	Security alert: unauthorized login. Enter code 910941 to secure account.	2025-11-10 00:00:00	0	en
5675	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5676	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5678	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 389718.	2025-11-10 00:00:00	0	ar
5682	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5683	تنبيه: تم إجراء عملية شراء بمبلغ 2127.67. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5684	مهم: بطاقتك المنتهية بالرقم 5666 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5685	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5689	A transfer of $8360.12 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5690	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5691	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5692	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5693	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 837876 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5694	We couldn't process your recent payment. Confirm by entering OTP 747076 now.	2025-11-10 00:00:00	0	en
5697	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5698	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5699	تنبيه: تم إجراء عملية شراء بمبلغ 2211.13. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5702	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5703	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5704	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5706	We couldn't process your recent payment. Confirm by entering OTP 592833 now.	2025-11-10 00:00:00	0	en
5707	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5715	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5717	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5718	تم تحويل مبلغ 6445.91 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5722	مهم: بطاقتك المنتهية بالرقم 5218 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5723	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5724	We detected unusual activity on your account. Confirm your identity with OTP: 108734	2025-11-10 00:00:00	0	en
5725	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 922264.	2025-11-10 00:00:00	0	ar
5727	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5728	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5729	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5730	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5731	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 120888	2025-11-10 00:00:00	0	ar
5732	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5733	Security alert: unauthorized login. Enter code 660524 to secure account.	2025-11-10 00:00:00	0	en
5734	Security alert: unauthorized login. Enter code 333119 to secure account.	2025-11-10 00:00:00	0	en
5735	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5736	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5739	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5741	We detected unusual activity on your account. Confirm your identity with OTP: 884970	2025-11-10 00:00:00	0	en
5742	Security alert: unauthorized login. Enter code 167619 to secure account.	2025-11-10 00:00:00	0	en
5743	Important: Your debit card ending with 7104 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5746	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5748	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5749	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5750	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5752	مهم: بطاقتك المنتهية بالرقم 2543 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5757	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5758	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5759	Confirm your payment of $6952.51 using code 604159. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5770	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5771	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 873266	2025-11-10 00:00:00	0	ar
5774	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5775	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5776	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5778	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5781	مهم: بطاقتك المنتهية بالرقم 8019 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5785	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5790	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5792	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5795	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5796	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5797	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5799	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5800	Important: Your debit card ending with 6111 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5802	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5803	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5804	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
5807	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 767958	2025-11-10 00:00:00	0	ar
5808	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
5809	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5815	تم تحويل مبلغ 7206.39 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5818	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5819	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5822	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 640611.	2025-11-10 00:00:00	0	ar
5823	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5825	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5827	We detected unusual activity on your account. Confirm your identity with OTP: 637997	2025-11-10 00:00:00	0	en
5828	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5829	A transfer of $7215.04 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5832	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5833	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5835	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5836	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5837	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5840	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 327593.	2025-11-10 00:00:00	0	ar
5841	We couldn't process your recent payment. Confirm by entering OTP 723764 now.	2025-11-10 00:00:00	0	en
5845	Important: Your debit card ending with 3510 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5846	مهم: بطاقتك المنتهية بالرقم 8146 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5848	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5849	تنبيه: تم إجراء عملية شراء بمبلغ 3739.33. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5852	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5853	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5856	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
5862	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5864	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5867	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5868	We couldn't process your recent payment. Confirm by entering OTP 978695 now.	2025-11-10 00:00:00	0	en
5869	مهم: بطاقتك المنتهية بالرقم 3286 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5873	We detected unusual activity on your account. Confirm your identity with OTP: 613027	2025-11-10 00:00:00	0	en
5875	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5878	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5880	تنبيه: تم إجراء عملية شراء بمبلغ 8055.55. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5882	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
5888	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 973156 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5890	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 718232	2025-11-10 00:00:00	0	ar
5891	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 224254 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5892	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
5893	تنبيه: تم إجراء عملية شراء بمبلغ 4886.41. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
5895	Important: Your debit card ending with 2913 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5899	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 777528.	2025-11-10 00:00:00	0	ar
5900	Important: Your debit card ending with 8178 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5901	تم تحويل مبلغ 7751.76 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5903	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5904	We detected unusual activity on your account. Confirm your identity with OTP: 197601	2025-11-10 00:00:00	0	en
5905	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 212011.	2025-11-10 00:00:00	0	ar
5906	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 578175.	2025-11-10 00:00:00	0	ar
5907	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5910	A transfer of $9535.23 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5911	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 634033 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5913	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5916	مهم: بطاقتك المنتهية بالرقم 4362 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5922	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5925	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5927	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5928	Security alert: unauthorized login. Enter code 932426 to secure account.	2025-11-10 00:00:00	0	en
5932	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5936	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5938	تم تحويل مبلغ 896.99 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
5941	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
5943	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 261892 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5944	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5945	Confirm your payment of $692.55 using code 330050. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5946	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5947	Important: Your debit card ending with 7095 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
5948	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 398027 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5950	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 589331 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5951	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 478223 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
5953	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
5956	A transfer of $2368.64 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5957	Confirm your payment of $6314.39 using code 983212. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5960	مهم: بطاقتك المنتهية بالرقم 3929 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5962	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5968	Security alert: unauthorized login. Enter code 189092 to secure account.	2025-11-10 00:00:00	0	en
5972	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
5973	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5974	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
5975	We couldn't process your recent payment. Confirm by entering OTP 501574 now.	2025-11-10 00:00:00	0	en
5978	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5979	Confirm your payment of $3866.57 using code 264634. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5980	A transfer of $523.19 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5981	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
5982	Confirm your payment of $3391.08 using code 487716. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
5983	مهم: بطاقتك المنتهية بالرقم 4312 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5984	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 593367	2025-11-10 00:00:00	0	ar
5985	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
5986	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5989	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
5990	We couldn't process your recent payment. Confirm by entering OTP 164149 now.	2025-11-10 00:00:00	0	en
5991	مهم: بطاقتك المنتهية بالرقم 1272 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5993	A transfer of $6633.96 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
5995	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 758423	2025-11-10 00:00:00	0	ar
5996	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
5998	مهم: بطاقتك المنتهية بالرقم 2638 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
5999	Important: Your debit card ending with 2906 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6003	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6004	تنبيه: تم إجراء عملية شراء بمبلغ 5650.38. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6006	Confirm your payment of $1885.36 using code 521966. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6007	We couldn't process your recent payment. Confirm by entering OTP 844750 now.	2025-11-10 00:00:00	0	en
6008	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6010	مهم: بطاقتك المنتهية بالرقم 8396 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6012	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6016	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6018	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6019	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6023	مهم: بطاقتك المنتهية بالرقم 8136 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6026	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 602815.	2025-11-10 00:00:00	0	ar
6027	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6028	تم تحويل مبلغ 5192.05 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6029	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 604482 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6030	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 266131	2025-11-10 00:00:00	0	ar
6032	A transfer of $852.73 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6034	مهم: بطاقتك المنتهية بالرقم 6192 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6041	A transfer of $6166.80 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6043	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6045	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6046	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6047	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 745657	2025-11-10 00:00:00	0	ar
6052	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6055	Important: Your debit card ending with 8857 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6061	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6063	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 271099	2025-11-10 00:00:00	0	ar
6065	Confirm your payment of $2714.79 using code 625054. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6066	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6068	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 128765	2025-11-10 00:00:00	0	ar
6069	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6071	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 348601 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6072	We detected unusual activity on your account. Confirm your identity with OTP: 774307	2025-11-10 00:00:00	0	en
6075	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6076	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6077	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6080	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6084	تنبيه: تم إجراء عملية شراء بمبلغ 5296.69. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6086	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 295406.	2025-11-10 00:00:00	0	ar
6089	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 160805	2025-11-10 00:00:00	0	ar
6090	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6092	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6095	تم تحويل مبلغ 4300.61 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6096	تنبيه: تم إجراء عملية شراء بمبلغ 1232.68. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6097	A transfer of $3038.24 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6098	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6099	We detected unusual activity on your account. Confirm your identity with OTP: 958316	2025-11-10 00:00:00	0	en
6102	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6104	Confirm your payment of $3367.73 using code 514885. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6106	Security alert: unauthorized login. Enter code 444678 to secure account.	2025-11-10 00:00:00	0	en
6111	Confirm your payment of $5284.80 using code 550790. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6114	Important: Your debit card ending with 4080 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6115	A transfer of $462.70 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6116	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6117	We detected unusual activity on your account. Confirm your identity with OTP: 591039	2025-11-10 00:00:00	0	en
6127	تنبيه: تم إجراء عملية شراء بمبلغ 3464.80. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6136	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6137	We couldn't process your recent payment. Confirm by entering OTP 281155 now.	2025-11-10 00:00:00	0	en
6138	Security alert: unauthorized login. Enter code 915595 to secure account.	2025-11-10 00:00:00	0	en
6139	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6140	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 325982 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6141	مهم: بطاقتك المنتهية بالرقم 6009 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6147	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6152	Security alert: unauthorized login. Enter code 448713 to secure account.	2025-11-10 00:00:00	0	en
6153	تم تحويل مبلغ 3194.21 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6155	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6156	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6159	We couldn't process your recent payment. Confirm by entering OTP 568260 now.	2025-11-10 00:00:00	0	en
6164	Important: Your debit card ending with 1580 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6166	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6168	Important: Your debit card ending with 3964 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6169	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6171	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6178	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6182	We detected unusual activity on your account. Confirm your identity with OTP: 896128	2025-11-10 00:00:00	0	en
6183	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 832185.	2025-11-10 00:00:00	0	ar
6184	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6185	Important: Your debit card ending with 6604 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6187	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6188	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6189	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6190	تم تحويل مبلغ 3878.38 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6193	A transfer of $9960.09 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6197	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6198	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 649898.	2025-11-10 00:00:00	0	ar
6202	We detected unusual activity on your account. Confirm your identity with OTP: 291590	2025-11-10 00:00:00	0	en
6205	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 542497.	2025-11-10 00:00:00	0	ar
6209	Security alert: unauthorized login. Enter code 388221 to secure account.	2025-11-10 00:00:00	0	en
6211	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 184429 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6216	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 386198.	2025-11-10 00:00:00	0	ar
6217	مهم: بطاقتك المنتهية بالرقم 8666 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6218	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6220	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6224	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6225	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6226	تنبيه: تم إجراء عملية شراء بمبلغ 8172.24. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6228	مهم: بطاقتك المنتهية بالرقم 8220 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6229	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6230	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 185887.	2025-11-10 00:00:00	0	ar
6231	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6232	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6236	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6237	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6238	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6240	تم تحويل مبلغ 3176.86 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6242	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6243	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 763632.	2025-11-10 00:00:00	0	ar
6245	تنبيه: تم إجراء عملية شراء بمبلغ 4233.63. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6247	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 410495 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6249	We detected unusual activity on your account. Confirm your identity with OTP: 742753	2025-11-10 00:00:00	0	en
6252	تم تحويل مبلغ 4857.59 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6253	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 205940.	2025-11-10 00:00:00	0	ar
6254	Confirm your payment of $3079.15 using code 166790. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6257	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6259	Important: Your debit card ending with 7449 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6261	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6264	تم تحويل مبلغ 2552.53 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6265	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6268	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6271	We couldn't process your recent payment. Confirm by entering OTP 294643 now.	2025-11-10 00:00:00	0	en
6272	مهم: بطاقتك المنتهية بالرقم 8938 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6273	تنبيه: تم إجراء عملية شراء بمبلغ 4846.30. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6274	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6278	تنبيه: تم إجراء عملية شراء بمبلغ 4935.43. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6281	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 225867	2025-11-10 00:00:00	0	ar
6283	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6284	We couldn't process your recent payment. Confirm by entering OTP 525332 now.	2025-11-10 00:00:00	0	en
6288	تنبيه: تم إجراء عملية شراء بمبلغ 6694.36. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6289	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 857814 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6291	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 123209.	2025-11-10 00:00:00	0	ar
6294	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6295	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6296	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 740013.	2025-11-10 00:00:00	0	ar
6297	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 325100	2025-11-10 00:00:00	0	ar
6299	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6303	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6304	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6305	We couldn't process your recent payment. Confirm by entering OTP 454110 now.	2025-11-10 00:00:00	0	en
6307	Confirm your payment of $1087.55 using code 102312. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6308	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6311	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6312	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6313	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 407499	2025-11-10 00:00:00	0	ar
6316	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6317	Confirm your payment of $3806.42 using code 310664. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6319	مهم: بطاقتك المنتهية بالرقم 3512 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6320	Confirm your payment of $7925.13 using code 453765. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6323	مهم: بطاقتك المنتهية بالرقم 7428 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6326	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6327	Important: Your debit card ending with 3289 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6328	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6329	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6332	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6334	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6336	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6338	We couldn't process your recent payment. Confirm by entering OTP 151806 now.	2025-11-10 00:00:00	0	en
6342	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 776008	2025-11-10 00:00:00	0	ar
6343	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 752855	2025-11-10 00:00:00	0	ar
6344	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6345	A transfer of $80.90 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6346	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 606006.	2025-11-10 00:00:00	0	ar
6347	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6350	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6354	Important: Your debit card ending with 2890 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6355	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6357	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6358	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6362	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6364	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6366	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6367	Important: Your debit card ending with 2814 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6369	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6371	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 703309	2025-11-10 00:00:00	0	ar
6375	تم تحويل مبلغ 1180.52 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6376	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6377	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6378	تم تحويل مبلغ 1605.54 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6379	We detected unusual activity on your account. Confirm your identity with OTP: 574129	2025-11-10 00:00:00	0	en
6380	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6383	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 674185.	2025-11-10 00:00:00	0	ar
6385	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6387	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6390	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6391	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 423535	2025-11-10 00:00:00	0	ar
6392	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6393	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6399	Confirm your payment of $7495.56 using code 146114. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6401	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6403	A transfer of $1407.04 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6404	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6405	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6406	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6407	Important: Your debit card ending with 9168 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6408	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 340262.	2025-11-10 00:00:00	0	ar
6411	Security alert: unauthorized login. Enter code 798261 to secure account.	2025-11-10 00:00:00	0	en
6414	We couldn't process your recent payment. Confirm by entering OTP 767517 now.	2025-11-10 00:00:00	0	en
6416	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 732773 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6418	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 252258.	2025-11-10 00:00:00	0	ar
6419	Confirm your payment of $5461.25 using code 154099. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6420	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 665372	2025-11-10 00:00:00	0	ar
6423	We detected unusual activity on your account. Confirm your identity with OTP: 537119	2025-11-10 00:00:00	0	en
6427	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6431	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 643978	2025-11-10 00:00:00	0	ar
6434	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6437	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6438	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6440	A transfer of $1179.19 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6443	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6444	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6446	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6449	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6450	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6451	We couldn't process your recent payment. Confirm by entering OTP 261152 now.	2025-11-10 00:00:00	0	en
6452	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 437482 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6453	Security alert: unauthorized login. Enter code 310423 to secure account.	2025-11-10 00:00:00	0	en
6454	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6455	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6459	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6460	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6461	We couldn't process your recent payment. Confirm by entering OTP 646549 now.	2025-11-10 00:00:00	0	en
6465	We couldn't process your recent payment. Confirm by entering OTP 769121 now.	2025-11-10 00:00:00	0	en
6466	A transfer of $490.19 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6468	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6470	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6472	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 502758	2025-11-10 00:00:00	0	ar
6474	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 150449.	2025-11-10 00:00:00	0	ar
6475	مهم: بطاقتك المنتهية بالرقم 4814 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6426	Your scheduled transfer completed successfully. Ref: 6240.	2025-11-10 00:00:00	\N	en
6476	Important: Your debit card ending with 5686 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6478	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6482	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6488	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6489	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6490	We detected unusual activity on your account. Confirm your identity with OTP: 693641	2025-11-10 00:00:00	0	en
6494	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 658663	2025-11-10 00:00:00	0	ar
6495	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 679111 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6496	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6497	Security alert: unauthorized login. Enter code 952727 to secure account.	2025-11-10 00:00:00	0	en
6498	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6501	Security alert: unauthorized login. Enter code 447666 to secure account.	2025-11-10 00:00:00	0	en
6502	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6504	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6506	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6508	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6510	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6515	Confirm your payment of $7916.02 using code 783778. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6516	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 491402 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6517	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6518	Confirm your payment of $1517.92 using code 497920. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6519	تم تحويل مبلغ 9355.89 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6520	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6521	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6524	مهم: بطاقتك المنتهية بالرقم 1042 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6526	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6527	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6529	We detected unusual activity on your account. Confirm your identity with OTP: 704785	2025-11-10 00:00:00	0	en
6530	We couldn't process your recent payment. Confirm by entering OTP 286051 now.	2025-11-10 00:00:00	0	en
6531	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6534	تنبيه: تم إجراء عملية شراء بمبلغ 8434.94. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6536	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6537	Security alert: unauthorized login. Enter code 733025 to secure account.	2025-11-10 00:00:00	0	en
6538	We detected unusual activity on your account. Confirm your identity with OTP: 426068	2025-11-10 00:00:00	0	en
6539	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 875215 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6542	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6543	تنبيه: تم إجراء عملية شراء بمبلغ 3214.35. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6547	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6548	Security alert: unauthorized login. Enter code 219927 to secure account.	2025-11-10 00:00:00	0	en
6551	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6555	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6556	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6559	We couldn't process your recent payment. Confirm by entering OTP 183934 now.	2025-11-10 00:00:00	0	en
6560	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6561	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6562	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 558819	2025-11-10 00:00:00	0	ar
6566	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6569	Confirm your payment of $428.23 using code 734679. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6570	Important: Your debit card ending with 3780 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6572	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6575	تنبيه: تم إجراء عملية شراء بمبلغ 9111.82. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6578	We couldn't process your recent payment. Confirm by entering OTP 128766 now.	2025-11-10 00:00:00	0	en
6579	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6581	تم تحويل مبلغ 1426.18 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6582	We couldn't process your recent payment. Confirm by entering OTP 696678 now.	2025-11-10 00:00:00	0	en
6587	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6588	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6592	Security alert: unauthorized login. Enter code 566082 to secure account.	2025-11-10 00:00:00	0	en
6535	Your transaction of $6499.97 at STORE was successful. Ref: 9918.	2025-11-10 00:00:00	\N	en
6593	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6595	Confirm your payment of $4920.85 using code 576981. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6596	We detected unusual activity on your account. Confirm your identity with OTP: 935569	2025-11-10 00:00:00	0	en
6597	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6601	We couldn't process your recent payment. Confirm by entering OTP 510852 now.	2025-11-10 00:00:00	0	en
6603	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 974699.	2025-11-10 00:00:00	0	ar
6607	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 292714	2025-11-10 00:00:00	0	ar
6608	A transfer of $7147.11 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6610	مهم: بطاقتك المنتهية بالرقم 4610 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6615	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6616	تم تحويل مبلغ 7059.01 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6620	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6621	We detected unusual activity on your account. Confirm your identity with OTP: 416336	2025-11-10 00:00:00	0	en
6622	A transfer of $5011.48 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6623	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6625	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6626	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6630	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6634	تم تحويل مبلغ 2538.58 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6637	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 940901 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6638	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6640	Confirm your payment of $7649.03 using code 327611. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6641	Important: Your debit card ending with 6655 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6642	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6645	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6648	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6649	Important: Your debit card ending with 5551 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6594	Your scheduled transfer completed successfully. Ref: 4340.	2025-11-10 00:00:00	\N	en
6651	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6652	تنبيه: تم إجراء عملية شراء بمبلغ 6991.41. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6653	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6654	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6655	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6657	مهم: بطاقتك المنتهية بالرقم 7013 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6658	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6661	Security alert: unauthorized login. Enter code 139394 to secure account.	2025-11-10 00:00:00	0	en
6664	Confirm your payment of $8961.43 using code 113203. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6671	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 621494 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6672	A transfer of $4744.86 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6675	Important: Your debit card ending with 8583 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6676	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6677	تم تحويل مبلغ 7092.19 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6679	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6680	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6681	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6683	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6685	تنبيه: تم إجراء عملية شراء بمبلغ 7407.42. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6687	تم تحويل مبلغ 8937.07 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6689	We detected unusual activity on your account. Confirm your identity with OTP: 837846	2025-11-10 00:00:00	0	en
6693	We detected unusual activity on your account. Confirm your identity with OTP: 290245	2025-11-10 00:00:00	0	en
6694	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6695	We couldn't process your recent payment. Confirm by entering OTP 198438 now.	2025-11-10 00:00:00	0	en
6697	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 575059 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6698	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 283123.	2025-11-10 00:00:00	0	ar
6699	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6700	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6703	تم تحويل مبلغ 1458.22 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6704	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6706	Important: Your debit card ending with 9461 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6707	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6708	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6709	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6710	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6713	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6715	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6718	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 146156 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6722	We couldn't process your recent payment. Confirm by entering OTP 538485 now.	2025-11-10 00:00:00	0	en
6723	تم تحويل مبلغ 3545.06 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6724	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6725	تم تحويل مبلغ 3371.92 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6729	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6737	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6742	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6743	A transfer of $971.59 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6744	We detected unusual activity on your account. Confirm your identity with OTP: 210056	2025-11-10 00:00:00	0	en
6745	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 381216 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6746	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6749	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6750	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6753	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 239005.	2025-11-10 00:00:00	0	ar
6754	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6756	تم تحويل مبلغ 961.61 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6757	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6762	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
556	Your OTP for transaction is 776208. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6763	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6764	تم تحويل مبلغ 8247.85 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6766	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6767	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6768	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6769	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6772	Important: Your debit card ending with 8509 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6774	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6775	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6777	Security alert: unauthorized login. Enter code 596317 to secure account.	2025-11-10 00:00:00	0	en
6780	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 423903 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6782	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6784	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6786	We detected unusual activity on your account. Confirm your identity with OTP: 244429	2025-11-10 00:00:00	0	en
6789	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6794	Security alert: unauthorized login. Enter code 949894 to secure account.	2025-11-10 00:00:00	0	en
6795	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6797	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6802	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6805	تنبيه: تم إجراء عملية شراء بمبلغ 8636.72. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6807	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 453640	2025-11-10 00:00:00	0	ar
6811	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6812	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
6818	We couldn't process your recent payment. Confirm by entering OTP 615559 now.	2025-11-10 00:00:00	0	en
6819	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6823	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6824	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6825	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 369140.	2025-11-10 00:00:00	0	ar
6827	We couldn't process your recent payment. Confirm by entering OTP 191377 now.	2025-11-10 00:00:00	0	en
6828	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
6831	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6839	Confirm your payment of $6938.31 using code 990977. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6840	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6844	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6847	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
6848	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6849	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 585429 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6850	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6853	تنبيه: تم إجراء عملية شراء بمبلغ 3714.90. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6855	We couldn't process your recent payment. Confirm by entering OTP 582117 now.	2025-11-10 00:00:00	0	en
6856	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6859	تم تحويل مبلغ 4662.63 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6860	Security alert: unauthorized login. Enter code 188360 to secure account.	2025-11-10 00:00:00	0	en
6863	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6866	We couldn't process your recent payment. Confirm by entering OTP 131797 now.	2025-11-10 00:00:00	0	en
6868	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 671866.	2025-11-10 00:00:00	0	ar
6869	تنبيه: تم إجراء عملية شراء بمبلغ 6101.23. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
6870	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6872	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 963128	2025-11-10 00:00:00	0	ar
6876	تم تحويل مبلغ 689.48 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6877	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6880	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6885	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6890	مهم: بطاقتك المنتهية بالرقم 1429 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6894	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6895	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6899	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6902	Important: Your debit card ending with 5748 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6903	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6904	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6905	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6909	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6910	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6912	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6913	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6914	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
6918	A transfer of $3932.95 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6919	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6920	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6921	Confirm your payment of $9010.56 using code 826150. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6922	تم تحويل مبلغ 6840.65 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6923	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6924	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
6925	Security alert: unauthorized login. Enter code 469156 to secure account.	2025-11-10 00:00:00	0	en
6926	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6927	تم تحويل مبلغ 6495.74 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6929	تم تحويل مبلغ 6125.28 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6931	تم تحويل مبلغ 4554.56 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6934	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6935	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6936	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
6941	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6943	تم تحويل مبلغ 3698.51 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6944	مهم: بطاقتك المنتهية بالرقم 1244 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
6945	A transfer of $7923.52 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
6946	Important: Your debit card ending with 4815 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
6948	We couldn't process your recent payment. Confirm by entering OTP 242239 now.	2025-11-10 00:00:00	0	en
6949	We couldn't process your recent payment. Confirm by entering OTP 481668 now.	2025-11-10 00:00:00	0	en
6950	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 676084 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6952	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6956	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 501322	2025-11-10 00:00:00	0	ar
6957	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 461474 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
6960	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6961	تم تحويل مبلغ 611.81 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6962	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
6964	Security alert: unauthorized login. Enter code 663778 to secure account.	2025-11-10 00:00:00	0	en
6966	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6969	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 594009.	2025-11-10 00:00:00	0	ar
6970	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
6971	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
6973	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6976	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
6977	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
6978	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6981	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 885321.	2025-11-10 00:00:00	0	ar
6985	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6988	تم تحويل مبلغ 4806.95 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
6993	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
6994	Security alert: unauthorized login. Enter code 144987 to secure account.	2025-11-10 00:00:00	0	en
6995	Confirm your payment of $865.21 using code 169951. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
6955	Your scheduled transfer completed successfully. Ref: 6216.	2025-11-10 00:00:00	\N	en
6998	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
6999	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7002	Security alert: unauthorized login. Enter code 321240 to secure account.	2025-11-10 00:00:00	0	en
7003	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7006	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 885540.	2025-11-10 00:00:00	0	ar
7010	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 209468 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7012	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7013	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 535991 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7014	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7015	مهم: بطاقتك المنتهية بالرقم 7061 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7018	We detected unusual activity on your account. Confirm your identity with OTP: 366781	2025-11-10 00:00:00	0	en
7020	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7021	A transfer of $6991.85 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7029	Security alert: unauthorized login. Enter code 318326 to secure account.	2025-11-10 00:00:00	0	en
7030	Important: Your debit card ending with 2619 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7031	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7034	We couldn't process your recent payment. Confirm by entering OTP 602574 now.	2025-11-10 00:00:00	0	en
7035	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7036	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7037	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 697486.	2025-11-10 00:00:00	0	ar
7038	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 585908.	2025-11-10 00:00:00	0	ar
7040	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7049	Important: Your debit card ending with 4042 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7050	تم تحويل مبلغ 4551.59 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7051	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 640931 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7052	مهم: بطاقتك المنتهية بالرقم 4220 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7054	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7055	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 267981.	2025-11-10 00:00:00	0	ar
7059	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7060	We detected unusual activity on your account. Confirm your identity with OTP: 125621	2025-11-10 00:00:00	0	en
7061	Important: Your debit card ending with 3373 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7062	Important: Your debit card ending with 3449 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7063	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 426111	2025-11-10 00:00:00	0	ar
7066	Security alert: unauthorized login. Enter code 680132 to secure account.	2025-11-10 00:00:00	0	en
7067	مهم: بطاقتك المنتهية بالرقم 3021 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7069	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7070	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7071	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7073	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7074	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7075	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7076	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 481413	2025-11-10 00:00:00	0	ar
7078	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7079	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7080	Security alert: unauthorized login. Enter code 429061 to secure account.	2025-11-10 00:00:00	0	en
7082	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7083	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7085	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7088	Security alert: unauthorized login. Enter code 524560 to secure account.	2025-11-10 00:00:00	0	en
7090	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7093	Important: Your debit card ending with 2474 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7094	مهم: بطاقتك المنتهية بالرقم 8041 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7095	Important: Your debit card ending with 4718 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7096	We couldn't process your recent payment. Confirm by entering OTP 341036 now.	2025-11-10 00:00:00	0	en
7098	We couldn't process your recent payment. Confirm by entering OTP 508836 now.	2025-11-10 00:00:00	0	en
7101	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7102	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7103	We detected unusual activity on your account. Confirm your identity with OTP: 828283	2025-11-10 00:00:00	0	en
7105	We couldn't process your recent payment. Confirm by entering OTP 647118 now.	2025-11-10 00:00:00	0	en
7106	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7108	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7109	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7111	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7057	Reminder: Your loan payment of $865.59 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7113	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 510037	2025-11-10 00:00:00	0	ar
7114	We detected unusual activity on your account. Confirm your identity with OTP: 153688	2025-11-10 00:00:00	0	en
7115	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7118	Security alert: unauthorized login. Enter code 112746 to secure account.	2025-11-10 00:00:00	0	en
7123	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7124	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7126	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 889250 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7128	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7129	We detected unusual activity on your account. Confirm your identity with OTP: 603914	2025-11-10 00:00:00	0	en
7130	We couldn't process your recent payment. Confirm by entering OTP 781253 now.	2025-11-10 00:00:00	0	en
7131	Confirm your payment of $3736.48 using code 328368. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7132	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7134	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7136	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7137	تم تحويل مبلغ 4092.21 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7138	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7140	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7141	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 713471	2025-11-10 00:00:00	0	ar
7145	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7146	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7147	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7148	A transfer of $8992.08 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7150	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7152	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 839918 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7154	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7158	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7159	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7165	We detected unusual activity on your account. Confirm your identity with OTP: 476618	2025-11-10 00:00:00	0	en
7166	Security alert: unauthorized login. Enter code 255992 to secure account.	2025-11-10 00:00:00	0	en
7167	Important: Your debit card ending with 8035 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7168	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7169	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7173	Security alert: unauthorized login. Enter code 935298 to secure account.	2025-11-10 00:00:00	0	en
7181	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7185	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7186	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7187	Confirm your payment of $8964.93 using code 289836. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7190	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7191	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7195	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 536960 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7197	مهم: بطاقتك المنتهية بالرقم 6880 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7198	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7199	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7201	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7202	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7207	Important: Your debit card ending with 3083 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7208	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7211	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7213	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 800897.	2025-11-10 00:00:00	0	ar
7214	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7216	Important: Your debit card ending with 3554 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7217	مهم: بطاقتك المنتهية بالرقم 3511 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7219	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 773589	2025-11-10 00:00:00	0	ar
7220	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7222	We couldn't process your recent payment. Confirm by entering OTP 993691 now.	2025-11-10 00:00:00	0	en
7223	We couldn't process your recent payment. Confirm by entering OTP 403324 now.	2025-11-10 00:00:00	0	en
7224	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 837819	2025-11-10 00:00:00	0	ar
7225	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7227	مهم: بطاقتك المنتهية بالرقم 3464 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7183	Reminder: Your loan payment of $9949.84 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7228	مهم: بطاقتك المنتهية بالرقم 4662 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7230	A transfer of $3650.89 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7233	We detected unusual activity on your account. Confirm your identity with OTP: 213718	2025-11-10 00:00:00	0	en
7234	تنبيه: تم إجراء عملية شراء بمبلغ 525.47. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7235	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7236	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7239	We couldn't process your recent payment. Confirm by entering OTP 407747 now.	2025-11-10 00:00:00	0	en
7240	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7241	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7243	Confirm your payment of $4418.25 using code 641868. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7244	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7245	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 533308 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7246	تنبيه: تم إجراء عملية شراء بمبلغ 2002.45. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7248	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7249	Confirm your payment of $8764.55 using code 227313. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7253	We couldn't process your recent payment. Confirm by entering OTP 653223 now.	2025-11-10 00:00:00	0	en
7254	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 657750 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7255	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7256	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7257	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7259	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7260	تم تحويل مبلغ 4918.37 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7263	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 377304 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7264	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 114553	2025-11-10 00:00:00	0	ar
7267	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 790369 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7269	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7270	We detected unusual activity on your account. Confirm your identity with OTP: 819701	2025-11-10 00:00:00	0	en
7273	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7276	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7277	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7278	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7281	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7282	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7285	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 393847.	2025-11-10 00:00:00	0	ar
7287	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7295	A transfer of $7213.85 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7296	تنبيه: تم إجراء عملية شراء بمبلغ 3584.57. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7298	A transfer of $6636.71 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7300	تنبيه: تم إجراء عملية شراء بمبلغ 467.14. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7301	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7305	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7306	We couldn't process your recent payment. Confirm by entering OTP 198076 now.	2025-11-10 00:00:00	0	en
7309	We detected unusual activity on your account. Confirm your identity with OTP: 937863	2025-11-10 00:00:00	0	en
7312	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7314	Confirm your payment of $1700.07 using code 812653. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7316	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7317	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 558030.	2025-11-10 00:00:00	0	ar
7318	تنبيه: تم إجراء عملية شراء بمبلغ 3917.78. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7319	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7322	Security alert: unauthorized login. Enter code 987019 to secure account.	2025-11-10 00:00:00	0	en
7323	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7324	مهم: بطاقتك المنتهية بالرقم 5813 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7325	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7326	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7330	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 967823.	2025-11-10 00:00:00	0	ar
7332	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7333	Important: Your debit card ending with 1371 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7338	مهم: بطاقتك المنتهية بالرقم 3839 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7339	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7341	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7343	We detected unusual activity on your account. Confirm your identity with OTP: 590235	2025-11-10 00:00:00	0	en
7345	Security alert: unauthorized login. Enter code 430206 to secure account.	2025-11-10 00:00:00	0	en
7346	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7347	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7348	تنبيه: تم إجراء عملية شراء بمبلغ 9518.92. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7350	تنبيه: تم إجراء عملية شراء بمبلغ 9351.86. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7351	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 917546.	2025-11-10 00:00:00	0	ar
7352	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7354	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7355	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7357	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7358	We couldn't process your recent payment. Confirm by entering OTP 789387 now.	2025-11-10 00:00:00	0	en
7363	Important: Your debit card ending with 2414 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7364	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7366	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 152787 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7370	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7372	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7373	تنبيه: تم إجراء عملية شراء بمبلغ 5946.13. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7374	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7375	Confirm your payment of $3739.85 using code 404429. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7376	Important: Your debit card ending with 2840 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7377	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7381	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7382	مهم: بطاقتك المنتهية بالرقم 1480 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7384	We detected unusual activity on your account. Confirm your identity with OTP: 698879	2025-11-10 00:00:00	0	en
7385	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7386	Security alert: unauthorized login. Enter code 283722 to secure account.	2025-11-10 00:00:00	0	en
7389	We couldn't process your recent payment. Confirm by entering OTP 872879 now.	2025-11-10 00:00:00	0	en
7390	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7391	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7393	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7394	Important: Your debit card ending with 8836 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7395	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 706588 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7397	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
776	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7405	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7406	Security alert: unauthorized login. Enter code 147523 to secure account.	2025-11-10 00:00:00	0	en
7408	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7410	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7415	Confirm your payment of $5809.75 using code 607277. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7416	Confirm your payment of $273.65 using code 602167. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7417	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 415073.	2025-11-10 00:00:00	0	ar
7420	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7423	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 891156	2025-11-10 00:00:00	0	ar
7426	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7427	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7428	Confirm your payment of $1078.07 using code 413055. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7429	Important: Your debit card ending with 9954 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7430	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7431	We detected unusual activity on your account. Confirm your identity with OTP: 224166	2025-11-10 00:00:00	0	en
7432	We detected unusual activity on your account. Confirm your identity with OTP: 423271	2025-11-10 00:00:00	0	en
7433	We detected unusual activity on your account. Confirm your identity with OTP: 453587	2025-11-10 00:00:00	0	en
7434	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7439	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7441	We detected unusual activity on your account. Confirm your identity with OTP: 573101	2025-11-10 00:00:00	0	en
7442	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7443	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7444	Confirm your payment of $6540.13 using code 576293. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7446	A transfer of $6747.98 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7447	تنبيه: تم إجراء عملية شراء بمبلغ 7917.36. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7448	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 628557.	2025-11-10 00:00:00	0	ar
7450	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7455	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7458	Confirm your payment of $7170.48 using code 503386. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7459	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7463	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 476956.	2025-11-10 00:00:00	0	ar
7464	تنبيه: تم إجراء عملية شراء بمبلغ 5365.88. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7466	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7467	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7468	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7469	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7470	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7471	تم تحويل مبلغ 2439.07 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7473	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7476	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 812381	2025-11-10 00:00:00	0	ar
7479	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7480	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 495016.	2025-11-10 00:00:00	0	ar
7484	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 241808.	2025-11-10 00:00:00	0	ar
7486	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7487	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7488	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7489	مهم: بطاقتك المنتهية بالرقم 4764 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7490	Security alert: unauthorized login. Enter code 890952 to secure account.	2025-11-10 00:00:00	0	en
7491	Security alert: unauthorized login. Enter code 255606 to secure account.	2025-11-10 00:00:00	0	en
7493	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7496	Important: Your debit card ending with 8037 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7497	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7499	We detected unusual activity on your account. Confirm your identity with OTP: 580203	2025-11-10 00:00:00	0	en
7500	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7503	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7505	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7508	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7509	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 910788	2025-11-10 00:00:00	0	ar
7510	We detected unusual activity on your account. Confirm your identity with OTP: 564632	2025-11-10 00:00:00	0	en
7512	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 820784 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7456	Your scheduled transfer completed successfully. Ref: 3404.	2025-11-10 00:00:00	\N	en
7513	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7514	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 499058.	2025-11-10 00:00:00	0	ar
7515	تنبيه: تم إجراء عملية شراء بمبلغ 2752.93. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7516	We couldn't process your recent payment. Confirm by entering OTP 614648 now.	2025-11-10 00:00:00	0	en
7518	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7519	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7520	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7522	We detected unusual activity on your account. Confirm your identity with OTP: 727375	2025-11-10 00:00:00	0	en
7523	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7524	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7527	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 676549	2025-11-10 00:00:00	0	ar
7530	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7531	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7532	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7535	مهم: بطاقتك المنتهية بالرقم 9582 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7536	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7541	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7542	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7543	تنبيه: تم إجراء عملية شراء بمبلغ 2805.51. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7544	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 773324.	2025-11-10 00:00:00	0	ar
7546	مهم: بطاقتك المنتهية بالرقم 4702 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7553	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7557	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7560	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7561	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 118300	2025-11-10 00:00:00	0	ar
7564	تم تحويل مبلغ 9782.68 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7566	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7567	Confirm your payment of $8347.91 using code 737868. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7570	تم تحويل مبلغ 3286.24 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7572	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7574	A transfer of $8729.74 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7576	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7577	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7580	Confirm your payment of $6433.75 using code 232178. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7581	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7583	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7585	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7587	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7588	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7589	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7590	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7595	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7596	Security alert: unauthorized login. Enter code 969029 to secure account.	2025-11-10 00:00:00	0	en
7601	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7603	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7604	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7610	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7613	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7617	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7618	Confirm your payment of $5830.31 using code 519533. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7619	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7622	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7624	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7569	Notification: Your card ending with 4250 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7627	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7629	Confirm your payment of $9662.66 using code 621854. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7630	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7631	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7632	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7634	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7635	Confirm your payment of $8443.78 using code 980897. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7636	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7639	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7643	Security alert: unauthorized login. Enter code 513413 to secure account.	2025-11-10 00:00:00	0	en
7644	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7647	We detected unusual activity on your account. Confirm your identity with OTP: 640784	2025-11-10 00:00:00	0	en
7654	We detected unusual activity on your account. Confirm your identity with OTP: 706720	2025-11-10 00:00:00	0	en
7655	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7657	تم تحويل مبلغ 2593.04 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7661	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7665	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7666	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7668	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7674	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7675	We detected unusual activity on your account. Confirm your identity with OTP: 775294	2025-11-10 00:00:00	0	en
7678	تم تحويل مبلغ 3019.99 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7681	Important: Your debit card ending with 7325 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7682	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7683	Security alert: unauthorized login. Enter code 337469 to secure account.	2025-11-10 00:00:00	0	en
7684	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7685	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7686	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7688	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 586559 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7692	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7697	Security alert: unauthorized login. Enter code 313077 to secure account.	2025-11-10 00:00:00	0	en
7699	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7700	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 447094 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7701	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7702	تم تحويل مبلغ 4303.80 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7704	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7710	Security alert: unauthorized login. Enter code 376871 to secure account.	2025-11-10 00:00:00	0	en
7711	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 198592	2025-11-10 00:00:00	0	ar
7713	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7715	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7717	تنبيه: تم إجراء عملية شراء بمبلغ 3861.43. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7718	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7720	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7721	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 543118 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7722	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7726	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7727	تم تحويل مبلغ 5381.27 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7729	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7730	تنبيه: تم إجراء عملية شراء بمبلغ 9061.05. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7733	Confirm your payment of $1680.77 using code 822976. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7734	مهم: بطاقتك المنتهية بالرقم 7873 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7735	We detected unusual activity on your account. Confirm your identity with OTP: 833065	2025-11-10 00:00:00	0	en
7736	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7737	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7738	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 408636 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7740	تم تحويل مبلغ 499.23 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7742	تنبيه: تم إجراء عملية شراء بمبلغ 6154.98. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7744	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7745	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7749	Security alert: unauthorized login. Enter code 370425 to secure account.	2025-11-10 00:00:00	0	en
7750	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7752	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7753	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 932814.	2025-11-10 00:00:00	0	ar
7754	We couldn't process your recent payment. Confirm by entering OTP 641045 now.	2025-11-10 00:00:00	0	en
7755	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7758	مهم: بطاقتك المنتهية بالرقم 3661 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7762	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7763	مهم: بطاقتك المنتهية بالرقم 8845 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7764	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7765	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7766	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7767	مهم: بطاقتك المنتهية بالرقم 6721 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7770	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7772	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7774	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7775	تنبيه: تم إجراء عملية شراء بمبلغ 6086.71. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7776	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 909056	2025-11-10 00:00:00	0	ar
7782	Important: Your debit card ending with 5195 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7783	تم تحويل مبلغ 9648.22 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7784	A transfer of $6535.55 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7786	تم تحويل مبلغ 3018.49 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7790	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7793	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 691863	2025-11-10 00:00:00	0	ar
7794	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 138707 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7797	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7800	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7802	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 165963.	2025-11-10 00:00:00	0	ar
7803	Important: Your debit card ending with 6727 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
7804	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7805	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7806	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7808	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 729244	2025-11-10 00:00:00	0	ar
7809	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7811	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7812	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7815	We couldn't process your recent payment. Confirm by entering OTP 446778 now.	2025-11-10 00:00:00	0	en
7816	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7817	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7818	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7819	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 958410.	2025-11-10 00:00:00	0	ar
7826	تنبيه: تم إجراء عملية شراء بمبلغ 7497.38. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7829	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 979905.	2025-11-10 00:00:00	0	ar
7830	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 805726.	2025-11-10 00:00:00	0	ar
7831	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7833	تم تحويل مبلغ 6229.14 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7834	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 331626.	2025-11-10 00:00:00	0	ar
7835	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7838	A transfer of $4707.40 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7840	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7841	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7846	We couldn't process your recent payment. Confirm by entering OTP 877395 now.	2025-11-10 00:00:00	0	en
7850	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7851	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 622847.	2025-11-10 00:00:00	0	ar
7856	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7858	تم تحويل مبلغ 5075.12 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7862	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7863	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7865	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
7869	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7873	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7875	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7879	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7881	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7884	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7885	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7888	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 508196 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7891	We detected unusual activity on your account. Confirm your identity with OTP: 114769	2025-11-10 00:00:00	0	en
7892	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7893	مهم: بطاقتك المنتهية بالرقم 2798 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7895	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 776046 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7898	We detected unusual activity on your account. Confirm your identity with OTP: 948910	2025-11-10 00:00:00	0	en
7899	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7900	Security alert: unauthorized login. Enter code 424746 to secure account.	2025-11-10 00:00:00	0	en
7901	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7902	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 436496 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
7903	Confirm your payment of $6774.02 using code 717431. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7905	مهم: بطاقتك المنتهية بالرقم 6980 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7906	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7908	مهم: بطاقتك المنتهية بالرقم 1583 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
7909	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
7910	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7913	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7915	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7916	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7918	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7919	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
7920	We detected unusual activity on your account. Confirm your identity with OTP: 596592	2025-11-10 00:00:00	0	en
7923	تنبيه: تم إجراء عملية شراء بمبلغ 8655.57. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7926	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7927	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7928	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
7929	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7930	تنبيه: تم إجراء عملية شراء بمبلغ 5995.22. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
7933	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7934	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
7940	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7942	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7944	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7946	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
7947	We couldn't process your recent payment. Confirm by entering OTP 121750 now.	2025-11-10 00:00:00	0	en
7948	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7949	تم تحويل مبلغ 5723.18 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7952	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7954	A transfer of $2991.20 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
7955	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7956	We detected unusual activity on your account. Confirm your identity with OTP: 176480	2025-11-10 00:00:00	0	en
7958	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
7960	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7962	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
7963	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7965	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7970	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
7972	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
7975	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
7978	Confirm your payment of $3155.32 using code 610757. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7979	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 353776	2025-11-10 00:00:00	0	ar
7982	Confirm your payment of $4384.40 using code 704274. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
7985	We couldn't process your recent payment. Confirm by entering OTP 103404 now.	2025-11-10 00:00:00	0	en
7989	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
7997	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
7998	تم تحويل مبلغ 2947.59 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
7999	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 889125.	2025-11-10 00:00:00	0	ar
8001	Security alert: unauthorized login. Enter code 449430 to secure account.	2025-11-10 00:00:00	0	en
8002	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8005	We detected unusual activity on your account. Confirm your identity with OTP: 789778	2025-11-10 00:00:00	0	en
8008	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8011	مهم: بطاقتك المنتهية بالرقم 3334 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8014	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8015	مهم: بطاقتك المنتهية بالرقم 8745 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8016	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8020	تم تحويل مبلغ 1315.57 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8021	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8023	We detected unusual activity on your account. Confirm your identity with OTP: 540023	2025-11-10 00:00:00	0	en
8024	Security alert: unauthorized login. Enter code 945811 to secure account.	2025-11-10 00:00:00	0	en
8025	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8027	Confirm your payment of $3945.46 using code 989273. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8028	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8029	Important: Your debit card ending with 3176 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8033	Confirm your payment of $6676.02 using code 659351. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8035	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 516704.	2025-11-10 00:00:00	0	ar
8037	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8038	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8040	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8041	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 886902.	2025-11-10 00:00:00	0	ar
8042	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8045	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 845028	2025-11-10 00:00:00	0	ar
8046	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 554578.	2025-11-10 00:00:00	0	ar
8048	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8049	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 972834.	2025-11-10 00:00:00	0	ar
8050	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8051	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8052	Confirm your payment of $9084.79 using code 842302. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8053	We couldn't process your recent payment. Confirm by entering OTP 668901 now.	2025-11-10 00:00:00	0	en
8055	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 658695.	2025-11-10 00:00:00	0	ar
8056	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8058	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8059	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 149353	2025-11-10 00:00:00	0	ar
8062	تم تحويل مبلغ 5953.14 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8064	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 450388.	2025-11-10 00:00:00	0	ar
8067	Important: Your debit card ending with 1539 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8068	تم تحويل مبلغ 710.40 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8069	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8071	We couldn't process your recent payment. Confirm by entering OTP 191557 now.	2025-11-10 00:00:00	0	en
8079	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8080	We detected unusual activity on your account. Confirm your identity with OTP: 764541	2025-11-10 00:00:00	0	en
8081	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 424727.	2025-11-10 00:00:00	0	ar
8082	Security alert: unauthorized login. Enter code 379466 to secure account.	2025-11-10 00:00:00	0	en
8083	Important: Your debit card ending with 2711 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8084	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 352532	2025-11-10 00:00:00	0	ar
8087	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8089	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8090	We couldn't process your recent payment. Confirm by entering OTP 157166 now.	2025-11-10 00:00:00	0	en
8092	Confirm your payment of $7220.85 using code 852841. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8093	We detected unusual activity on your account. Confirm your identity with OTP: 204018	2025-11-10 00:00:00	0	en
8094	تم تحويل مبلغ 1585.21 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8097	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8101	Security alert: unauthorized login. Enter code 715068 to secure account.	2025-11-10 00:00:00	0	en
8102	Important: Your debit card ending with 6807 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8105	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 177571 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8106	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8107	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8108	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8112	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8114	Confirm your payment of $6357.80 using code 893414. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8116	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8117	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8118	تنبيه: تم إجراء عملية شراء بمبلغ 4831.83. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8120	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8122	Security alert: unauthorized login. Enter code 650565 to secure account.	2025-11-10 00:00:00	0	en
8123	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8128	Confirm your payment of $7106.44 using code 691494. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8133	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 656956	2025-11-10 00:00:00	0	ar
8137	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 407305 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8138	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8140	تم تحويل مبلغ 5804.21 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8143	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8144	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8145	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8147	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 389777.	2025-11-10 00:00:00	0	ar
8148	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 820054.	2025-11-10 00:00:00	0	ar
8149	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8150	Important: Your debit card ending with 5966 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8151	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8152	تنبيه: تم إجراء عملية شراء بمبلغ 3167.94. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8153	We detected unusual activity on your account. Confirm your identity with OTP: 836469	2025-11-10 00:00:00	0	en
8154	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8158	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8159	We couldn't process your recent payment. Confirm by entering OTP 847260 now.	2025-11-10 00:00:00	0	en
8162	We detected unusual activity on your account. Confirm your identity with OTP: 246170	2025-11-10 00:00:00	0	en
8166	مهم: بطاقتك المنتهية بالرقم 3232 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8168	مهم: بطاقتك المنتهية بالرقم 3158 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8170	تم تحويل مبلغ 6831.09 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8172	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8173	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8175	مهم: بطاقتك المنتهية بالرقم 5160 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8176	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8177	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8181	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8183	Important: Your debit card ending with 2626 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8184	تنبيه: تم إجراء عملية شراء بمبلغ 9662.24. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8187	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8188	تنبيه: تم إجراء عملية شراء بمبلغ 8610.42. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8189	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8191	مهم: بطاقتك المنتهية بالرقم 9173 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8192	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8193	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8194	We couldn't process your recent payment. Confirm by entering OTP 890130 now.	2025-11-10 00:00:00	0	en
8195	تنبيه: تم إجراء عملية شراء بمبلغ 287.83. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8196	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8197	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8198	We couldn't process your recent payment. Confirm by entering OTP 251363 now.	2025-11-10 00:00:00	0	en
8200	Confirm your payment of $5992.48 using code 126720. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8203	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8204	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8205	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8207	تنبيه: تم إجراء عملية شراء بمبلغ 8816.66. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8216	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8219	We detected unusual activity on your account. Confirm your identity with OTP: 757331	2025-11-10 00:00:00	0	en
8220	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8223	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8224	Important: Your debit card ending with 7686 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8227	Important: Your debit card ending with 5104 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8229	تم تحويل مبلغ 7833.84 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8231	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 925486.	2025-11-10 00:00:00	0	ar
8232	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8236	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8237	تنبيه: تم إجراء عملية شراء بمبلغ 2120.46. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8242	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8244	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8245	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8246	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8250	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 678774 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8251	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8253	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8254	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8257	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8259	We detected unusual activity on your account. Confirm your identity with OTP: 991206	2025-11-10 00:00:00	0	en
8260	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8261	Confirm your payment of $7673.02 using code 861954. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8263	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8264	تنبيه: تم إجراء عملية شراء بمبلغ 8051.28. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8265	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8266	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8267	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 126004 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8268	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 937435	2025-11-10 00:00:00	0	ar
8271	A transfer of $6917.58 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8272	A transfer of $5337.15 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8273	We detected unusual activity on your account. Confirm your identity with OTP: 986469	2025-11-10 00:00:00	0	en
8275	We detected unusual activity on your account. Confirm your identity with OTP: 828790	2025-11-10 00:00:00	0	en
8276	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8280	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8282	We detected unusual activity on your account. Confirm your identity with OTP: 206017	2025-11-10 00:00:00	0	en
8283	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 678228 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8285	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8286	تنبيه: تم إجراء عملية شراء بمبلغ 9433.52. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8288	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8293	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 432838.	2025-11-10 00:00:00	0	ar
8294	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8296	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8297	We detected unusual activity on your account. Confirm your identity with OTP: 658564	2025-11-10 00:00:00	0	en
8300	مهم: بطاقتك المنتهية بالرقم 6981 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8301	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8307	Important: Your debit card ending with 2434 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8308	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8313	تم تحويل مبلغ 7937.98 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8318	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8319	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8321	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8323	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8324	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8327	مهم: بطاقتك المنتهية بالرقم 8644 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8328	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8332	Important: Your debit card ending with 9455 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8336	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8341	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8344	مهم: بطاقتك المنتهية بالرقم 5247 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8347	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8348	مهم: بطاقتك المنتهية بالرقم 5857 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8349	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 940706.	2025-11-10 00:00:00	0	ar
8352	We detected unusual activity on your account. Confirm your identity with OTP: 208767	2025-11-10 00:00:00	0	en
8353	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8356	تم تحويل مبلغ 8500.37 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8358	مهم: بطاقتك المنتهية بالرقم 9141 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8362	Confirm your payment of $3030.61 using code 783703. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8363	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8365	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 772563	2025-11-10 00:00:00	0	ar
8366	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8367	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8368	Important: Your debit card ending with 7840 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8371	تنبيه: تم إجراء عملية شراء بمبلغ 7857.58. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8372	مهم: بطاقتك المنتهية بالرقم 7619 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8373	A transfer of $4562.29 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8375	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8378	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8379	We detected unusual activity on your account. Confirm your identity with OTP: 720223	2025-11-10 00:00:00	0	en
8380	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8381	تنبيه: تم إجراء عملية شراء بمبلغ 6945.96. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8383	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8385	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8386	Confirm your payment of $4636.42 using code 584105. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8389	تم تحويل مبلغ 9823.08 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8390	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8391	We detected unusual activity on your account. Confirm your identity with OTP: 716371	2025-11-10 00:00:00	0	en
8396	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8398	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8399	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 463281.	2025-11-10 00:00:00	0	ar
8403	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8405	Confirm your payment of $5750.06 using code 890542. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8408	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8410	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 846904.	2025-11-10 00:00:00	0	ar
8411	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8412	Confirm your payment of $1846.35 using code 257838. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8413	We couldn't process your recent payment. Confirm by entering OTP 170670 now.	2025-11-10 00:00:00	0	en
8414	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8416	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8417	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8418	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8419	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8420	Important: Your debit card ending with 1353 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8421	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8424	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8425	We couldn't process your recent payment. Confirm by entering OTP 856199 now.	2025-11-10 00:00:00	0	en
8426	We detected unusual activity on your account. Confirm your identity with OTP: 876557	2025-11-10 00:00:00	0	en
8428	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8431	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8433	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8435	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 506154 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8437	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8440	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 526219.	2025-11-10 00:00:00	0	ar
8441	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8442	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8443	تنبيه: تم إجراء عملية شراء بمبلغ 1421.88. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8447	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8449	مهم: بطاقتك المنتهية بالرقم 2539 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8450	تنبيه: تم إجراء عملية شراء بمبلغ 4004.36. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8451	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 845385	2025-11-10 00:00:00	0	ar
8453	Confirm your payment of $5571.97 using code 380616. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8454	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8455	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8456	We detected unusual activity on your account. Confirm your identity with OTP: 525277	2025-11-10 00:00:00	0	en
8457	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8460	تم تحويل مبلغ 1283.64 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8461	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8462	تنبيه: تم إجراء عملية شراء بمبلغ 629.99. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8463	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8465	مهم: بطاقتك المنتهية بالرقم 7533 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8467	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8470	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8471	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8473	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 673429 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8474	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8476	Confirm your payment of $8277.97 using code 704243. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8477	Confirm your payment of $1902.05 using code 422561. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8478	Important: Your debit card ending with 8577 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8479	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8480	مهم: بطاقتك المنتهية بالرقم 3312 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8482	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8483	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 883745	2025-11-10 00:00:00	0	ar
8484	Important: Your debit card ending with 1885 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8485	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8487	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 977901.	2025-11-10 00:00:00	0	ar
8488	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8489	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8492	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 190154.	2025-11-10 00:00:00	0	ar
8495	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8498	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8502	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8503	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 981665	2025-11-10 00:00:00	0	ar
8506	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 393387	2025-11-10 00:00:00	0	ar
8509	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8510	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 899713 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8511	We detected unusual activity on your account. Confirm your identity with OTP: 282931	2025-11-10 00:00:00	0	en
8512	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8514	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8515	We detected unusual activity on your account. Confirm your identity with OTP: 506275	2025-11-10 00:00:00	0	en
8518	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8520	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 916673 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8525	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8527	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8531	A transfer of $32.53 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8533	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8535	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8537	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8538	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 931086.	2025-11-10 00:00:00	0	ar
8540	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8541	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8542	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8544	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8546	Confirm your payment of $9520.72 using code 772940. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8548	Important: Your debit card ending with 1440 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8551	We detected unusual activity on your account. Confirm your identity with OTP: 596785	2025-11-10 00:00:00	0	en
8553	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8554	We detected unusual activity on your account. Confirm your identity with OTP: 271579	2025-11-10 00:00:00	0	en
8557	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 597239 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8558	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 778325.	2025-11-10 00:00:00	0	ar
8559	تنبيه: تم إجراء عملية شراء بمبلغ 4245.09. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8560	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8562	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8564	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8565	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8566	تم تحويل مبلغ 2248.56 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8570	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 144893.	2025-11-10 00:00:00	0	ar
8573	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8574	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8575	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8580	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8582	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 407637 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8583	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8586	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8591	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8592	We detected unusual activity on your account. Confirm your identity with OTP: 286547	2025-11-10 00:00:00	0	en
8595	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8597	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8598	Important: Your debit card ending with 3390 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8599	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8600	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8602	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 244645	2025-11-10 00:00:00	0	ar
8603	Security alert: unauthorized login. Enter code 253081 to secure account.	2025-11-10 00:00:00	0	en
8605	We detected unusual activity on your account. Confirm your identity with OTP: 859360	2025-11-10 00:00:00	0	en
8606	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 614861 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8607	We detected unusual activity on your account. Confirm your identity with OTP: 539701	2025-11-10 00:00:00	0	en
8608	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8609	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8610	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 680746 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8611	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8612	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8616	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8618	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8619	Important: Your debit card ending with 1005 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8620	We detected unusual activity on your account. Confirm your identity with OTP: 900664	2025-11-10 00:00:00	0	en
8621	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8623	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8624	تم تحويل مبلغ 1596.44 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8627	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 670257	2025-11-10 00:00:00	0	ar
8628	Important: Your debit card ending with 3817 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8633	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8637	Security alert: unauthorized login. Enter code 887322 to secure account.	2025-11-10 00:00:00	0	en
8639	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8640	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8641	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8642	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 566491	2025-11-10 00:00:00	0	ar
8643	تم تحويل مبلغ 7001.68 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8645	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8647	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8648	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8649	تنبيه: تم إجراء عملية شراء بمبلغ 5936.44. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8650	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 532280	2025-11-10 00:00:00	0	ar
8651	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8656	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8658	مهم: بطاقتك المنتهية بالرقم 2093 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8659	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 851355	2025-11-10 00:00:00	0	ar
8660	We detected unusual activity on your account. Confirm your identity with OTP: 678789	2025-11-10 00:00:00	0	en
8622	Your scheduled transfer completed successfully. Ref: 9426.	2025-11-10 00:00:00	\N	en
8663	We couldn't process your recent payment. Confirm by entering OTP 360171 now.	2025-11-10 00:00:00	0	en
8664	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8665	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8666	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 768241.	2025-11-10 00:00:00	0	ar
8667	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8668	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8670	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8673	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8676	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 395381 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8680	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8683	مهم: بطاقتك المنتهية بالرقم 5110 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8689	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8692	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8693	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8697	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 997935 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8701	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8702	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8703	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8706	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8707	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8711	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8712	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8713	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8714	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8715	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8717	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8718	A transfer of $7520.16 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
778	تذكير: قسط القرض بقيمة 3891.51 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8721	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8725	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8726	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8727	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8728	We detected unusual activity on your account. Confirm your identity with OTP: 532771	2025-11-10 00:00:00	0	en
8730	مهم: بطاقتك المنتهية بالرقم 7057 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8731	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8732	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8733	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8734	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8736	Confirm your payment of $1733.76 using code 768741. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8740	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8743	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8744	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8745	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8748	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8749	مهم: بطاقتك المنتهية بالرقم 1114 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8751	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8755	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8757	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 524439.	2025-11-10 00:00:00	0	ar
8758	تنبيه: تم إجراء عملية شراء بمبلغ 5560.39. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8761	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8762	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8763	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8766	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8767	We detected unusual activity on your account. Confirm your identity with OTP: 756776	2025-11-10 00:00:00	0	en
8768	Confirm your payment of $6048.98 using code 108254. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8769	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8770	تم تحويل مبلغ 1930.67 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8771	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 401338.	2025-11-10 00:00:00	0	ar
8775	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8723	Your scheduled transfer completed successfully. Ref: 7542.	2025-11-10 00:00:00	\N	en
8780	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8782	Important: Your debit card ending with 4119 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8784	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 822306.	2025-11-10 00:00:00	0	ar
8787	Security alert: unauthorized login. Enter code 483606 to secure account.	2025-11-10 00:00:00	0	en
8788	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8790	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8791	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8792	We couldn't process your recent payment. Confirm by entering OTP 204715 now.	2025-11-10 00:00:00	0	en
8793	مهم: بطاقتك المنتهية بالرقم 6509 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8796	تم تحويل مبلغ 3286.95 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8797	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8798	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8799	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 730777 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8804	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8809	We detected unusual activity on your account. Confirm your identity with OTP: 822915	2025-11-10 00:00:00	0	en
8811	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 851867	2025-11-10 00:00:00	0	ar
8812	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8813	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8814	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 341693	2025-11-10 00:00:00	0	ar
8815	We detected unusual activity on your account. Confirm your identity with OTP: 373103	2025-11-10 00:00:00	0	en
8822	We detected unusual activity on your account. Confirm your identity with OTP: 820688	2025-11-10 00:00:00	0	en
8823	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 492222.	2025-11-10 00:00:00	0	ar
8825	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 232599 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8827	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8829	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8831	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 453923.	2025-11-10 00:00:00	0	ar
8832	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8834	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8837	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8838	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8839	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8842	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8846	We detected unusual activity on your account. Confirm your identity with OTP: 953721	2025-11-10 00:00:00	0	en
8847	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8852	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 463215.	2025-11-10 00:00:00	0	ar
8853	Security alert: unauthorized login. Enter code 228320 to secure account.	2025-11-10 00:00:00	0	en
8855	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8856	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8858	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 202036 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8859	We detected unusual activity on your account. Confirm your identity with OTP: 744838	2025-11-10 00:00:00	0	en
8860	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 654177	2025-11-10 00:00:00	0	ar
8861	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8862	A transfer of $1744.29 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8868	مهم: بطاقتك المنتهية بالرقم 6703 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8870	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 760547	2025-11-10 00:00:00	0	ar
8871	A transfer of $3301.37 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8872	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 995760 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8873	A transfer of $3733.88 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8874	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8875	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8876	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 146179.	2025-11-10 00:00:00	0	ar
8880	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8885	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 656137.	2025-11-10 00:00:00	0	ar
8887	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8888	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8889	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8891	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 891124 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
8892	تنبيه: تم إجراء عملية شراء بمبلغ 9650.31. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8898	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8904	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
8905	Important: Your debit card ending with 3245 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8906	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8908	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8909	Important: Your debit card ending with 2224 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8910	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 295153	2025-11-10 00:00:00	0	ar
8911	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8912	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 655855.	2025-11-10 00:00:00	0	ar
8913	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8914	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8917	Important: Your debit card ending with 7357 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8918	Important: Your debit card ending with 9896 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8919	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 486060	2025-11-10 00:00:00	0	ar
8921	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 924972	2025-11-10 00:00:00	0	ar
8924	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8927	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
8928	A transfer of $2977.67 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8929	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8930	تنبيه: تم إجراء عملية شراء بمبلغ 4445.59. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8932	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8933	تم تحويل مبلغ 2638.22 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8934	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 762496	2025-11-10 00:00:00	0	ar
8935	Security alert: unauthorized login. Enter code 199289 to secure account.	2025-11-10 00:00:00	0	en
8942	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8944	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
8949	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
8951	تم تحويل مبلغ 9261.77 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8952	A transfer of $9001.14 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8953	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8954	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
8955	Important: Your debit card ending with 7166 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8956	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 999251	2025-11-10 00:00:00	0	ar
8960	Important: Your debit card ending with 6395 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
8961	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8962	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8964	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
8965	We couldn't process your recent payment. Confirm by entering OTP 236322 now.	2025-11-10 00:00:00	0	en
8966	We couldn't process your recent payment. Confirm by entering OTP 825147 now.	2025-11-10 00:00:00	0	en
8969	تم تحويل مبلغ 8252.45 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8970	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
8973	مهم: بطاقتك المنتهية بالرقم 4443 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8977	We couldn't process your recent payment. Confirm by entering OTP 513271 now.	2025-11-10 00:00:00	0	en
8979	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
8980	تم تحويل مبلغ 3898.23 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
8981	مهم: بطاقتك المنتهية بالرقم 4678 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
8982	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
8983	We couldn't process your recent payment. Confirm by entering OTP 548575 now.	2025-11-10 00:00:00	0	en
8984	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8986	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
8987	A transfer of $942.80 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
8989	Confirm your payment of $7824.13 using code 718207. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
8991	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
8992	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
8996	تنبيه: تم إجراء عملية شراء بمبلغ 6004.71. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
8998	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
8999	We detected unusual activity on your account. Confirm your identity with OTP: 742745	2025-11-10 00:00:00	0	en
9002	تم تحويل مبلغ 270.80 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9003	Security alert: unauthorized login. Enter code 253659 to secure account.	2025-11-10 00:00:00	0	en
9004	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9009	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9010	We couldn't process your recent payment. Confirm by entering OTP 868696 now.	2025-11-10 00:00:00	0	en
9011	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9012	تنبيه: تم إجراء عملية شراء بمبلغ 8542.61. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9013	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9015	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9016	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 863261 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9018	Confirm your payment of $6978.30 using code 787291. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9020	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9021	مهم: بطاقتك المنتهية بالرقم 9801 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9023	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9024	We couldn't process your recent payment. Confirm by entering OTP 543269 now.	2025-11-10 00:00:00	0	en
9025	مهم: بطاقتك المنتهية بالرقم 7152 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9026	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 442985	2025-11-10 00:00:00	0	ar
9031	Security alert: unauthorized login. Enter code 603584 to secure account.	2025-11-10 00:00:00	0	en
9032	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 175681	2025-11-10 00:00:00	0	ar
9034	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9038	Security alert: unauthorized login. Enter code 824351 to secure account.	2025-11-10 00:00:00	0	en
9039	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9040	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9047	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 629230	2025-11-10 00:00:00	0	ar
9050	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9052	A transfer of $1442.34 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9054	A transfer of $1655.96 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9056	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9057	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9060	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9061	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9065	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9068	We detected unusual activity on your account. Confirm your identity with OTP: 775078	2025-11-10 00:00:00	0	en
9069	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9070	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9072	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9073	مهم: بطاقتك المنتهية بالرقم 2832 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9074	تم تحويل مبلغ 9880.84 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9075	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 433062	2025-11-10 00:00:00	0	ar
9081	مهم: بطاقتك المنتهية بالرقم 7867 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9082	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9083	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9085	We detected unusual activity on your account. Confirm your identity with OTP: 769374	2025-11-10 00:00:00	0	en
9086	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 350768 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9087	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9089	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9090	تم تحويل مبلغ 1514.39 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9092	تم تحويل مبلغ 1560.48 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9096	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9097	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9102	Important: Your debit card ending with 2554 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9105	تنبيه: تم إجراء عملية شراء بمبلغ 1195.93. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9106	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9109	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9110	A transfer of $8849.61 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9111	Confirm your payment of $6114.11 using code 984445. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9112	We couldn't process your recent payment. Confirm by entering OTP 296748 now.	2025-11-10 00:00:00	0	en
9115	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9118	Important: Your debit card ending with 2279 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9119	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9124	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9126	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9130	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9132	We detected unusual activity on your account. Confirm your identity with OTP: 406958	2025-11-10 00:00:00	0	en
9134	تنبيه: تم إجراء عملية شراء بمبلغ 275.46. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9135	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 183615	2025-11-10 00:00:00	0	ar
9136	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9138	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9139	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9146	تنبيه: تم إجراء عملية شراء بمبلغ 2171.40. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9148	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9152	مهم: بطاقتك المنتهية بالرقم 1599 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9153	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 236966 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9154	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9156	Confirm your payment of $633.08 using code 261651. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9158	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 866165 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9159	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9161	Security alert: unauthorized login. Enter code 973129 to secure account.	2025-11-10 00:00:00	0	en
9165	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 823674.	2025-11-10 00:00:00	0	ar
9166	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9167	Confirm your payment of $6828.81 using code 788717. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9169	Security alert: unauthorized login. Enter code 364780 to secure account.	2025-11-10 00:00:00	0	en
9178	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 432617	2025-11-10 00:00:00	0	ar
9180	Important: Your debit card ending with 2274 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9181	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9182	A transfer of $9782.39 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
1124	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9183	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9190	A transfer of $5970.83 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9191	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9192	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9193	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9194	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9200	Confirm your payment of $2518.26 using code 947163. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9201	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9202	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9203	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 323965	2025-11-10 00:00:00	0	ar
9204	Confirm your payment of $8708.38 using code 114736. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9206	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9207	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9208	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9209	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9210	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9211	تم تحويل مبلغ 3939.60 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9216	مهم: بطاقتك المنتهية بالرقم 3884 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9220	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9221	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 173814 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9222	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9223	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9224	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9225	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9226	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 565009	2025-11-10 00:00:00	0	ar
9232	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 326857 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9233	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9235	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9236	تنبيه: تم إجراء عملية شراء بمبلغ 8988.07. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9237	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 728171 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9238	Important: Your debit card ending with 9771 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9240	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9244	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 545648 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9246	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9247	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 170660 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9248	Security alert: unauthorized login. Enter code 733300 to secure account.	2025-11-10 00:00:00	0	en
9251	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 999425 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9256	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9259	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 507929.	2025-11-10 00:00:00	0	ar
9264	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 495035	2025-11-10 00:00:00	0	ar
9265	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9266	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9268	تنبيه: تم إجراء عملية شراء بمبلغ 7699.82. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9270	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 624706 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9273	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9274	We detected unusual activity on your account. Confirm your identity with OTP: 543878	2025-11-10 00:00:00	0	en
9277	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9279	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9280	مهم: بطاقتك المنتهية بالرقم 6134 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9283	Confirm your payment of $479.79 using code 542668. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9284	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9285	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9286	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9288	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9294	تم تحويل مبلغ 4372.65 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9297	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9298	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 973011	2025-11-10 00:00:00	0	ar
9300	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 400732.	2025-11-10 00:00:00	0	ar
9301	We couldn't process your recent payment. Confirm by entering OTP 968760 now.	2025-11-10 00:00:00	0	en
9302	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9303	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9304	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9305	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9307	مهم: بطاقتك المنتهية بالرقم 8951 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9308	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9309	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9310	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9311	A transfer of $7773.76 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9314	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9315	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 860096.	2025-11-10 00:00:00	0	ar
9316	مهم: بطاقتك المنتهية بالرقم 2312 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9319	Security alert: unauthorized login. Enter code 400455 to secure account.	2025-11-10 00:00:00	0	en
9320	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9321	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9322	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 190248	2025-11-10 00:00:00	0	ar
9323	Confirm your payment of $6605.41 using code 788086. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9324	تنبيه: تم إجراء عملية شراء بمبلغ 944.61. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9325	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 422155.	2025-11-10 00:00:00	0	ar
9326	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9328	تم تحويل مبلغ 7771.54 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9330	A transfer of $1330.30 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9332	A transfer of $8169.92 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9336	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9337	We couldn't process your recent payment. Confirm by entering OTP 430379 now.	2025-11-10 00:00:00	0	en
9338	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9340	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 865479.	2025-11-10 00:00:00	0	ar
9344	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 883806	2025-11-10 00:00:00	0	ar
9345	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9351	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9358	تنبيه: تم إجراء عملية شراء بمبلغ 6630.70. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9359	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9361	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9362	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9363	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9364	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9367	We detected unusual activity on your account. Confirm your identity with OTP: 291373	2025-11-10 00:00:00	0	en
9368	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9372	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 688410 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9373	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9376	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9377	Security alert: unauthorized login. Enter code 684740 to secure account.	2025-11-10 00:00:00	0	en
9380	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9383	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9384	Important: Your debit card ending with 3393 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9389	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9390	مهم: بطاقتك المنتهية بالرقم 9722 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9392	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9394	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 147043.	2025-11-10 00:00:00	0	ar
9395	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9396	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9397	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 506810	2025-11-10 00:00:00	0	ar
9403	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 891749	2025-11-10 00:00:00	0	ar
9406	We couldn't process your recent payment. Confirm by entering OTP 649399 now.	2025-11-10 00:00:00	0	en
9365	Your scheduled transfer completed successfully. Ref: 2283.	2025-11-10 00:00:00	\N	en
9412	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9413	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9415	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9417	We couldn't process your recent payment. Confirm by entering OTP 661842 now.	2025-11-10 00:00:00	0	en
9420	A transfer of $9593.46 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9422	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9424	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9426	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9428	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9430	تم تحويل مبلغ 6628.20 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9431	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9432	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 481280	2025-11-10 00:00:00	0	ar
9438	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9439	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9440	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9441	A transfer of $5221.14 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9445	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9446	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9448	We detected unusual activity on your account. Confirm your identity with OTP: 811507	2025-11-10 00:00:00	0	en
9450	تم تحويل مبلغ 5521.24 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9454	مهم: بطاقتك المنتهية بالرقم 7463 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9455	مهم: بطاقتك المنتهية بالرقم 1825 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9457	Important: Your debit card ending with 5447 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9458	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9460	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9461	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9462	Confirm your payment of $969.67 using code 818239. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9463	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9466	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9467	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9468	مهم: بطاقتك المنتهية بالرقم 9372 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9469	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9471	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9472	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9473	مهم: بطاقتك المنتهية بالرقم 8113 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9477	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9483	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9486	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 297541.	2025-11-10 00:00:00	0	ar
9488	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9489	تنبيه: تم إجراء عملية شراء بمبلغ 5713.48. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9492	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 697408 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9495	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9496	تم تحويل مبلغ 6344.88 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9498	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9500	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9503	We detected unusual activity on your account. Confirm your identity with OTP: 701761	2025-11-10 00:00:00	0	en
9504	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9509	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9510	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 780803	2025-11-10 00:00:00	0	ar
9511	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9514	A transfer of $4083.06 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9515	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9516	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9517	Confirm your payment of $7140.69 using code 490624. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9519	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9520	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9521	We couldn't process your recent payment. Confirm by entering OTP 688056 now.	2025-11-10 00:00:00	0	en
9522	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9526	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9470	Your online transfer of $2819.99 to account 4193 was successful.	2025-11-10 00:00:00	\N	en
9527	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 442303	2025-11-10 00:00:00	0	ar
9528	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9530	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9531	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9532	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9533	We couldn't process your recent payment. Confirm by entering OTP 941132 now.	2025-11-10 00:00:00	0	en
9534	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9535	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9537	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9539	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9540	A transfer of $2261.28 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9541	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9542	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9545	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 780610 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9547	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9549	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9551	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9554	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9556	We detected unusual activity on your account. Confirm your identity with OTP: 965756	2025-11-10 00:00:00	0	en
9559	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 908588	2025-11-10 00:00:00	0	ar
9560	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9561	تنبيه: تم إجراء عملية شراء بمبلغ 1913.68. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9563	Confirm your payment of $5089.86 using code 565238. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9564	Important: Your debit card ending with 4043 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9567	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9570	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9571	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9575	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9576	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9577	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9579	We couldn't process your recent payment. Confirm by entering OTP 544170 now.	2025-11-10 00:00:00	0	en
9580	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9581	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9582	Important: Your debit card ending with 6858 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9583	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9585	Confirm your payment of $1983.66 using code 557430. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9587	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 562655	2025-11-10 00:00:00	0	ar
9593	We detected unusual activity on your account. Confirm your identity with OTP: 861086	2025-11-10 00:00:00	0	en
9595	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9601	We detected unusual activity on your account. Confirm your identity with OTP: 455284	2025-11-10 00:00:00	0	en
9604	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9605	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9607	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9608	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 811206.	2025-11-10 00:00:00	0	ar
9609	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9614	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9615	We detected unusual activity on your account. Confirm your identity with OTP: 248850	2025-11-10 00:00:00	0	en
9618	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9619	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9620	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 445188	2025-11-10 00:00:00	0	ar
9626	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 485076	2025-11-10 00:00:00	0	ar
9631	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9633	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9635	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9640	تم تحويل مبلغ 4408.27 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9645	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9646	Confirm your payment of $7663.60 using code 194252. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9647	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9648	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9649	Confirm your payment of $7242.58 using code 371674. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9652	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9653	مهم: بطاقتك المنتهية بالرقم 7955 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9659	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9660	مهم: بطاقتك المنتهية بالرقم 2490 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9663	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9664	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 689839.	2025-11-10 00:00:00	0	ar
9668	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9670	تم تحويل مبلغ 7827.00 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9672	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 176059.	2025-11-10 00:00:00	0	ar
9677	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9678	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9680	مهم: بطاقتك المنتهية بالرقم 9577 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9682	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 974357	2025-11-10 00:00:00	0	ar
9684	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9689	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 820607	2025-11-10 00:00:00	0	ar
9690	Confirm your payment of $8882.95 using code 210251. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9692	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9693	A transfer of $5033.08 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9695	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9696	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 419198	2025-11-10 00:00:00	0	ar
9697	مهم: بطاقتك المنتهية بالرقم 8030 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9698	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9700	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 117828.	2025-11-10 00:00:00	0	ar
9701	We detected unusual activity on your account. Confirm your identity with OTP: 525451	2025-11-10 00:00:00	0	en
9702	A transfer of $9058.21 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9703	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 109509 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9705	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9706	Important: Your debit card ending with 5573 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9707	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9708	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9709	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9710	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 674611	2025-11-10 00:00:00	0	ar
9713	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9715	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9717	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9718	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9720	We detected unusual activity on your account. Confirm your identity with OTP: 702103	2025-11-10 00:00:00	0	en
9725	We detected unusual activity on your account. Confirm your identity with OTP: 619663	2025-11-10 00:00:00	0	en
9726	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9730	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9732	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9734	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9735	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9739	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 474619.	2025-11-10 00:00:00	0	ar
9741	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9744	Security alert: unauthorized login. Enter code 168750 to secure account.	2025-11-10 00:00:00	0	en
9745	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9747	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9748	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9751	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9752	We detected unusual activity on your account. Confirm your identity with OTP: 487561	2025-11-10 00:00:00	0	en
9722	Your transaction of $4421.56 at STORE was successful. Ref: 4348.	2025-11-10 00:00:00	\N	en
9756	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9758	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 814892.	2025-11-10 00:00:00	0	ar
9759	A transfer of $3397.74 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9760	مهم: بطاقتك المنتهية بالرقم 1625 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9761	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9765	تنبيه: تم إجراء عملية شراء بمبلغ 7106.06. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9767	We couldn't process your recent payment. Confirm by entering OTP 437149 now.	2025-11-10 00:00:00	0	en
9768	Confirm your payment of $9476.98 using code 727936. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9769	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 636593.	2025-11-10 00:00:00	0	ar
9773	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9774	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9776	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9780	A transfer of $1844.66 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9781	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9783	We detected unusual activity on your account. Confirm your identity with OTP: 164199	2025-11-10 00:00:00	0	en
9786	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9787	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9789	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 356203.	2025-11-10 00:00:00	0	ar
9790	مهم: بطاقتك المنتهية بالرقم 5763 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9793	تم تحويل مبلغ 8697.09 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9794	مهم: بطاقتك المنتهية بالرقم 4479 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9797	Confirm your payment of $63.41 using code 400053. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9802	We couldn't process your recent payment. Confirm by entering OTP 574778 now.	2025-11-10 00:00:00	0	en
9803	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9804	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 294224.	2025-11-10 00:00:00	0	ar
9806	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 465901 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9807	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9809	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 147519.	2025-11-10 00:00:00	0	ar
9811	We detected unusual activity on your account. Confirm your identity with OTP: 172990	2025-11-10 00:00:00	0	en
9813	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9814	A transfer of $3176.72 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9815	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9816	مهم: بطاقتك المنتهية بالرقم 5874 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9817	تم تحويل مبلغ 6691.67 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9819	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 950764	2025-11-10 00:00:00	0	ar
9820	تم تحويل مبلغ 5407.84 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9823	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9826	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9830	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9831	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9832	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9833	Security alert: unauthorized login. Enter code 787862 to secure account.	2025-11-10 00:00:00	0	en
9837	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9838	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 655142	2025-11-10 00:00:00	0	ar
9840	تم تحويل مبلغ 1702.42 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9841	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9842	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9845	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 610716 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9847	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 353709	2025-11-10 00:00:00	0	ar
9848	تم تحويل مبلغ 3515.73 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9849	مهم: بطاقتك المنتهية بالرقم 4743 تم إيقافها. تحقق عبر <URL>	2025-11-10 00:00:00	0	ar
9851	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9852	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 976882	2025-11-10 00:00:00	0	ar
9854	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9855	Confirm your payment of $5351.39 using code 568869. If you didn't authorize, contact us.	2025-11-10 00:00:00	0	en
9856	We couldn't process your recent payment. Confirm by entering OTP 429695 now.	2025-11-10 00:00:00	0	en
9857	We couldn't process your recent payment. Confirm by entering OTP 581411 now.	2025-11-10 00:00:00	0	en
9859	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9864	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9872	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9873	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 578413.	2025-11-10 00:00:00	0	ar
9874	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 378329	2025-11-10 00:00:00	0	ar
9878	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9880	Bank: Your direct deposit failed. Update details at <URL> to receive funds.	2025-11-10 00:00:00	0	en
9881	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9883	تحذير: محاولة دخول غير مصرح بها. أدخل الكود 813259 لتأمين حسابك.	2025-11-10 00:00:00	0	ar
9885	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9886	Security alert: unauthorized login. Enter code 300870 to secure account.	2025-11-10 00:00:00	0	en
9888	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9892	تم تحويل مبلغ 4426.17 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9893	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 932639.	2025-11-10 00:00:00	0	ar
9894	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9895	Security alert: unauthorized login. Enter code 485871 to secure account.	2025-11-10 00:00:00	0	en
9896	Alert: Suspicious transaction. Call back on <PHONE> or verify at <URL>.	2025-11-10 00:00:00	0	en
9898	تنبيه: تم إجراء عملية شراء بمبلغ 6209.16. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9903	يرجى عدم تجاهل: حسابك سيغلق خلال 24 ساعة إن لم تؤكد بياناتك عبر <URL>.	2025-11-10 00:00:00	0	ar
9904	Important: Your debit card ending with 8865 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9907	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9908	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9909	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9910	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9912	A transfer of $8311.24 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9913	We detected unusual activity on your account. Confirm your identity with OTP: 899569	2025-11-10 00:00:00	0	en
9918	تم تحويل مبلغ 7748.47 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9919	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9920	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9922	Important: Your debit card ending with 8125 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9923	Your online banking credentials need updating. Login: <URL>	2025-11-10 00:00:00	0	en
9925	A transfer of $7929.03 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9932	We couldn't process your recent payment. Confirm by entering OTP 909068 now.	2025-11-10 00:00:00	0	en
9933	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9934	تم تحويل مبلغ 940.48 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9936	We detected unusual activity on your account. Confirm your identity with OTP: 554632	2025-11-10 00:00:00	0	en
9940	تم استلام طلب تحويل كبير، لتأكيد الهوية أدخل الرمز 351857.	2025-11-10 00:00:00	0	ar
9941	Security alert: unauthorized login. Enter code 283690 to secure account.	2025-11-10 00:00:00	0	en
9943	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9945	Security alert: unauthorized login. Enter code 174287 to secure account.	2025-11-10 00:00:00	0	en
9950	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9951	Security alert: unauthorized login. Enter code 422147 to secure account.	2025-11-10 00:00:00	0	en
9954	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9960	عاجل: رجاء تحديث معلومات بطاقة الخصم عبر <URL> لتفادي قطع الخدمة.	2025-11-10 00:00:00	0	ar
9963	We couldn't process your recent payment. Confirm by entering OTP 470705 now.	2025-11-10 00:00:00	0	en
9966	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9969	A transfer of $7079.01 was made from your account. If this wasn't you click <URL>	2025-11-10 00:00:00	0	en
9970	We detected unusual activity on your account. Confirm your identity with OTP: 698152	2025-11-10 00:00:00	0	en
9971	رسالة من البنك: نحتاج تحديث معلوماتك البنكية، اضغط هنا: <URL>	2025-11-10 00:00:00	0	ar
9972	Your bank account has been suspended. Verify immediately at <URL> to restore access.	2025-11-10 00:00:00	0	en
9973	تم تعليق حسابك البنكي. الرجاء التحقق فورًا عبر <URL> لاستعادة الوصول.	2025-11-10 00:00:00	0	ar
9974	كشفنا عن نشاط غير عادي على حسابك. أكد هويتك باستخدام رمز: 500661	2025-11-10 00:00:00	0	ar
9975	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9976	Security alert: unauthorized login. Enter code 536425 to secure account.	2025-11-10 00:00:00	0	en
9978	تنبيه: تم إجراء عملية شراء بمبلغ 1772.15. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9979	تم تحويل مبلغ 5921.55 من حسابك. إن لم تكن أنت اضغط على <URL>	2025-11-10 00:00:00	0	ar
9981	قم بتحديث بياناتك البنكية الآن لتجنب إغلاق الحساب: <URL>	2025-11-10 00:00:00	0	ar
9982	Immediate action required: Verify your account details at <URL> or be charged.	2025-11-10 00:00:00	0	en
9989	Claim refund now by entering your account number at <URL>	2025-11-10 00:00:00	0	en
9993	Important: Your debit card ending with 7422 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
9995	Update your bank details now to avoid account closure: <URL>	2025-11-10 00:00:00	0	en
9996	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
9997	We couldn't process your recent payment. Confirm by entering OTP 819727 now.	2025-11-10 00:00:00	0	en
9998	تنبيه: تم إجراء عملية شراء بمبلغ 7374.94. إذا لم تكن أنت تواصل معنا.	2025-11-10 00:00:00	0	ar
9999	Important: Your debit card ending with 2665 has been blocked. Verify at <URL>	2025-11-10 00:00:00	0	en
10000	استلم المبلغ عبر إدخال رقم حسابك في الرابط التالي: <URL>	2025-11-10 00:00:00	0	ar
1	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4	Your transaction of $7651.14 at STORE was successful. Ref: 2439.	2025-11-10 00:00:00	\N	en
5	Your debit card ending 6088 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6	ستنتهي صلاحية بطاقتك المنتهية بـ 8633 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7	Dear customer, your account balance is $1474.70. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9	تذكير: قسط القرض بقيمة 1843.08 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
11	عزيزي العميل، رصيد حسابك هو 5669.66. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
16	التحويل المجدول اكتمل بنجاح. مرجع: 6031.	2025-11-10 00:00:00	\N	ar
17	Your online transfer of $5825.33 to account 5362 was successful.	2025-11-10 00:00:00	\N	en
21	تنبيه: بطاقتك المنتهية بـ 2282 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
22	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
23	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
27	Your OTP for transaction is 505495. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
28	Reminder: Your loan payment of $1562.57 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
30	Your transaction of $6805.48 at STORE was successful. Ref: 8293.	2025-11-10 00:00:00	\N	en
32	تذكير: قسط القرض بقيمة 2488.56 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
35	Dear customer, your account balance is $4898.39. Visit our branch for details.	2025-11-10 00:00:00	\N	en
37	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
40	Your debit card ending 5713 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
41	Your transaction of $4934.14 at STORE was successful. Ref: 7790.	2025-11-10 00:00:00	\N	en
42	Your scheduled transfer completed successfully. Ref: 1807.	2025-11-10 00:00:00	\N	en
43	Your scheduled transfer completed successfully. Ref: 6644.	2025-11-10 00:00:00	\N	en
44	Notification: Your card ending with 6555 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
46	Payment of $7268.24 received to your account ending with 2461. Thank you.	2025-11-10 00:00:00	\N	en
49	Your online transfer of $8089.26 to account 5631 was successful.	2025-11-10 00:00:00	\N	en
50	Reminder: Your loan payment of $7648.54 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
51	تذكير: قسط القرض بقيمة 1602.68 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
54	تم استلام دفعة بقيمة 8069.53 في حسابك المنتهي بـ 1967. شكرًا لك.	2025-11-10 00:00:00	\N	ar
55	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
57	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
62	عزيزي العميل، رصيد حسابك هو 8584.01. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
63	ستنتهي صلاحية بطاقتك المنتهية بـ 9064 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
65	عزيزي العميل، رصيد حسابك هو 9717.42. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
66	Your debit card ending 7552 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
67	ستنتهي صلاحية بطاقتك المنتهية بـ 7369 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
68	Your online transfer of $8834.43 to account 9954 was successful.	2025-11-10 00:00:00	\N	en
69	التحويل المجدول اكتمل بنجاح. مرجع: 2307.	2025-11-10 00:00:00	\N	ar
70	التحويل المجدول اكتمل بنجاح. مرجع: 9253.	2025-11-10 00:00:00	\N	ar
72	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
75	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
76	عزيزي العميل، رصيد حسابك هو 1439.28. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
77	ستنتهي صلاحية بطاقتك المنتهية بـ 9695 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
78	Your online transfer of $9800.93 to account 9003 was successful.	2025-11-10 00:00:00	\N	en
79	Dear customer, your account balance is $3323.41. Visit our branch for details.	2025-11-10 00:00:00	\N	en
83	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
86	Your OTP for transaction is 158674. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
87	Your scheduled transfer completed successfully. Ref: 1778.	2025-11-10 00:00:00	\N	en
89	Your transaction of $5307.61 at STORE was successful. Ref: 1951.	2025-11-10 00:00:00	\N	en
93	Your scheduled transfer completed successfully. Ref: 7556.	2025-11-10 00:00:00	\N	en
94	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
96	Notification: Your card ending with 2025 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
97	تم استلام دفعة بقيمة 1399.97 في حسابك المنتهي بـ 4876. شكرًا لك.	2025-11-10 00:00:00	\N	ar
101	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
102	عزيزي العميل، رصيد حسابك هو 6119.08. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
104	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
105	تنبيه: بطاقتك المنتهية بـ 6411 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
109	التحويل المجدول اكتمل بنجاح. مرجع: 7341.	2025-11-10 00:00:00	\N	ar
112	التحويل المجدول اكتمل بنجاح. مرجع: 9051.	2025-11-10 00:00:00	\N	ar
114	تذكير: قسط القرض بقيمة 1742.53 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
115	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
119	رمز التحقق لعملية الدفع هو 941379. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
120	تنبيه: بطاقتك المنتهية بـ 5415 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
121	Dear customer, your account balance is $8172.75. Visit our branch for details.	2025-11-10 00:00:00	\N	en
124	Payment of $5197.69 received to your account ending with 3024. Thank you.	2025-11-10 00:00:00	\N	en
125	رمز التحقق لعملية الدفع هو 186240. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
129	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
130	التحويل المجدول اكتمل بنجاح. مرجع: 4074.	2025-11-10 00:00:00	\N	ar
132	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
135	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
137	Payment of $2883.20 received to your account ending with 3584. Thank you.	2025-11-10 00:00:00	\N	en
139	Your scheduled transfer completed successfully. Ref: 5054.	2025-11-10 00:00:00	\N	en
141	تم استلام دفعة بقيمة 592.84 في حسابك المنتهي بـ 3254. شكرًا لك.	2025-11-10 00:00:00	\N	ar
142	Notification: Your card ending with 9459 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
143	ستنتهي صلاحية بطاقتك المنتهية بـ 3147 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
144	Payment of $45.58 received to your account ending with 9650. Thank you.	2025-11-10 00:00:00	\N	en
146	تنبيه: بطاقتك المنتهية بـ 3336 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
148	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
150	عزيزي العميل، رصيد حسابك هو 5874.67. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
153	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
158	Your scheduled transfer completed successfully. Ref: 4747.	2025-11-10 00:00:00	\N	en
159	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
160	Notification: Your card ending with 1643 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
163	تنبيه: بطاقتك المنتهية بـ 2074 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
168	تم استلام دفعة بقيمة 399.35 في حسابك المنتهي بـ 6180. شكرًا لك.	2025-11-10 00:00:00	\N	ar
169	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
170	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
174	Your OTP for transaction is 608810. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
176	تم استلام دفعة بقيمة 1137.68 في حسابك المنتهي بـ 1160. شكرًا لك.	2025-11-10 00:00:00	\N	ar
177	عزيزي العميل، رصيد حسابك هو 6081.98. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
181	Your OTP for transaction is 507079. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
182	رمز التحقق لعملية الدفع هو 706344. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
183	رمز التحقق لعملية الدفع هو 422482. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
185	عزيزي العميل، رصيد حسابك هو 4408.22. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
189	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
190	عزيزي العميل، رصيد حسابك هو 7406.27. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
191	Payment of $7619.93 received to your account ending with 4344. Thank you.	2025-11-10 00:00:00	\N	en
193	تنبيه: بطاقتك المنتهية بـ 7986 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
199	Your debit card ending 4795 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
201	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
203	التحويل المجدول اكتمل بنجاح. مرجع: 6994.	2025-11-10 00:00:00	\N	ar
206	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
210	تنبيه: بطاقتك المنتهية بـ 2677 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
211	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
212	Reminder: Your loan payment of $8621.80 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
213	ستنتهي صلاحية بطاقتك المنتهية بـ 3680 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
215	Your transaction of $9431.79 at STORE was successful. Ref: 6656.	2025-11-10 00:00:00	\N	en
216	عزيزي العميل، رصيد حسابك هو 5968.15. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
218	ستنتهي صلاحية بطاقتك المنتهية بـ 1530 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
220	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
222	Reminder: Your loan payment of $6591.56 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
223	رمز التحقق لعملية الدفع هو 579657. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
227	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
229	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
238	عزيزي العميل، رصيد حسابك هو 3348.02. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
239	Dear customer, your account balance is $326.99. Visit our branch for details.	2025-11-10 00:00:00	\N	en
240	تم استلام دفعة بقيمة 6599.37 في حسابك المنتهي بـ 5212. شكرًا لك.	2025-11-10 00:00:00	\N	ar
242	Your OTP for transaction is 227195. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
243	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
244	التحويل المجدول اكتمل بنجاح. مرجع: 6651.	2025-11-10 00:00:00	\N	ar
246	تمت عملية بقيمة 4129.21 في المتجر. مرجع: 8585.	2025-11-10 00:00:00	\N	ar
247	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
249	تذكير: قسط القرض بقيمة 2036.59 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
250	تذكير: قسط القرض بقيمة 2932.51 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
251	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
252	Your debit card ending 9277 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
254	Reminder: Your loan payment of $6578.55 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
255	تذكير: قسط القرض بقيمة 6568.72 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
256	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
257	تمت عملية بقيمة 8372.33 في المتجر. مرجع: 9270.	2025-11-10 00:00:00	\N	ar
259	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
260	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
261	Your transaction of $6513.54 at STORE was successful. Ref: 6677.	2025-11-10 00:00:00	\N	en
262	التحويل المجدول اكتمل بنجاح. مرجع: 1283.	2025-11-10 00:00:00	\N	ar
264	Dear customer, your account balance is $8116.31. Visit our branch for details.	2025-11-10 00:00:00	\N	en
265	ستنتهي صلاحية بطاقتك المنتهية بـ 4968 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
266	رمز التحقق لعملية الدفع هو 701491. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
268	Notification: Your card ending with 2055 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
269	تم استلام دفعة بقيمة 2219.07 في حسابك المنتهي بـ 2758. شكرًا لك.	2025-11-10 00:00:00	\N	ar
272	تمت عملية بقيمة 3455.35 في المتجر. مرجع: 1680.	2025-11-10 00:00:00	\N	ar
277	Your transaction of $9657.08 at STORE was successful. Ref: 8620.	2025-11-10 00:00:00	\N	en
278	Your debit card ending 1544 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
279	Your transaction of $3144.59 at STORE was successful. Ref: 3160.	2025-11-10 00:00:00	\N	en
280	Your scheduled transfer completed successfully. Ref: 2089.	2025-11-10 00:00:00	\N	en
283	رمز التحقق لعملية الدفع هو 957275. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
288	Your scheduled transfer completed successfully. Ref: 3394.	2025-11-10 00:00:00	\N	en
289	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
291	Your transaction of $964.89 at STORE was successful. Ref: 2311.	2025-11-10 00:00:00	\N	en
292	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
293	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
295	Your debit card ending 7109 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
296	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
297	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
298	Dear customer, your account balance is $1849.27. Visit our branch for details.	2025-11-10 00:00:00	\N	en
299	تنبيه: بطاقتك المنتهية بـ 2934 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
301	Your debit card ending 1980 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
302	Your transaction of $6891.48 at STORE was successful. Ref: 9513.	2025-11-10 00:00:00	\N	en
303	Reminder: Your loan payment of $8574.89 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
304	تذكير: قسط القرض بقيمة 1680.46 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
306	Your online transfer of $8821.29 to account 9673 was successful.	2025-11-10 00:00:00	\N	en
307	Your online transfer of $4750.60 to account 2580 was successful.	2025-11-10 00:00:00	\N	en
309	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
310	تذكير: قسط القرض بقيمة 5467.55 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
311	Your OTP for transaction is 566050. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
313	Your OTP for transaction is 737683. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
314	Notification: Your card ending with 1046 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
316	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
317	رمز التحقق لعملية الدفع هو 165485. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
320	رمز التحقق لعملية الدفع هو 542704. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
321	تنبيه: بطاقتك المنتهية بـ 9097 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
322	تم استلام دفعة بقيمة 9303.21 في حسابك المنتهي بـ 8418. شكرًا لك.	2025-11-10 00:00:00	\N	ar
323	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
324	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
325	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
326	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
327	Your OTP for transaction is 859478. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
328	Payment of $1886.77 received to your account ending with 2605. Thank you.	2025-11-10 00:00:00	\N	en
329	تمت عملية بقيمة 5044.04 في المتجر. مرجع: 4925.	2025-11-10 00:00:00	\N	ar
332	Your online transfer of $7611.94 to account 3810 was successful.	2025-11-10 00:00:00	\N	en
333	تمت عملية بقيمة 450.45 في المتجر. مرجع: 5008.	2025-11-10 00:00:00	\N	ar
338	التحويل المجدول اكتمل بنجاح. مرجع: 6673.	2025-11-10 00:00:00	\N	ar
340	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
342	Your transaction of $2925.44 at STORE was successful. Ref: 7108.	2025-11-10 00:00:00	\N	en
345	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
346	Your transaction of $8389.85 at STORE was successful. Ref: 5025.	2025-11-10 00:00:00	\N	en
347	التحويل المجدول اكتمل بنجاح. مرجع: 8298.	2025-11-10 00:00:00	\N	ar
349	التحويل المجدول اكتمل بنجاح. مرجع: 4985.	2025-11-10 00:00:00	\N	ar
350	ستنتهي صلاحية بطاقتك المنتهية بـ 2899 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
351	Your OTP for transaction is 844654. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
354	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
355	Your transaction of $9767.87 at STORE was successful. Ref: 9152.	2025-11-10 00:00:00	\N	en
357	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
362	Payment of $8982.74 received to your account ending with 9006. Thank you.	2025-11-10 00:00:00	\N	en
365	ستنتهي صلاحية بطاقتك المنتهية بـ 9865 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
366	Your scheduled transfer completed successfully. Ref: 9729.	2025-11-10 00:00:00	\N	en
367	Reminder: Your loan payment of $4812.45 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
368	Your transaction of $1064.73 at STORE was successful. Ref: 1955.	2025-11-10 00:00:00	\N	en
370	Your scheduled transfer completed successfully. Ref: 5519.	2025-11-10 00:00:00	\N	en
375	Reminder: Your loan payment of $4849.05 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
376	ستنتهي صلاحية بطاقتك المنتهية بـ 6651 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
377	رمز التحقق لعملية الدفع هو 565049. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
378	تم استلام دفعة بقيمة 2530.36 في حسابك المنتهي بـ 3697. شكرًا لك.	2025-11-10 00:00:00	\N	ar
380	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
382	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
383	تمت عملية بقيمة 5399.79 في المتجر. مرجع: 4128.	2025-11-10 00:00:00	\N	ar
384	Dear customer, your account balance is $9648.37. Visit our branch for details.	2025-11-10 00:00:00	\N	en
385	التحويل المجدول اكتمل بنجاح. مرجع: 7028.	2025-11-10 00:00:00	\N	ar
390	تم استلام دفعة بقيمة 4816.99 في حسابك المنتهي بـ 3368. شكرًا لك.	2025-11-10 00:00:00	\N	ar
391	تم استلام دفعة بقيمة 6669.30 في حسابك المنتهي بـ 1567. شكرًا لك.	2025-11-10 00:00:00	\N	ar
395	Your OTP for transaction is 256722. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
396	تذكير: قسط القرض بقيمة 2285.31 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
401	ستنتهي صلاحية بطاقتك المنتهية بـ 3834 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
403	Your OTP for transaction is 771569. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
405	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
407	Notification: Your card ending with 2844 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
408	Your scheduled transfer completed successfully. Ref: 9692.	2025-11-10 00:00:00	\N	en
411	ستنتهي صلاحية بطاقتك المنتهية بـ 4117 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
412	Your debit card ending 2255 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
414	تمت عملية بقيمة 2065.50 في المتجر. مرجع: 8069.	2025-11-10 00:00:00	\N	ar
415	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
418	Your OTP for transaction is 456935. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
432	تم استلام دفعة بقيمة 9647.85 في حسابك المنتهي بـ 2731. شكرًا لك.	2025-11-10 00:00:00	\N	ar
434	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
438	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
441	التحويل المجدول اكتمل بنجاح. مرجع: 7864.	2025-11-10 00:00:00	\N	ar
443	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
445	Your scheduled transfer completed successfully. Ref: 1275.	2025-11-10 00:00:00	\N	en
447	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
448	Your online transfer of $2714.07 to account 2011 was successful.	2025-11-10 00:00:00	\N	en
449	Your OTP for transaction is 909459. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
450	Your debit card ending 7680 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
452	تنبيه: بطاقتك المنتهية بـ 4795 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
453	Notification: Your card ending with 4277 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
454	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
455	Your OTP for transaction is 936864. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
462	التحويل المجدول اكتمل بنجاح. مرجع: 8354.	2025-11-10 00:00:00	\N	ar
466	التحويل المجدول اكتمل بنجاح. مرجع: 9966.	2025-11-10 00:00:00	\N	ar
467	Reminder: Your loan payment of $1865.70 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
468	Notification: Your card ending with 6213 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
469	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
470	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
472	ستنتهي صلاحية بطاقتك المنتهية بـ 5719 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
476	تذكير: قسط القرض بقيمة 2948.87 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
477	ستنتهي صلاحية بطاقتك المنتهية بـ 6497 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
478	Notification: Your card ending with 5211 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
481	Payment of $5309.13 received to your account ending with 7118. Thank you.	2025-11-10 00:00:00	\N	en
482	Your OTP for transaction is 598613. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
483	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
486	ستنتهي صلاحية بطاقتك المنتهية بـ 5187 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
490	التحويل المجدول اكتمل بنجاح. مرجع: 8728.	2025-11-10 00:00:00	\N	ar
493	التحويل المجدول اكتمل بنجاح. مرجع: 4344.	2025-11-10 00:00:00	\N	ar
498	تمت عملية بقيمة 8608.95 في المتجر. مرجع: 8839.	2025-11-10 00:00:00	\N	ar
499	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
507	Dear customer, your account balance is $3105.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
508	Your online transfer of $1284.00 to account 6627 was successful.	2025-11-10 00:00:00	\N	en
512	تمت عملية بقيمة 171.63 في المتجر. مرجع: 2040.	2025-11-10 00:00:00	\N	ar
513	تمت عملية بقيمة 4384.60 في المتجر. مرجع: 2843.	2025-11-10 00:00:00	\N	ar
514	Your online transfer of $5325.68 to account 5322 was successful.	2025-11-10 00:00:00	\N	en
516	Your OTP for transaction is 138866. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
517	عزيزي العميل، رصيد حسابك هو 3572.20. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
519	Payment of $2191.18 received to your account ending with 1381. Thank you.	2025-11-10 00:00:00	\N	en
522	Your online transfer of $9742.19 to account 5507 was successful.	2025-11-10 00:00:00	\N	en
523	Your scheduled transfer completed successfully. Ref: 2145.	2025-11-10 00:00:00	\N	en
526	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
527	رمز التحقق لعملية الدفع هو 377426. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
531	رمز التحقق لعملية الدفع هو 407590. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
532	Your online transfer of $1995.54 to account 9936 was successful.	2025-11-10 00:00:00	\N	en
535	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
538	Your online transfer of $4849.50 to account 7590 was successful.	2025-11-10 00:00:00	\N	en
539	تنبيه: بطاقتك المنتهية بـ 2098 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
541	Your transaction of $1228.34 at STORE was successful. Ref: 3390.	2025-11-10 00:00:00	\N	en
542	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
543	التحويل المجدول اكتمل بنجاح. مرجع: 4895.	2025-11-10 00:00:00	\N	ar
544	Dear customer, your account balance is $3496.01. Visit our branch for details.	2025-11-10 00:00:00	\N	en
545	Your online transfer of $6155.01 to account 6015 was successful.	2025-11-10 00:00:00	\N	en
546	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
547	تمت عملية بقيمة 2059.34 في المتجر. مرجع: 4937.	2025-11-10 00:00:00	\N	ar
549	التحويل المجدول اكتمل بنجاح. مرجع: 9405.	2025-11-10 00:00:00	\N	ar
551	تم استلام دفعة بقيمة 5575.57 في حسابك المنتهي بـ 2274. شكرًا لك.	2025-11-10 00:00:00	\N	ar
552	Payment of $5472.18 received to your account ending with 3340. Thank you.	2025-11-10 00:00:00	\N	en
553	Your OTP for transaction is 943703. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
554	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
557	تنبيه: بطاقتك المنتهية بـ 7724 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
559	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
560	تذكير: قسط القرض بقيمة 5443.25 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
563	تمت عملية بقيمة 9858.49 في المتجر. مرجع: 9237.	2025-11-10 00:00:00	\N	ar
567	التحويل المجدول اكتمل بنجاح. مرجع: 9019.	2025-11-10 00:00:00	\N	ar
569	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
570	تم استلام دفعة بقيمة 6488.07 في حسابك المنتهي بـ 7922. شكرًا لك.	2025-11-10 00:00:00	\N	ar
573	Your debit card ending 6366 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
574	Dear customer, your account balance is $8362.28. Visit our branch for details.	2025-11-10 00:00:00	\N	en
576	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
577	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
581	Dear customer, your account balance is $632.83. Visit our branch for details.	2025-11-10 00:00:00	\N	en
586	التحويل المجدول اكتمل بنجاح. مرجع: 3579.	2025-11-10 00:00:00	\N	ar
589	Dear customer, your account balance is $5053.71. Visit our branch for details.	2025-11-10 00:00:00	\N	en
590	تذكير: قسط القرض بقيمة 382.78 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
591	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
596	Your debit card ending 3081 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
597	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
598	تمت عملية بقيمة 1043.56 في المتجر. مرجع: 4039.	2025-11-10 00:00:00	\N	ar
599	تمت عملية بقيمة 7339.81 في المتجر. مرجع: 2672.	2025-11-10 00:00:00	\N	ar
600	Payment of $555.72 received to your account ending with 4044. Thank you.	2025-11-10 00:00:00	\N	en
604	رمز التحقق لعملية الدفع هو 811425. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
605	Your debit card ending 6982 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
606	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
607	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
608	عزيزي العميل، رصيد حسابك هو 3514.54. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
609	Notification: Your card ending with 3446 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
610	تذكير: قسط القرض بقيمة 6828.94 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
611	ستنتهي صلاحية بطاقتك المنتهية بـ 7486 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
616	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
617	تم استلام دفعة بقيمة 2523.57 في حسابك المنتهي بـ 6921. شكرًا لك.	2025-11-10 00:00:00	\N	ar
624	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
625	Your scheduled transfer completed successfully. Ref: 4636.	2025-11-10 00:00:00	\N	en
627	ستنتهي صلاحية بطاقتك المنتهية بـ 1776 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
630	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
632	Notification: Your card ending with 1517 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
635	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
636	التحويل المجدول اكتمل بنجاح. مرجع: 9524.	2025-11-10 00:00:00	\N	ar
641	ستنتهي صلاحية بطاقتك المنتهية بـ 9730 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
642	Reminder: Your loan payment of $2669.84 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
643	Your debit card ending 9533 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
645	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
646	Reminder: Your loan payment of $9343.39 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
647	Your transaction of $6914.98 at STORE was successful. Ref: 8426.	2025-11-10 00:00:00	\N	en
649	التحويل المجدول اكتمل بنجاح. مرجع: 2196.	2025-11-10 00:00:00	\N	ar
650	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
651	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
652	تم استلام دفعة بقيمة 4117.13 في حسابك المنتهي بـ 1858. شكرًا لك.	2025-11-10 00:00:00	\N	ar
654	التحويل المجدول اكتمل بنجاح. مرجع: 7185.	2025-11-10 00:00:00	\N	ar
656	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
657	Your OTP for transaction is 206643. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
660	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
661	تم استلام دفعة بقيمة 3271.03 في حسابك المنتهي بـ 7899. شكرًا لك.	2025-11-10 00:00:00	\N	ar
663	Your debit card ending 8422 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
665	رمز التحقق لعملية الدفع هو 566198. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
666	Notification: Your card ending with 4008 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
670	تم استلام دفعة بقيمة 8084.22 في حسابك المنتهي بـ 3495. شكرًا لك.	2025-11-10 00:00:00	\N	ar
671	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
672	تنبيه: بطاقتك المنتهية بـ 4461 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
673	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
675	Your online transfer of $440.26 to account 9410 was successful.	2025-11-10 00:00:00	\N	en
676	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
677	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
678	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
679	تم استلام دفعة بقيمة 9856.61 في حسابك المنتهي بـ 3630. شكرًا لك.	2025-11-10 00:00:00	\N	ar
683	التحويل المجدول اكتمل بنجاح. مرجع: 9030.	2025-11-10 00:00:00	\N	ar
684	Your OTP for transaction is 809978. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
686	تنبيه: بطاقتك المنتهية بـ 7569 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
687	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
689	Payment of $8162.34 received to your account ending with 7688. Thank you.	2025-11-10 00:00:00	\N	en
692	ستنتهي صلاحية بطاقتك المنتهية بـ 6549 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
695	التحويل المجدول اكتمل بنجاح. مرجع: 1303.	2025-11-10 00:00:00	\N	ar
697	تنبيه: بطاقتك المنتهية بـ 8099 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
698	تم استلام دفعة بقيمة 9122.23 في حسابك المنتهي بـ 1342. شكرًا لك.	2025-11-10 00:00:00	\N	ar
699	Your debit card ending 3915 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
700	Your OTP for transaction is 513440. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
701	Your OTP for transaction is 713192. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
703	Your online transfer of $2773.89 to account 1241 was successful.	2025-11-10 00:00:00	\N	en
704	تمت عملية بقيمة 9602.77 في المتجر. مرجع: 4593.	2025-11-10 00:00:00	\N	ar
707	Your transaction of $6645.18 at STORE was successful. Ref: 5674.	2025-11-10 00:00:00	\N	en
710	عزيزي العميل، رصيد حسابك هو 9648.02. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
712	Notification: Your card ending with 4471 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
715	التحويل المجدول اكتمل بنجاح. مرجع: 3211.	2025-11-10 00:00:00	\N	ar
716	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
718	Your transaction of $3500.51 at STORE was successful. Ref: 6443.	2025-11-10 00:00:00	\N	en
722	عزيزي العميل، رصيد حسابك هو 7507.97. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
723	عزيزي العميل، رصيد حسابك هو 2431.44. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
725	تذكير: قسط القرض بقيمة 91.05 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
726	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
727	تم استلام دفعة بقيمة 1890.04 في حسابك المنتهي بـ 6705. شكرًا لك.	2025-11-10 00:00:00	\N	ar
730	Your scheduled transfer completed successfully. Ref: 1940.	2025-11-10 00:00:00	\N	en
731	تذكير: قسط القرض بقيمة 1122.23 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
732	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
733	Payment of $4808.44 received to your account ending with 9390. Thank you.	2025-11-10 00:00:00	\N	en
734	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
735	Reminder: Your loan payment of $5778.05 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
736	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
739	تم استلام دفعة بقيمة 9650.75 في حسابك المنتهي بـ 6883. شكرًا لك.	2025-11-10 00:00:00	\N	ar
740	Payment of $9989.39 received to your account ending with 9352. Thank you.	2025-11-10 00:00:00	\N	en
748	ستنتهي صلاحية بطاقتك المنتهية بـ 3678 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
749	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
750	Your OTP for transaction is 950549. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
752	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
753	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
755	ستنتهي صلاحية بطاقتك المنتهية بـ 6794 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
758	Your debit card ending 5720 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
759	Payment of $9949.29 received to your account ending with 5115. Thank you.	2025-11-10 00:00:00	\N	en
760	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
764	Reminder: Your loan payment of $8251.34 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
766	رمز التحقق لعملية الدفع هو 777072. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
767	Notification: Your card ending with 4429 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
768	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
770	Your online transfer of $235.08 to account 2308 was successful.	2025-11-10 00:00:00	\N	en
771	Your transaction of $9586.48 at STORE was successful. Ref: 7262.	2025-11-10 00:00:00	\N	en
772	تنبيه: بطاقتك المنتهية بـ 6184 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
773	Your online transfer of $5757.09 to account 6008 was successful.	2025-11-10 00:00:00	\N	en
775	تذكير: قسط القرض بقيمة 7101.30 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
779	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
782	Your transaction of $7004.12 at STORE was successful. Ref: 8537.	2025-11-10 00:00:00	\N	en
783	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
785	Your online transfer of $2289.04 to account 6787 was successful.	2025-11-10 00:00:00	\N	en
789	Notification: Your card ending with 7118 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
790	عزيزي العميل، رصيد حسابك هو 2930.52. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
793	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
795	Notification: Your card ending with 7043 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
797	Notification: Your card ending with 3669 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
801	Payment of $3736.66 received to your account ending with 3536. Thank you.	2025-11-10 00:00:00	\N	en
803	تم استلام دفعة بقيمة 2347.26 في حسابك المنتهي بـ 5420. شكرًا لك.	2025-11-10 00:00:00	\N	ar
805	Your OTP for transaction is 295010. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
806	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
809	Your scheduled transfer completed successfully. Ref: 3037.	2025-11-10 00:00:00	\N	en
810	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
811	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
814	تم استلام دفعة بقيمة 5374.53 في حسابك المنتهي بـ 4270. شكرًا لك.	2025-11-10 00:00:00	\N	ar
816	Your transaction of $455.83 at STORE was successful. Ref: 3884.	2025-11-10 00:00:00	\N	en
820	Your debit card ending 2294 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
821	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
823	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
826	التحويل المجدول اكتمل بنجاح. مرجع: 1826.	2025-11-10 00:00:00	\N	ar
827	تذكير: قسط القرض بقيمة 1248.69 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
828	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
829	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
830	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
833	Dear customer, your account balance is $2514.00. Visit our branch for details.	2025-11-10 00:00:00	\N	en
835	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
836	Your online transfer of $1029.14 to account 5581 was successful.	2025-11-10 00:00:00	\N	en
839	عزيزي العميل، رصيد حسابك هو 4405.12. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
842	ستنتهي صلاحية بطاقتك المنتهية بـ 9779 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
844	Notification: Your card ending with 5328 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
845	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
846	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
847	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
848	Notification: Your card ending with 7780 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
849	Payment of $2325.66 received to your account ending with 6164. Thank you.	2025-11-10 00:00:00	\N	en
853	عزيزي العميل، رصيد حسابك هو 5156.93. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
854	Your transaction of $1862.05 at STORE was successful. Ref: 1281.	2025-11-10 00:00:00	\N	en
857	Your online transfer of $3241.03 to account 2760 was successful.	2025-11-10 00:00:00	\N	en
858	تم استلام دفعة بقيمة 7738.14 في حسابك المنتهي بـ 6941. شكرًا لك.	2025-11-10 00:00:00	\N	ar
860	تنبيه: بطاقتك المنتهية بـ 4999 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
862	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
864	Your online transfer of $3151.52 to account 3441 was successful.	2025-11-10 00:00:00	\N	en
865	Your debit card ending 7555 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
866	تنبيه: بطاقتك المنتهية بـ 8665 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
867	Your transaction of $6955.36 at STORE was successful. Ref: 7879.	2025-11-10 00:00:00	\N	en
871	Your OTP for transaction is 386021. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
872	التحويل المجدول اكتمل بنجاح. مرجع: 1391.	2025-11-10 00:00:00	\N	ar
873	عزيزي العميل، رصيد حسابك هو 3712.75. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
874	Payment of $2206.18 received to your account ending with 4408. Thank you.	2025-11-10 00:00:00	\N	en
875	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
878	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
879	Your OTP for transaction is 157782. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
882	Payment of $744.14 received to your account ending with 1910. Thank you.	2025-11-10 00:00:00	\N	en
883	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
884	Dear customer, your account balance is $4773.17. Visit our branch for details.	2025-11-10 00:00:00	\N	en
885	التحويل المجدول اكتمل بنجاح. مرجع: 8165.	2025-11-10 00:00:00	\N	ar
886	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
888	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
889	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
892	ستنتهي صلاحية بطاقتك المنتهية بـ 5190 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
894	Payment of $4199.68 received to your account ending with 2184. Thank you.	2025-11-10 00:00:00	\N	en
895	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
896	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
898	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
901	تمت عملية بقيمة 8469.97 في المتجر. مرجع: 3024.	2025-11-10 00:00:00	\N	ar
902	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
903	Notification: Your card ending with 3914 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
905	Your OTP for transaction is 230870. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
907	Payment of $7059.25 received to your account ending with 9572. Thank you.	2025-11-10 00:00:00	\N	en
911	Payment of $2777.83 received to your account ending with 8202. Thank you.	2025-11-10 00:00:00	\N	en
912	Your online transfer of $4512.14 to account 9626 was successful.	2025-11-10 00:00:00	\N	en
913	تذكير: قسط القرض بقيمة 2347.71 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
914	Your transaction of $1199.40 at STORE was successful. Ref: 9957.	2025-11-10 00:00:00	\N	en
918	عزيزي العميل، رصيد حسابك هو 5859.12. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
919	Payment of $2251.33 received to your account ending with 8671. Thank you.	2025-11-10 00:00:00	\N	en
920	رمز التحقق لعملية الدفع هو 876667. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
921	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
924	Dear customer, your account balance is $1920.02. Visit our branch for details.	2025-11-10 00:00:00	\N	en
925	عزيزي العميل، رصيد حسابك هو 181.87. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
927	Dear customer, your account balance is $8858.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
928	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
930	التحويل المجدول اكتمل بنجاح. مرجع: 6657.	2025-11-10 00:00:00	\N	ar
931	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
933	Your transaction of $9618.14 at STORE was successful. Ref: 4134.	2025-11-10 00:00:00	\N	en
934	Your online transfer of $8554.54 to account 8286 was successful.	2025-11-10 00:00:00	\N	en
936	Your OTP for transaction is 128033. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
938	Your transaction of $1071.23 at STORE was successful. Ref: 1804.	2025-11-10 00:00:00	\N	en
943	التحويل المجدول اكتمل بنجاح. مرجع: 6002.	2025-11-10 00:00:00	\N	ar
945	تم استلام دفعة بقيمة 9283.97 في حسابك المنتهي بـ 7293. شكرًا لك.	2025-11-10 00:00:00	\N	ar
946	تم استلام دفعة بقيمة 7639.35 في حسابك المنتهي بـ 2400. شكرًا لك.	2025-11-10 00:00:00	\N	ar
947	تنبيه: بطاقتك المنتهية بـ 4124 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
948	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
949	ستنتهي صلاحية بطاقتك المنتهية بـ 3493 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
950	التحويل المجدول اكتمل بنجاح. مرجع: 7266.	2025-11-10 00:00:00	\N	ar
952	عزيزي العميل، رصيد حسابك هو 1096.03. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
956	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
958	تذكير: قسط القرض بقيمة 3580.36 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
960	Notification: Your card ending with 7996 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
961	Notification: Your card ending with 6496 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
962	Your scheduled transfer completed successfully. Ref: 7810.	2025-11-10 00:00:00	\N	en
963	Notification: Your card ending with 1913 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
965	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
967	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
971	رمز التحقق لعملية الدفع هو 972362. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
974	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
977	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
981	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
982	Your debit card ending 6633 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
984	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
987	تمت عملية بقيمة 9131.32 في المتجر. مرجع: 2126.	2025-11-10 00:00:00	\N	ar
988	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
993	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
994	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
999	رمز التحقق لعملية الدفع هو 747335. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1000	تذكير: قسط القرض بقيمة 8607.25 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1009	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1010	تنبيه: بطاقتك المنتهية بـ 8974 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1011	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1015	تم استلام دفعة بقيمة 6494.95 في حسابك المنتهي بـ 9290. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1019	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1020	تذكير: قسط القرض بقيمة 8000.67 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1023	تذكير: قسط القرض بقيمة 4318.79 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1027	التحويل المجدول اكتمل بنجاح. مرجع: 6447.	2025-11-10 00:00:00	\N	ar
1030	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1031	ستنتهي صلاحية بطاقتك المنتهية بـ 9575 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1032	Notification: Your card ending with 1578 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1035	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1037	تمت عملية بقيمة 4690.55 في المتجر. مرجع: 2793.	2025-11-10 00:00:00	\N	ar
1038	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1039	Reminder: Your loan payment of $1147.73 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1040	ستنتهي صلاحية بطاقتك المنتهية بـ 9303 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1043	Payment of $2990.77 received to your account ending with 5993. Thank you.	2025-11-10 00:00:00	\N	en
1044	Dear customer, your account balance is $625.34. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1045	تم استلام دفعة بقيمة 4907.67 في حسابك المنتهي بـ 3964. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1046	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1049	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1053	ستنتهي صلاحية بطاقتك المنتهية بـ 9228 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1054	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1056	Your debit card ending 4864 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1059	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1060	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1061	تم استلام دفعة بقيمة 7467.55 في حسابك المنتهي بـ 1990. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1063	Your transaction of $577.50 at STORE was successful. Ref: 6374.	2025-11-10 00:00:00	\N	en
1065	تمت عملية بقيمة 5021.04 في المتجر. مرجع: 3352.	2025-11-10 00:00:00	\N	ar
1066	رمز التحقق لعملية الدفع هو 461795. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1067	التحويل المجدول اكتمل بنجاح. مرجع: 2103.	2025-11-10 00:00:00	\N	ar
1068	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1078	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1080	Your transaction of $4315.01 at STORE was successful. Ref: 1730.	2025-11-10 00:00:00	\N	en
1081	ستنتهي صلاحية بطاقتك المنتهية بـ 4503 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1082	Your OTP for transaction is 669408. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1083	التحويل المجدول اكتمل بنجاح. مرجع: 5664.	2025-11-10 00:00:00	\N	ar
1084	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1088	Payment of $558.15 received to your account ending with 3388. Thank you.	2025-11-10 00:00:00	\N	en
1090	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1091	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1093	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1094	التحويل المجدول اكتمل بنجاح. مرجع: 7079.	2025-11-10 00:00:00	\N	ar
1096	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1098	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1100	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1103	ستنتهي صلاحية بطاقتك المنتهية بـ 3414 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1105	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1106	تذكير: قسط القرض بقيمة 8937.92 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1108	Your transaction of $9796.61 at STORE was successful. Ref: 9130.	2025-11-10 00:00:00	\N	en
1109	رمز التحقق لعملية الدفع هو 356114. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1113	Your OTP for transaction is 556412. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1115	Your debit card ending 7870 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1116	Your transaction of $9644.51 at STORE was successful. Ref: 2677.	2025-11-10 00:00:00	\N	en
1117	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1119	Your online transfer of $9296.14 to account 8610 was successful.	2025-11-10 00:00:00	\N	en
1120	Your OTP for transaction is 238939. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1123	Notification: Your card ending with 7898 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1127	التحويل المجدول اكتمل بنجاح. مرجع: 7842.	2025-11-10 00:00:00	\N	ar
1128	تذكير: قسط القرض بقيمة 3338.81 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1129	Your debit card ending 2560 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1130	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1131	Dear customer, your account balance is $1154.99. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1133	Your transaction of $2638.89 at STORE was successful. Ref: 1529.	2025-11-10 00:00:00	\N	en
1135	تنبيه: بطاقتك المنتهية بـ 4026 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1136	رمز التحقق لعملية الدفع هو 837236. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1139	Reminder: Your loan payment of $9747.62 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1141	Dear customer, your account balance is $7333.18. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1142	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1143	Reminder: Your loan payment of $1578.83 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1144	تم استلام دفعة بقيمة 5566.37 في حسابك المنتهي بـ 3694. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1145	Your OTP for transaction is 910388. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1146	التحويل المجدول اكتمل بنجاح. مرجع: 8058.	2025-11-10 00:00:00	\N	ar
1149	تمت عملية بقيمة 8039.79 في المتجر. مرجع: 8881.	2025-11-10 00:00:00	\N	ar
1150	تنبيه: بطاقتك المنتهية بـ 8292 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1151	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1153	تذكير: قسط القرض بقيمة 6495.69 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1154	تذكير: قسط القرض بقيمة 9344.99 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1158	ستنتهي صلاحية بطاقتك المنتهية بـ 5099 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1162	تم استلام دفعة بقيمة 5183.89 في حسابك المنتهي بـ 3100. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1163	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1166	ستنتهي صلاحية بطاقتك المنتهية بـ 4143 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1169	ستنتهي صلاحية بطاقتك المنتهية بـ 5259 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1172	تم استلام دفعة بقيمة 5499.47 في حسابك المنتهي بـ 8614. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1177	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1181	Reminder: Your loan payment of $3455.21 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1184	Notification: Your card ending with 4210 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1186	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1187	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1188	Your online transfer of $8656.08 to account 1877 was successful.	2025-11-10 00:00:00	\N	en
1190	تم استلام دفعة بقيمة 6344.15 في حسابك المنتهي بـ 8503. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1191	تنبيه: بطاقتك المنتهية بـ 6513 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1192	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1194	عزيزي العميل، رصيد حسابك هو 2607.85. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1195	Dear customer, your account balance is $6985.67. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1197	تذكير: قسط القرض بقيمة 9818.20 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1199	Your OTP for transaction is 209382. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1204	Your online transfer of $3433.58 to account 5161 was successful.	2025-11-10 00:00:00	\N	en
1206	Payment of $3911.76 received to your account ending with 1899. Thank you.	2025-11-10 00:00:00	\N	en
1207	تمت عملية بقيمة 9804.05 في المتجر. مرجع: 6718.	2025-11-10 00:00:00	\N	ar
1211	Your scheduled transfer completed successfully. Ref: 7161.	2025-11-10 00:00:00	\N	en
1212	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1214	Your scheduled transfer completed successfully. Ref: 2478.	2025-11-10 00:00:00	\N	en
1216	عزيزي العميل، رصيد حسابك هو 6060.27. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1217	تمت عملية بقيمة 315.10 في المتجر. مرجع: 8666.	2025-11-10 00:00:00	\N	ar
1223	تنبيه: بطاقتك المنتهية بـ 8866 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1225	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1226	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1229	تم استلام دفعة بقيمة 9263.88 في حسابك المنتهي بـ 5246. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1230	Your OTP for transaction is 641273. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1232	Reminder: Your loan payment of $9548.37 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1233	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1234	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1237	تنبيه: بطاقتك المنتهية بـ 2801 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1238	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1240	Your scheduled transfer completed successfully. Ref: 2249.	2025-11-10 00:00:00	\N	en
1242	Your transaction of $8289.39 at STORE was successful. Ref: 2364.	2025-11-10 00:00:00	\N	en
1243	Your online transfer of $7637.63 to account 2018 was successful.	2025-11-10 00:00:00	\N	en
1244	Reminder: Your loan payment of $9369.22 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1246	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1247	Your online transfer of $3163.48 to account 7621 was successful.	2025-11-10 00:00:00	\N	en
1249	Dear customer, your account balance is $22.20. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1250	Notification: Your card ending with 4803 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1252	التحويل المجدول اكتمل بنجاح. مرجع: 7468.	2025-11-10 00:00:00	\N	ar
1255	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1256	التحويل المجدول اكتمل بنجاح. مرجع: 9606.	2025-11-10 00:00:00	\N	ar
1257	التحويل المجدول اكتمل بنجاح. مرجع: 8422.	2025-11-10 00:00:00	\N	ar
1259	عزيزي العميل، رصيد حسابك هو 7175.73. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1260	Payment of $5421.13 received to your account ending with 3743. Thank you.	2025-11-10 00:00:00	\N	en
1265	Your debit card ending 1691 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1269	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1270	تم استلام دفعة بقيمة 15.07 في حسابك المنتهي بـ 4609. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1273	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1275	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1277	Your transaction of $6279.34 at STORE was successful. Ref: 3842.	2025-11-10 00:00:00	\N	en
1279	Dear customer, your account balance is $9974.06. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1280	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1281	Your OTP for transaction is 788723. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1284	Notification: Your card ending with 9219 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1285	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1286	التحويل المجدول اكتمل بنجاح. مرجع: 9860.	2025-11-10 00:00:00	\N	ar
1287	Dear customer, your account balance is $8397.56. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1288	تنبيه: بطاقتك المنتهية بـ 3585 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1289	Reminder: Your loan payment of $9029.64 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1291	Your scheduled transfer completed successfully. Ref: 4834.	2025-11-10 00:00:00	\N	en
1293	تمت عملية بقيمة 8403.80 في المتجر. مرجع: 9410.	2025-11-10 00:00:00	\N	ar
1295	Your online transfer of $9973.53 to account 3337 was successful.	2025-11-10 00:00:00	\N	en
1296	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1297	Payment of $2823.29 received to your account ending with 1229. Thank you.	2025-11-10 00:00:00	\N	en
1298	عزيزي العميل، رصيد حسابك هو 7071.69. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1299	رمز التحقق لعملية الدفع هو 467292. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1301	Reminder: Your loan payment of $560.43 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1302	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1305	تم استلام دفعة بقيمة 7867.44 في حسابك المنتهي بـ 6712. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1309	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1310	Your online transfer of $6697.73 to account 4824 was successful.	2025-11-10 00:00:00	\N	en
1313	Your debit card ending 5093 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1316	Your transaction of $2149.44 at STORE was successful. Ref: 6270.	2025-11-10 00:00:00	\N	en
1318	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1321	ستنتهي صلاحية بطاقتك المنتهية بـ 1287 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1323	Your OTP for transaction is 641611. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1325	تم استلام دفعة بقيمة 8632.82 في حسابك المنتهي بـ 9188. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1326	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1328	تم استلام دفعة بقيمة 2158.25 في حسابك المنتهي بـ 2321. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1329	تم استلام دفعة بقيمة 9803.97 في حسابك المنتهي بـ 6549. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1330	رمز التحقق لعملية الدفع هو 835550. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1331	Your online transfer of $4520.08 to account 2433 was successful.	2025-11-10 00:00:00	\N	en
1332	رمز التحقق لعملية الدفع هو 307369. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1335	عزيزي العميل، رصيد حسابك هو 5859.16. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1336	Your OTP for transaction is 111556. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1337	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1338	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1339	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1340	تذكير: قسط القرض بقيمة 6898.53 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1567	تمت عملية بقيمة 2450.10 في المتجر. مرجع: 2945.	2025-11-10 00:00:00	\N	ar
1342	عزيزي العميل، رصيد حسابك هو 2535.34. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1345	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1347	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1348	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1349	Reminder: Your loan payment of $4209.00 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1352	التحويل المجدول اكتمل بنجاح. مرجع: 4012.	2025-11-10 00:00:00	\N	ar
1353	Your debit card ending 5319 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1356	Your online transfer of $5372.39 to account 2457 was successful.	2025-11-10 00:00:00	\N	en
1357	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1362	ستنتهي صلاحية بطاقتك المنتهية بـ 2142 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1364	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1365	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1366	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1368	تم استلام دفعة بقيمة 3973.83 في حسابك المنتهي بـ 1787. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1370	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1372	تمت عملية بقيمة 3207.84 في المتجر. مرجع: 3449.	2025-11-10 00:00:00	\N	ar
1374	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1376	تمت عملية بقيمة 258.47 في المتجر. مرجع: 8209.	2025-11-10 00:00:00	\N	ar
1377	تنبيه: بطاقتك المنتهية بـ 8085 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1381	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1383	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1384	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1385	ستنتهي صلاحية بطاقتك المنتهية بـ 1846 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1388	Your scheduled transfer completed successfully. Ref: 9901.	2025-11-10 00:00:00	\N	en
1391	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1392	Your online transfer of $8553.03 to account 2574 was successful.	2025-11-10 00:00:00	\N	en
1397	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1398	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1402	عزيزي العميل، رصيد حسابك هو 6583.19. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1403	التحويل المجدول اكتمل بنجاح. مرجع: 6586.	2025-11-10 00:00:00	\N	ar
1404	ستنتهي صلاحية بطاقتك المنتهية بـ 9584 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1407	تذكير: قسط القرض بقيمة 6051.45 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1411	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1413	Notification: Your card ending with 6742 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1414	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1415	ستنتهي صلاحية بطاقتك المنتهية بـ 4164 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1418	ستنتهي صلاحية بطاقتك المنتهية بـ 9072 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1419	Dear customer, your account balance is $3637.76. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1421	ستنتهي صلاحية بطاقتك المنتهية بـ 8009 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1423	Reminder: Your loan payment of $517.11 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1424	التحويل المجدول اكتمل بنجاح. مرجع: 5737.	2025-11-10 00:00:00	\N	ar
1426	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1427	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1431	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1434	Your scheduled transfer completed successfully. Ref: 3534.	2025-11-10 00:00:00	\N	en
1435	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1438	Reminder: Your loan payment of $7881.46 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1439	Your online transfer of $5295.70 to account 2108 was successful.	2025-11-10 00:00:00	\N	en
1440	Reminder: Your loan payment of $1753.11 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1441	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1442	تمت عملية بقيمة 3787.65 في المتجر. مرجع: 1031.	2025-11-10 00:00:00	\N	ar
1443	Payment of $7487.05 received to your account ending with 2414. Thank you.	2025-11-10 00:00:00	\N	en
1445	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1447	التحويل المجدول اكتمل بنجاح. مرجع: 9857.	2025-11-10 00:00:00	\N	ar
1448	Your online transfer of $1611.19 to account 7184 was successful.	2025-11-10 00:00:00	\N	en
1450	Your debit card ending 9397 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1451	Reminder: Your loan payment of $5067.60 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1457	ستنتهي صلاحية بطاقتك المنتهية بـ 8914 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1464	رمز التحقق لعملية الدفع هو 164496. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1465	تم استلام دفعة بقيمة 1771.20 في حسابك المنتهي بـ 5136. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1466	ستنتهي صلاحية بطاقتك المنتهية بـ 8423 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1467	Your debit card ending 6366 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1468	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1469	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1470	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1473	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1474	Your debit card ending 8911 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1477	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1478	Your scheduled transfer completed successfully. Ref: 5356.	2025-11-10 00:00:00	\N	en
1479	عزيزي العميل، رصيد حسابك هو 3962.75. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1480	التحويل المجدول اكتمل بنجاح. مرجع: 3883.	2025-11-10 00:00:00	\N	ar
1483	Your transaction of $9646.78 at STORE was successful. Ref: 4053.	2025-11-10 00:00:00	\N	en
1485	رمز التحقق لعملية الدفع هو 441143. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1489	التحويل المجدول اكتمل بنجاح. مرجع: 6061.	2025-11-10 00:00:00	\N	ar
1490	Your scheduled transfer completed successfully. Ref: 2629.	2025-11-10 00:00:00	\N	en
1491	Reminder: Your loan payment of $8399.01 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1498	تنبيه: بطاقتك المنتهية بـ 8773 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1499	Your debit card ending 9634 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1500	التحويل المجدول اكتمل بنجاح. مرجع: 9466.	2025-11-10 00:00:00	\N	ar
1501	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1504	Notification: Your card ending with 3537 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1506	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1507	Your online transfer of $8178.17 to account 8723 was successful.	2025-11-10 00:00:00	\N	en
1508	Reminder: Your loan payment of $5518.36 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1509	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1510	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1517	Dear customer, your account balance is $6889.03. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1519	ستنتهي صلاحية بطاقتك المنتهية بـ 7708 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1520	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1521	Dear customer, your account balance is $9285.30. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1522	تذكير: قسط القرض بقيمة 3296.70 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1526	تم استلام دفعة بقيمة 3809.87 في حسابك المنتهي بـ 7912. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1528	Your OTP for transaction is 964323. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1532	تنبيه: بطاقتك المنتهية بـ 3596 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1533	التحويل المجدول اكتمل بنجاح. مرجع: 2692.	2025-11-10 00:00:00	\N	ar
1534	Notification: Your card ending with 8923 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1537	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1538	ستنتهي صلاحية بطاقتك المنتهية بـ 4038 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1539	Your online transfer of $5452.10 to account 5815 was successful.	2025-11-10 00:00:00	\N	en
1540	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1541	Reminder: Your loan payment of $8102.11 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1544	Payment of $512.29 received to your account ending with 8823. Thank you.	2025-11-10 00:00:00	\N	en
1545	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1547	Reminder: Your loan payment of $9737.60 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1548	Your OTP for transaction is 939993. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1551	Your scheduled transfer completed successfully. Ref: 8621.	2025-11-10 00:00:00	\N	en
1552	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1553	Notification: Your card ending with 8354 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1554	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1555	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1557	Your online transfer of $2806.61 to account 9938 was successful.	2025-11-10 00:00:00	\N	en
1558	تم استلام دفعة بقيمة 184.00 في حسابك المنتهي بـ 2327. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1559	عزيزي العميل، رصيد حسابك هو 8616.25. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1560	تم استلام دفعة بقيمة 7938.62 في حسابك المنتهي بـ 3306. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1564	Your debit card ending 9766 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1565	رمز التحقق لعملية الدفع هو 119047. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1566	Notification: Your card ending with 9755 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1570	Your online transfer of $3255.78 to account 9364 was successful.	2025-11-10 00:00:00	\N	en
1571	ستنتهي صلاحية بطاقتك المنتهية بـ 7003 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1574	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1575	التحويل المجدول اكتمل بنجاح. مرجع: 1316.	2025-11-10 00:00:00	\N	ar
1580	Reminder: Your loan payment of $8530.86 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1581	رمز التحقق لعملية الدفع هو 144367. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1582	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1585	Payment of $8881.66 received to your account ending with 3956. Thank you.	2025-11-10 00:00:00	\N	en
1590	تذكير: قسط القرض بقيمة 1440.94 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1596	التحويل المجدول اكتمل بنجاح. مرجع: 5627.	2025-11-10 00:00:00	\N	ar
1597	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1599	التحويل المجدول اكتمل بنجاح. مرجع: 2836.	2025-11-10 00:00:00	\N	ar
1600	رمز التحقق لعملية الدفع هو 124724. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1605	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1607	تم استلام دفعة بقيمة 2944.52 في حسابك المنتهي بـ 1219. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1608	Your online transfer of $3008.93 to account 1538 was successful.	2025-11-10 00:00:00	\N	en
1610	تم استلام دفعة بقيمة 4724.24 في حسابك المنتهي بـ 4127. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1611	Your transaction of $9750.56 at STORE was successful. Ref: 2824.	2025-11-10 00:00:00	\N	en
1612	عزيزي العميل، رصيد حسابك هو 9492.14. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1614	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1620	Dear customer, your account balance is $5424.57. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1621	التحويل المجدول اكتمل بنجاح. مرجع: 1896.	2025-11-10 00:00:00	\N	ar
1622	Your debit card ending 3030 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1626	التحويل المجدول اكتمل بنجاح. مرجع: 7421.	2025-11-10 00:00:00	\N	ar
1627	Dear customer, your account balance is $9689.35. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1631	Your OTP for transaction is 330304. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1632	تنبيه: بطاقتك المنتهية بـ 5392 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1633	Your OTP for transaction is 589611. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1634	ستنتهي صلاحية بطاقتك المنتهية بـ 9516 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1637	Dear customer, your account balance is $1259.65. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1640	تمت عملية بقيمة 3105.79 في المتجر. مرجع: 4046.	2025-11-10 00:00:00	\N	ar
1642	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1644	Payment of $1926.06 received to your account ending with 5566. Thank you.	2025-11-10 00:00:00	\N	en
1646	Your transaction of $3569.51 at STORE was successful. Ref: 3757.	2025-11-10 00:00:00	\N	en
1647	عزيزي العميل، رصيد حسابك هو 2729.95. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1648	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1650	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1658	Your debit card ending 3622 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1659	Notification: Your card ending with 6386 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1660	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1661	Payment of $2502.73 received to your account ending with 6906. Thank you.	2025-11-10 00:00:00	\N	en
1662	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1664	Your OTP for transaction is 179972. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1667	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1668	Your debit card ending 4669 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1669	Notification: Your card ending with 5350 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1670	تم استلام دفعة بقيمة 3233.97 في حسابك المنتهي بـ 1252. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1672	Reminder: Your loan payment of $931.90 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1673	تنبيه: بطاقتك المنتهية بـ 1442 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1674	Your scheduled transfer completed successfully. Ref: 5010.	2025-11-10 00:00:00	\N	en
1676	Your OTP for transaction is 759116. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1682	التحويل المجدول اكتمل بنجاح. مرجع: 9009.	2025-11-10 00:00:00	\N	ar
1685	Your transaction of $5494.41 at STORE was successful. Ref: 9632.	2025-11-10 00:00:00	\N	en
1686	تم استلام دفعة بقيمة 4807.81 في حسابك المنتهي بـ 9425. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1687	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1689	Your debit card ending 9928 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1691	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1693	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1694	Your OTP for transaction is 339445. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1695	التحويل المجدول اكتمل بنجاح. مرجع: 5238.	2025-11-10 00:00:00	\N	ar
1696	تذكير: قسط القرض بقيمة 6107.69 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1698	تنبيه: بطاقتك المنتهية بـ 8822 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1699	التحويل المجدول اكتمل بنجاح. مرجع: 1670.	2025-11-10 00:00:00	\N	ar
1700	Your OTP for transaction is 756259. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1701	Your online transfer of $190.26 to account 9643 was successful.	2025-11-10 00:00:00	\N	en
1702	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1703	تنبيه: بطاقتك المنتهية بـ 9075 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1704	رمز التحقق لعملية الدفع هو 540404. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1705	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1706	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1707	تنبيه: بطاقتك المنتهية بـ 2226 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1708	Payment of $1331.57 received to your account ending with 1105. Thank you.	2025-11-10 00:00:00	\N	en
1710	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1713	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1714	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1715	Your online transfer of $7840.67 to account 9433 was successful.	2025-11-10 00:00:00	\N	en
1716	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1721	Payment of $1518.47 received to your account ending with 8448. Thank you.	2025-11-10 00:00:00	\N	en
1723	Your scheduled transfer completed successfully. Ref: 1025.	2025-11-10 00:00:00	\N	en
1724	عزيزي العميل، رصيد حسابك هو 4049.60. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1728	Payment of $811.63 received to your account ending with 1289. Thank you.	2025-11-10 00:00:00	\N	en
1729	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1730	تمت عملية بقيمة 9826.02 في المتجر. مرجع: 2679.	2025-11-10 00:00:00	\N	ar
1734	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1735	Your OTP for transaction is 721260. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1736	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1737	Your online transfer of $4949.22 to account 5365 was successful.	2025-11-10 00:00:00	\N	en
1741	تنبيه: بطاقتك المنتهية بـ 4521 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1744	Notification: Your card ending with 4352 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1745	تم استلام دفعة بقيمة 9099.61 في حسابك المنتهي بـ 8847. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1747	Your online transfer of $3269.34 to account 2281 was successful.	2025-11-10 00:00:00	\N	en
1748	تنبيه: بطاقتك المنتهية بـ 5166 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1751	تم استلام دفعة بقيمة 5168.19 في حسابك المنتهي بـ 5849. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1753	Dear customer, your account balance is $3921.36. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1755	Reminder: Your loan payment of $990.25 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1757	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1760	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1761	عزيزي العميل، رصيد حسابك هو 4084.30. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1763	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1765	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1767	التحويل المجدول اكتمل بنجاح. مرجع: 5101.	2025-11-10 00:00:00	\N	ar
1768	Your OTP for transaction is 961853. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1769	Payment of $5248.34 received to your account ending with 5029. Thank you.	2025-11-10 00:00:00	\N	en
1770	رمز التحقق لعملية الدفع هو 478520. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1771	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1774	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1775	Your online transfer of $7121.88 to account 1085 was successful.	2025-11-10 00:00:00	\N	en
1776	Your OTP for transaction is 281894. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1777	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1778	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1780	Dear customer, your account balance is $1433.75. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1781	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1788	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1789	تم استلام دفعة بقيمة 3424.55 في حسابك المنتهي بـ 6454. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1791	Notification: Your card ending with 9328 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1792	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1793	Payment of $4059.50 received to your account ending with 2458. Thank you.	2025-11-10 00:00:00	\N	en
1796	ستنتهي صلاحية بطاقتك المنتهية بـ 3497 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1797	Your scheduled transfer completed successfully. Ref: 8645.	2025-11-10 00:00:00	\N	en
1798	Payment of $5846.93 received to your account ending with 6162. Thank you.	2025-11-10 00:00:00	\N	en
1799	تمت عملية بقيمة 3858.54 في المتجر. مرجع: 1096.	2025-11-10 00:00:00	\N	ar
1800	رمز التحقق لعملية الدفع هو 134841. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1801	Dear customer, your account balance is $8733.22. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1802	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1803	التحويل المجدول اكتمل بنجاح. مرجع: 8014.	2025-11-10 00:00:00	\N	ar
1805	Your transaction of $4559.98 at STORE was successful. Ref: 6537.	2025-11-10 00:00:00	\N	en
1806	التحويل المجدول اكتمل بنجاح. مرجع: 6743.	2025-11-10 00:00:00	\N	ar
1807	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1808	رمز التحقق لعملية الدفع هو 784507. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1809	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1811	تنبيه: بطاقتك المنتهية بـ 2890 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1812	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1813	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1816	تم استلام دفعة بقيمة 9294.23 في حسابك المنتهي بـ 9625. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1817	رمز التحقق لعملية الدفع هو 774911. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1823	رمز التحقق لعملية الدفع هو 674358. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1824	Payment of $8457.44 received to your account ending with 5589. Thank you.	2025-11-10 00:00:00	\N	en
1825	Dear customer, your account balance is $7675.04. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1830	تذكير: قسط القرض بقيمة 6591.43 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1835	ستنتهي صلاحية بطاقتك المنتهية بـ 7666 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1836	رمز التحقق لعملية الدفع هو 241551. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1839	عزيزي العميل، رصيد حسابك هو 3795.50. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1840	Your transaction of $5354.92 at STORE was successful. Ref: 3781.	2025-11-10 00:00:00	\N	en
1846	تنبيه: بطاقتك المنتهية بـ 8403 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1847	Payment of $3574.58 received to your account ending with 6898. Thank you.	2025-11-10 00:00:00	\N	en
1848	Your online transfer of $4627.67 to account 7594 was successful.	2025-11-10 00:00:00	\N	en
1853	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1854	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1856	تذكير: قسط القرض بقيمة 153.17 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1858	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1860	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1863	تمت عملية بقيمة 3977.35 في المتجر. مرجع: 7003.	2025-11-10 00:00:00	\N	ar
1865	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
1866	Your OTP for transaction is 438338. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1867	ستنتهي صلاحية بطاقتك المنتهية بـ 7227 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1868	Reminder: Your loan payment of $6760.06 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1869	التحويل المجدول اكتمل بنجاح. مرجع: 4513.	2025-11-10 00:00:00	\N	ar
1870	Notification: Your card ending with 7297 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1871	تذكير: قسط القرض بقيمة 1683.72 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1873	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1877	ستنتهي صلاحية بطاقتك المنتهية بـ 4855 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1881	Your transaction of $3818.39 at STORE was successful. Ref: 7164.	2025-11-10 00:00:00	\N	en
1882	تمت عملية بقيمة 4045.42 في المتجر. مرجع: 9642.	2025-11-10 00:00:00	\N	ar
1883	Your OTP for transaction is 317518. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1884	Your online transfer of $4666.34 to account 9103 was successful.	2025-11-10 00:00:00	\N	en
1886	تذكير: قسط القرض بقيمة 3363.61 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1887	التحويل المجدول اكتمل بنجاح. مرجع: 5203.	2025-11-10 00:00:00	\N	ar
1888	Dear customer, your account balance is $6653.04. Visit our branch for details.	2025-11-10 00:00:00	\N	en
1889	ستنتهي صلاحية بطاقتك المنتهية بـ 6107 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1890	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1891	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1898	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1899	تنبيه: بطاقتك المنتهية بـ 7508 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1900	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1901	تم استلام دفعة بقيمة 5260.12 في حسابك المنتهي بـ 3129. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1903	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1904	Your online transfer of $9291.07 to account 3465 was successful.	2025-11-10 00:00:00	\N	en
1907	تنبيه: بطاقتك المنتهية بـ 1999 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1908	Your OTP for transaction is 563937. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
1910	عزيزي العميل، رصيد حسابك هو 7760.76. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1911	تذكير: قسط القرض بقيمة 5832.88 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1912	ستنتهي صلاحية بطاقتك المنتهية بـ 9591 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
1917	Payment of $7839.51 received to your account ending with 6553. Thank you.	2025-11-10 00:00:00	\N	en
1921	Your online transfer of $9372.24 to account 8845 was successful.	2025-11-10 00:00:00	\N	en
1926	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
1928	رمز التحقق لعملية الدفع هو 142871. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
1935	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1937	Reminder: Your loan payment of $5389.82 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1939	Payment of $5554.66 received to your account ending with 9115. Thank you.	2025-11-10 00:00:00	\N	en
1940	تذكير: قسط القرض بقيمة 2405.15 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1941	تنبيه: بطاقتك المنتهية بـ 2157 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1946	Notification: Your card ending with 5256 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
1947	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1950	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1952	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1954	تمت عملية بقيمة 7510.59 في المتجر. مرجع: 3495.	2025-11-10 00:00:00	\N	ar
1955	Reminder: Your loan payment of $370.66 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1956	Your debit card ending 6607 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1958	تنبيه: بطاقتك المنتهية بـ 7192 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1959	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
1960	عزيزي العميل، رصيد حسابك هو 5837.24. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
1961	Reminder: Your loan payment of $2939.36 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
1964	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1965	تم استلام دفعة بقيمة 3431.30 في حسابك المنتهي بـ 7317. شكرًا لك.	2025-11-10 00:00:00	\N	ar
1966	Your transaction of $2212.78 at STORE was successful. Ref: 2519.	2025-11-10 00:00:00	\N	en
1967	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
1968	Payment of $9280.47 received to your account ending with 5638. Thank you.	2025-11-10 00:00:00	\N	en
1970	Your scheduled transfer completed successfully. Ref: 8818.	2025-11-10 00:00:00	\N	en
1971	Payment of $1520.49 received to your account ending with 6134. Thank you.	2025-11-10 00:00:00	\N	en
1974	تذكير: قسط القرض بقيمة 5389.78 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
1978	تنبيه: بطاقتك المنتهية بـ 4207 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
1979	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
1980	Your scheduled transfer completed successfully. Ref: 1736.	2025-11-10 00:00:00	\N	en
1981	Your debit card ending 7779 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
1983	تمت عملية بقيمة 3186.79 في المتجر. مرجع: 1467.	2025-11-10 00:00:00	\N	ar
1985	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1986	التحويل المجدول اكتمل بنجاح. مرجع: 4952.	2025-11-10 00:00:00	\N	ar
1987	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
1988	Your scheduled transfer completed successfully. Ref: 4101.	2025-11-10 00:00:00	\N	en
1991	Your transaction of $9734.08 at STORE was successful. Ref: 6546.	2025-11-10 00:00:00	\N	en
1992	Your transaction of $9415.48 at STORE was successful. Ref: 5116.	2025-11-10 00:00:00	\N	en
1994	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
1995	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2002	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2005	رمز التحقق لعملية الدفع هو 409863. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2009	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2011	التحويل المجدول اكتمل بنجاح. مرجع: 8999.	2025-11-10 00:00:00	\N	ar
2012	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2015	تذكير: قسط القرض بقيمة 1697.16 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2016	Your debit card ending 8343 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2017	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2018	تذكير: قسط القرض بقيمة 5045.58 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2020	Your debit card ending 2749 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2021	Your OTP for transaction is 296295. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2023	Payment of $7442.97 received to your account ending with 8816. Thank you.	2025-11-10 00:00:00	\N	en
2026	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2027	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2030	Your OTP for transaction is 690462. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2031	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2032	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2033	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2042	تم استلام دفعة بقيمة 7745.79 في حسابك المنتهي بـ 2324. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2043	Your OTP for transaction is 651801. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2047	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2048	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2053	تنبيه: بطاقتك المنتهية بـ 9882 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2054	تمت عملية بقيمة 1162.63 في المتجر. مرجع: 6043.	2025-11-10 00:00:00	\N	ar
2056	Your online transfer of $1084.09 to account 3775 was successful.	2025-11-10 00:00:00	\N	en
2058	ستنتهي صلاحية بطاقتك المنتهية بـ 7518 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2060	Your debit card ending 8072 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2061	تذكير: قسط القرض بقيمة 6729.35 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2062	Reminder: Your loan payment of $5427.17 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2065	تم استلام دفعة بقيمة 4624.95 في حسابك المنتهي بـ 4006. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2066	عزيزي العميل، رصيد حسابك هو 9268.65. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2068	تم استلام دفعة بقيمة 2115.04 في حسابك المنتهي بـ 5616. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2069	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2072	Reminder: Your loan payment of $965.99 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2073	Your OTP for transaction is 901470. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2075	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2078	Reminder: Your loan payment of $270.93 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2079	تذكير: قسط القرض بقيمة 5685.18 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2083	عزيزي العميل، رصيد حسابك هو 6402.68. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2086	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2087	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2088	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2092	Payment of $7775.71 received to your account ending with 8162. Thank you.	2025-11-10 00:00:00	\N	en
2093	Reminder: Your loan payment of $7006.02 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2095	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2105	Your OTP for transaction is 541892. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2107	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2108	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2109	Notification: Your card ending with 9838 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2112	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2113	Your scheduled transfer completed successfully. Ref: 6636.	2025-11-10 00:00:00	\N	en
2117	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2119	Notification: Your card ending with 6028 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2120	تذكير: قسط القرض بقيمة 3221.15 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2123	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2125	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2127	Your transaction of $3653.62 at STORE was successful. Ref: 8118.	2025-11-10 00:00:00	\N	en
2128	ستنتهي صلاحية بطاقتك المنتهية بـ 8700 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2129	Your OTP for transaction is 892549. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2131	Your debit card ending 3188 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2134	Dear customer, your account balance is $3694.86. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2143	Your OTP for transaction is 403049. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2144	Your scheduled transfer completed successfully. Ref: 2600.	2025-11-10 00:00:00	\N	en
2145	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2147	Your transaction of $3251.54 at STORE was successful. Ref: 6972.	2025-11-10 00:00:00	\N	en
2149	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2150	Your transaction of $9697.43 at STORE was successful. Ref: 6433.	2025-11-10 00:00:00	\N	en
2151	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2154	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2156	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2158	Dear customer, your account balance is $1613.97. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2160	رمز التحقق لعملية الدفع هو 620506. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2161	ستنتهي صلاحية بطاقتك المنتهية بـ 4123 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2164	التحويل المجدول اكتمل بنجاح. مرجع: 3762.	2025-11-10 00:00:00	\N	ar
2165	Reminder: Your loan payment of $2432.85 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2167	تذكير: قسط القرض بقيمة 9737.81 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2168	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2174	عزيزي العميل، رصيد حسابك هو 2328.43. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2178	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2181	Payment of $9668.53 received to your account ending with 1000. Thank you.	2025-11-10 00:00:00	\N	en
2182	تمت عملية بقيمة 5970.48 في المتجر. مرجع: 1780.	2025-11-10 00:00:00	\N	ar
2185	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2187	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2190	Your online transfer of $7855.03 to account 8174 was successful.	2025-11-10 00:00:00	\N	en
2192	تنبيه: بطاقتك المنتهية بـ 2714 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2194	تذكير: قسط القرض بقيمة 4278.01 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2195	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2197	Your scheduled transfer completed successfully. Ref: 9917.	2025-11-10 00:00:00	\N	en
2201	Notification: Your card ending with 7816 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2204	تمت عملية بقيمة 6721.25 في المتجر. مرجع: 3643.	2025-11-10 00:00:00	\N	ar
2206	رمز التحقق لعملية الدفع هو 391941. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2207	عزيزي العميل، رصيد حسابك هو 6095.35. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2208	تمت عملية بقيمة 3621.84 في المتجر. مرجع: 8552.	2025-11-10 00:00:00	\N	ar
2209	Your online transfer of $4376.47 to account 8025 was successful.	2025-11-10 00:00:00	\N	en
2211	تنبيه: بطاقتك المنتهية بـ 8356 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2212	تنبيه: بطاقتك المنتهية بـ 4194 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2214	Notification: Your card ending with 3010 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2216	تنبيه: بطاقتك المنتهية بـ 1320 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2218	تم استلام دفعة بقيمة 854.18 في حسابك المنتهي بـ 6495. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2219	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2220	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2221	التحويل المجدول اكتمل بنجاح. مرجع: 6260.	2025-11-10 00:00:00	\N	ar
2222	رمز التحقق لعملية الدفع هو 785218. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2223	تنبيه: بطاقتك المنتهية بـ 2807 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2226	رمز التحقق لعملية الدفع هو 735492. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2234	Your online transfer of $949.20 to account 7713 was successful.	2025-11-10 00:00:00	\N	en
2236	Payment of $112.91 received to your account ending with 4256. Thank you.	2025-11-10 00:00:00	\N	en
2237	التحويل المجدول اكتمل بنجاح. مرجع: 6498.	2025-11-10 00:00:00	\N	ar
2241	Your transaction of $515.06 at STORE was successful. Ref: 2530.	2025-11-10 00:00:00	\N	en
2243	Notification: Your card ending with 5583 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2244	تمت عملية بقيمة 5794.39 في المتجر. مرجع: 5934.	2025-11-10 00:00:00	\N	ar
2247	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2248	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2249	تم استلام دفعة بقيمة 2893.19 في حسابك المنتهي بـ 5273. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2251	ستنتهي صلاحية بطاقتك المنتهية بـ 6113 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2252	Your OTP for transaction is 681102. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2253	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2256	Reminder: Your loan payment of $3948.81 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2258	رمز التحقق لعملية الدفع هو 358530. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2259	Your scheduled transfer completed successfully. Ref: 4613.	2025-11-10 00:00:00	\N	en
2262	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2263	التحويل المجدول اكتمل بنجاح. مرجع: 7133.	2025-11-10 00:00:00	\N	ar
2265	ستنتهي صلاحية بطاقتك المنتهية بـ 8937 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2267	Reminder: Your loan payment of $7471.88 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2269	التحويل المجدول اكتمل بنجاح. مرجع: 3860.	2025-11-10 00:00:00	\N	ar
2272	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2273	Your debit card ending 4765 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2274	Your transaction of $1133.01 at STORE was successful. Ref: 7587.	2025-11-10 00:00:00	\N	en
2276	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2526	Your OTP for transaction is 323030. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2278	تنبيه: بطاقتك المنتهية بـ 2591 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2281	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2286	تنبيه: بطاقتك المنتهية بـ 4327 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2287	Your scheduled transfer completed successfully. Ref: 8634.	2025-11-10 00:00:00	\N	en
2290	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2292	Dear customer, your account balance is $4959.84. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2293	Notification: Your card ending with 3903 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2295	Payment of $3878.41 received to your account ending with 2760. Thank you.	2025-11-10 00:00:00	\N	en
2296	رمز التحقق لعملية الدفع هو 927310. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2299	تمت عملية بقيمة 8464.17 في المتجر. مرجع: 4666.	2025-11-10 00:00:00	\N	ar
2300	Your scheduled transfer completed successfully. Ref: 4317.	2025-11-10 00:00:00	\N	en
2301	تذكير: قسط القرض بقيمة 481.44 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2306	تنبيه: بطاقتك المنتهية بـ 8046 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2307	Your debit card ending 3243 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2308	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2310	Reminder: Your loan payment of $4589.66 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2311	تذكير: قسط القرض بقيمة 645.81 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2313	تمت عملية بقيمة 5725.02 في المتجر. مرجع: 6045.	2025-11-10 00:00:00	\N	ar
2314	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2316	ستنتهي صلاحية بطاقتك المنتهية بـ 7144 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2317	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2322	Reminder: Your loan payment of $6411.30 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2323	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2325	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2327	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2330	ستنتهي صلاحية بطاقتك المنتهية بـ 6187 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2332	تم استلام دفعة بقيمة 2364.69 في حسابك المنتهي بـ 6532. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2333	Your debit card ending 3640 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2334	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2342	Your transaction of $8013.70 at STORE was successful. Ref: 1981.	2025-11-10 00:00:00	\N	en
2343	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2344	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2346	Notification: Your card ending with 2097 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2348	رمز التحقق لعملية الدفع هو 642543. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2349	Dear customer, your account balance is $1615.49. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2350	تنبيه: بطاقتك المنتهية بـ 7750 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2352	Your scheduled transfer completed successfully. Ref: 6538.	2025-11-10 00:00:00	\N	en
2353	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2356	Your transaction of $742.64 at STORE was successful. Ref: 3731.	2025-11-10 00:00:00	\N	en
2361	Your OTP for transaction is 371914. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2365	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2366	تمت عملية بقيمة 6651.89 في المتجر. مرجع: 1862.	2025-11-10 00:00:00	\N	ar
2367	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2369	Dear customer, your account balance is $6085.04. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2371	Your transaction of $2826.67 at STORE was successful. Ref: 2064.	2025-11-10 00:00:00	\N	en
2373	تم استلام دفعة بقيمة 3081.45 في حسابك المنتهي بـ 4491. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2374	Your scheduled transfer completed successfully. Ref: 3990.	2025-11-10 00:00:00	\N	en
2375	تمت عملية بقيمة 5625.07 في المتجر. مرجع: 1030.	2025-11-10 00:00:00	\N	ar
2376	Your transaction of $4633.70 at STORE was successful. Ref: 5117.	2025-11-10 00:00:00	\N	en
2379	Dear customer, your account balance is $631.29. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2380	Payment of $5519.85 received to your account ending with 1909. Thank you.	2025-11-10 00:00:00	\N	en
2381	Your OTP for transaction is 437261. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2382	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2383	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2385	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2389	رمز التحقق لعملية الدفع هو 128694. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2390	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2393	Your scheduled transfer completed successfully. Ref: 3185.	2025-11-10 00:00:00	\N	en
2395	تنبيه: بطاقتك المنتهية بـ 5894 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2648	Payment of $4268.77 received to your account ending with 4635. Thank you.	2025-11-10 00:00:00	\N	en
2396	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2400	Dear customer, your account balance is $4201.67. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2401	Your OTP for transaction is 848985. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2409	تذكير: قسط القرض بقيمة 3416.28 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2411	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2413	تذكير: قسط القرض بقيمة 8501.58 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2415	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2418	ستنتهي صلاحية بطاقتك المنتهية بـ 8614 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2421	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2424	Your OTP for transaction is 684270. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2425	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2428	تنبيه: بطاقتك المنتهية بـ 1090 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2431	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2432	تم استلام دفعة بقيمة 875.59 في حسابك المنتهي بـ 8863. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2434	Your OTP for transaction is 925383. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2435	تم استلام دفعة بقيمة 6639.02 في حسابك المنتهي بـ 1966. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2437	Dear customer, your account balance is $5781.65. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2439	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2440	Notification: Your card ending with 4436 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2441	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2444	عزيزي العميل، رصيد حسابك هو 8124.15. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2445	Dear customer, your account balance is $8518.31. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2446	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2448	ستنتهي صلاحية بطاقتك المنتهية بـ 9498 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2451	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2452	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2453	تذكير: قسط القرض بقيمة 9743.61 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2455	Your online transfer of $8294.58 to account 8342 was successful.	2025-11-10 00:00:00	\N	en
2457	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2458	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2462	Payment of $1178.48 received to your account ending with 4954. Thank you.	2025-11-10 00:00:00	\N	en
2465	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2469	التحويل المجدول اكتمل بنجاح. مرجع: 5131.	2025-11-10 00:00:00	\N	ar
2470	Your transaction of $9297.07 at STORE was successful. Ref: 3495.	2025-11-10 00:00:00	\N	en
2472	عزيزي العميل، رصيد حسابك هو 1154.03. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2478	تذكير: قسط القرض بقيمة 5598.68 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2481	Your scheduled transfer completed successfully. Ref: 4045.	2025-11-10 00:00:00	\N	en
2484	Payment of $5418.75 received to your account ending with 8181. Thank you.	2025-11-10 00:00:00	\N	en
2485	تمت عملية بقيمة 2264.38 في المتجر. مرجع: 4201.	2025-11-10 00:00:00	\N	ar
2486	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2488	Reminder: Your loan payment of $8621.85 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2493	عزيزي العميل، رصيد حسابك هو 2059.41. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2495	Notification: Your card ending with 9950 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2497	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2499	Your transaction of $969.32 at STORE was successful. Ref: 7225.	2025-11-10 00:00:00	\N	en
2502	Reminder: Your loan payment of $7248.86 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2505	Dear customer, your account balance is $3426.22. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2506	Notification: Your card ending with 4658 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2508	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2510	تذكير: قسط القرض بقيمة 9677.35 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2512	Notification: Your card ending with 7767 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2513	Notification: Your card ending with 8558 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2514	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2515	Your transaction of $1988.03 at STORE was successful. Ref: 7878.	2025-11-10 00:00:00	\N	en
2517	رمز التحقق لعملية الدفع هو 835135. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2519	Your transaction of $108.06 at STORE was successful. Ref: 2987.	2025-11-10 00:00:00	\N	en
2520	Your transaction of $9472.09 at STORE was successful. Ref: 1621.	2025-11-10 00:00:00	\N	en
2521	تم استلام دفعة بقيمة 7348.69 في حسابك المنتهي بـ 3580. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2522	تم استلام دفعة بقيمة 1213.50 في حسابك المنتهي بـ 8492. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2525	تنبيه: بطاقتك المنتهية بـ 1434 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2527	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2529	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2533	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2534	رمز التحقق لعملية الدفع هو 316313. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2536	Your scheduled transfer completed successfully. Ref: 1843.	2025-11-10 00:00:00	\N	en
2537	عزيزي العميل، رصيد حسابك هو 8137.11. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2538	تم استلام دفعة بقيمة 2985.08 في حسابك المنتهي بـ 4409. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2539	Your transaction of $6773.20 at STORE was successful. Ref: 5426.	2025-11-10 00:00:00	\N	en
2540	ستنتهي صلاحية بطاقتك المنتهية بـ 6726 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2541	ستنتهي صلاحية بطاقتك المنتهية بـ 7664 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2544	تنبيه: بطاقتك المنتهية بـ 3158 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2545	Your scheduled transfer completed successfully. Ref: 7005.	2025-11-10 00:00:00	\N	en
2548	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2550	ستنتهي صلاحية بطاقتك المنتهية بـ 5759 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2552	Payment of $6847.01 received to your account ending with 1779. Thank you.	2025-11-10 00:00:00	\N	en
2553	Your scheduled transfer completed successfully. Ref: 4189.	2025-11-10 00:00:00	\N	en
2557	Payment of $2927.73 received to your account ending with 1328. Thank you.	2025-11-10 00:00:00	\N	en
2559	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2560	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2562	تمت عملية بقيمة 9580.59 في المتجر. مرجع: 3408.	2025-11-10 00:00:00	\N	ar
2563	Payment of $4658.12 received to your account ending with 2101. Thank you.	2025-11-10 00:00:00	\N	en
2564	Your OTP for transaction is 319806. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2566	Reminder: Your loan payment of $1507.90 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2569	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2570	تم استلام دفعة بقيمة 3798.97 في حسابك المنتهي بـ 8065. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2571	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2578	Your transaction of $8975.82 at STORE was successful. Ref: 7622.	2025-11-10 00:00:00	\N	en
2579	رمز التحقق لعملية الدفع هو 905712. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2580	Reminder: Your loan payment of $7605.64 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2587	تم استلام دفعة بقيمة 2396.79 في حسابك المنتهي بـ 4745. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2589	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2591	ستنتهي صلاحية بطاقتك المنتهية بـ 5251 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2593	تنبيه: بطاقتك المنتهية بـ 1518 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2596	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2599	Your debit card ending 9359 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2600	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2602	Payment of $5217.93 received to your account ending with 6524. Thank you.	2025-11-10 00:00:00	\N	en
2603	Your transaction of $8134.53 at STORE was successful. Ref: 5690.	2025-11-10 00:00:00	\N	en
2604	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2605	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2606	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2607	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2611	Payment of $661.74 received to your account ending with 8975. Thank you.	2025-11-10 00:00:00	\N	en
2613	تذكير: قسط القرض بقيمة 4123.26 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2616	التحويل المجدول اكتمل بنجاح. مرجع: 3821.	2025-11-10 00:00:00	\N	ar
2619	Notification: Your card ending with 9899 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2624	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2625	التحويل المجدول اكتمل بنجاح. مرجع: 9565.	2025-11-10 00:00:00	\N	ar
2628	Notification: Your card ending with 4213 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2630	تمت عملية بقيمة 4827.62 في المتجر. مرجع: 6045.	2025-11-10 00:00:00	\N	ar
2631	Your scheduled transfer completed successfully. Ref: 1073.	2025-11-10 00:00:00	\N	en
2632	تذكير: قسط القرض بقيمة 251.21 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2633	Your online transfer of $1296.17 to account 7274 was successful.	2025-11-10 00:00:00	\N	en
2634	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2635	Reminder: Your loan payment of $7466.53 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2637	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2639	عزيزي العميل، رصيد حسابك هو 9933.92. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2645	Your online transfer of $6003.09 to account 3648 was successful.	2025-11-10 00:00:00	\N	en
2647	تم استلام دفعة بقيمة 655.34 في حسابك المنتهي بـ 5357. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2649	Your debit card ending 9263 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2650	Your OTP for transaction is 657840. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2651	Payment of $3735.20 received to your account ending with 5684. Thank you.	2025-11-10 00:00:00	\N	en
2652	تم استلام دفعة بقيمة 6493.06 في حسابك المنتهي بـ 9518. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2653	Your debit card ending 5563 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2654	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2656	Your OTP for transaction is 358292. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2657	Your transaction of $429.00 at STORE was successful. Ref: 1115.	2025-11-10 00:00:00	\N	en
2661	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2665	التحويل المجدول اكتمل بنجاح. مرجع: 2767.	2025-11-10 00:00:00	\N	ar
2668	Your debit card ending 1224 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2669	Dear customer, your account balance is $6915.22. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2674	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2675	Your online transfer of $5691.14 to account 2179 was successful.	2025-11-10 00:00:00	\N	en
2679	Notification: Your card ending with 8655 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2683	تذكير: قسط القرض بقيمة 5606.72 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2684	رمز التحقق لعملية الدفع هو 362491. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2685	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2686	تنبيه: بطاقتك المنتهية بـ 5073 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2687	Your scheduled transfer completed successfully. Ref: 1475.	2025-11-10 00:00:00	\N	en
2689	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2690	Notification: Your card ending with 4401 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2691	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2692	ستنتهي صلاحية بطاقتك المنتهية بـ 2712 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2695	Dear customer, your account balance is $7921.57. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2697	تنبيه: بطاقتك المنتهية بـ 8445 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2699	Your scheduled transfer completed successfully. Ref: 3013.	2025-11-10 00:00:00	\N	en
2700	تم استلام دفعة بقيمة 2554.05 في حسابك المنتهي بـ 7098. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2701	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2705	Your OTP for transaction is 270253. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2706	Your online transfer of $7369.33 to account 4605 was successful.	2025-11-10 00:00:00	\N	en
2709	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2710	رمز التحقق لعملية الدفع هو 978946. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2713	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2714	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2715	ستنتهي صلاحية بطاقتك المنتهية بـ 8702 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2717	عزيزي العميل، رصيد حسابك هو 1663.83. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2718	Notification: Your card ending with 9321 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2720	ستنتهي صلاحية بطاقتك المنتهية بـ 6350 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2721	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2722	Your debit card ending 2617 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2723	Your OTP for transaction is 705692. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2724	تمت عملية بقيمة 2472.86 في المتجر. مرجع: 2583.	2025-11-10 00:00:00	\N	ar
2725	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2726	Reminder: Your loan payment of $5075.15 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2728	Notification: Your card ending with 1518 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2730	عزيزي العميل، رصيد حسابك هو 6203.87. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2731	Your transaction of $9867.36 at STORE was successful. Ref: 2107.	2025-11-10 00:00:00	\N	en
2733	Your online transfer of $271.64 to account 9495 was successful.	2025-11-10 00:00:00	\N	en
2734	تذكير: قسط القرض بقيمة 3332.74 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2735	عزيزي العميل، رصيد حسابك هو 3835.08. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2741	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2743	عزيزي العميل، رصيد حسابك هو 939.45. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2744	Your online transfer of $1380.99 to account 7869 was successful.	2025-11-10 00:00:00	\N	en
2745	تم استلام دفعة بقيمة 8462.50 في حسابك المنتهي بـ 7735. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2746	تنبيه: بطاقتك المنتهية بـ 2401 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2751	Payment of $4807.01 received to your account ending with 2758. Thank you.	2025-11-10 00:00:00	\N	en
2756	تمت عملية بقيمة 3644.33 في المتجر. مرجع: 1140.	2025-11-10 00:00:00	\N	ar
2759	Your online transfer of $3467.68 to account 1981 was successful.	2025-11-10 00:00:00	\N	en
2760	Your transaction of $7720.94 at STORE was successful. Ref: 4234.	2025-11-10 00:00:00	\N	en
2762	Your online transfer of $4332.90 to account 6866 was successful.	2025-11-10 00:00:00	\N	en
2767	Reminder: Your loan payment of $7435.44 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2768	Your scheduled transfer completed successfully. Ref: 1920.	2025-11-10 00:00:00	\N	en
2769	ستنتهي صلاحية بطاقتك المنتهية بـ 7280 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2770	Your online transfer of $609.26 to account 9895 was successful.	2025-11-10 00:00:00	\N	en
2776	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2779	Payment of $5724.83 received to your account ending with 3247. Thank you.	2025-11-10 00:00:00	\N	en
2788	Your online transfer of $3917.23 to account 2761 was successful.	2025-11-10 00:00:00	\N	en
2789	Notification: Your card ending with 4790 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2792	Your scheduled transfer completed successfully. Ref: 2999.	2025-11-10 00:00:00	\N	en
2794	تذكير: قسط القرض بقيمة 7676.48 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2795	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2796	Notification: Your card ending with 8002 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2800	تنبيه: بطاقتك المنتهية بـ 1082 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2801	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2803	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2804	تمت عملية بقيمة 4826.81 في المتجر. مرجع: 5316.	2025-11-10 00:00:00	\N	ar
2805	تذكير: قسط القرض بقيمة 9519.96 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2806	تنبيه: بطاقتك المنتهية بـ 8137 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2807	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2808	تم استلام دفعة بقيمة 1786.22 في حسابك المنتهي بـ 8986. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2809	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2810	Dear customer, your account balance is $3365.33. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2815	Reminder: Your loan payment of $9152.65 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2817	تمت عملية بقيمة 8508.45 في المتجر. مرجع: 3399.	2025-11-10 00:00:00	\N	ar
2818	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2823	تمت عملية بقيمة 4277.91 في المتجر. مرجع: 7672.	2025-11-10 00:00:00	\N	ar
2824	تم استلام دفعة بقيمة 3459.38 في حسابك المنتهي بـ 4210. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2825	Your online transfer of $5111.48 to account 1039 was successful.	2025-11-10 00:00:00	\N	en
2828	Reminder: Your loan payment of $4806.19 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2830	Reminder: Your loan payment of $3988.50 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2833	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2834	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2836	التحويل المجدول اكتمل بنجاح. مرجع: 1556.	2025-11-10 00:00:00	\N	ar
2837	Your online transfer of $3107.94 to account 5309 was successful.	2025-11-10 00:00:00	\N	en
2838	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2839	رمز التحقق لعملية الدفع هو 453227. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
2840	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2842	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2846	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2848	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2849	Your online transfer of $193.37 to account 4358 was successful.	2025-11-10 00:00:00	\N	en
2851	تمت عملية بقيمة 7288.30 في المتجر. مرجع: 3122.	2025-11-10 00:00:00	\N	ar
2852	التحويل المجدول اكتمل بنجاح. مرجع: 7859.	2025-11-10 00:00:00	\N	ar
2853	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2855	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2857	التحويل المجدول اكتمل بنجاح. مرجع: 4056.	2025-11-10 00:00:00	\N	ar
2859	Your scheduled transfer completed successfully. Ref: 2999.	2025-11-10 00:00:00	\N	en
2860	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2861	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2862	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2866	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2868	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2870	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2871	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
2872	Your OTP for transaction is 848991. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2875	Dear customer, your account balance is $6732.16. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2878	Your OTP for transaction is 983768. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2880	عزيزي العميل، رصيد حسابك هو 6469.72. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2881	Your scheduled transfer completed successfully. Ref: 1758.	2025-11-10 00:00:00	\N	en
2883	Your debit card ending 6291 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2885	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2886	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2890	تنبيه: بطاقتك المنتهية بـ 4981 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2897	Dear customer, your account balance is $3680.72. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2902	تنبيه: بطاقتك المنتهية بـ 8981 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2903	تذكير: قسط القرض بقيمة 1751.89 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2906	تذكير: قسط القرض بقيمة 8286.25 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2910	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2911	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2915	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2916	تمت عملية بقيمة 8601.65 في المتجر. مرجع: 3591.	2025-11-10 00:00:00	\N	ar
2917	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2918	تم استلام دفعة بقيمة 7648.75 في حسابك المنتهي بـ 2945. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2922	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2924	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2925	Your transaction of $4890.03 at STORE was successful. Ref: 7001.	2025-11-10 00:00:00	\N	en
2927	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2929	Payment of $5876.06 received to your account ending with 5578. Thank you.	2025-11-10 00:00:00	\N	en
2930	تنبيه: بطاقتك المنتهية بـ 4686 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
2934	Your transaction of $3085.04 at STORE was successful. Ref: 8053.	2025-11-10 00:00:00	\N	en
2936	Payment of $5227.47 received to your account ending with 9409. Thank you.	2025-11-10 00:00:00	\N	en
2937	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2939	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
2944	ستنتهي صلاحية بطاقتك المنتهية بـ 2808 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
2946	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2949	Notification: Your card ending with 9602 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
2952	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
2953	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2955	Reminder: Your loan payment of $1011.43 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2957	Your debit card ending 8024 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
2959	Your transaction of $1141.61 at STORE was successful. Ref: 9670.	2025-11-10 00:00:00	\N	en
2960	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2961	Reminder: Your loan payment of $4240.47 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
2963	Your scheduled transfer completed successfully. Ref: 6202.	2025-11-10 00:00:00	\N	en
2967	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
2968	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2972	Your OTP for transaction is 911224. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2973	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
2976	التحويل المجدول اكتمل بنجاح. مرجع: 7205.	2025-11-10 00:00:00	\N	ar
2980	تم استلام دفعة بقيمة 1963.89 في حسابك المنتهي بـ 7804. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2984	عزيزي العميل، رصيد حسابك هو 5256.76. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
2987	Your online transfer of $2504.71 to account 5875 was successful.	2025-11-10 00:00:00	\N	en
2988	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
2989	تذكير: قسط القرض بقيمة 6091.71 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
2991	تم استلام دفعة بقيمة 1676.39 في حسابك المنتهي بـ 4820. شكرًا لك.	2025-11-10 00:00:00	\N	ar
2992	Your OTP for transaction is 164975. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2993	Your OTP for transaction is 229400. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
2994	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
2995	Dear customer, your account balance is $242.47. Visit our branch for details.	2025-11-10 00:00:00	\N	en
2997	Payment of $5971.31 received to your account ending with 3893. Thank you.	2025-11-10 00:00:00	\N	en
2998	تمت عملية بقيمة 9456.20 في المتجر. مرجع: 6699.	2025-11-10 00:00:00	\N	ar
3001	Your OTP for transaction is 241805. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3004	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3006	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3007	Payment of $574.63 received to your account ending with 3303. Thank you.	2025-11-10 00:00:00	\N	en
3009	Notification: Your card ending with 1257 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3017	تمت عملية بقيمة 3027.58 في المتجر. مرجع: 8792.	2025-11-10 00:00:00	\N	ar
3018	تمت عملية بقيمة 9042.09 في المتجر. مرجع: 2531.	2025-11-10 00:00:00	\N	ar
3019	تمت عملية بقيمة 7527.59 في المتجر. مرجع: 4404.	2025-11-10 00:00:00	\N	ar
3021	التحويل المجدول اكتمل بنجاح. مرجع: 4096.	2025-11-10 00:00:00	\N	ar
3022	Dear customer, your account balance is $7100.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3025	التحويل المجدول اكتمل بنجاح. مرجع: 8354.	2025-11-10 00:00:00	\N	ar
3027	تم استلام دفعة بقيمة 6036.50 في حسابك المنتهي بـ 6877. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3033	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3037	Your online transfer of $5272.90 to account 2900 was successful.	2025-11-10 00:00:00	\N	en
3040	تم استلام دفعة بقيمة 3504.90 في حسابك المنتهي بـ 7011. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3041	ستنتهي صلاحية بطاقتك المنتهية بـ 2316 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3043	ستنتهي صلاحية بطاقتك المنتهية بـ 3399 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3044	Dear customer, your account balance is $4355.42. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3046	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3047	رمز التحقق لعملية الدفع هو 400891. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3048	Reminder: Your loan payment of $45.07 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3050	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3052	Dear customer, your account balance is $2226.14. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3053	عزيزي العميل، رصيد حسابك هو 5681.24. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3054	رمز التحقق لعملية الدفع هو 449422. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3055	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3057	تنبيه: بطاقتك المنتهية بـ 1399 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3058	التحويل المجدول اكتمل بنجاح. مرجع: 2353.	2025-11-10 00:00:00	\N	ar
3060	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3061	تذكير: قسط القرض بقيمة 3348.67 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3063	Your transaction of $3620.45 at STORE was successful. Ref: 3653.	2025-11-10 00:00:00	\N	en
3065	تم استلام دفعة بقيمة 8165.10 في حسابك المنتهي بـ 8342. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3066	Dear customer, your account balance is $2412.68. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3067	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3069	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3074	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3077	تنبيه: بطاقتك المنتهية بـ 9358 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3078	تذكير: قسط القرض بقيمة 1918.89 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3080	Payment of $9036.02 received to your account ending with 5704. Thank you.	2025-11-10 00:00:00	\N	en
3083	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3086	Notification: Your card ending with 1077 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3087	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3088	Your debit card ending 5615 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3089	Your debit card ending 6831 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3094	تنبيه: بطاقتك المنتهية بـ 7475 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3096	تذكير: قسط القرض بقيمة 8669.10 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3104	عزيزي العميل، رصيد حسابك هو 5782.71. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3107	Dear customer, your account balance is $1912.04. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3110	Your online transfer of $7390.25 to account 2368 was successful.	2025-11-10 00:00:00	\N	en
3112	Your scheduled transfer completed successfully. Ref: 5926.	2025-11-10 00:00:00	\N	en
3113	تنبيه: بطاقتك المنتهية بـ 9855 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3122	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3123	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3126	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3127	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3128	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3129	Your transaction of $2881.59 at STORE was successful. Ref: 8055.	2025-11-10 00:00:00	\N	en
3131	ستنتهي صلاحية بطاقتك المنتهية بـ 6253 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3134	Payment of $19.60 received to your account ending with 6853. Thank you.	2025-11-10 00:00:00	\N	en
3136	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3137	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3142	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3143	رمز التحقق لعملية الدفع هو 146330. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3146	Reminder: Your loan payment of $7949.37 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3147	Notification: Your card ending with 8139 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3148	Your scheduled transfer completed successfully. Ref: 9464.	2025-11-10 00:00:00	\N	en
3149	تذكير: قسط القرض بقيمة 3790.52 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3150	Notification: Your card ending with 7797 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3153	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3155	التحويل المجدول اكتمل بنجاح. مرجع: 8634.	2025-11-10 00:00:00	\N	ar
3158	Your OTP for transaction is 612759. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3162	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3163	Your debit card ending 3240 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3164	Your online transfer of $9923.69 to account 9862 was successful.	2025-11-10 00:00:00	\N	en
3165	Dear customer, your account balance is $4906.77. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3166	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3167	Your OTP for transaction is 581546. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3168	Your scheduled transfer completed successfully. Ref: 7803.	2025-11-10 00:00:00	\N	en
3169	ستنتهي صلاحية بطاقتك المنتهية بـ 3894 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3170	Notification: Your card ending with 9817 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3172	تنبيه: بطاقتك المنتهية بـ 5854 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3173	تذكير: قسط القرض بقيمة 7978.48 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3177	تم استلام دفعة بقيمة 3192.46 في حسابك المنتهي بـ 3129. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3179	Reminder: Your loan payment of $4483.21 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3180	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3181	التحويل المجدول اكتمل بنجاح. مرجع: 4102.	2025-11-10 00:00:00	\N	ar
3182	رمز التحقق لعملية الدفع هو 395479. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3183	عزيزي العميل، رصيد حسابك هو 2098.37. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3184	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3185	Dear customer, your account balance is $7302.79. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3186	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3187	Your debit card ending 3077 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3189	Your OTP for transaction is 813793. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3190	Reminder: Your loan payment of $100.99 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3191	Your transaction of $9259.14 at STORE was successful. Ref: 7176.	2025-11-10 00:00:00	\N	en
3195	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3198	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3199	Your debit card ending 6917 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3201	Your online transfer of $570.45 to account 9042 was successful.	2025-11-10 00:00:00	\N	en
3204	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3207	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3208	Your OTP for transaction is 331800. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3210	تنبيه: بطاقتك المنتهية بـ 2846 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3211	تنبيه: بطاقتك المنتهية بـ 8185 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3214	Dear customer, your account balance is $1984.19. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3215	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3216	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3219	تذكير: قسط القرض بقيمة 9142.44 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3221	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3222	التحويل المجدول اكتمل بنجاح. مرجع: 7760.	2025-11-10 00:00:00	\N	ar
3226	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3229	تنبيه: بطاقتك المنتهية بـ 2493 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3230	ستنتهي صلاحية بطاقتك المنتهية بـ 3543 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3231	تم استلام دفعة بقيمة 8376.15 في حسابك المنتهي بـ 7784. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3232	Your transaction of $5473.92 at STORE was successful. Ref: 5946.	2025-11-10 00:00:00	\N	en
3233	التحويل المجدول اكتمل بنجاح. مرجع: 8908.	2025-11-10 00:00:00	\N	ar
3235	تنبيه: بطاقتك المنتهية بـ 3106 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3236	تنبيه: بطاقتك المنتهية بـ 9206 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3237	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3239	Payment of $4896.43 received to your account ending with 6318. Thank you.	2025-11-10 00:00:00	\N	en
3241	Payment of $5760.33 received to your account ending with 8321. Thank you.	2025-11-10 00:00:00	\N	en
3242	ستنتهي صلاحية بطاقتك المنتهية بـ 1579 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3245	التحويل المجدول اكتمل بنجاح. مرجع: 2220.	2025-11-10 00:00:00	\N	ar
3246	Your online transfer of $1206.84 to account 3145 was successful.	2025-11-10 00:00:00	\N	en
3248	Your debit card ending 7641 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3249	Your scheduled transfer completed successfully. Ref: 7351.	2025-11-10 00:00:00	\N	en
3253	تنبيه: بطاقتك المنتهية بـ 5062 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3254	Reminder: Your loan payment of $5702.69 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3255	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3261	Your debit card ending 2963 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3263	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3264	Dear customer, your account balance is $4794.02. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3265	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3268	Reminder: Your loan payment of $5055.63 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3274	تنبيه: بطاقتك المنتهية بـ 8576 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3283	Your debit card ending 4658 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3285	تذكير: قسط القرض بقيمة 4927.07 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3286	رمز التحقق لعملية الدفع هو 104471. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3289	Dear customer, your account balance is $8477.72. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3290	ستنتهي صلاحية بطاقتك المنتهية بـ 4252 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3291	عزيزي العميل، رصيد حسابك هو 5427.11. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3292	Dear customer, your account balance is $3301.30. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3294	تمت عملية بقيمة 8240.45 في المتجر. مرجع: 8741.	2025-11-10 00:00:00	\N	ar
3296	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3298	Your transaction of $6175.85 at STORE was successful. Ref: 7959.	2025-11-10 00:00:00	\N	en
3302	تمت عملية بقيمة 4174.24 في المتجر. مرجع: 5609.	2025-11-10 00:00:00	\N	ar
3303	رمز التحقق لعملية الدفع هو 447937. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3305	تنبيه: بطاقتك المنتهية بـ 7628 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3307	التحويل المجدول اكتمل بنجاح. مرجع: 6042.	2025-11-10 00:00:00	\N	ar
3308	تذكير: قسط القرض بقيمة 2473.52 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3311	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3315	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3317	Your online transfer of $4420.30 to account 4448 was successful.	2025-11-10 00:00:00	\N	en
3321	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3323	ستنتهي صلاحية بطاقتك المنتهية بـ 7136 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3326	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3329	Your debit card ending 6610 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3331	التحويل المجدول اكتمل بنجاح. مرجع: 2242.	2025-11-10 00:00:00	\N	ar
3333	تذكير: قسط القرض بقيمة 734.02 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3334	تمت عملية بقيمة 4885.46 في المتجر. مرجع: 7900.	2025-11-10 00:00:00	\N	ar
3337	تمت عملية بقيمة 9670.87 في المتجر. مرجع: 2907.	2025-11-10 00:00:00	\N	ar
3339	تذكير: قسط القرض بقيمة 1230.70 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3340	التحويل المجدول اكتمل بنجاح. مرجع: 6731.	2025-11-10 00:00:00	\N	ar
3342	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3343	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3345	Your OTP for transaction is 905852. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3346	عزيزي العميل، رصيد حسابك هو 7272.66. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3347	Your OTP for transaction is 385853. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3348	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3349	Dear customer, your account balance is $9657.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3352	Reminder: Your loan payment of $929.52 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3357	التحويل المجدول اكتمل بنجاح. مرجع: 6618.	2025-11-10 00:00:00	\N	ar
3362	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3363	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3364	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3366	Reminder: Your loan payment of $6449.89 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3369	Your scheduled transfer completed successfully. Ref: 4359.	2025-11-10 00:00:00	\N	en
3370	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3371	رمز التحقق لعملية الدفع هو 878820. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3372	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3374	Your transaction of $6223.52 at STORE was successful. Ref: 2337.	2025-11-10 00:00:00	\N	en
3378	Notification: Your card ending with 3434 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3384	تذكير: قسط القرض بقيمة 5981.48 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3385	Your scheduled transfer completed successfully. Ref: 3776.	2025-11-10 00:00:00	\N	en
3387	Dear customer, your account balance is $6254.18. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3388	ستنتهي صلاحية بطاقتك المنتهية بـ 1443 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3389	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3390	ستنتهي صلاحية بطاقتك المنتهية بـ 8777 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3391	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3395	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3398	Your transaction of $5002.27 at STORE was successful. Ref: 9376.	2025-11-10 00:00:00	\N	en
3403	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3406	Your online transfer of $8989.15 to account 1644 was successful.	2025-11-10 00:00:00	\N	en
3407	Your online transfer of $7699.06 to account 4178 was successful.	2025-11-10 00:00:00	\N	en
3408	رمز التحقق لعملية الدفع هو 374829. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3410	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3411	Dear customer, your account balance is $5288.13. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3414	Dear customer, your account balance is $3992.34. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3415	Dear customer, your account balance is $975.58. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3416	تم استلام دفعة بقيمة 1194.69 في حسابك المنتهي بـ 3448. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3417	Your scheduled transfer completed successfully. Ref: 8898.	2025-11-10 00:00:00	\N	en
3423	Your online transfer of $6987.18 to account 3351 was successful.	2025-11-10 00:00:00	\N	en
3424	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3425	Payment of $1246.29 received to your account ending with 3742. Thank you.	2025-11-10 00:00:00	\N	en
3428	Your OTP for transaction is 663345. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3430	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3433	تم استلام دفعة بقيمة 9328.52 في حسابك المنتهي بـ 3274. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3439	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3441	تذكير: قسط القرض بقيمة 8389.48 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3442	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3443	Your OTP for transaction is 442524. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3444	تم استلام دفعة بقيمة 7964.68 في حسابك المنتهي بـ 1763. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3447	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3448	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3450	Dear customer, your account balance is $9828.91. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3455	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3456	التحويل المجدول اكتمل بنجاح. مرجع: 1150.	2025-11-10 00:00:00	\N	ar
3457	Your transaction of $4167.37 at STORE was successful. Ref: 7164.	2025-11-10 00:00:00	\N	en
3458	Your transaction of $5306.12 at STORE was successful. Ref: 1981.	2025-11-10 00:00:00	\N	en
3460	Your online transfer of $6721.72 to account 1690 was successful.	2025-11-10 00:00:00	\N	en
3462	Notification: Your card ending with 2566 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3463	Notification: Your card ending with 9535 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3466	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3467	Your debit card ending 2740 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3473	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3474	Your debit card ending 2411 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3475	Your transaction of $3598.64 at STORE was successful. Ref: 8672.	2025-11-10 00:00:00	\N	en
3476	عزيزي العميل، رصيد حسابك هو 3001.71. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3479	Your online transfer of $5319.98 to account 1553 was successful.	2025-11-10 00:00:00	\N	en
3481	Reminder: Your loan payment of $4668.49 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3483	تمت عملية بقيمة 6383.86 في المتجر. مرجع: 2286.	2025-11-10 00:00:00	\N	ar
3486	رمز التحقق لعملية الدفع هو 794621. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3489	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3492	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3493	Notification: Your card ending with 5387 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3494	ستنتهي صلاحية بطاقتك المنتهية بـ 5752 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3495	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3498	Your online transfer of $8779.30 to account 5468 was successful.	2025-11-10 00:00:00	\N	en
3499	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3500	Payment of $8990.90 received to your account ending with 9973. Thank you.	2025-11-10 00:00:00	\N	en
3508	Notification: Your card ending with 3639 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3510	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3511	Your scheduled transfer completed successfully. Ref: 2253.	2025-11-10 00:00:00	\N	en
3512	ستنتهي صلاحية بطاقتك المنتهية بـ 3891 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3518	التحويل المجدول اكتمل بنجاح. مرجع: 1012.	2025-11-10 00:00:00	\N	ar
3519	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3520	Your transaction of $3507.68 at STORE was successful. Ref: 9694.	2025-11-10 00:00:00	\N	en
3521	Your debit card ending 7095 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3523	Dear customer, your account balance is $9411.17. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3525	تذكير: قسط القرض بقيمة 1046.22 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3526	تنبيه: بطاقتك المنتهية بـ 9105 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3527	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3528	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3529	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3530	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3531	Your online transfer of $2649.29 to account 7239 was successful.	2025-11-10 00:00:00	\N	en
3532	تذكير: قسط القرض بقيمة 6869.63 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3533	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3539	Payment of $779.41 received to your account ending with 8531. Thank you.	2025-11-10 00:00:00	\N	en
3541	رمز التحقق لعملية الدفع هو 810168. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3542	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3546	Payment of $1600.35 received to your account ending with 1914. Thank you.	2025-11-10 00:00:00	\N	en
3550	Your online transfer of $2315.78 to account 4330 was successful.	2025-11-10 00:00:00	\N	en
3552	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3553	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3554	Dear customer, your account balance is $6462.22. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3555	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3558	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3560	رمز التحقق لعملية الدفع هو 136107. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3562	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3563	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3564	Payment of $8696.53 received to your account ending with 2842. Thank you.	2025-11-10 00:00:00	\N	en
3567	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3568	عزيزي العميل، رصيد حسابك هو 5220.48. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3569	Your online transfer of $4428.14 to account 8281 was successful.	2025-11-10 00:00:00	\N	en
3577	تذكير: قسط القرض بقيمة 7897.16 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3578	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3579	ستنتهي صلاحية بطاقتك المنتهية بـ 3693 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3580	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3582	Payment of $8561.01 received to your account ending with 1883. Thank you.	2025-11-10 00:00:00	\N	en
3583	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3587	Your online transfer of $8757.66 to account 8196 was successful.	2025-11-10 00:00:00	\N	en
3591	رمز التحقق لعملية الدفع هو 562634. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3593	Your debit card ending 7919 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3595	ستنتهي صلاحية بطاقتك المنتهية بـ 9923 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3596	تمت عملية بقيمة 5535.62 في المتجر. مرجع: 7571.	2025-11-10 00:00:00	\N	ar
3597	رمز التحقق لعملية الدفع هو 282637. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3599	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3600	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3601	Payment of $6405.87 received to your account ending with 3227. Thank you.	2025-11-10 00:00:00	\N	en
3602	Your debit card ending 1453 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3603	تمت عملية بقيمة 8997.57 في المتجر. مرجع: 8939.	2025-11-10 00:00:00	\N	ar
3604	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3605	رمز التحقق لعملية الدفع هو 401260. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3606	عزيزي العميل، رصيد حسابك هو 9983.10. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3608	Your OTP for transaction is 976024. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3609	تذكير: قسط القرض بقيمة 3026.61 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3611	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3612	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3613	تذكير: قسط القرض بقيمة 6860.22 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3614	Your OTP for transaction is 637153. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3615	تذكير: قسط القرض بقيمة 2032.64 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3618	تمت عملية بقيمة 1915.94 في المتجر. مرجع: 9618.	2025-11-10 00:00:00	\N	ar
3622	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3623	Your OTP for transaction is 534434. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3626	Payment of $945.44 received to your account ending with 2039. Thank you.	2025-11-10 00:00:00	\N	en
3627	Reminder: Your loan payment of $187.54 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3628	Payment of $8081.85 received to your account ending with 5707. Thank you.	2025-11-10 00:00:00	\N	en
3629	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3630	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3631	Your debit card ending 7138 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3632	تم استلام دفعة بقيمة 2638.87 في حسابك المنتهي بـ 7247. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3635	تنبيه: بطاقتك المنتهية بـ 7526 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3637	Payment of $3973.02 received to your account ending with 4904. Thank you.	2025-11-10 00:00:00	\N	en
3638	رمز التحقق لعملية الدفع هو 653903. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3639	Notification: Your card ending with 5375 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3640	Your transaction of $2893.16 at STORE was successful. Ref: 3823.	2025-11-10 00:00:00	\N	en
3644	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3646	Your transaction of $8374.42 at STORE was successful. Ref: 1885.	2025-11-10 00:00:00	\N	en
3648	تم استلام دفعة بقيمة 724.15 في حسابك المنتهي بـ 1754. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3649	رمز التحقق لعملية الدفع هو 427501. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3651	تم استلام دفعة بقيمة 1916.38 في حسابك المنتهي بـ 5134. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3652	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3653	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3654	تمت عملية بقيمة 2478.77 في المتجر. مرجع: 5101.	2025-11-10 00:00:00	\N	ar
3657	Payment of $274.96 received to your account ending with 3522. Thank you.	2025-11-10 00:00:00	\N	en
3658	تذكير: قسط القرض بقيمة 1814.95 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3661	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3662	عزيزي العميل، رصيد حسابك هو 5969.57. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3664	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3665	Notification: Your card ending with 8486 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3666	التحويل المجدول اكتمل بنجاح. مرجع: 8626.	2025-11-10 00:00:00	\N	ar
3668	Payment of $5467.07 received to your account ending with 7816. Thank you.	2025-11-10 00:00:00	\N	en
3671	Your transaction of $3878.30 at STORE was successful. Ref: 4863.	2025-11-10 00:00:00	\N	en
3672	Reminder: Your loan payment of $5078.16 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3673	تم استلام دفعة بقيمة 3378.91 في حسابك المنتهي بـ 4274. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3674	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3682	رمز التحقق لعملية الدفع هو 484333. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3683	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3686	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3689	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3691	Your online transfer of $6558.50 to account 2253 was successful.	2025-11-10 00:00:00	\N	en
3692	التحويل المجدول اكتمل بنجاح. مرجع: 8566.	2025-11-10 00:00:00	\N	ar
3695	Your OTP for transaction is 966631. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3701	Payment of $8888.90 received to your account ending with 2740. Thank you.	2025-11-10 00:00:00	\N	en
3704	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3707	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3710	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3712	Your online transfer of $947.54 to account 8961 was successful.	2025-11-10 00:00:00	\N	en
3713	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3714	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3719	Your transaction of $746.99 at STORE was successful. Ref: 5905.	2025-11-10 00:00:00	\N	en
3721	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3724	عزيزي العميل، رصيد حسابك هو 2847.57. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3725	Dear customer, your account balance is $5957.12. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3726	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3727	رمز التحقق لعملية الدفع هو 705693. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3731	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3735	تمت عملية بقيمة 4020.90 في المتجر. مرجع: 4977.	2025-11-10 00:00:00	\N	ar
3737	Your online transfer of $4754.25 to account 6140 was successful.	2025-11-10 00:00:00	\N	en
3741	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3743	تنبيه: بطاقتك المنتهية بـ 7798 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3744	رمز التحقق لعملية الدفع هو 233634. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3745	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3746	رمز التحقق لعملية الدفع هو 880662. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3748	Payment of $9119.49 received to your account ending with 6514. Thank you.	2025-11-10 00:00:00	\N	en
3754	Your transaction of $7660.67 at STORE was successful. Ref: 7851.	2025-11-10 00:00:00	\N	en
3759	عزيزي العميل، رصيد حسابك هو 3567.15. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3761	تمت عملية بقيمة 2079.83 في المتجر. مرجع: 3583.	2025-11-10 00:00:00	\N	ar
3764	تذكير: قسط القرض بقيمة 1244.00 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3771	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3772	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3774	تمت عملية بقيمة 3240.48 في المتجر. مرجع: 5759.	2025-11-10 00:00:00	\N	ar
3777	Reminder: Your loan payment of $5460.36 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3779	Your OTP for transaction is 989163. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3785	Your online transfer of $733.85 to account 9751 was successful.	2025-11-10 00:00:00	\N	en
3787	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3790	Your online transfer of $4813.34 to account 5916 was successful.	2025-11-10 00:00:00	\N	en
3791	رمز التحقق لعملية الدفع هو 782000. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3794	Your debit card ending 4864 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3797	Payment of $9668.30 received to your account ending with 8130. Thank you.	2025-11-10 00:00:00	\N	en
3798	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3801	تنبيه: بطاقتك المنتهية بـ 7378 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3802	Your online transfer of $2361.30 to account 3403 was successful.	2025-11-10 00:00:00	\N	en
3803	تم استلام دفعة بقيمة 3745.09 في حسابك المنتهي بـ 8553. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3804	Your scheduled transfer completed successfully. Ref: 5859.	2025-11-10 00:00:00	\N	en
3805	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3807	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3809	تمت عملية بقيمة 5292.12 في المتجر. مرجع: 1527.	2025-11-10 00:00:00	\N	ar
3810	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3815	تمت عملية بقيمة 7360.44 في المتجر. مرجع: 4266.	2025-11-10 00:00:00	\N	ar
3818	تنبيه: بطاقتك المنتهية بـ 3658 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3820	التحويل المجدول اكتمل بنجاح. مرجع: 7269.	2025-11-10 00:00:00	\N	ar
3821	تنبيه: بطاقتك المنتهية بـ 2116 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3822	تنبيه: بطاقتك المنتهية بـ 3886 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3823	Your debit card ending 5383 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3824	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3825	تنبيه: بطاقتك المنتهية بـ 3520 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3826	Your online transfer of $7991.66 to account 2727 was successful.	2025-11-10 00:00:00	\N	en
3828	Notification: Your card ending with 7495 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
3829	Reminder: Your loan payment of $4612.60 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3837	تنبيه: بطاقتك المنتهية بـ 8695 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3839	Dear customer, your account balance is $2154.08. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3840	رمز التحقق لعملية الدفع هو 575938. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
3842	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3843	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3844	Your transaction of $7261.70 at STORE was successful. Ref: 2687.	2025-11-10 00:00:00	\N	en
3845	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3848	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3851	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3852	تنبيه: بطاقتك المنتهية بـ 6367 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3853	Your transaction of $1177.53 at STORE was successful. Ref: 2541.	2025-11-10 00:00:00	\N	en
3976	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3857	تم استلام دفعة بقيمة 807.42 في حسابك المنتهي بـ 3518. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3859	تم استلام دفعة بقيمة 3194.76 في حسابك المنتهي بـ 2132. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3861	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3862	عزيزي العميل، رصيد حسابك هو 2595.35. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3865	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3866	Dear customer, your account balance is $1601.73. Visit our branch for details.	2025-11-10 00:00:00	\N	en
3867	Your debit card ending 1838 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3872	Your online transfer of $6801.86 to account 2034 was successful.	2025-11-10 00:00:00	\N	en
3873	تمت عملية بقيمة 9441.65 في المتجر. مرجع: 5087.	2025-11-10 00:00:00	\N	ar
3874	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3877	Reminder: Your loan payment of $2013.52 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3878	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3879	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3880	Payment of $6216.69 received to your account ending with 9584. Thank you.	2025-11-10 00:00:00	\N	en
3881	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3882	Your debit card ending 1760 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3883	Payment of $9778.55 received to your account ending with 4787. Thank you.	2025-11-10 00:00:00	\N	en
3884	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3887	تنبيه: بطاقتك المنتهية بـ 2579 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3888	Your online transfer of $8613.57 to account 4556 was successful.	2025-11-10 00:00:00	\N	en
3889	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3890	تذكير: قسط القرض بقيمة 2409.16 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3891	تنبيه: بطاقتك المنتهية بـ 6712 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3892	Your transaction of $6059.87 at STORE was successful. Ref: 6980.	2025-11-10 00:00:00	\N	en
3893	تم استلام دفعة بقيمة 2270.74 في حسابك المنتهي بـ 8972. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3897	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3899	التحويل المجدول اكتمل بنجاح. مرجع: 3162.	2025-11-10 00:00:00	\N	ar
3908	ستنتهي صلاحية بطاقتك المنتهية بـ 4977 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3909	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3910	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3913	Your transaction of $3579.60 at STORE was successful. Ref: 9054.	2025-11-10 00:00:00	\N	en
3914	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3916	Your transaction of $1539.11 at STORE was successful. Ref: 2019.	2025-11-10 00:00:00	\N	en
3917	Your OTP for transaction is 578742. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
3918	تم استلام دفعة بقيمة 5496.63 في حسابك المنتهي بـ 3808. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3919	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3921	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3924	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
3925	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3928	تنبيه: بطاقتك المنتهية بـ 6336 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3929	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3930	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3931	Your debit card ending 3155 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3935	Payment of $4662.36 received to your account ending with 9580. Thank you.	2025-11-10 00:00:00	\N	en
3938	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
3946	تذكير: قسط القرض بقيمة 4641.77 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
3947	تمت عملية بقيمة 8092.86 في المتجر. مرجع: 2298.	2025-11-10 00:00:00	\N	ar
3948	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
3950	ستنتهي صلاحية بطاقتك المنتهية بـ 6288 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
3952	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3953	Reminder: Your loan payment of $256.54 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3955	تم استلام دفعة بقيمة 6686.21 في حسابك المنتهي بـ 1177. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3960	عزيزي العميل، رصيد حسابك هو 4626.50. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3961	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3966	Your online transfer of $1028.00 to account 8425 was successful.	2025-11-10 00:00:00	\N	en
3968	التحويل المجدول اكتمل بنجاح. مرجع: 9273.	2025-11-10 00:00:00	\N	ar
3969	عزيزي العميل، رصيد حسابك هو 6700.88. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
3972	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3978	Your online transfer of $379.75 to account 9604 was successful.	2025-11-10 00:00:00	\N	en
3979	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
3980	Reminder: Your loan payment of $4470.96 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
3981	تنبيه: بطاقتك المنتهية بـ 2837 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
3982	تمت عملية بقيمة 4043.18 في المتجر. مرجع: 5437.	2025-11-10 00:00:00	\N	ar
3983	Your transaction of $3279.90 at STORE was successful. Ref: 3274.	2025-11-10 00:00:00	\N	en
3985	Your debit card ending 4362 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3986	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3987	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
3989	تم استلام دفعة بقيمة 1621.84 في حسابك المنتهي بـ 3462. شكرًا لك.	2025-11-10 00:00:00	\N	ar
3992	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
3993	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
3995	Your debit card ending 8323 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
3998	Payment of $4658.21 received to your account ending with 2144. Thank you.	2025-11-10 00:00:00	\N	en
4000	Your scheduled transfer completed successfully. Ref: 7832.	2025-11-10 00:00:00	\N	en
4001	Your scheduled transfer completed successfully. Ref: 7755.	2025-11-10 00:00:00	\N	en
4003	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4006	Payment of $6752.74 received to your account ending with 4954. Thank you.	2025-11-10 00:00:00	\N	en
4007	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4008	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4009	Your debit card ending 4102 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4013	Your OTP for transaction is 449976. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4016	Your online transfer of $9431.48 to account 4532 was successful.	2025-11-10 00:00:00	\N	en
4017	ستنتهي صلاحية بطاقتك المنتهية بـ 4733 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4019	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4020	ستنتهي صلاحية بطاقتك المنتهية بـ 5480 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4021	Your online transfer of $5134.68 to account 7992 was successful.	2025-11-10 00:00:00	\N	en
4022	تم استلام دفعة بقيمة 5614.02 في حسابك المنتهي بـ 8203. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4024	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4025	التحويل المجدول اكتمل بنجاح. مرجع: 4997.	2025-11-10 00:00:00	\N	ar
4027	Payment of $7170.66 received to your account ending with 8890. Thank you.	2025-11-10 00:00:00	\N	en
4029	عزيزي العميل، رصيد حسابك هو 8678.10. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4031	Notification: Your card ending with 6823 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4032	رمز التحقق لعملية الدفع هو 162995. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4033	تم استلام دفعة بقيمة 2448.42 في حسابك المنتهي بـ 4066. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4034	Your scheduled transfer completed successfully. Ref: 8366.	2025-11-10 00:00:00	\N	en
4035	Dear customer, your account balance is $5467.08. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4036	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4038	Reminder: Your loan payment of $8571.11 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4041	Your debit card ending 8098 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4042	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4046	Dear customer, your account balance is $1372.09. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4047	Reminder: Your loan payment of $2049.79 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4051	تنبيه: بطاقتك المنتهية بـ 9086 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4052	تمت عملية بقيمة 6587.71 في المتجر. مرجع: 1701.	2025-11-10 00:00:00	\N	ar
4053	Reminder: Your loan payment of $6732.38 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4056	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4058	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4059	Dear customer, your account balance is $6730.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4060	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4062	Your scheduled transfer completed successfully. Ref: 2088.	2025-11-10 00:00:00	\N	en
4063	تم استلام دفعة بقيمة 1269.53 في حسابك المنتهي بـ 7545. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4064	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4066	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4067	Your transaction of $4203.53 at STORE was successful. Ref: 5876.	2025-11-10 00:00:00	\N	en
4068	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4071	تم استلام دفعة بقيمة 1894.60 في حسابك المنتهي بـ 7427. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4074	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4075	Your OTP for transaction is 333296. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4076	تمت عملية بقيمة 2206.19 في المتجر. مرجع: 9175.	2025-11-10 00:00:00	\N	ar
4080	Notification: Your card ending with 1354 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4084	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4085	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4087	Your scheduled transfer completed successfully. Ref: 3896.	2025-11-10 00:00:00	\N	en
4089	التحويل المجدول اكتمل بنجاح. مرجع: 8746.	2025-11-10 00:00:00	\N	ar
4090	تنبيه: بطاقتك المنتهية بـ 5784 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4092	تم استلام دفعة بقيمة 3392.94 في حسابك المنتهي بـ 6733. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4093	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4097	تمت عملية بقيمة 1283.49 في المتجر. مرجع: 9497.	2025-11-10 00:00:00	\N	ar
4098	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4099	Your OTP for transaction is 140563. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4101	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4104	ستنتهي صلاحية بطاقتك المنتهية بـ 4899 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4106	تذكير: قسط القرض بقيمة 7964.07 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4112	تم استلام دفعة بقيمة 9882.27 في حسابك المنتهي بـ 3823. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4113	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4115	Your online transfer of $4662.43 to account 3949 was successful.	2025-11-10 00:00:00	\N	en
4116	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4119	Your scheduled transfer completed successfully. Ref: 6965.	2025-11-10 00:00:00	\N	en
4124	تنبيه: بطاقتك المنتهية بـ 4810 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4125	Your debit card ending 4788 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4131	التحويل المجدول اكتمل بنجاح. مرجع: 2958.	2025-11-10 00:00:00	\N	ar
4133	Dear customer, your account balance is $9839.01. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4135	تنبيه: بطاقتك المنتهية بـ 3866 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4137	عزيزي العميل، رصيد حسابك هو 7264.10. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4146	Reminder: Your loan payment of $6487.32 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4147	Your OTP for transaction is 473331. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4151	رمز التحقق لعملية الدفع هو 319372. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4152	Your online transfer of $9792.94 to account 5192 was successful.	2025-11-10 00:00:00	\N	en
4158	Your debit card ending 5820 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4160	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4162	Your scheduled transfer completed successfully. Ref: 5817.	2025-11-10 00:00:00	\N	en
4168	ستنتهي صلاحية بطاقتك المنتهية بـ 3586 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4173	Reminder: Your loan payment of $8861.38 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4176	Reminder: Your loan payment of $2296.11 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4177	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4181	Your online transfer of $8586.71 to account 1098 was successful.	2025-11-10 00:00:00	\N	en
4184	Notification: Your card ending with 9075 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4185	التحويل المجدول اكتمل بنجاح. مرجع: 2537.	2025-11-10 00:00:00	\N	ar
4186	ستنتهي صلاحية بطاقتك المنتهية بـ 5135 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4188	Notification: Your card ending with 8958 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4190	Your online transfer of $6265.55 to account 8571 was successful.	2025-11-10 00:00:00	\N	en
4191	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4192	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4194	عزيزي العميل، رصيد حسابك هو 7651.25. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4197	Your transaction of $3337.78 at STORE was successful. Ref: 1633.	2025-11-10 00:00:00	\N	en
4203	Your scheduled transfer completed successfully. Ref: 7535.	2025-11-10 00:00:00	\N	en
4204	Dear customer, your account balance is $5239.10. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4209	Dear customer, your account balance is $1079.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4210	Your scheduled transfer completed successfully. Ref: 2475.	2025-11-10 00:00:00	\N	en
4211	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4212	تنبيه: بطاقتك المنتهية بـ 5690 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4213	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4214	تم استلام دفعة بقيمة 5266.27 في حسابك المنتهي بـ 5438. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4216	التحويل المجدول اكتمل بنجاح. مرجع: 4240.	2025-11-10 00:00:00	\N	ar
4217	Your online transfer of $8495.27 to account 4870 was successful.	2025-11-10 00:00:00	\N	en
4218	Your debit card ending 4022 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4221	تذكير: قسط القرض بقيمة 4646.38 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4227	Notification: Your card ending with 1693 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4339	تذكير: قسط القرض بقيمة 2017.15 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4228	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4229	Your online transfer of $7716.86 to account 8824 was successful.	2025-11-10 00:00:00	\N	en
4230	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4232	عزيزي العميل، رصيد حسابك هو 1525.08. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4233	Your online transfer of $6656.93 to account 9764 was successful.	2025-11-10 00:00:00	\N	en
4235	تذكير: قسط القرض بقيمة 4651.40 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4241	Your transaction of $3814.65 at STORE was successful. Ref: 4399.	2025-11-10 00:00:00	\N	en
4242	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4243	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4246	Your OTP for transaction is 630205. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4248	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4249	Your transaction of $9065.36 at STORE was successful. Ref: 5680.	2025-11-10 00:00:00	\N	en
4250	تم استلام دفعة بقيمة 7940.24 في حسابك المنتهي بـ 4306. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4252	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4256	Your debit card ending 3883 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4257	Your OTP for transaction is 119457. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4262	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4263	Dear customer, your account balance is $4729.87. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4264	رمز التحقق لعملية الدفع هو 647570. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4265	Your transaction of $9348.64 at STORE was successful. Ref: 7609.	2025-11-10 00:00:00	\N	en
4267	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4268	التحويل المجدول اكتمل بنجاح. مرجع: 5264.	2025-11-10 00:00:00	\N	ar
4270	Your transaction of $7387.94 at STORE was successful. Ref: 9748.	2025-11-10 00:00:00	\N	en
4272	Reminder: Your loan payment of $3605.21 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4273	عزيزي العميل، رصيد حسابك هو 4795.07. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4275	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4278	تنبيه: بطاقتك المنتهية بـ 4021 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4279	عزيزي العميل، رصيد حسابك هو 3654.16. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4280	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4281	Payment of $9347.15 received to your account ending with 2743. Thank you.	2025-11-10 00:00:00	\N	en
4282	ستنتهي صلاحية بطاقتك المنتهية بـ 1629 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4283	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4284	ستنتهي صلاحية بطاقتك المنتهية بـ 7040 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4285	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4288	Reminder: Your loan payment of $6161.86 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4289	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4290	Your OTP for transaction is 706047. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4292	رمز التحقق لعملية الدفع هو 700282. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4294	Notification: Your card ending with 9308 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4295	Notification: Your card ending with 9733 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4297	رمز التحقق لعملية الدفع هو 851738. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4298	Payment of $6860.97 received to your account ending with 3755. Thank you.	2025-11-10 00:00:00	\N	en
4299	تم استلام دفعة بقيمة 4482.13 في حسابك المنتهي بـ 8236. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4300	رمز التحقق لعملية الدفع هو 411770. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4301	التحويل المجدول اكتمل بنجاح. مرجع: 9437.	2025-11-10 00:00:00	\N	ar
4303	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4306	Reminder: Your loan payment of $2890.76 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4309	Your scheduled transfer completed successfully. Ref: 2759.	2025-11-10 00:00:00	\N	en
4312	ستنتهي صلاحية بطاقتك المنتهية بـ 8471 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4316	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4325	Your online transfer of $3008.82 to account 1794 was successful.	2025-11-10 00:00:00	\N	en
4326	تم استلام دفعة بقيمة 3156.24 في حسابك المنتهي بـ 1061. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4327	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4328	تذكير: قسط القرض بقيمة 8545.04 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4329	تم استلام دفعة بقيمة 5936.49 في حسابك المنتهي بـ 5835. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4330	التحويل المجدول اكتمل بنجاح. مرجع: 1776.	2025-11-10 00:00:00	\N	ar
4331	التحويل المجدول اكتمل بنجاح. مرجع: 3879.	2025-11-10 00:00:00	\N	ar
4335	التحويل المجدول اكتمل بنجاح. مرجع: 1714.	2025-11-10 00:00:00	\N	ar
4341	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4343	تمت عملية بقيمة 7874.20 في المتجر. مرجع: 4720.	2025-11-10 00:00:00	\N	ar
4345	التحويل المجدول اكتمل بنجاح. مرجع: 3242.	2025-11-10 00:00:00	\N	ar
4347	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4349	Your transaction of $6898.69 at STORE was successful. Ref: 3270.	2025-11-10 00:00:00	\N	en
4350	Reminder: Your loan payment of $671.27 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4351	تذكير: قسط القرض بقيمة 5978.28 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4353	Payment of $4390.79 received to your account ending with 4284. Thank you.	2025-11-10 00:00:00	\N	en
4356	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4360	Your debit card ending 2304 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4361	ستنتهي صلاحية بطاقتك المنتهية بـ 2132 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4362	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4363	تنبيه: بطاقتك المنتهية بـ 7716 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4365	Payment of $16.03 received to your account ending with 6619. Thank you.	2025-11-10 00:00:00	\N	en
4366	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4370	Reminder: Your loan payment of $7689.64 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4373	التحويل المجدول اكتمل بنجاح. مرجع: 8772.	2025-11-10 00:00:00	\N	ar
4376	التحويل المجدول اكتمل بنجاح. مرجع: 9152.	2025-11-10 00:00:00	\N	ar
4377	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4379	تذكير: قسط القرض بقيمة 5349.80 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4380	تم استلام دفعة بقيمة 3613.58 في حسابك المنتهي بـ 1048. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4381	عزيزي العميل، رصيد حسابك هو 2060.89. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4382	Payment of $3073.09 received to your account ending with 6236. Thank you.	2025-11-10 00:00:00	\N	en
4385	عزيزي العميل، رصيد حسابك هو 1131.47. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4386	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4388	Your OTP for transaction is 125688. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4390	Your transaction of $5514.32 at STORE was successful. Ref: 1762.	2025-11-10 00:00:00	\N	en
4395	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4398	التحويل المجدول اكتمل بنجاح. مرجع: 5734.	2025-11-10 00:00:00	\N	ar
4400	رمز التحقق لعملية الدفع هو 869752. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4404	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4408	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4409	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4413	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4415	Your online transfer of $4470.13 to account 7324 was successful.	2025-11-10 00:00:00	\N	en
4419	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4420	رمز التحقق لعملية الدفع هو 393743. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4421	تنبيه: بطاقتك المنتهية بـ 3687 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4423	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4424	تم استلام دفعة بقيمة 3971.67 في حسابك المنتهي بـ 8446. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4425	التحويل المجدول اكتمل بنجاح. مرجع: 8015.	2025-11-10 00:00:00	\N	ar
4431	Your OTP for transaction is 774956. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4432	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4434	Payment of $3961.15 received to your account ending with 5981. Thank you.	2025-11-10 00:00:00	\N	en
4437	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4441	تذكير: قسط القرض بقيمة 5279.96 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4443	رمز التحقق لعملية الدفع هو 636116. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4444	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4447	Your online transfer of $1319.96 to account 9878 was successful.	2025-11-10 00:00:00	\N	en
4448	Your transaction of $4305.99 at STORE was successful. Ref: 1606.	2025-11-10 00:00:00	\N	en
4453	Your transaction of $1765.34 at STORE was successful. Ref: 6782.	2025-11-10 00:00:00	\N	en
4454	Your debit card ending 8881 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4455	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4463	عزيزي العميل، رصيد حسابك هو 5368.72. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4465	تمت عملية بقيمة 768.87 في المتجر. مرجع: 1782.	2025-11-10 00:00:00	\N	ar
4467	Your scheduled transfer completed successfully. Ref: 5129.	2025-11-10 00:00:00	\N	en
4469	Notification: Your card ending with 7013 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4470	Your scheduled transfer completed successfully. Ref: 7682.	2025-11-10 00:00:00	\N	en
4471	Your debit card ending 3007 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4472	تذكير: قسط القرض بقيمة 1969.36 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4473	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4474	Payment of $6691.02 received to your account ending with 9182. Thank you.	2025-11-10 00:00:00	\N	en
4475	Reminder: Your loan payment of $2515.09 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4476	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4477	عزيزي العميل، رصيد حسابك هو 9153.35. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4478	تذكير: قسط القرض بقيمة 8482.57 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4488	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4489	تنبيه: بطاقتك المنتهية بـ 7399 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4491	Your transaction of $2656.89 at STORE was successful. Ref: 1123.	2025-11-10 00:00:00	\N	en
4492	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4493	رمز التحقق لعملية الدفع هو 321626. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4494	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4495	Your online transfer of $4898.92 to account 1433 was successful.	2025-11-10 00:00:00	\N	en
4496	ستنتهي صلاحية بطاقتك المنتهية بـ 2070 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4498	عزيزي العميل، رصيد حسابك هو 2836.92. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4500	Your transaction of $2400.42 at STORE was successful. Ref: 7807.	2025-11-10 00:00:00	\N	en
4502	التحويل المجدول اكتمل بنجاح. مرجع: 8995.	2025-11-10 00:00:00	\N	ar
4503	تذكير: قسط القرض بقيمة 1689.22 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4505	التحويل المجدول اكتمل بنجاح. مرجع: 3690.	2025-11-10 00:00:00	\N	ar
4509	ستنتهي صلاحية بطاقتك المنتهية بـ 2560 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4510	Your scheduled transfer completed successfully. Ref: 3807.	2025-11-10 00:00:00	\N	en
4515	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4516	تنبيه: بطاقتك المنتهية بـ 2500 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4518	Your online transfer of $7117.80 to account 2313 was successful.	2025-11-10 00:00:00	\N	en
4519	رمز التحقق لعملية الدفع هو 872466. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4522	Notification: Your card ending with 7251 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4523	التحويل المجدول اكتمل بنجاح. مرجع: 9888.	2025-11-10 00:00:00	\N	ar
4525	Your OTP for transaction is 484137. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4526	تم استلام دفعة بقيمة 7262.36 في حسابك المنتهي بـ 7994. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4527	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4528	تذكير: قسط القرض بقيمة 6078.37 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4530	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4532	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4533	Dear customer, your account balance is $1652.19. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4534	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4535	تم استلام دفعة بقيمة 3036.90 في حسابك المنتهي بـ 1018. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4536	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4537	تم استلام دفعة بقيمة 300.02 في حسابك المنتهي بـ 8191. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4538	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4539	Payment of $5762.57 received to your account ending with 3268. Thank you.	2025-11-10 00:00:00	\N	en
4540	تنبيه: بطاقتك المنتهية بـ 6934 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4543	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4544	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4545	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4548	Reminder: Your loan payment of $6531.17 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4549	Your transaction of $7735.53 at STORE was successful. Ref: 8791.	2025-11-10 00:00:00	\N	en
4550	تم استلام دفعة بقيمة 1626.27 في حسابك المنتهي بـ 1093. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4553	Your OTP for transaction is 425733. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4558	التحويل المجدول اكتمل بنجاح. مرجع: 6909.	2025-11-10 00:00:00	\N	ar
4559	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4560	تذكير: قسط القرض بقيمة 9917.03 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4561	تم استلام دفعة بقيمة 8920.03 في حسابك المنتهي بـ 4473. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4569	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4571	عزيزي العميل، رصيد حسابك هو 4373.20. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4572	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4573	Your debit card ending 1325 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4575	عزيزي العميل، رصيد حسابك هو 6770.73. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4576	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4577	تم استلام دفعة بقيمة 444.19 في حسابك المنتهي بـ 4630. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4578	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4581	Your transaction of $6440.82 at STORE was successful. Ref: 6628.	2025-11-10 00:00:00	\N	en
4583	Reminder: Your loan payment of $6588.79 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4585	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4586	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4591	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4594	Your online transfer of $9128.20 to account 4617 was successful.	2025-11-10 00:00:00	\N	en
4596	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4598	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4599	Your transaction of $566.58 at STORE was successful. Ref: 8940.	2025-11-10 00:00:00	\N	en
4600	Your online transfer of $3332.05 to account 4213 was successful.	2025-11-10 00:00:00	\N	en
4601	Your scheduled transfer completed successfully. Ref: 7802.	2025-11-10 00:00:00	\N	en
4605	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4607	التحويل المجدول اكتمل بنجاح. مرجع: 7869.	2025-11-10 00:00:00	\N	ar
4608	Your transaction of $5958.04 at STORE was successful. Ref: 5431.	2025-11-10 00:00:00	\N	en
4609	Notification: Your card ending with 5588 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4610	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4612	تنبيه: بطاقتك المنتهية بـ 9593 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4613	Payment of $6662.49 received to your account ending with 4894. Thank you.	2025-11-10 00:00:00	\N	en
4614	Your debit card ending 3692 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4617	Your OTP for transaction is 676806. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4619	Your transaction of $7580.16 at STORE was successful. Ref: 6149.	2025-11-10 00:00:00	\N	en
4621	تذكير: قسط القرض بقيمة 8404.62 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4623	Your OTP for transaction is 827018. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4625	تنبيه: بطاقتك المنتهية بـ 5501 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4629	Payment of $3395.39 received to your account ending with 4077. Thank you.	2025-11-10 00:00:00	\N	en
4631	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4632	Your online transfer of $9891.23 to account 5706 was successful.	2025-11-10 00:00:00	\N	en
4633	Notification: Your card ending with 1041 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4634	Reminder: Your loan payment of $5686.36 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4636	التحويل المجدول اكتمل بنجاح. مرجع: 3187.	2025-11-10 00:00:00	\N	ar
4638	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4639	تذكير: قسط القرض بقيمة 7112.94 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4640	تذكير: قسط القرض بقيمة 4884.09 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4641	Reminder: Your loan payment of $2823.73 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4642	عزيزي العميل، رصيد حسابك هو 5078.94. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4644	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4645	عزيزي العميل، رصيد حسابك هو 967.80. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4647	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4649	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4651	تذكير: قسط القرض بقيمة 8489.41 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4654	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4657	التحويل المجدول اكتمل بنجاح. مرجع: 1894.	2025-11-10 00:00:00	\N	ar
4658	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4659	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4660	تمت عملية بقيمة 2677.75 في المتجر. مرجع: 1493.	2025-11-10 00:00:00	\N	ar
4663	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4664	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4672	Your scheduled transfer completed successfully. Ref: 4869.	2025-11-10 00:00:00	\N	en
4675	Your online transfer of $1654.91 to account 9836 was successful.	2025-11-10 00:00:00	\N	en
4676	Your transaction of $7158.54 at STORE was successful. Ref: 1839.	2025-11-10 00:00:00	\N	en
4679	Your scheduled transfer completed successfully. Ref: 7685.	2025-11-10 00:00:00	\N	en
4680	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4682	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4685	تمت عملية بقيمة 9811.86 في المتجر. مرجع: 2904.	2025-11-10 00:00:00	\N	ar
4693	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4696	تذكير: قسط القرض بقيمة 5009.47 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4697	تذكير: قسط القرض بقيمة 2301.96 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4702	Your transaction of $2329.28 at STORE was successful. Ref: 6765.	2025-11-10 00:00:00	\N	en
4703	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4704	Your OTP for transaction is 432353. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4706	ستنتهي صلاحية بطاقتك المنتهية بـ 5284 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4707	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4710	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4712	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4714	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4718	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4721	Your transaction of $7030.31 at STORE was successful. Ref: 3850.	2025-11-10 00:00:00	\N	en
4725	Your OTP for transaction is 666608. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4727	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4730	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4731	تنبيه: بطاقتك المنتهية بـ 3219 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4733	تمت عملية بقيمة 8369.92 في المتجر. مرجع: 5892.	2025-11-10 00:00:00	\N	ar
4740	Your transaction of $4992.87 at STORE was successful. Ref: 2226.	2025-11-10 00:00:00	\N	en
4743	تنبيه: بطاقتك المنتهية بـ 3781 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4744	Your online transfer of $6131.29 to account 4306 was successful.	2025-11-10 00:00:00	\N	en
4745	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4747	Reminder: Your loan payment of $7859.37 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4748	Your OTP for transaction is 837008. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4749	Your debit card ending 9682 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4751	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4755	Your debit card ending 6275 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4758	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4761	رمز التحقق لعملية الدفع هو 477158. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4764	Notification: Your card ending with 3787 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4765	Payment of $4843.30 received to your account ending with 7863. Thank you.	2025-11-10 00:00:00	\N	en
4766	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4767	Notification: Your card ending with 7618 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4769	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4770	Your OTP for transaction is 801520. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4771	Your debit card ending 1993 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4773	عزيزي العميل، رصيد حسابك هو 2401.71. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4777	Your scheduled transfer completed successfully. Ref: 1497.	2025-11-10 00:00:00	\N	en
4778	تنبيه: بطاقتك المنتهية بـ 3281 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4782	Your online transfer of $5192.54 to account 6246 was successful.	2025-11-10 00:00:00	\N	en
4785	رمز التحقق لعملية الدفع هو 499491. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4786	تمت عملية بقيمة 1768.94 في المتجر. مرجع: 6074.	2025-11-10 00:00:00	\N	ar
4787	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4790	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4793	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4794	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4795	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4796	تمت عملية بقيمة 4322.04 في المتجر. مرجع: 4600.	2025-11-10 00:00:00	\N	ar
4797	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4802	التحويل المجدول اكتمل بنجاح. مرجع: 6525.	2025-11-10 00:00:00	\N	ar
4807	Notification: Your card ending with 5241 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4808	Reminder: Your loan payment of $2750.33 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4810	Dear customer, your account balance is $9942.39. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4811	تذكير: قسط القرض بقيمة 7699.21 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4812	Your debit card ending 9132 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
4814	تمت عملية بقيمة 7484.84 في المتجر. مرجع: 3747.	2025-11-10 00:00:00	\N	ar
4818	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4819	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4831	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4833	تمت عملية بقيمة 7828.45 في المتجر. مرجع: 1483.	2025-11-10 00:00:00	\N	ar
4836	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4839	التحويل المجدول اكتمل بنجاح. مرجع: 1845.	2025-11-10 00:00:00	\N	ar
4840	عزيزي العميل، رصيد حسابك هو 445.44. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4841	ستنتهي صلاحية بطاقتك المنتهية بـ 9427 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4844	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4851	Dear customer, your account balance is $3688.64. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4852	Your transaction of $8301.34 at STORE was successful. Ref: 5431.	2025-11-10 00:00:00	\N	en
4853	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4855	تنبيه: بطاقتك المنتهية بـ 8265 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
4857	Payment of $3962.27 received to your account ending with 1862. Thank you.	2025-11-10 00:00:00	\N	en
4860	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4861	ستنتهي صلاحية بطاقتك المنتهية بـ 1398 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4863	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4864	Dear customer, your account balance is $677.76. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4865	تم استلام دفعة بقيمة 9781.92 في حسابك المنتهي بـ 7190. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4866	Your scheduled transfer completed successfully. Ref: 1223.	2025-11-10 00:00:00	\N	en
4868	تم استلام دفعة بقيمة 260.42 في حسابك المنتهي بـ 7283. شكرًا لك.	2025-11-10 00:00:00	\N	ar
4871	Reminder: Your loan payment of $4799.54 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4872	تذكير: قسط القرض بقيمة 2739.55 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4873	ستنتهي صلاحية بطاقتك المنتهية بـ 8540 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4875	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4876	Payment of $776.91 received to your account ending with 3092. Thank you.	2025-11-10 00:00:00	\N	en
4880	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4881	Your online transfer of $9021.49 to account 8754 was successful.	2025-11-10 00:00:00	\N	en
4882	ستنتهي صلاحية بطاقتك المنتهية بـ 2009 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4883	تذكير: قسط القرض بقيمة 8171.52 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
4885	رمز التحقق لعملية الدفع هو 921555. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4889	Payment of $4948.36 received to your account ending with 8055. Thank you.	2025-11-10 00:00:00	\N	en
4890	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
4892	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4893	Your online transfer of $5315.08 to account 1105 was successful.	2025-11-10 00:00:00	\N	en
4894	عزيزي العميل، رصيد حسابك هو 2451.13. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4901	Your OTP for transaction is 907184. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4902	Notification: Your card ending with 4565 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4903	رمز التحقق لعملية الدفع هو 967663. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4905	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
4908	التحويل المجدول اكتمل بنجاح. مرجع: 3616.	2025-11-10 00:00:00	\N	ar
4910	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4911	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4913	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4917	عزيزي العميل، رصيد حسابك هو 2858.89. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4924	Your transaction of $9759.53 at STORE was successful. Ref: 2585.	2025-11-10 00:00:00	\N	en
4925	عزيزي العميل، رصيد حسابك هو 7016.50. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
4926	Your scheduled transfer completed successfully. Ref: 4382.	2025-11-10 00:00:00	\N	en
4929	Notification: Your card ending with 5240 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4930	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4932	Dear customer, your account balance is $7275.43. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4933	Your transaction of $8724.18 at STORE was successful. Ref: 5387.	2025-11-10 00:00:00	\N	en
4935	Notification: Your card ending with 9708 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4940	رمز التحقق لعملية الدفع هو 611341. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4945	رمز التحقق لعملية الدفع هو 343030. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
4946	ستنتهي صلاحية بطاقتك المنتهية بـ 3862 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4947	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4952	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
4954	Your scheduled transfer completed successfully. Ref: 4635.	2025-11-10 00:00:00	\N	en
4955	تمت عملية بقيمة 3716.94 في المتجر. مرجع: 8792.	2025-11-10 00:00:00	\N	ar
4956	Payment of $6396.59 received to your account ending with 9410. Thank you.	2025-11-10 00:00:00	\N	en
4958	Payment of $6210.69 received to your account ending with 7947. Thank you.	2025-11-10 00:00:00	\N	en
4959	ستنتهي صلاحية بطاقتك المنتهية بـ 4503 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
4964	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4966	Reminder: Your loan payment of $2183.56 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
4968	Your OTP for transaction is 981988. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
4971	Notification: Your card ending with 9222 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4974	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
4979	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
4981	Notification: Your card ending with 5390 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
4983	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
4986	Dear customer, your account balance is $749.26. Visit our branch for details.	2025-11-10 00:00:00	\N	en
4992	تمت عملية بقيمة 5767.05 في المتجر. مرجع: 9394.	2025-11-10 00:00:00	\N	ar
4993	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
4995	Your scheduled transfer completed successfully. Ref: 5115.	2025-11-10 00:00:00	\N	en
4996	Your scheduled transfer completed successfully. Ref: 3866.	2025-11-10 00:00:00	\N	en
4997	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5001	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5002	Dear customer, your account balance is $6936.02. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5005	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5006	تذكير: قسط القرض بقيمة 8671.21 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5007	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5009	Your online transfer of $499.28 to account 4659 was successful.	2025-11-10 00:00:00	\N	en
5010	ستنتهي صلاحية بطاقتك المنتهية بـ 1502 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5012	Your transaction of $8235.01 at STORE was successful. Ref: 3045.	2025-11-10 00:00:00	\N	en
5013	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5018	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5019	تنبيه: بطاقتك المنتهية بـ 2639 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5021	Notification: Your card ending with 3753 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5022	تم استلام دفعة بقيمة 5917.53 في حسابك المنتهي بـ 4054. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5023	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5025	Your debit card ending 3368 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5026	تنبيه: بطاقتك المنتهية بـ 8704 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5027	رمز التحقق لعملية الدفع هو 583130. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5028	Your debit card ending 5129 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5029	تمت عملية بقيمة 8686.74 في المتجر. مرجع: 4602.	2025-11-10 00:00:00	\N	ar
5030	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5031	عزيزي العميل، رصيد حسابك هو 5587.19. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5033	تمت عملية بقيمة 5766.81 في المتجر. مرجع: 9982.	2025-11-10 00:00:00	\N	ar
5034	Your OTP for transaction is 646328. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5035	تمت عملية بقيمة 5734.30 في المتجر. مرجع: 2840.	2025-11-10 00:00:00	\N	ar
5037	Your OTP for transaction is 989085. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5040	Your debit card ending 8643 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5043	تذكير: قسط القرض بقيمة 2038.42 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5044	Your transaction of $8281.40 at STORE was successful. Ref: 1979.	2025-11-10 00:00:00	\N	en
5045	تنبيه: بطاقتك المنتهية بـ 4092 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5046	Payment of $5931.99 received to your account ending with 4553. Thank you.	2025-11-10 00:00:00	\N	en
5048	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5049	رمز التحقق لعملية الدفع هو 235166. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5050	تنبيه: بطاقتك المنتهية بـ 6386 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5053	Notification: Your card ending with 9796 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5056	عزيزي العميل، رصيد حسابك هو 1074.20. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5060	Your scheduled transfer completed successfully. Ref: 9500.	2025-11-10 00:00:00	\N	en
5063	رمز التحقق لعملية الدفع هو 691005. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5065	Reminder: Your loan payment of $1525.18 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5067	تنبيه: بطاقتك المنتهية بـ 6483 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5069	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5073	تنبيه: بطاقتك المنتهية بـ 2000 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5075	رمز التحقق لعملية الدفع هو 799754. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5076	Your OTP for transaction is 628566. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5077	Dear customer, your account balance is $3068.66. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5078	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5079	تذكير: قسط القرض بقيمة 9099.95 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5080	Dear customer, your account balance is $3518.33. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5082	تمت عملية بقيمة 7894.81 في المتجر. مرجع: 6046.	2025-11-10 00:00:00	\N	ar
5083	عزيزي العميل، رصيد حسابك هو 1417.54. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5084	تذكير: قسط القرض بقيمة 9698.84 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5086	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5087	تذكير: قسط القرض بقيمة 6852.84 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5094	التحويل المجدول اكتمل بنجاح. مرجع: 2214.	2025-11-10 00:00:00	\N	ar
5095	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5096	عزيزي العميل، رصيد حسابك هو 3084.94. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5099	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5100	رمز التحقق لعملية الدفع هو 657565. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5101	تمت عملية بقيمة 6223.19 في المتجر. مرجع: 7642.	2025-11-10 00:00:00	\N	ar
5102	Your transaction of $2514.74 at STORE was successful. Ref: 5901.	2025-11-10 00:00:00	\N	en
5103	التحويل المجدول اكتمل بنجاح. مرجع: 5259.	2025-11-10 00:00:00	\N	ar
5105	Your online transfer of $762.95 to account 7602 was successful.	2025-11-10 00:00:00	\N	en
5110	Payment of $8622.05 received to your account ending with 4941. Thank you.	2025-11-10 00:00:00	\N	en
5111	Your scheduled transfer completed successfully. Ref: 8706.	2025-11-10 00:00:00	\N	en
5114	Reminder: Your loan payment of $9026.69 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5121	التحويل المجدول اكتمل بنجاح. مرجع: 8948.	2025-11-10 00:00:00	\N	ar
5123	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5124	Notification: Your card ending with 3451 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5126	عزيزي العميل، رصيد حسابك هو 3776.18. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5127	Your online transfer of $2861.60 to account 7517 was successful.	2025-11-10 00:00:00	\N	en
5128	تذكير: قسط القرض بقيمة 6129.62 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5130	عزيزي العميل، رصيد حسابك هو 6645.04. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5131	Dear customer, your account balance is $7227.53. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5132	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5134	Dear customer, your account balance is $7105.16. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5137	Your transaction of $9525.80 at STORE was successful. Ref: 8679.	2025-11-10 00:00:00	\N	en
5138	تم استلام دفعة بقيمة 3949.39 في حسابك المنتهي بـ 6559. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5140	Notification: Your card ending with 6341 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5141	ستنتهي صلاحية بطاقتك المنتهية بـ 6484 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5142	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5143	Your debit card ending 6739 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5144	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5149	Reminder: Your loan payment of $8549.65 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5154	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5155	Your online transfer of $628.59 to account 5899 was successful.	2025-11-10 00:00:00	\N	en
5156	رمز التحقق لعملية الدفع هو 117026. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5158	Your OTP for transaction is 863620. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5159	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5166	Your OTP for transaction is 845562. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5170	رمز التحقق لعملية الدفع هو 374192. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5172	التحويل المجدول اكتمل بنجاح. مرجع: 4252.	2025-11-10 00:00:00	\N	ar
5173	تمت عملية بقيمة 6503.60 في المتجر. مرجع: 7309.	2025-11-10 00:00:00	\N	ar
5174	Reminder: Your loan payment of $5045.22 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5176	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5177	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5178	التحويل المجدول اكتمل بنجاح. مرجع: 4429.	2025-11-10 00:00:00	\N	ar
5180	Your debit card ending 5926 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5181	Your OTP for transaction is 271836. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5183	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5184	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5186	Notification: Your card ending with 1631 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5190	Your transaction of $8328.70 at STORE was successful. Ref: 9988.	2025-11-10 00:00:00	\N	en
5192	Your OTP for transaction is 151262. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5325	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5193	ستنتهي صلاحية بطاقتك المنتهية بـ 1073 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5195	رمز التحقق لعملية الدفع هو 960188. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5200	Payment of $4345.95 received to your account ending with 2426. Thank you.	2025-11-10 00:00:00	\N	en
5201	تنبيه: بطاقتك المنتهية بـ 2147 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5204	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5206	التحويل المجدول اكتمل بنجاح. مرجع: 9379.	2025-11-10 00:00:00	\N	ar
5210	Notification: Your card ending with 1199 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5212	Payment of $2430.20 received to your account ending with 1042. Thank you.	2025-11-10 00:00:00	\N	en
5216	رمز التحقق لعملية الدفع هو 499773. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5220	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5221	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5223	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5224	تنبيه: بطاقتك المنتهية بـ 2451 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5225	ستنتهي صلاحية بطاقتك المنتهية بـ 8502 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5228	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5229	تنبيه: بطاقتك المنتهية بـ 3424 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5231	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5232	ستنتهي صلاحية بطاقتك المنتهية بـ 9559 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5233	تذكير: قسط القرض بقيمة 7009.64 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5236	Your transaction of $8004.43 at STORE was successful. Ref: 6640.	2025-11-10 00:00:00	\N	en
5243	Reminder: Your loan payment of $9953.17 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5247	Reminder: Your loan payment of $3574.19 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5249	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5250	تذكير: قسط القرض بقيمة 4009.86 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5251	Payment of $5424.93 received to your account ending with 1785. Thank you.	2025-11-10 00:00:00	\N	en
5254	Your debit card ending 3414 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5256	Notification: Your card ending with 7882 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5259	عزيزي العميل، رصيد حسابك هو 3657.64. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5260	رمز التحقق لعملية الدفع هو 536465. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5262	تمت عملية بقيمة 9840.11 في المتجر. مرجع: 6344.	2025-11-10 00:00:00	\N	ar
5264	تذكير: قسط القرض بقيمة 3774.21 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5268	التحويل المجدول اكتمل بنجاح. مرجع: 9902.	2025-11-10 00:00:00	\N	ar
5269	عزيزي العميل، رصيد حسابك هو 4174.32. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5270	Your scheduled transfer completed successfully. Ref: 4139.	2025-11-10 00:00:00	\N	en
5271	تذكير: قسط القرض بقيمة 7442.25 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5274	Dear customer, your account balance is $7413.25. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5276	Your online transfer of $270.34 to account 3527 was successful.	2025-11-10 00:00:00	\N	en
5278	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5280	Your debit card ending 7304 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5282	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5283	تم استلام دفعة بقيمة 6779.16 في حسابك المنتهي بـ 2933. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5284	تذكير: قسط القرض بقيمة 6055.56 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5285	Your OTP for transaction is 247026. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5289	Your scheduled transfer completed successfully. Ref: 2112.	2025-11-10 00:00:00	\N	en
5292	عزيزي العميل، رصيد حسابك هو 1589.28. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5293	Your transaction of $5231.52 at STORE was successful. Ref: 8840.	2025-11-10 00:00:00	\N	en
5300	التحويل المجدول اكتمل بنجاح. مرجع: 6441.	2025-11-10 00:00:00	\N	ar
5302	تمت عملية بقيمة 1162.03 في المتجر. مرجع: 2409.	2025-11-10 00:00:00	\N	ar
5303	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5304	Dear customer, your account balance is $2657.27. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5311	Notification: Your card ending with 9500 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5313	Reminder: Your loan payment of $4306.75 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8777	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5315	ستنتهي صلاحية بطاقتك المنتهية بـ 4374 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5318	Payment of $4008.16 received to your account ending with 6756. Thank you.	2025-11-10 00:00:00	\N	en
5319	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5320	Payment of $3969.36 received to your account ending with 8033. Thank you.	2025-11-10 00:00:00	\N	en
5321	Reminder: Your loan payment of $7701.45 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5326	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5327	تمت عملية بقيمة 3963.17 في المتجر. مرجع: 8224.	2025-11-10 00:00:00	\N	ar
5329	Your scheduled transfer completed successfully. Ref: 2243.	2025-11-10 00:00:00	\N	en
5332	Your scheduled transfer completed successfully. Ref: 7721.	2025-11-10 00:00:00	\N	en
5333	Your debit card ending 1208 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5334	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5336	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5342	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5345	عزيزي العميل، رصيد حسابك هو 9213.49. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5346	تنبيه: بطاقتك المنتهية بـ 4480 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5347	Your OTP for transaction is 448059. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5348	تم استلام دفعة بقيمة 1846.40 في حسابك المنتهي بـ 9170. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5349	عزيزي العميل، رصيد حسابك هو 4244.96. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5350	تمت عملية بقيمة 5654.65 في المتجر. مرجع: 6580.	2025-11-10 00:00:00	\N	ar
5352	Your OTP for transaction is 487007. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5355	Reminder: Your loan payment of $44.36 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5356	Payment of $1545.46 received to your account ending with 2094. Thank you.	2025-11-10 00:00:00	\N	en
5359	ستنتهي صلاحية بطاقتك المنتهية بـ 8791 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5360	تمت عملية بقيمة 3889.78 في المتجر. مرجع: 3965.	2025-11-10 00:00:00	\N	ar
5365	Your scheduled transfer completed successfully. Ref: 4178.	2025-11-10 00:00:00	\N	en
5366	Notification: Your card ending with 5722 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5369	Payment of $2309.43 received to your account ending with 1005. Thank you.	2025-11-10 00:00:00	\N	en
5370	التحويل المجدول اكتمل بنجاح. مرجع: 8547.	2025-11-10 00:00:00	\N	ar
5371	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5372	رمز التحقق لعملية الدفع هو 620974. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5375	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5376	عزيزي العميل، رصيد حسابك هو 5065.67. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5377	Your debit card ending 9755 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5381	Dear customer, your account balance is $4227.56. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5383	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5384	Reminder: Your loan payment of $9756.05 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5385	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5386	Your transaction of $4660.26 at STORE was successful. Ref: 2602.	2025-11-10 00:00:00	\N	en
5387	ستنتهي صلاحية بطاقتك المنتهية بـ 4060 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5389	Dear customer, your account balance is $2550.54. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5391	Your OTP for transaction is 775676. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5392	Notification: Your card ending with 1119 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5393	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5395	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5396	رمز التحقق لعملية الدفع هو 698397. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5399	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5401	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5402	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5403	رمز التحقق لعملية الدفع هو 275465. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5405	تم استلام دفعة بقيمة 3422.58 في حسابك المنتهي بـ 4684. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5409	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5411	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5413	Your OTP for transaction is 635007. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5414	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5416	تنبيه: بطاقتك المنتهية بـ 7478 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5418	Payment of $2281.38 received to your account ending with 6788. Thank you.	2025-11-10 00:00:00	\N	en
5419	Dear customer, your account balance is $1799.01. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5420	Reminder: Your loan payment of $1372.34 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5421	التحويل المجدول اكتمل بنجاح. مرجع: 4567.	2025-11-10 00:00:00	\N	ar
5423	Your debit card ending 8131 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5424	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5426	تنبيه: بطاقتك المنتهية بـ 3521 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5428	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5430	Your online transfer of $244.72 to account 1108 was successful.	2025-11-10 00:00:00	\N	en
5432	Payment of $3616.31 received to your account ending with 6806. Thank you.	2025-11-10 00:00:00	\N	en
5433	Your online transfer of $2891.70 to account 4410 was successful.	2025-11-10 00:00:00	\N	en
5435	تمت عملية بقيمة 6906.26 في المتجر. مرجع: 6664.	2025-11-10 00:00:00	\N	ar
5436	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5437	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5442	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5443	Notification: Your card ending with 8556 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5444	عزيزي العميل، رصيد حسابك هو 3303.57. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5446	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5447	Your OTP for transaction is 359952. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5448	تنبيه: بطاقتك المنتهية بـ 9369 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5452	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5455	التحويل المجدول اكتمل بنجاح. مرجع: 2760.	2025-11-10 00:00:00	\N	ar
5456	Dear customer, your account balance is $4964.57. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5459	Dear customer, your account balance is $5585.63. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5461	تذكير: قسط القرض بقيمة 5202.10 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5463	Reminder: Your loan payment of $611.54 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5464	Your online transfer of $3997.28 to account 5947 was successful.	2025-11-10 00:00:00	\N	en
5466	رمز التحقق لعملية الدفع هو 415361. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5467	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5468	Your online transfer of $723.23 to account 9473 was successful.	2025-11-10 00:00:00	\N	en
5470	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5472	Your debit card ending 1208 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5474	ستنتهي صلاحية بطاقتك المنتهية بـ 5233 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5476	تم استلام دفعة بقيمة 9469.32 في حسابك المنتهي بـ 2351. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5480	التحويل المجدول اكتمل بنجاح. مرجع: 6532.	2025-11-10 00:00:00	\N	ar
5483	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5485	Reminder: Your loan payment of $8429.09 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5487	Your OTP for transaction is 293840. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5488	Reminder: Your loan payment of $573.30 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5490	Your OTP for transaction is 820986. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5491	تمت عملية بقيمة 7626.83 في المتجر. مرجع: 5091.	2025-11-10 00:00:00	\N	ar
5492	تذكير: قسط القرض بقيمة 1614.57 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5493	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5497	Notification: Your card ending with 8261 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5498	Notification: Your card ending with 1000 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5499	تنبيه: بطاقتك المنتهية بـ 5786 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5504	Your transaction of $6292.55 at STORE was successful. Ref: 7917.	2025-11-10 00:00:00	\N	en
5506	Your scheduled transfer completed successfully. Ref: 2912.	2025-11-10 00:00:00	\N	en
5507	Your debit card ending 8587 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5509	Reminder: Your loan payment of $8009.37 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5511	Payment of $6450.80 received to your account ending with 8797. Thank you.	2025-11-10 00:00:00	\N	en
5512	Notification: Your card ending with 3642 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5513	تمت عملية بقيمة 8636.79 في المتجر. مرجع: 7851.	2025-11-10 00:00:00	\N	ar
5514	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5515	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5516	التحويل المجدول اكتمل بنجاح. مرجع: 4065.	2025-11-10 00:00:00	\N	ar
5517	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5523	Your debit card ending 1915 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5524	تمت عملية بقيمة 6035.67 في المتجر. مرجع: 1978.	2025-11-10 00:00:00	\N	ar
5527	Your debit card ending 2007 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5528	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5529	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5530	عزيزي العميل، رصيد حسابك هو 6861.97. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5533	Dear customer, your account balance is $8700.26. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5534	Dear customer, your account balance is $7978.59. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5535	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5536	Your scheduled transfer completed successfully. Ref: 8333.	2025-11-10 00:00:00	\N	en
5537	التحويل المجدول اكتمل بنجاح. مرجع: 1231.	2025-11-10 00:00:00	\N	ar
5538	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5539	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5542	Your transaction of $996.88 at STORE was successful. Ref: 7792.	2025-11-10 00:00:00	\N	en
5543	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5544	التحويل المجدول اكتمل بنجاح. مرجع: 1788.	2025-11-10 00:00:00	\N	ar
5545	تذكير: قسط القرض بقيمة 5040.43 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5546	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5548	Notification: Your card ending with 3835 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5549	Your scheduled transfer completed successfully. Ref: 7880.	2025-11-10 00:00:00	\N	en
5551	Reminder: Your loan payment of $200.43 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5555	Reminder: Your loan payment of $3375.43 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5556	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5557	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5558	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5559	Notification: Your card ending with 8353 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5560	تنبيه: بطاقتك المنتهية بـ 6892 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5563	Notification: Your card ending with 2283 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5564	Notification: Your card ending with 6926 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5567	تمت عملية بقيمة 3484.85 في المتجر. مرجع: 9710.	2025-11-10 00:00:00	\N	ar
5568	Your scheduled transfer completed successfully. Ref: 5901.	2025-11-10 00:00:00	\N	en
5569	التحويل المجدول اكتمل بنجاح. مرجع: 8120.	2025-11-10 00:00:00	\N	ar
5572	تذكير: قسط القرض بقيمة 7244.56 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5576	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5577	التحويل المجدول اكتمل بنجاح. مرجع: 4541.	2025-11-10 00:00:00	\N	ar
5579	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5580	Your online transfer of $2588.30 to account 9627 was successful.	2025-11-10 00:00:00	\N	en
5582	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5583	تمت عملية بقيمة 864.34 في المتجر. مرجع: 5119.	2025-11-10 00:00:00	\N	ar
5584	ستنتهي صلاحية بطاقتك المنتهية بـ 6398 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5585	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5586	Your online transfer of $5865.08 to account 3855 was successful.	2025-11-10 00:00:00	\N	en
5587	التحويل المجدول اكتمل بنجاح. مرجع: 2358.	2025-11-10 00:00:00	\N	ar
5589	تمت عملية بقيمة 9275.77 في المتجر. مرجع: 9626.	2025-11-10 00:00:00	\N	ar
5592	ستنتهي صلاحية بطاقتك المنتهية بـ 2291 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5596	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5597	تذكير: قسط القرض بقيمة 3107.97 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5599	تنبيه: بطاقتك المنتهية بـ 5491 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5600	Your debit card ending 6011 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5601	تم استلام دفعة بقيمة 9012.48 في حسابك المنتهي بـ 8838. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5603	Payment of $1869.87 received to your account ending with 8928. Thank you.	2025-11-10 00:00:00	\N	en
5604	Reminder: Your loan payment of $3188.73 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5606	Payment of $1839.33 received to your account ending with 6426. Thank you.	2025-11-10 00:00:00	\N	en
5607	تذكير: قسط القرض بقيمة 5562.10 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5608	Your scheduled transfer completed successfully. Ref: 7461.	2025-11-10 00:00:00	\N	en
5609	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5610	عزيزي العميل، رصيد حسابك هو 6844.17. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5613	Dear customer, your account balance is $7318.67. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5614	Reminder: Your loan payment of $9980.98 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5616	Your online transfer of $48.80 to account 3360 was successful.	2025-11-10 00:00:00	\N	en
5619	عزيزي العميل، رصيد حسابك هو 8088.15. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5622	التحويل المجدول اكتمل بنجاح. مرجع: 2162.	2025-11-10 00:00:00	\N	ar
5624	Payment of $1334.08 received to your account ending with 7760. Thank you.	2025-11-10 00:00:00	\N	en
5626	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5627	Payment of $8356.60 received to your account ending with 6911. Thank you.	2025-11-10 00:00:00	\N	en
5628	التحويل المجدول اكتمل بنجاح. مرجع: 9146.	2025-11-10 00:00:00	\N	ar
5629	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5632	Your scheduled transfer completed successfully. Ref: 7308.	2025-11-10 00:00:00	\N	en
5633	Your debit card ending 4577 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5635	عزيزي العميل، رصيد حسابك هو 9854.09. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5637	عزيزي العميل، رصيد حسابك هو 8622.88. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5638	Your online transfer of $2504.02 to account 2670 was successful.	2025-11-10 00:00:00	\N	en
5640	Notification: Your card ending with 7336 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5641	ستنتهي صلاحية بطاقتك المنتهية بـ 9320 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5642	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5644	Your scheduled transfer completed successfully. Ref: 3319.	2025-11-10 00:00:00	\N	en
5649	ستنتهي صلاحية بطاقتك المنتهية بـ 6997 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5650	Payment of $729.47 received to your account ending with 8890. Thank you.	2025-11-10 00:00:00	\N	en
5651	Notification: Your card ending with 6298 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5655	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5658	Your debit card ending 8154 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5659	Reminder: Your loan payment of $3139.89 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5662	Your transaction of $5287.90 at STORE was successful. Ref: 4672.	2025-11-10 00:00:00	\N	en
5664	Your online transfer of $8978.18 to account 1606 was successful.	2025-11-10 00:00:00	\N	en
5669	Your debit card ending 8480 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5670	التحويل المجدول اكتمل بنجاح. مرجع: 7090.	2025-11-10 00:00:00	\N	ar
5677	ستنتهي صلاحية بطاقتك المنتهية بـ 6396 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5679	Your OTP for transaction is 370176. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5680	Reminder: Your loan payment of $3558.61 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5681	تذكير: قسط القرض بقيمة 4494.45 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5686	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5687	عزيزي العميل، رصيد حسابك هو 2281.34. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5688	Reminder: Your loan payment of $7785.01 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5695	Your online transfer of $9753.50 to account 8847 was successful.	2025-11-10 00:00:00	\N	en
5696	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5700	تمت عملية بقيمة 8047.28 في المتجر. مرجع: 5816.	2025-11-10 00:00:00	\N	ar
5701	ستنتهي صلاحية بطاقتك المنتهية بـ 1065 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5705	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5708	تذكير: قسط القرض بقيمة 1260.12 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5709	رمز التحقق لعملية الدفع هو 616431. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5710	Notification: Your card ending with 5196 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5711	Payment of $1518.68 received to your account ending with 2078. Thank you.	2025-11-10 00:00:00	\N	en
5712	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5713	Dear customer, your account balance is $6460.58. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5714	Reminder: Your loan payment of $8714.07 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5716	Your transaction of $3991.33 at STORE was successful. Ref: 4271.	2025-11-10 00:00:00	\N	en
5719	تمت عملية بقيمة 5101.79 في المتجر. مرجع: 4503.	2025-11-10 00:00:00	\N	ar
5720	Your OTP for transaction is 577912. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5721	Your debit card ending 5935 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5726	Your scheduled transfer completed successfully. Ref: 5376.	2025-11-10 00:00:00	\N	en
5737	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5738	رمز التحقق لعملية الدفع هو 285671. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5740	التحويل المجدول اكتمل بنجاح. مرجع: 5586.	2025-11-10 00:00:00	\N	ar
5744	Notification: Your card ending with 5240 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5745	Your OTP for transaction is 973519. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5747	رمز التحقق لعملية الدفع هو 612011. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5751	Payment of $2632.42 received to your account ending with 7285. Thank you.	2025-11-10 00:00:00	\N	en
5753	رمز التحقق لعملية الدفع هو 290785. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5754	Reminder: Your loan payment of $945.09 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5755	Your OTP for transaction is 404983. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5756	ستنتهي صلاحية بطاقتك المنتهية بـ 8870 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5760	ستنتهي صلاحية بطاقتك المنتهية بـ 1286 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5761	التحويل المجدول اكتمل بنجاح. مرجع: 3904.	2025-11-10 00:00:00	\N	ar
5762	Your scheduled transfer completed successfully. Ref: 6989.	2025-11-10 00:00:00	\N	en
5763	تمت عملية بقيمة 6501.28 في المتجر. مرجع: 2992.	2025-11-10 00:00:00	\N	ar
5764	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5765	Your scheduled transfer completed successfully. Ref: 2436.	2025-11-10 00:00:00	\N	en
5766	Your online transfer of $9840.29 to account 4396 was successful.	2025-11-10 00:00:00	\N	en
5767	Payment of $5265.95 received to your account ending with 1288. Thank you.	2025-11-10 00:00:00	\N	en
5768	Dear customer, your account balance is $3198.19. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5769	Dear customer, your account balance is $2829.21. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5772	Your transaction of $8539.43 at STORE was successful. Ref: 7312.	2025-11-10 00:00:00	\N	en
5773	Reminder: Your loan payment of $720.83 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5777	Reminder: Your loan payment of $3892.67 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5779	التحويل المجدول اكتمل بنجاح. مرجع: 4070.	2025-11-10 00:00:00	\N	ar
5780	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5782	Your transaction of $4234.92 at STORE was successful. Ref: 9086.	2025-11-10 00:00:00	\N	en
5783	التحويل المجدول اكتمل بنجاح. مرجع: 1750.	2025-11-10 00:00:00	\N	ar
5784	Notification: Your card ending with 1539 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5786	عزيزي العميل، رصيد حسابك هو 7025.06. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5787	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5788	Payment of $6380.84 received to your account ending with 9535. Thank you.	2025-11-10 00:00:00	\N	en
5789	Dear customer, your account balance is $4080.59. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5791	Your scheduled transfer completed successfully. Ref: 4446.	2025-11-10 00:00:00	\N	en
5793	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5794	تم استلام دفعة بقيمة 8222.56 في حسابك المنتهي بـ 8360. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5798	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5801	Your online transfer of $2485.18 to account 7201 was successful.	2025-11-10 00:00:00	\N	en
5805	Your scheduled transfer completed successfully. Ref: 5049.	2025-11-10 00:00:00	\N	en
5806	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5810	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
5811	Notification: Your card ending with 9045 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5812	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5813	ستنتهي صلاحية بطاقتك المنتهية بـ 3932 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5814	Your online transfer of $2458.69 to account 6391 was successful.	2025-11-10 00:00:00	\N	en
5816	تنبيه: بطاقتك المنتهية بـ 8851 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5817	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5820	Your OTP for transaction is 952434. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5821	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5824	Dear customer, your account balance is $3040.17. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5826	Payment of $2958.40 received to your account ending with 2852. Thank you.	2025-11-10 00:00:00	\N	en
5830	Dear customer, your account balance is $4919.41. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5831	تمت عملية بقيمة 2639.87 في المتجر. مرجع: 6496.	2025-11-10 00:00:00	\N	ar
5834	عزيزي العميل، رصيد حسابك هو 4514.29. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5838	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5839	Payment of $2286.59 received to your account ending with 9638. Thank you.	2025-11-10 00:00:00	\N	en
5842	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5843	Your transaction of $6863.91 at STORE was successful. Ref: 8297.	2025-11-10 00:00:00	\N	en
5844	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5847	Your debit card ending 8835 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5850	Payment of $8996.08 received to your account ending with 6554. Thank you.	2025-11-10 00:00:00	\N	en
5851	تمت عملية بقيمة 2708.49 في المتجر. مرجع: 7816.	2025-11-10 00:00:00	\N	ar
5854	Your online transfer of $1103.04 to account 4406 was successful.	2025-11-10 00:00:00	\N	en
5855	Your transaction of $7619.51 at STORE was successful. Ref: 8759.	2025-11-10 00:00:00	\N	en
5857	Notification: Your card ending with 2978 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5858	Dear customer, your account balance is $2463.48. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5859	Your debit card ending 4541 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
5860	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5861	التحويل المجدول اكتمل بنجاح. مرجع: 8586.	2025-11-10 00:00:00	\N	ar
5863	تنبيه: بطاقتك المنتهية بـ 3061 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5865	Notification: Your card ending with 2926 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5866	Notification: Your card ending with 1365 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5870	Payment of $7857.87 received to your account ending with 2610. Thank you.	2025-11-10 00:00:00	\N	en
5871	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5872	ستنتهي صلاحية بطاقتك المنتهية بـ 9273 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5874	Dear customer, your account balance is $8253.42. Visit our branch for details.	2025-11-10 00:00:00	\N	en
5876	Your OTP for transaction is 358422. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5877	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5879	رمز التحقق لعملية الدفع هو 116827. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5881	التحويل المجدول اكتمل بنجاح. مرجع: 1016.	2025-11-10 00:00:00	\N	ar
5883	تنبيه: بطاقتك المنتهية بـ 2453 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5884	Your scheduled transfer completed successfully. Ref: 3171.	2025-11-10 00:00:00	\N	en
5885	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5886	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5887	ستنتهي صلاحية بطاقتك المنتهية بـ 2676 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5889	عزيزي العميل، رصيد حسابك هو 9898.38. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5894	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5896	Your online transfer of $5316.41 to account 9027 was successful.	2025-11-10 00:00:00	\N	en
5897	Payment of $4616.37 received to your account ending with 6409. Thank you.	2025-11-10 00:00:00	\N	en
5898	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5902	تمت عملية بقيمة 6258.94 في المتجر. مرجع: 1595.	2025-11-10 00:00:00	\N	ar
5908	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5909	تنبيه: بطاقتك المنتهية بـ 5349 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5912	تنبيه: بطاقتك المنتهية بـ 8956 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5914	Your transaction of $442.63 at STORE was successful. Ref: 1541.	2025-11-10 00:00:00	\N	en
5915	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5917	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
5918	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5919	Your scheduled transfer completed successfully. Ref: 7814.	2025-11-10 00:00:00	\N	en
5920	Your transaction of $8518.35 at STORE was successful. Ref: 2618.	2025-11-10 00:00:00	\N	en
5921	رمز التحقق لعملية الدفع هو 884384. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5923	تنبيه: بطاقتك المنتهية بـ 5656 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5924	Your scheduled transfer completed successfully. Ref: 2783.	2025-11-10 00:00:00	\N	en
5926	Your online transfer of $2706.54 to account 1493 was successful.	2025-11-10 00:00:00	\N	en
5929	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
5930	رمز التحقق لعملية الدفع هو 685606. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5931	Your scheduled transfer completed successfully. Ref: 6561.	2025-11-10 00:00:00	\N	en
5933	Reminder: Your loan payment of $1664.56 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5934	Payment of $2639.95 received to your account ending with 9147. Thank you.	2025-11-10 00:00:00	\N	en
5935	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5937	Notification: Your card ending with 2317 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
5939	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
5940	Reminder: Your loan payment of $8051.32 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5942	عزيزي العميل، رصيد حسابك هو 6165.08. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
5949	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5952	Your OTP for transaction is 710320. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5954	تنبيه: بطاقتك المنتهية بـ 2146 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
5955	تم استلام دفعة بقيمة 8730.66 في حسابك المنتهي بـ 1892. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5958	Your online transfer of $752.12 to account 7989 was successful.	2025-11-10 00:00:00	\N	en
5959	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5961	Your OTP for transaction is 269274. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5963	Your OTP for transaction is 241574. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
5964	Your scheduled transfer completed successfully. Ref: 5514.	2025-11-10 00:00:00	\N	en
5965	تذكير: قسط القرض بقيمة 8812.63 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5966	ستنتهي صلاحية بطاقتك المنتهية بـ 5379 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5967	Reminder: Your loan payment of $7549.17 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5969	ستنتهي صلاحية بطاقتك المنتهية بـ 4740 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
5970	تم استلام دفعة بقيمة 6597.75 في حسابك المنتهي بـ 4814. شكرًا لك.	2025-11-10 00:00:00	\N	ar
5971	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
5976	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
5977	تذكير: قسط القرض بقيمة 4688.36 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
5987	رمز التحقق لعملية الدفع هو 156340. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
5988	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
5992	Your scheduled transfer completed successfully. Ref: 9862.	2025-11-10 00:00:00	\N	en
5994	Reminder: Your loan payment of $5753.01 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
5997	Dear customer, your account balance is $1320.65. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6000	التحويل المجدول اكتمل بنجاح. مرجع: 8409.	2025-11-10 00:00:00	\N	ar
6001	رمز التحقق لعملية الدفع هو 308077. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6002	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6005	التحويل المجدول اكتمل بنجاح. مرجع: 4925.	2025-11-10 00:00:00	\N	ar
6009	Your OTP for transaction is 845348. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6011	تمت عملية بقيمة 3966.04 في المتجر. مرجع: 3492.	2025-11-10 00:00:00	\N	ar
6013	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6014	عزيزي العميل، رصيد حسابك هو 1042.85. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6015	Payment of $1073.68 received to your account ending with 2947. Thank you.	2025-11-10 00:00:00	\N	en
6017	تمت عملية بقيمة 4849.42 في المتجر. مرجع: 1994.	2025-11-10 00:00:00	\N	ar
6020	تمت عملية بقيمة 8433.02 في المتجر. مرجع: 8317.	2025-11-10 00:00:00	\N	ar
6021	Dear customer, your account balance is $1321.02. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6022	Your scheduled transfer completed successfully. Ref: 4202.	2025-11-10 00:00:00	\N	en
6024	التحويل المجدول اكتمل بنجاح. مرجع: 6291.	2025-11-10 00:00:00	\N	ar
6025	Your OTP for transaction is 109878. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6031	Reminder: Your loan payment of $6907.34 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6033	Your OTP for transaction is 855892. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6035	Notification: Your card ending with 7066 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6036	Your online transfer of $1255.68 to account 8896 was successful.	2025-11-10 00:00:00	\N	en
6037	Your transaction of $9071.74 at STORE was successful. Ref: 6728.	2025-11-10 00:00:00	\N	en
6038	التحويل المجدول اكتمل بنجاح. مرجع: 4020.	2025-11-10 00:00:00	\N	ar
6039	رمز التحقق لعملية الدفع هو 961750. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6040	تمت عملية بقيمة 2154.87 في المتجر. مرجع: 7822.	2025-11-10 00:00:00	\N	ar
6042	Your scheduled transfer completed successfully. Ref: 8066.	2025-11-10 00:00:00	\N	en
6044	Dear customer, your account balance is $7725.89. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6048	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6049	Reminder: Your loan payment of $4902.78 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6050	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6051	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6053	Reminder: Your loan payment of $1580.17 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6054	Your online transfer of $2411.36 to account 4641 was successful.	2025-11-10 00:00:00	\N	en
6056	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6057	تنبيه: بطاقتك المنتهية بـ 5056 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6058	Payment of $2212.14 received to your account ending with 6728. Thank you.	2025-11-10 00:00:00	\N	en
6059	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6060	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6062	ستنتهي صلاحية بطاقتك المنتهية بـ 6782 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6064	Reminder: Your loan payment of $5727.97 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6067	تمت عملية بقيمة 837.75 في المتجر. مرجع: 6158.	2025-11-10 00:00:00	\N	ar
6070	Your debit card ending 4099 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6073	Reminder: Your loan payment of $5373.00 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6074	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6078	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6079	Your OTP for transaction is 454595. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6081	التحويل المجدول اكتمل بنجاح. مرجع: 9579.	2025-11-10 00:00:00	\N	ar
6082	رمز التحقق لعملية الدفع هو 235432. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6083	تمت عملية بقيمة 4763.46 في المتجر. مرجع: 2425.	2025-11-10 00:00:00	\N	ar
6085	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6087	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6088	التحويل المجدول اكتمل بنجاح. مرجع: 8814.	2025-11-10 00:00:00	\N	ar
6091	Your OTP for transaction is 109286. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6093	Your scheduled transfer completed successfully. Ref: 4213.	2025-11-10 00:00:00	\N	en
6094	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6100	Your OTP for transaction is 894587. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6101	Reminder: Your loan payment of $9463.91 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6103	Your OTP for transaction is 259023. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6105	تذكير: قسط القرض بقيمة 1587.05 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6107	Your debit card ending 5790 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6108	Reminder: Your loan payment of $9643.50 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6109	تم استلام دفعة بقيمة 3134.48 في حسابك المنتهي بـ 2645. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6110	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6112	رمز التحقق لعملية الدفع هو 261427. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6113	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6118	Your debit card ending 9655 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6119	Reminder: Your loan payment of $620.17 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6120	ستنتهي صلاحية بطاقتك المنتهية بـ 3919 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6121	عزيزي العميل، رصيد حسابك هو 3478.11. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6122	رمز التحقق لعملية الدفع هو 374673. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6123	Your transaction of $8824.24 at STORE was successful. Ref: 2811.	2025-11-10 00:00:00	\N	en
6124	تم استلام دفعة بقيمة 9984.38 في حسابك المنتهي بـ 6031. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6125	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6126	ستنتهي صلاحية بطاقتك المنتهية بـ 2139 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6128	ستنتهي صلاحية بطاقتك المنتهية بـ 7976 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6129	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6130	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6131	عزيزي العميل، رصيد حسابك هو 1795.54. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6132	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6133	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6134	عزيزي العميل، رصيد حسابك هو 36.87. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6135	تنبيه: بطاقتك المنتهية بـ 8516 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6142	Your scheduled transfer completed successfully. Ref: 7951.	2025-11-10 00:00:00	\N	en
6143	تمت عملية بقيمة 2005.34 في المتجر. مرجع: 3000.	2025-11-10 00:00:00	\N	ar
6144	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6145	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6146	تذكير: قسط القرض بقيمة 3721.14 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6148	Your debit card ending 4065 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6149	تم استلام دفعة بقيمة 2849.69 في حسابك المنتهي بـ 7846. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6150	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6151	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6154	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6157	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6158	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6160	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6161	تذكير: قسط القرض بقيمة 9315.24 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6162	تنبيه: بطاقتك المنتهية بـ 3570 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6163	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6165	تم استلام دفعة بقيمة 6077.96 في حسابك المنتهي بـ 6955. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6167	Your debit card ending 2050 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6170	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6172	Payment of $6829.43 received to your account ending with 2161. Thank you.	2025-11-10 00:00:00	\N	en
6173	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6174	Your debit card ending 5777 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6175	Payment of $9746.15 received to your account ending with 1231. Thank you.	2025-11-10 00:00:00	\N	en
6176	Notification: Your card ending with 3619 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6177	تنبيه: بطاقتك المنتهية بـ 6344 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6179	Your transaction of $9173.18 at STORE was successful. Ref: 9247.	2025-11-10 00:00:00	\N	en
6180	Dear customer, your account balance is $9742.13. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6181	Dear customer, your account balance is $7897.30. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6186	Dear customer, your account balance is $4113.66. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6191	Reminder: Your loan payment of $802.74 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6192	Notification: Your card ending with 5000 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6194	Dear customer, your account balance is $2318.87. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6195	ستنتهي صلاحية بطاقتك المنتهية بـ 6208 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6196	Your debit card ending 9941 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6199	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6200	Your OTP for transaction is 330560. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6201	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6203	Dear customer, your account balance is $3255.83. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6204	Your scheduled transfer completed successfully. Ref: 1160.	2025-11-10 00:00:00	\N	en
6206	تذكير: قسط القرض بقيمة 2944.57 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6207	تم استلام دفعة بقيمة 7841.93 في حسابك المنتهي بـ 6311. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6208	تذكير: قسط القرض بقيمة 9939.19 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6210	Your transaction of $497.40 at STORE was successful. Ref: 4932.	2025-11-10 00:00:00	\N	en
6212	عزيزي العميل، رصيد حسابك هو 6949.78. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6213	تمت عملية بقيمة 131.31 في المتجر. مرجع: 6744.	2025-11-10 00:00:00	\N	ar
6214	تمت عملية بقيمة 3387.09 في المتجر. مرجع: 9331.	2025-11-10 00:00:00	\N	ar
6215	ستنتهي صلاحية بطاقتك المنتهية بـ 1083 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6219	رمز التحقق لعملية الدفع هو 881380. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6221	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6222	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6223	رمز التحقق لعملية الدفع هو 293988. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6227	Notification: Your card ending with 4799 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6233	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6234	Notification: Your card ending with 6906 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6235	عزيزي العميل، رصيد حسابك هو 1173.75. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6239	تمت عملية بقيمة 2304.83 في المتجر. مرجع: 2240.	2025-11-10 00:00:00	\N	ar
6241	Your OTP for transaction is 713633. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6244	عزيزي العميل، رصيد حسابك هو 5667.24. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6246	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6248	تم استلام دفعة بقيمة 10000.53 في حسابك المنتهي بـ 4365. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6250	Your transaction of $288.38 at STORE was successful. Ref: 4653.	2025-11-10 00:00:00	\N	en
6251	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6255	عزيزي العميل، رصيد حسابك هو 6967.39. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6256	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6258	Payment of $8900.96 received to your account ending with 8311. Thank you.	2025-11-10 00:00:00	\N	en
6260	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6262	Dear customer, your account balance is $6665.43. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6263	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6266	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6267	Your debit card ending 3829 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6269	Notification: Your card ending with 2977 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6270	ستنتهي صلاحية بطاقتك المنتهية بـ 7826 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6275	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6276	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6277	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6279	تمت عملية بقيمة 1654.65 في المتجر. مرجع: 3716.	2025-11-10 00:00:00	\N	ar
6280	Reminder: Your loan payment of $8835.99 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6282	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6285	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6286	Your online transfer of $8114.89 to account 9942 was successful.	2025-11-10 00:00:00	\N	en
6287	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6290	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6292	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6293	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6298	Dear customer, your account balance is $2004.77. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6300	Reminder: Your loan payment of $1557.95 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6301	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6302	Your OTP for transaction is 145082. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6306	Your online transfer of $8504.59 to account 6868 was successful.	2025-11-10 00:00:00	\N	en
6309	Your scheduled transfer completed successfully. Ref: 5573.	2025-11-10 00:00:00	\N	en
6310	تنبيه: بطاقتك المنتهية بـ 3215 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6314	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6315	تنبيه: بطاقتك المنتهية بـ 5060 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6318	Dear customer, your account balance is $9062.85. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6321	ستنتهي صلاحية بطاقتك المنتهية بـ 6343 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6322	تمت عملية بقيمة 8873.49 في المتجر. مرجع: 4124.	2025-11-10 00:00:00	\N	ar
6324	ستنتهي صلاحية بطاقتك المنتهية بـ 3494 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6325	تمت عملية بقيمة 5035.97 في المتجر. مرجع: 7933.	2025-11-10 00:00:00	\N	ar
6330	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6331	عزيزي العميل، رصيد حسابك هو 555.10. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6333	Notification: Your card ending with 6195 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6335	Notification: Your card ending with 6947 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6337	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6339	Notification: Your card ending with 1312 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6340	Dear customer, your account balance is $1706.48. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6341	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6348	Your scheduled transfer completed successfully. Ref: 7129.	2025-11-10 00:00:00	\N	en
6349	Your debit card ending 8356 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6351	Your debit card ending 6251 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6352	تمت عملية بقيمة 5754.99 في المتجر. مرجع: 4694.	2025-11-10 00:00:00	\N	ar
6353	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6356	Dear customer, your account balance is $281.53. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6359	ستنتهي صلاحية بطاقتك المنتهية بـ 1842 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6360	تذكير: قسط القرض بقيمة 8197.31 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6361	تنبيه: بطاقتك المنتهية بـ 3115 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6363	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6365	Notification: Your card ending with 4285 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6368	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6370	ستنتهي صلاحية بطاقتك المنتهية بـ 3423 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6372	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6373	Reminder: Your loan payment of $9120.79 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6374	Notification: Your card ending with 6876 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6381	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6382	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6384	التحويل المجدول اكتمل بنجاح. مرجع: 3153.	2025-11-10 00:00:00	\N	ar
6386	Notification: Your card ending with 4498 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6388	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6389	Your online transfer of $2574.63 to account 2116 was successful.	2025-11-10 00:00:00	\N	en
6394	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6395	Your online transfer of $3582.06 to account 1790 was successful.	2025-11-10 00:00:00	\N	en
6396	Payment of $711.22 received to your account ending with 5868. Thank you.	2025-11-10 00:00:00	\N	en
6397	Notification: Your card ending with 5972 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6398	Dear customer, your account balance is $7569.22. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6400	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6402	Your scheduled transfer completed successfully. Ref: 1647.	2025-11-10 00:00:00	\N	en
6409	ستنتهي صلاحية بطاقتك المنتهية بـ 3446 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6410	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6412	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6413	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6415	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6417	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6421	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6422	ستنتهي صلاحية بطاقتك المنتهية بـ 6285 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6424	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6425	Payment of $9866.21 received to your account ending with 1543. Thank you.	2025-11-10 00:00:00	\N	en
6428	رمز التحقق لعملية الدفع هو 795491. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6429	Notification: Your card ending with 7351 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6430	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6432	Dear customer, your account balance is $7358.42. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6433	Your transaction of $6486.02 at STORE was successful. Ref: 6315.	2025-11-10 00:00:00	\N	en
6435	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6436	تم استلام دفعة بقيمة 312.92 في حسابك المنتهي بـ 4106. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6439	Dear customer, your account balance is $560.36. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6441	Your debit card ending 7941 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6442	عزيزي العميل، رصيد حسابك هو 9671.60. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6445	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6447	تذكير: قسط القرض بقيمة 1303.52 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6448	Your OTP for transaction is 641466. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6456	عزيزي العميل، رصيد حسابك هو 957.43. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6457	Dear customer, your account balance is $4618.85. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6458	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6462	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6463	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6464	تم استلام دفعة بقيمة 1493.60 في حسابك المنتهي بـ 1985. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6467	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6469	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6471	Your debit card ending 7098 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6473	Your OTP for transaction is 733843. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6477	Your OTP for transaction is 244779. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6479	Dear customer, your account balance is $9674.29. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6480	Your debit card ending 7281 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6481	تذكير: قسط القرض بقيمة 1988.11 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6483	عزيزي العميل، رصيد حسابك هو 6760.57. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6484	عزيزي العميل، رصيد حسابك هو 3298.59. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6485	Notification: Your card ending with 9096 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6486	تم استلام دفعة بقيمة 1400.95 في حسابك المنتهي بـ 1207. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6487	Payment of $5465.72 received to your account ending with 3428. Thank you.	2025-11-10 00:00:00	\N	en
6491	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6492	Dear customer, your account balance is $7193.78. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6493	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6499	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6500	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6503	Notification: Your card ending with 5910 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6505	Your transaction of $3874.96 at STORE was successful. Ref: 4407.	2025-11-10 00:00:00	\N	en
6507	رمز التحقق لعملية الدفع هو 150780. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6509	Dear customer, your account balance is $3643.15. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6511	التحويل المجدول اكتمل بنجاح. مرجع: 1214.	2025-11-10 00:00:00	\N	ar
6512	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6513	عزيزي العميل، رصيد حسابك هو 7181.22. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6514	عزيزي العميل، رصيد حسابك هو 8996.41. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6522	Your online transfer of $849.30 to account 2322 was successful.	2025-11-10 00:00:00	\N	en
6523	تمت عملية بقيمة 364.64 في المتجر. مرجع: 7849.	2025-11-10 00:00:00	\N	ar
6525	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6528	تمت عملية بقيمة 9194.19 في المتجر. مرجع: 9497.	2025-11-10 00:00:00	\N	ar
6532	تم استلام دفعة بقيمة 4607.80 في حسابك المنتهي بـ 1913. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6533	تمت عملية بقيمة 3140.40 في المتجر. مرجع: 3836.	2025-11-10 00:00:00	\N	ar
6540	Notification: Your card ending with 5671 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6541	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6544	Your OTP for transaction is 933880. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6545	عزيزي العميل، رصيد حسابك هو 1547.72. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6546	Notification: Your card ending with 3425 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6549	Your scheduled transfer completed successfully. Ref: 3625.	2025-11-10 00:00:00	\N	en
6550	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6552	ستنتهي صلاحية بطاقتك المنتهية بـ 1714 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6553	Dear customer, your account balance is $1157.48. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6554	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6557	Dear customer, your account balance is $5189.57. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6558	تم استلام دفعة بقيمة 5189.56 في حسابك المنتهي بـ 3602. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6563	Reminder: Your loan payment of $13.46 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6564	Your transaction of $4327.49 at STORE was successful. Ref: 9549.	2025-11-10 00:00:00	\N	en
6565	Your OTP for transaction is 139957. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6567	التحويل المجدول اكتمل بنجاح. مرجع: 1257.	2025-11-10 00:00:00	\N	ar
6568	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6571	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6573	تم استلام دفعة بقيمة 3428.48 في حسابك المنتهي بـ 9961. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6574	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6576	Your transaction of $5827.81 at STORE was successful. Ref: 9444.	2025-11-10 00:00:00	\N	en
6577	تم استلام دفعة بقيمة 3089.00 في حسابك المنتهي بـ 7357. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6580	رمز التحقق لعملية الدفع هو 624113. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6583	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6584	ستنتهي صلاحية بطاقتك المنتهية بـ 7907 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6585	Your debit card ending 1020 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6586	Payment of $8860.23 received to your account ending with 9749. Thank you.	2025-11-10 00:00:00	\N	en
6589	تمت عملية بقيمة 7401.77 في المتجر. مرجع: 6172.	2025-11-10 00:00:00	\N	ar
6590	Your scheduled transfer completed successfully. Ref: 8206.	2025-11-10 00:00:00	\N	en
6591	Your transaction of $132.82 at STORE was successful. Ref: 1613.	2025-11-10 00:00:00	\N	en
6598	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6599	Reminder: Your loan payment of $5487.09 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6600	تذكير: قسط القرض بقيمة 6446.18 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6602	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6604	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6605	تنبيه: بطاقتك المنتهية بـ 8633 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6606	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6609	التحويل المجدول اكتمل بنجاح. مرجع: 4855.	2025-11-10 00:00:00	\N	ar
6611	Your OTP for transaction is 681559. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6612	Your transaction of $9090.58 at STORE was successful. Ref: 2381.	2025-11-10 00:00:00	\N	en
6613	Payment of $3092.65 received to your account ending with 8478. Thank you.	2025-11-10 00:00:00	\N	en
6614	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6617	Reminder: Your loan payment of $9290.67 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6618	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6619	تم استلام دفعة بقيمة 5735.86 في حسابك المنتهي بـ 9344. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6624	Reminder: Your loan payment of $2944.32 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6627	Your OTP for transaction is 791274. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6628	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6629	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6631	ستنتهي صلاحية بطاقتك المنتهية بـ 7609 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6632	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6633	ستنتهي صلاحية بطاقتك المنتهية بـ 7142 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6635	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6636	تم استلام دفعة بقيمة 8121.18 في حسابك المنتهي بـ 9413. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6639	Reminder: Your loan payment of $3079.94 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6643	Notification: Your card ending with 6033 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6644	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6646	عزيزي العميل، رصيد حسابك هو 2209.22. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6647	Your online transfer of $2521.81 to account 1784 was successful.	2025-11-10 00:00:00	\N	en
6650	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6656	Your scheduled transfer completed successfully. Ref: 6781.	2025-11-10 00:00:00	\N	en
6659	تنبيه: بطاقتك المنتهية بـ 6713 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6660	عزيزي العميل، رصيد حسابك هو 4582.71. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6662	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6663	تنبيه: بطاقتك المنتهية بـ 4183 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6665	عزيزي العميل، رصيد حسابك هو 1347.11. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6666	تنبيه: بطاقتك المنتهية بـ 5763 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6667	ستنتهي صلاحية بطاقتك المنتهية بـ 4945 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6668	Dear customer, your account balance is $9565.44. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6669	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6670	رمز التحقق لعملية الدفع هو 737399. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6673	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6674	Your transaction of $3764.48 at STORE was successful. Ref: 3978.	2025-11-10 00:00:00	\N	en
6678	تذكير: قسط القرض بقيمة 2506.91 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6682	ستنتهي صلاحية بطاقتك المنتهية بـ 2249 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6684	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6686	Dear customer, your account balance is $3571.15. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6688	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6690	Payment of $5806.05 received to your account ending with 4650. Thank you.	2025-11-10 00:00:00	\N	en
6691	ستنتهي صلاحية بطاقتك المنتهية بـ 4329 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6692	Your scheduled transfer completed successfully. Ref: 2026.	2025-11-10 00:00:00	\N	en
6696	Notification: Your card ending with 1694 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6701	Dear customer, your account balance is $426.08. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6702	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6705	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6711	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6712	التحويل المجدول اكتمل بنجاح. مرجع: 2299.	2025-11-10 00:00:00	\N	ar
6714	التحويل المجدول اكتمل بنجاح. مرجع: 3805.	2025-11-10 00:00:00	\N	ar
6716	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6717	Your OTP for transaction is 173617. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6719	Notification: Your card ending with 1536 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6720	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6721	رمز التحقق لعملية الدفع هو 123757. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6726	تم استلام دفعة بقيمة 915.76 في حسابك المنتهي بـ 1623. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6727	رمز التحقق لعملية الدفع هو 305435. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6728	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6730	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6731	تنبيه: بطاقتك المنتهية بـ 7421 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6732	تنبيه: بطاقتك المنتهية بـ 4084 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6733	التحويل المجدول اكتمل بنجاح. مرجع: 6099.	2025-11-10 00:00:00	\N	ar
6734	Your online transfer of $8417.96 to account 2135 was successful.	2025-11-10 00:00:00	\N	en
6735	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6736	Payment of $6169.18 received to your account ending with 1898. Thank you.	2025-11-10 00:00:00	\N	en
6738	التحويل المجدول اكتمل بنجاح. مرجع: 9614.	2025-11-10 00:00:00	\N	ar
6739	ستنتهي صلاحية بطاقتك المنتهية بـ 2803 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6740	رمز التحقق لعملية الدفع هو 314861. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6741	Your OTP for transaction is 878819. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6747	رمز التحقق لعملية الدفع هو 583798. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6748	Your scheduled transfer completed successfully. Ref: 8198.	2025-11-10 00:00:00	\N	en
6751	ستنتهي صلاحية بطاقتك المنتهية بـ 8782 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6752	Your OTP for transaction is 103463. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6755	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6758	Dear customer, your account balance is $2083.01. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6759	تم استلام دفعة بقيمة 2443.62 في حسابك المنتهي بـ 6563. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6760	Payment of $4531.15 received to your account ending with 4537. Thank you.	2025-11-10 00:00:00	\N	en
6761	Your scheduled transfer completed successfully. Ref: 4574.	2025-11-10 00:00:00	\N	en
6765	رمز التحقق لعملية الدفع هو 588013. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6770	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6771	رمز التحقق لعملية الدفع هو 849595. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6773	تمت عملية بقيمة 7458.97 في المتجر. مرجع: 7047.	2025-11-10 00:00:00	\N	ar
6776	رمز التحقق لعملية الدفع هو 715789. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6778	Notification: Your card ending with 7173 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6779	Payment of $3460.46 received to your account ending with 8561. Thank you.	2025-11-10 00:00:00	\N	en
6781	Your scheduled transfer completed successfully. Ref: 9392.	2025-11-10 00:00:00	\N	en
6783	تنبيه: بطاقتك المنتهية بـ 3146 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6785	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6787	التحويل المجدول اكتمل بنجاح. مرجع: 4705.	2025-11-10 00:00:00	\N	ar
6788	Your online transfer of $4427.42 to account 6638 was successful.	2025-11-10 00:00:00	\N	en
6790	Payment of $7136.25 received to your account ending with 9434. Thank you.	2025-11-10 00:00:00	\N	en
6791	تم استلام دفعة بقيمة 1969.93 في حسابك المنتهي بـ 1513. شكرًا لك.	2025-11-10 00:00:00	\N	ar
6792	Reminder: Your loan payment of $5793.74 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6793	رمز التحقق لعملية الدفع هو 821208. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6796	Your scheduled transfer completed successfully. Ref: 8498.	2025-11-10 00:00:00	\N	en
6798	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6799	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6800	Notification: Your card ending with 1929 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6801	Reminder: Your loan payment of $6159.03 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6803	Dear customer, your account balance is $441.71. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6804	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6806	Your OTP for transaction is 674477. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6808	عزيزي العميل، رصيد حسابك هو 2101.07. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6809	Reminder: Your loan payment of $3236.40 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6810	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6813	رمز التحقق لعملية الدفع هو 605181. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6814	عزيزي العميل، رصيد حسابك هو 4037.20. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6815	تذكير: قسط القرض بقيمة 2292.40 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6816	Your transaction of $9027.61 at STORE was successful. Ref: 7824.	2025-11-10 00:00:00	\N	en
6817	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6820	Payment of $5403.51 received to your account ending with 8087. Thank you.	2025-11-10 00:00:00	\N	en
6821	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6822	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6826	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6829	Notification: Your card ending with 9115 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6830	التحويل المجدول اكتمل بنجاح. مرجع: 1040.	2025-11-10 00:00:00	\N	ar
6832	Payment of $5044.33 received to your account ending with 8495. Thank you.	2025-11-10 00:00:00	\N	en
6833	تذكير: قسط القرض بقيمة 6667.87 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6834	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6835	ستنتهي صلاحية بطاقتك المنتهية بـ 6028 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6836	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
6837	عزيزي العميل، رصيد حسابك هو 8035.78. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6838	Your online transfer of $4934.42 to account 4810 was successful.	2025-11-10 00:00:00	\N	en
6841	عزيزي العميل، رصيد حسابك هو 730.14. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6842	Payment of $5393.81 received to your account ending with 1762. Thank you.	2025-11-10 00:00:00	\N	en
6843	تمت عملية بقيمة 2730.22 في المتجر. مرجع: 2880.	2025-11-10 00:00:00	\N	ar
6845	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6846	Your scheduled transfer completed successfully. Ref: 7117.	2025-11-10 00:00:00	\N	en
6851	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6852	Your scheduled transfer completed successfully. Ref: 7689.	2025-11-10 00:00:00	\N	en
6854	التحويل المجدول اكتمل بنجاح. مرجع: 4792.	2025-11-10 00:00:00	\N	ar
6857	Your debit card ending 2564 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6858	ستنتهي صلاحية بطاقتك المنتهية بـ 7004 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6861	Your scheduled transfer completed successfully. Ref: 1242.	2025-11-10 00:00:00	\N	en
6862	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
6864	عزيزي العميل، رصيد حسابك هو 4386.66. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6865	Payment of $8443.18 received to your account ending with 8786. Thank you.	2025-11-10 00:00:00	\N	en
6867	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6871	Reminder: Your loan payment of $1176.20 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6873	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6874	Your transaction of $6660.32 at STORE was successful. Ref: 8286.	2025-11-10 00:00:00	\N	en
6875	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6878	التحويل المجدول اكتمل بنجاح. مرجع: 8828.	2025-11-10 00:00:00	\N	ar
6879	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6881	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6882	Dear customer, your account balance is $35.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6883	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
6884	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6886	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6887	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6888	رمز التحقق لعملية الدفع هو 115313. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6889	تنبيه: بطاقتك المنتهية بـ 9980 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6891	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6892	Your scheduled transfer completed successfully. Ref: 5849.	2025-11-10 00:00:00	\N	en
6893	Your debit card ending 7781 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6896	Your scheduled transfer completed successfully. Ref: 2491.	2025-11-10 00:00:00	\N	en
6897	تمت عملية بقيمة 7896.98 في المتجر. مرجع: 4370.	2025-11-10 00:00:00	\N	ar
6898	Your OTP for transaction is 480329. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6900	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6901	عزيزي العميل، رصيد حسابك هو 1009.87. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
6906	تنبيه: بطاقتك المنتهية بـ 1662 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6907	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6908	Reminder: Your loan payment of $4746.49 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6911	التحويل المجدول اكتمل بنجاح. مرجع: 8483.	2025-11-10 00:00:00	\N	ar
6915	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6916	التحويل المجدول اكتمل بنجاح. مرجع: 5843.	2025-11-10 00:00:00	\N	ar
6917	Dear customer, your account balance is $9618.21. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6928	Notification: Your card ending with 6970 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6930	التحويل المجدول اكتمل بنجاح. مرجع: 1538.	2025-11-10 00:00:00	\N	ar
6932	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6933	تنبيه: بطاقتك المنتهية بـ 7073 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
6937	Dear customer, your account balance is $341.97. Visit our branch for details.	2025-11-10 00:00:00	\N	en
6938	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6939	تمت عملية بقيمة 4334.92 في المتجر. مرجع: 3721.	2025-11-10 00:00:00	\N	ar
6940	Notification: Your card ending with 8870 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
6942	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
6947	Your debit card ending 9002 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6951	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
6953	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6954	التحويل المجدول اكتمل بنجاح. مرجع: 5702.	2025-11-10 00:00:00	\N	ar
6958	Your debit card ending 6737 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6959	Your debit card ending 5477 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
6963	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6965	Your scheduled transfer completed successfully. Ref: 6933.	2025-11-10 00:00:00	\N	en
6967	Reminder: Your loan payment of $9650.60 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6968	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6972	Your transaction of $2818.03 at STORE was successful. Ref: 3128.	2025-11-10 00:00:00	\N	en
6974	رمز التحقق لعملية الدفع هو 504421. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
6975	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
6979	Your scheduled transfer completed successfully. Ref: 4579.	2025-11-10 00:00:00	\N	en
6980	التحويل المجدول اكتمل بنجاح. مرجع: 9596.	2025-11-10 00:00:00	\N	ar
6982	ستنتهي صلاحية بطاقتك المنتهية بـ 4738 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
6983	Your transaction of $3773.39 at STORE was successful. Ref: 5916.	2025-11-10 00:00:00	\N	en
6984	Your transaction of $2253.01 at STORE was successful. Ref: 5443.	2025-11-10 00:00:00	\N	en
6986	تذكير: قسط القرض بقيمة 852.52 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
6987	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
6989	Reminder: Your loan payment of $3056.67 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
6990	Your scheduled transfer completed successfully. Ref: 2324.	2025-11-10 00:00:00	\N	en
6991	Payment of $9419.41 received to your account ending with 5976. Thank you.	2025-11-10 00:00:00	\N	en
6992	Your OTP for transaction is 680122. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
6996	Your transaction of $9755.39 at STORE was successful. Ref: 1222.	2025-11-10 00:00:00	\N	en
6997	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7000	Notification: Your card ending with 1967 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7001	Your OTP for transaction is 291703. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7004	ستنتهي صلاحية بطاقتك المنتهية بـ 3918 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7005	Notification: Your card ending with 3331 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7007	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7008	ستنتهي صلاحية بطاقتك المنتهية بـ 5048 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7009	Reminder: Your loan payment of $2681.01 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7011	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7016	Payment of $2789.47 received to your account ending with 8673. Thank you.	2025-11-10 00:00:00	\N	en
7017	Dear customer, your account balance is $8968.33. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7019	Your transaction of $1985.67 at STORE was successful. Ref: 1789.	2025-11-10 00:00:00	\N	en
7022	Payment of $8538.58 received to your account ending with 1304. Thank you.	2025-11-10 00:00:00	\N	en
7023	Your scheduled transfer completed successfully. Ref: 3081.	2025-11-10 00:00:00	\N	en
7024	عزيزي العميل، رصيد حسابك هو 4700.06. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7025	Reminder: Your loan payment of $287.17 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7026	Your transaction of $392.48 at STORE was successful. Ref: 1985.	2025-11-10 00:00:00	\N	en
7027	تمت عملية بقيمة 9060.79 في المتجر. مرجع: 9215.	2025-11-10 00:00:00	\N	ar
7028	تم استلام دفعة بقيمة 6106.01 في حسابك المنتهي بـ 2540. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7032	Your scheduled transfer completed successfully. Ref: 8989.	2025-11-10 00:00:00	\N	en
7033	Dear customer, your account balance is $7290.82. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7039	ستنتهي صلاحية بطاقتك المنتهية بـ 7983 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7041	Your OTP for transaction is 487247. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7042	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7043	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7044	عزيزي العميل، رصيد حسابك هو 1767.07. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7045	التحويل المجدول اكتمل بنجاح. مرجع: 5219.	2025-11-10 00:00:00	\N	ar
7046	Payment of $948.00 received to your account ending with 9743. Thank you.	2025-11-10 00:00:00	\N	en
7047	Your transaction of $773.21 at STORE was successful. Ref: 4663.	2025-11-10 00:00:00	\N	en
7048	Your debit card ending 2272 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7053	Payment of $7172.11 received to your account ending with 2065. Thank you.	2025-11-10 00:00:00	\N	en
7056	تم استلام دفعة بقيمة 9851.09 في حسابك المنتهي بـ 3183. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7058	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7064	Your OTP for transaction is 584097. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7065	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7068	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7072	Your OTP for transaction is 947148. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7077	Payment of $8206.48 received to your account ending with 2168. Thank you.	2025-11-10 00:00:00	\N	en
7081	ستنتهي صلاحية بطاقتك المنتهية بـ 8190 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7084	تنبيه: بطاقتك المنتهية بـ 5204 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7086	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7087	Reminder: Your loan payment of $2254.48 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7089	ستنتهي صلاحية بطاقتك المنتهية بـ 2205 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7091	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7092	Your transaction of $477.37 at STORE was successful. Ref: 5043.	2025-11-10 00:00:00	\N	en
7097	رمز التحقق لعملية الدفع هو 440699. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7099	عزيزي العميل، رصيد حسابك هو 2931.03. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7100	التحويل المجدول اكتمل بنجاح. مرجع: 3291.	2025-11-10 00:00:00	\N	ar
7104	تذكير: قسط القرض بقيمة 5607.83 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7107	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7110	تمت عملية بقيمة 2933.20 في المتجر. مرجع: 5964.	2025-11-10 00:00:00	\N	ar
7112	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7116	Notification: Your card ending with 5293 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7117	تذكير: قسط القرض بقيمة 9981.20 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7119	تم استلام دفعة بقيمة 7276.78 في حسابك المنتهي بـ 5387. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7120	Reminder: Your loan payment of $3836.03 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7121	Your debit card ending 8972 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7122	رمز التحقق لعملية الدفع هو 878894. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7125	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7127	رمز التحقق لعملية الدفع هو 932118. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7133	تم استلام دفعة بقيمة 2994.65 في حسابك المنتهي بـ 1341. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7135	تذكير: قسط القرض بقيمة 1934.04 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7139	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7142	تذكير: قسط القرض بقيمة 5060.87 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7143	Your OTP for transaction is 596225. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7144	Payment of $5568.55 received to your account ending with 5832. Thank you.	2025-11-10 00:00:00	\N	en
7149	تم استلام دفعة بقيمة 7673.30 في حسابك المنتهي بـ 6103. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7151	Your online transfer of $3788.40 to account 1898 was successful.	2025-11-10 00:00:00	\N	en
7153	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7155	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7156	تم استلام دفعة بقيمة 9085.84 في حسابك المنتهي بـ 9050. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7157	Your OTP for transaction is 232420. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7160	Your transaction of $2986.18 at STORE was successful. Ref: 9682.	2025-11-10 00:00:00	\N	en
7161	التحويل المجدول اكتمل بنجاح. مرجع: 3904.	2025-11-10 00:00:00	\N	ar
7162	Reminder: Your loan payment of $3141.40 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7163	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7645	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7164	تنبيه: بطاقتك المنتهية بـ 7247 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7170	تمت عملية بقيمة 2279.87 في المتجر. مرجع: 5227.	2025-11-10 00:00:00	\N	ar
7171	Notification: Your card ending with 8822 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7172	Dear customer, your account balance is $8655.77. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7174	تمت عملية بقيمة 167.23 في المتجر. مرجع: 3310.	2025-11-10 00:00:00	\N	ar
7175	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7176	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7177	عزيزي العميل، رصيد حسابك هو 9490.63. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7178	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7179	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7180	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7182	Your debit card ending 8987 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7184	تمت عملية بقيمة 8648.56 في المتجر. مرجع: 1292.	2025-11-10 00:00:00	\N	ar
7188	Dear customer, your account balance is $2603.00. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7189	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7192	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7193	التحويل المجدول اكتمل بنجاح. مرجع: 1668.	2025-11-10 00:00:00	\N	ar
7194	Your online transfer of $5556.44 to account 5491 was successful.	2025-11-10 00:00:00	\N	en
7196	عزيزي العميل، رصيد حسابك هو 9019.39. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7200	ستنتهي صلاحية بطاقتك المنتهية بـ 7458 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7203	عزيزي العميل، رصيد حسابك هو 1580.86. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7204	Reminder: Your loan payment of $1915.07 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7205	Dear customer, your account balance is $6761.52. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7206	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7209	Payment of $7911.78 received to your account ending with 2869. Thank you.	2025-11-10 00:00:00	\N	en
7210	التحويل المجدول اكتمل بنجاح. مرجع: 4180.	2025-11-10 00:00:00	\N	ar
7212	تذكير: قسط القرض بقيمة 1270.65 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7215	التحويل المجدول اكتمل بنجاح. مرجع: 4836.	2025-11-10 00:00:00	\N	ar
7218	عزيزي العميل، رصيد حسابك هو 1125.59. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7221	Your transaction of $2044.38 at STORE was successful. Ref: 4486.	2025-11-10 00:00:00	\N	en
7226	رمز التحقق لعملية الدفع هو 522282. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7229	تمت عملية بقيمة 2933.54 في المتجر. مرجع: 7256.	2025-11-10 00:00:00	\N	ar
7231	تم استلام دفعة بقيمة 9720.15 في حسابك المنتهي بـ 3230. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7232	Dear customer, your account balance is $7182.07. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7237	Notification: Your card ending with 8016 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7238	ستنتهي صلاحية بطاقتك المنتهية بـ 1138 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7242	ستنتهي صلاحية بطاقتك المنتهية بـ 9946 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7247	عزيزي العميل، رصيد حسابك هو 6580.36. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7250	تذكير: قسط القرض بقيمة 1461.96 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7251	Your transaction of $2121.01 at STORE was successful. Ref: 1987.	2025-11-10 00:00:00	\N	en
7252	Payment of $8826.58 received to your account ending with 3291. Thank you.	2025-11-10 00:00:00	\N	en
7258	تنبيه: بطاقتك المنتهية بـ 8085 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7261	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7262	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7265	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7266	تمت عملية بقيمة 1327.31 في المتجر. مرجع: 2757.	2025-11-10 00:00:00	\N	ar
7268	تذكير: قسط القرض بقيمة 7223.52 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7271	التحويل المجدول اكتمل بنجاح. مرجع: 1569.	2025-11-10 00:00:00	\N	ar
7272	تنبيه: بطاقتك المنتهية بـ 6457 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7274	ستنتهي صلاحية بطاقتك المنتهية بـ 9322 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7275	ستنتهي صلاحية بطاقتك المنتهية بـ 6965 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7279	تنبيه: بطاقتك المنتهية بـ 3326 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7280	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7283	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7284	تم استلام دفعة بقيمة 6432.48 في حسابك المنتهي بـ 1730. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7286	Your OTP for transaction is 294876. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7288	تنبيه: بطاقتك المنتهية بـ 1516 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7289	Your debit card ending 9709 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7290	تذكير: قسط القرض بقيمة 833.89 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7291	Your OTP for transaction is 670173. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7292	Reminder: Your loan payment of $9781.10 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7293	Your scheduled transfer completed successfully. Ref: 7970.	2025-11-10 00:00:00	\N	en
7294	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7297	Your scheduled transfer completed successfully. Ref: 7394.	2025-11-10 00:00:00	\N	en
7299	Your transaction of $643.66 at STORE was successful. Ref: 9356.	2025-11-10 00:00:00	\N	en
7302	تم استلام دفعة بقيمة 4124.69 في حسابك المنتهي بـ 9303. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7303	تم استلام دفعة بقيمة 1489.27 في حسابك المنتهي بـ 2379. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7304	Your OTP for transaction is 940359. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7307	Your debit card ending 3571 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7308	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7310	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7311	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7313	Your transaction of $9528.75 at STORE was successful. Ref: 4203.	2025-11-10 00:00:00	\N	en
7315	Your online transfer of $3544.27 to account 1715 was successful.	2025-11-10 00:00:00	\N	en
7320	Reminder: Your loan payment of $9335.31 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7321	ستنتهي صلاحية بطاقتك المنتهية بـ 4731 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7327	عزيزي العميل، رصيد حسابك هو 3854.21. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7328	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7329	تنبيه: بطاقتك المنتهية بـ 3075 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7331	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7334	عزيزي العميل، رصيد حسابك هو 3754.12. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7335	Your transaction of $8261.40 at STORE was successful. Ref: 1440.	2025-11-10 00:00:00	\N	en
7336	رمز التحقق لعملية الدفع هو 263122. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7337	رمز التحقق لعملية الدفع هو 990954. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7340	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7342	رمز التحقق لعملية الدفع هو 632043. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7344	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7349	التحويل المجدول اكتمل بنجاح. مرجع: 6800.	2025-11-10 00:00:00	\N	ar
7353	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7356	تمت عملية بقيمة 6456.85 في المتجر. مرجع: 5299.	2025-11-10 00:00:00	\N	ar
7359	Reminder: Your loan payment of $8649.59 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7360	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7361	رمز التحقق لعملية الدفع هو 693851. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7362	Your debit card ending 7676 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7365	رمز التحقق لعملية الدفع هو 975219. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7367	عزيزي العميل، رصيد حسابك هو 5170.54. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7368	ستنتهي صلاحية بطاقتك المنتهية بـ 6425 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7369	Your OTP for transaction is 690030. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7371	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7378	Reminder: Your loan payment of $9598.79 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7379	التحويل المجدول اكتمل بنجاح. مرجع: 6167.	2025-11-10 00:00:00	\N	ar
7380	التحويل المجدول اكتمل بنجاح. مرجع: 3095.	2025-11-10 00:00:00	\N	ar
7383	Your OTP for transaction is 926238. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7387	عزيزي العميل، رصيد حسابك هو 8719.09. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7388	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7392	التحويل المجدول اكتمل بنجاح. مرجع: 9803.	2025-11-10 00:00:00	\N	ar
7396	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7398	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7399	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7400	Notification: Your card ending with 2219 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7401	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7402	تمت عملية بقيمة 1013.73 في المتجر. مرجع: 2590.	2025-11-10 00:00:00	\N	ar
7403	تنبيه: بطاقتك المنتهية بـ 4718 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7404	تنبيه: بطاقتك المنتهية بـ 6539 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7407	رمز التحقق لعملية الدفع هو 446980. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7409	Your transaction of $8566.47 at STORE was successful. Ref: 2640.	2025-11-10 00:00:00	\N	en
7411	Dear customer, your account balance is $8041.46. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7412	عزيزي العميل، رصيد حسابك هو 1272.00. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7413	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7414	تذكير: قسط القرض بقيمة 6015.01 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7418	عزيزي العميل، رصيد حسابك هو 1042.02. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7419	تمت عملية بقيمة 8531.43 في المتجر. مرجع: 6672.	2025-11-10 00:00:00	\N	ar
7421	تنبيه: بطاقتك المنتهية بـ 6564 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7422	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7424	رمز التحقق لعملية الدفع هو 840702. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7425	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7435	Your OTP for transaction is 131846. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7436	تمت عملية بقيمة 4624.28 في المتجر. مرجع: 6039.	2025-11-10 00:00:00	\N	ar
7437	Notification: Your card ending with 9611 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7438	التحويل المجدول اكتمل بنجاح. مرجع: 6662.	2025-11-10 00:00:00	\N	ar
7440	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7445	تم استلام دفعة بقيمة 8107.92 في حسابك المنتهي بـ 2300. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7449	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7451	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7452	Your debit card ending 2909 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7453	تم استلام دفعة بقيمة 5594.52 في حسابك المنتهي بـ 7249. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7454	Dear customer, your account balance is $6981.68. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7457	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7460	تذكير: قسط القرض بقيمة 9480.10 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7461	Dear customer, your account balance is $5286.63. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7462	Your transaction of $8005.59 at STORE was successful. Ref: 8610.	2025-11-10 00:00:00	\N	en
7465	Your transaction of $7422.85 at STORE was successful. Ref: 5678.	2025-11-10 00:00:00	\N	en
7472	تمت عملية بقيمة 8642.20 في المتجر. مرجع: 9346.	2025-11-10 00:00:00	\N	ar
7474	Dear customer, your account balance is $6561.23. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7475	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7477	Payment of $6303.93 received to your account ending with 8017. Thank you.	2025-11-10 00:00:00	\N	en
7478	تمت عملية بقيمة 2084.33 في المتجر. مرجع: 9601.	2025-11-10 00:00:00	\N	ar
7481	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7482	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7483	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7485	تم استلام دفعة بقيمة 3340.47 في حسابك المنتهي بـ 7144. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7492	Your scheduled transfer completed successfully. Ref: 8181.	2025-11-10 00:00:00	\N	en
7494	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7495	تنبيه: بطاقتك المنتهية بـ 8472 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7498	Your debit card ending 6832 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7501	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7502	تنبيه: بطاقتك المنتهية بـ 7666 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7504	تذكير: قسط القرض بقيمة 303.19 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7506	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7507	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7511	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7517	Your transaction of $3151.41 at STORE was successful. Ref: 5551.	2025-11-10 00:00:00	\N	en
7521	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7525	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7526	تمت عملية بقيمة 4890.94 في المتجر. مرجع: 6554.	2025-11-10 00:00:00	\N	ar
7528	تم استلام دفعة بقيمة 9961.67 في حسابك المنتهي بـ 9823. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7529	Notification: Your card ending with 2695 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7533	Reminder: Your loan payment of $4695.18 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7534	Dear customer, your account balance is $2039.92. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7537	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7538	Your transaction of $3785.09 at STORE was successful. Ref: 6218.	2025-11-10 00:00:00	\N	en
7539	تمت عملية بقيمة 454.89 في المتجر. مرجع: 7808.	2025-11-10 00:00:00	\N	ar
7540	ستنتهي صلاحية بطاقتك المنتهية بـ 5749 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7545	ستنتهي صلاحية بطاقتك المنتهية بـ 5876 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7547	تذكير: قسط القرض بقيمة 2701.78 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7548	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7549	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7550	تنبيه: بطاقتك المنتهية بـ 5797 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7551	عزيزي العميل، رصيد حسابك هو 6956.02. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7552	عزيزي العميل، رصيد حسابك هو 2034.70. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7554	رمز التحقق لعملية الدفع هو 432474. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7555	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7556	Your OTP for transaction is 992422. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7558	Dear customer, your account balance is $2517.34. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7559	عزيزي العميل، رصيد حسابك هو 6099.94. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7562	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7563	Your debit card ending 8948 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7565	تم استلام دفعة بقيمة 1258.12 في حسابك المنتهي بـ 3412. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7568	ستنتهي صلاحية بطاقتك المنتهية بـ 6937 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7571	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7573	عزيزي العميل، رصيد حسابك هو 665.13. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7575	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7578	رمز التحقق لعملية الدفع هو 565968. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7579	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7582	Dear customer, your account balance is $2023.97. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7584	Your online transfer of $4147.89 to account 6632 was successful.	2025-11-10 00:00:00	\N	en
7586	Your scheduled transfer completed successfully. Ref: 2089.	2025-11-10 00:00:00	\N	en
7591	تذكير: قسط القرض بقيمة 9029.64 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7592	Your scheduled transfer completed successfully. Ref: 1169.	2025-11-10 00:00:00	\N	en
7593	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7594	عزيزي العميل، رصيد حسابك هو 708.74. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7597	عزيزي العميل، رصيد حسابك هو 1881.14. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7598	تمت عملية بقيمة 6225.41 في المتجر. مرجع: 6887.	2025-11-10 00:00:00	\N	ar
7599	Your debit card ending 4705 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7600	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7602	تمت عملية بقيمة 4018.88 في المتجر. مرجع: 1010.	2025-11-10 00:00:00	\N	ar
7605	Your OTP for transaction is 181837. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7606	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7607	Your debit card ending 9461 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7608	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7609	Payment of $6151.06 received to your account ending with 8820. Thank you.	2025-11-10 00:00:00	\N	en
7611	التحويل المجدول اكتمل بنجاح. مرجع: 4713.	2025-11-10 00:00:00	\N	ar
7612	عزيزي العميل، رصيد حسابك هو 2707.21. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7614	ستنتهي صلاحية بطاقتك المنتهية بـ 9065 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7615	Your debit card ending 3908 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7616	Payment of $1541.18 received to your account ending with 1300. Thank you.	2025-11-10 00:00:00	\N	en
7620	Notification: Your card ending with 7907 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7621	ستنتهي صلاحية بطاقتك المنتهية بـ 1814 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7623	رمز التحقق لعملية الدفع هو 905338. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7625	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7626	Dear customer, your account balance is $8182.23. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7628	Your transaction of $6044.65 at STORE was successful. Ref: 4451.	2025-11-10 00:00:00	\N	en
7633	Your debit card ending 7748 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7637	تذكير: قسط القرض بقيمة 4959.34 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7638	Dear customer, your account balance is $5752.81. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7640	Your transaction of $5679.39 at STORE was successful. Ref: 5964.	2025-11-10 00:00:00	\N	en
7641	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7642	تنبيه: بطاقتك المنتهية بـ 1113 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7646	Dear customer, your account balance is $6993.13. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7648	تذكير: قسط القرض بقيمة 8988.32 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7649	تم استلام دفعة بقيمة 642.34 في حسابك المنتهي بـ 3011. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7650	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7651	Payment of $134.31 received to your account ending with 8134. Thank you.	2025-11-10 00:00:00	\N	en
7652	Your online transfer of $9472.36 to account 1662 was successful.	2025-11-10 00:00:00	\N	en
7653	تمت عملية بقيمة 9959.21 في المتجر. مرجع: 1519.	2025-11-10 00:00:00	\N	ar
7656	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7658	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7659	Dear customer, your account balance is $1769.94. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7660	عزيزي العميل، رصيد حسابك هو 8484.93. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7662	تم استلام دفعة بقيمة 5244.08 في حسابك المنتهي بـ 7898. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7663	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7664	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7667	Reminder: Your loan payment of $7673.87 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7669	رمز التحقق لعملية الدفع هو 566769. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7670	ستنتهي صلاحية بطاقتك المنتهية بـ 6224 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7671	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7672	تمت عملية بقيمة 8904.14 في المتجر. مرجع: 7076.	2025-11-10 00:00:00	\N	ar
7673	رمز التحقق لعملية الدفع هو 741423. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7676	Your debit card ending 7784 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7677	Your OTP for transaction is 436256. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7679	Your debit card ending 6379 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7680	Your transaction of $9221.45 at STORE was successful. Ref: 3935.	2025-11-10 00:00:00	\N	en
7687	ستنتهي صلاحية بطاقتك المنتهية بـ 5757 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7689	Reminder: Your loan payment of $672.15 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7690	تم استلام دفعة بقيمة 5262.74 في حسابك المنتهي بـ 9831. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7691	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7693	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7694	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7695	تذكير: قسط القرض بقيمة 6843.60 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7696	التحويل المجدول اكتمل بنجاح. مرجع: 5547.	2025-11-10 00:00:00	\N	ar
7698	ستنتهي صلاحية بطاقتك المنتهية بـ 4987 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7703	تمت عملية بقيمة 3958.18 في المتجر. مرجع: 1955.	2025-11-10 00:00:00	\N	ar
7705	Your transaction of $5422.15 at STORE was successful. Ref: 4982.	2025-11-10 00:00:00	\N	en
7706	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7707	تم استلام دفعة بقيمة 8224.14 في حسابك المنتهي بـ 9044. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7708	Reminder: Your loan payment of $129.09 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7709	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7712	رمز التحقق لعملية الدفع هو 180314. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7714	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7716	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7719	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7723	Payment of $6526.69 received to your account ending with 7168. Thank you.	2025-11-10 00:00:00	\N	en
7724	تم استلام دفعة بقيمة 5447.61 في حسابك المنتهي بـ 6279. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7725	Reminder: Your loan payment of $6978.19 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7728	تم استلام دفعة بقيمة 6405.17 في حسابك المنتهي بـ 5547. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7731	Notification: Your card ending with 1052 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7732	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7739	عزيزي العميل، رصيد حسابك هو 8071.24. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7741	Payment of $8715.63 received to your account ending with 2826. Thank you.	2025-11-10 00:00:00	\N	en
7743	Notification: Your card ending with 8488 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7746	تذكير: قسط القرض بقيمة 6945.97 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7747	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7748	التحويل المجدول اكتمل بنجاح. مرجع: 8137.	2025-11-10 00:00:00	\N	ar
7751	ستنتهي صلاحية بطاقتك المنتهية بـ 8455 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7756	Your debit card ending 3657 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7757	التحويل المجدول اكتمل بنجاح. مرجع: 8004.	2025-11-10 00:00:00	\N	ar
7759	Your transaction of $5352.67 at STORE was successful. Ref: 2523.	2025-11-10 00:00:00	\N	en
7760	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7761	Your transaction of $664.08 at STORE was successful. Ref: 4192.	2025-11-10 00:00:00	\N	en
7768	عزيزي العميل، رصيد حسابك هو 9304.56. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7769	Payment of $731.24 received to your account ending with 9861. Thank you.	2025-11-10 00:00:00	\N	en
7771	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7773	Your OTP for transaction is 224081. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7777	Payment of $2960.25 received to your account ending with 9671. Thank you.	2025-11-10 00:00:00	\N	en
7778	تم استلام دفعة بقيمة 1132.89 في حسابك المنتهي بـ 2963. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7779	Reminder: Your loan payment of $2246.03 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7780	Notification: Your card ending with 7141 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7781	Payment of $6570.59 received to your account ending with 6079. Thank you.	2025-11-10 00:00:00	\N	en
7785	تمت عملية بقيمة 4008.74 في المتجر. مرجع: 8544.	2025-11-10 00:00:00	\N	ar
7787	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7788	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7789	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7791	Reminder: Your loan payment of $2943.77 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7792	Your online transfer of $7299.06 to account 4693 was successful.	2025-11-10 00:00:00	\N	en
7795	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7796	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7798	Your online transfer of $9694.10 to account 8926 was successful.	2025-11-10 00:00:00	\N	en
7799	عزيزي العميل، رصيد حسابك هو 324.72. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7801	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7807	التحويل المجدول اكتمل بنجاح. مرجع: 9792.	2025-11-10 00:00:00	\N	ar
7810	Payment of $2901.05 received to your account ending with 9689. Thank you.	2025-11-10 00:00:00	\N	en
7813	Your scheduled transfer completed successfully. Ref: 6206.	2025-11-10 00:00:00	\N	en
7814	تم استلام دفعة بقيمة 5250.46 في حسابك المنتهي بـ 2452. شكرًا لك.	2025-11-10 00:00:00	\N	ar
7820	رمز التحقق لعملية الدفع هو 761002. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7821	Your online transfer of $6038.86 to account 1178 was successful.	2025-11-10 00:00:00	\N	en
7822	Your debit card ending 9498 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7823	تمت عملية بقيمة 9706.76 في المتجر. مرجع: 6012.	2025-11-10 00:00:00	\N	ar
7824	ستنتهي صلاحية بطاقتك المنتهية بـ 7921 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7825	التحويل المجدول اكتمل بنجاح. مرجع: 8038.	2025-11-10 00:00:00	\N	ar
7827	رمز التحقق لعملية الدفع هو 673216. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7828	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7832	Your OTP for transaction is 696095. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7836	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7837	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7839	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7842	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7843	Your transaction of $8808.46 at STORE was successful. Ref: 2807.	2025-11-10 00:00:00	\N	en
7844	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7845	التحويل المجدول اكتمل بنجاح. مرجع: 4739.	2025-11-10 00:00:00	\N	ar
7847	رمز التحقق لعملية الدفع هو 614945. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7848	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7849	Your debit card ending 9594 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7852	Payment of $8050.40 received to your account ending with 7774. Thank you.	2025-11-10 00:00:00	\N	en
7853	Your debit card ending 8409 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7854	رمز التحقق لعملية الدفع هو 381444. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7855	Your transaction of $6378.36 at STORE was successful. Ref: 8588.	2025-11-10 00:00:00	\N	en
7857	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7859	التحويل المجدول اكتمل بنجاح. مرجع: 4100.	2025-11-10 00:00:00	\N	ar
7860	التحويل المجدول اكتمل بنجاح. مرجع: 6517.	2025-11-10 00:00:00	\N	ar
7861	Your online transfer of $4188.42 to account 9571 was successful.	2025-11-10 00:00:00	\N	en
7864	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7866	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7867	تمت عملية بقيمة 3870.60 في المتجر. مرجع: 5495.	2025-11-10 00:00:00	\N	ar
7868	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7870	Dear customer, your account balance is $5495.98. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7871	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7872	تمت عملية بقيمة 3412.93 في المتجر. مرجع: 9595.	2025-11-10 00:00:00	\N	ar
7874	عزيزي العميل، رصيد حسابك هو 6212.43. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7876	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7877	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7878	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7880	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
7882	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7883	Notification: Your card ending with 5660 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7886	رمز التحقق لعملية الدفع هو 522546. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7887	تنبيه: بطاقتك المنتهية بـ 6138 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7889	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7890	التحويل المجدول اكتمل بنجاح. مرجع: 2125.	2025-11-10 00:00:00	\N	ar
7894	Dear customer, your account balance is $218.72. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7896	عزيزي العميل، رصيد حسابك هو 8217.62. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7897	Reminder: Your loan payment of $8378.96 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7904	Notification: Your card ending with 8918 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7907	ستنتهي صلاحية بطاقتك المنتهية بـ 5226 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7911	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7912	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7914	ستنتهي صلاحية بطاقتك المنتهية بـ 3882 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
7917	التحويل المجدول اكتمل بنجاح. مرجع: 2645.	2025-11-10 00:00:00	\N	ar
7921	عزيزي العميل، رصيد حسابك هو 1733.49. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7922	تذكير: قسط القرض بقيمة 9665.39 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7924	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
7925	Payment of $4615.69 received to your account ending with 8750. Thank you.	2025-11-10 00:00:00	\N	en
7931	Your debit card ending 7329 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7932	Your OTP for transaction is 514112. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7935	Your OTP for transaction is 508219. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
7936	تذكير: قسط القرض بقيمة 2852.16 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7937	تمت عملية بقيمة 2370.08 في المتجر. مرجع: 2630.	2025-11-10 00:00:00	\N	ar
7938	تذكير: قسط القرض بقيمة 84.79 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7939	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7941	Dear customer, your account balance is $8983.59. Visit our branch for details.	2025-11-10 00:00:00	\N	en
7943	Your scheduled transfer completed successfully. Ref: 5528.	2025-11-10 00:00:00	\N	en
7945	Your debit card ending 9637 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7950	Your online transfer of $1856.03 to account 7060 was successful.	2025-11-10 00:00:00	\N	en
7951	Your scheduled transfer completed successfully. Ref: 5371.	2025-11-10 00:00:00	\N	en
7953	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7957	التحويل المجدول اكتمل بنجاح. مرجع: 3671.	2025-11-10 00:00:00	\N	ar
7959	رمز التحقق لعملية الدفع هو 522203. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
7961	Reminder: Your loan payment of $860.56 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7964	Notification: Your card ending with 4040 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7966	Reminder: Your loan payment of $3723.15 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7967	Your online transfer of $6346.41 to account 4616 was successful.	2025-11-10 00:00:00	\N	en
7968	عزيزي العميل، رصيد حسابك هو 1237.21. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
7969	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
7971	Your debit card ending 3301 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7973	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
7974	Reminder: Your loan payment of $4952.20 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7976	Reminder: Your loan payment of $3363.94 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
7977	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
7980	تنبيه: بطاقتك المنتهية بـ 4843 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
7981	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
7983	تذكير: قسط القرض بقيمة 3683.36 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7984	Your transaction of $2577.14 at STORE was successful. Ref: 8258.	2025-11-10 00:00:00	\N	en
7986	Your debit card ending 9458 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
7987	تمت عملية بقيمة 9491.81 في المتجر. مرجع: 2279.	2025-11-10 00:00:00	\N	ar
7988	Notification: Your card ending with 3727 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7990	Your transaction of $7254.25 at STORE was successful. Ref: 8927.	2025-11-10 00:00:00	\N	en
7991	Notification: Your card ending with 2548 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
7992	Your transaction of $856.61 at STORE was successful. Ref: 4828.	2025-11-10 00:00:00	\N	en
7993	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
7994	Your transaction of $8238.28 at STORE was successful. Ref: 3933.	2025-11-10 00:00:00	\N	en
7995	تذكير: قسط القرض بقيمة 5719.44 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
7996	Your debit card ending 7325 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8000	Your OTP for transaction is 564227. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8003	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8004	تذكير: قسط القرض بقيمة 1886.74 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8006	تمت عملية بقيمة 3589.58 في المتجر. مرجع: 1933.	2025-11-10 00:00:00	\N	ar
8007	التحويل المجدول اكتمل بنجاح. مرجع: 4301.	2025-11-10 00:00:00	\N	ar
8009	تذكير: قسط القرض بقيمة 1162.33 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8010	تمت عملية بقيمة 6474.31 في المتجر. مرجع: 8095.	2025-11-10 00:00:00	\N	ar
8012	Your transaction of $2213.57 at STORE was successful. Ref: 5096.	2025-11-10 00:00:00	\N	en
8013	Your OTP for transaction is 901194. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8017	تذكير: قسط القرض بقيمة 297.24 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8018	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8019	رمز التحقق لعملية الدفع هو 425032. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8022	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8026	التحويل المجدول اكتمل بنجاح. مرجع: 1160.	2025-11-10 00:00:00	\N	ar
8030	Your transaction of $1112.27 at STORE was successful. Ref: 4677.	2025-11-10 00:00:00	\N	en
8031	ستنتهي صلاحية بطاقتك المنتهية بـ 9018 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8032	عزيزي العميل، رصيد حسابك هو 6410.75. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8034	تمت عملية بقيمة 9874.35 في المتجر. مرجع: 2348.	2025-11-10 00:00:00	\N	ar
8036	ستنتهي صلاحية بطاقتك المنتهية بـ 9573 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8039	عزيزي العميل، رصيد حسابك هو 5469.25. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8043	Your debit card ending 7426 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8044	Your OTP for transaction is 530419. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8047	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8054	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8057	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8060	Your OTP for transaction is 377702. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8061	Your online transfer of $9715.19 to account 6968 was successful.	2025-11-10 00:00:00	\N	en
8063	Your debit card ending 4983 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8065	Payment of $2334.62 received to your account ending with 8610. Thank you.	2025-11-10 00:00:00	\N	en
8066	رمز التحقق لعملية الدفع هو 703962. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8070	تذكير: قسط القرض بقيمة 2036.84 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8072	Your debit card ending 6917 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8073	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8074	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8075	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8076	ستنتهي صلاحية بطاقتك المنتهية بـ 5236 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8077	Your transaction of $838.34 at STORE was successful. Ref: 5054.	2025-11-10 00:00:00	\N	en
8078	Your debit card ending 7380 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8085	Your transaction of $4666.46 at STORE was successful. Ref: 9273.	2025-11-10 00:00:00	\N	en
8086	Reminder: Your loan payment of $174.34 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8088	ستنتهي صلاحية بطاقتك المنتهية بـ 5853 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8091	Your transaction of $3043.91 at STORE was successful. Ref: 7280.	2025-11-10 00:00:00	\N	en
8095	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8096	Your debit card ending 3880 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8098	تم استلام دفعة بقيمة 8989.83 في حسابك المنتهي بـ 7846. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8099	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8100	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8103	تنبيه: بطاقتك المنتهية بـ 4398 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8104	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8109	Your online transfer of $9036.05 to account 2671 was successful.	2025-11-10 00:00:00	\N	en
8110	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8111	رمز التحقق لعملية الدفع هو 929804. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8113	Your debit card ending 9990 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8115	تمت عملية بقيمة 8372.99 في المتجر. مرجع: 8093.	2025-11-10 00:00:00	\N	ar
8119	تم استلام دفعة بقيمة 4903.73 في حسابك المنتهي بـ 4439. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8121	عزيزي العميل، رصيد حسابك هو 8280.39. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8124	تمت عملية بقيمة 796.43 في المتجر. مرجع: 1543.	2025-11-10 00:00:00	\N	ar
8125	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8126	Your transaction of $9605.94 at STORE was successful. Ref: 6135.	2025-11-10 00:00:00	\N	en
8127	تم استلام دفعة بقيمة 5521.06 في حسابك المنتهي بـ 2629. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8129	Reminder: Your loan payment of $8897.59 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8130	Your scheduled transfer completed successfully. Ref: 5825.	2025-11-10 00:00:00	\N	en
8131	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8132	تمت عملية بقيمة 2787.55 في المتجر. مرجع: 8524.	2025-11-10 00:00:00	\N	ar
8134	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8135	Reminder: Your loan payment of $6428.60 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8136	تذكير: قسط القرض بقيمة 5430.45 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8139	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8141	Your OTP for transaction is 304708. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8142	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8146	Reminder: Your loan payment of $648.74 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8155	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8156	Notification: Your card ending with 2178 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8157	Payment of $5172.93 received to your account ending with 2672. Thank you.	2025-11-10 00:00:00	\N	en
8160	عزيزي العميل، رصيد حسابك هو 8684.55. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8161	Dear customer, your account balance is $4484.89. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8163	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8164	Your scheduled transfer completed successfully. Ref: 4953.	2025-11-10 00:00:00	\N	en
8165	Payment of $3403.26 received to your account ending with 7480. Thank you.	2025-11-10 00:00:00	\N	en
8167	التحويل المجدول اكتمل بنجاح. مرجع: 4737.	2025-11-10 00:00:00	\N	ar
8169	Reminder: Your loan payment of $6897.56 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8171	Notification: Your card ending with 9893 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8174	تذكير: قسط القرض بقيمة 4808.19 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8178	التحويل المجدول اكتمل بنجاح. مرجع: 5227.	2025-11-10 00:00:00	\N	ar
8179	تنبيه: بطاقتك المنتهية بـ 9359 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8180	Notification: Your card ending with 3906 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8182	التحويل المجدول اكتمل بنجاح. مرجع: 6224.	2025-11-10 00:00:00	\N	ar
8185	تنبيه: بطاقتك المنتهية بـ 1724 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8186	Payment of $656.46 received to your account ending with 3822. Thank you.	2025-11-10 00:00:00	\N	en
8190	Dear customer, your account balance is $6311.95. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8199	Payment of $1801.99 received to your account ending with 7396. Thank you.	2025-11-10 00:00:00	\N	en
8201	Notification: Your card ending with 9546 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8202	Your scheduled transfer completed successfully. Ref: 2362.	2025-11-10 00:00:00	\N	en
8206	تم استلام دفعة بقيمة 6834.39 في حسابك المنتهي بـ 7646. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8208	رمز التحقق لعملية الدفع هو 588453. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8209	Reminder: Your loan payment of $7664.09 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8210	Your online transfer of $2036.16 to account 8959 was successful.	2025-11-10 00:00:00	\N	en
8211	Payment of $1039.62 received to your account ending with 1389. Thank you.	2025-11-10 00:00:00	\N	en
8212	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8213	Your scheduled transfer completed successfully. Ref: 6140.	2025-11-10 00:00:00	\N	en
8214	تمت عملية بقيمة 1950.79 في المتجر. مرجع: 2991.	2025-11-10 00:00:00	\N	ar
8215	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8217	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8218	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8221	عزيزي العميل، رصيد حسابك هو 5242.54. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8222	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8225	Your scheduled transfer completed successfully. Ref: 9682.	2025-11-10 00:00:00	\N	en
8226	Your transaction of $6091.55 at STORE was successful. Ref: 4102.	2025-11-10 00:00:00	\N	en
8228	Your transaction of $8086.00 at STORE was successful. Ref: 1191.	2025-11-10 00:00:00	\N	en
8230	تم استلام دفعة بقيمة 750.75 في حسابك المنتهي بـ 9782. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8233	التحويل المجدول اكتمل بنجاح. مرجع: 5617.	2025-11-10 00:00:00	\N	ar
8234	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8235	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8238	Dear customer, your account balance is $6315.03. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8239	ستنتهي صلاحية بطاقتك المنتهية بـ 6779 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8240	تم استلام دفعة بقيمة 9184.17 في حسابك المنتهي بـ 1292. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8614	Notification: Your card ending with 9184 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8241	ستنتهي صلاحية بطاقتك المنتهية بـ 6717 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8243	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8247	تمت عملية بقيمة 4429.63 في المتجر. مرجع: 3436.	2025-11-10 00:00:00	\N	ar
8248	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8249	Payment of $1170.79 received to your account ending with 6817. Thank you.	2025-11-10 00:00:00	\N	en
8252	التحويل المجدول اكتمل بنجاح. مرجع: 9886.	2025-11-10 00:00:00	\N	ar
8255	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8256	تم استلام دفعة بقيمة 6382.54 في حسابك المنتهي بـ 1801. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8258	تذكير: قسط القرض بقيمة 2689.83 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8262	Dear customer, your account balance is $1190.45. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8269	ستنتهي صلاحية بطاقتك المنتهية بـ 4701 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8270	ستنتهي صلاحية بطاقتك المنتهية بـ 8952 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8274	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8277	Your debit card ending 5501 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8278	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8279	Notification: Your card ending with 5980 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8281	Dear customer, your account balance is $3652.98. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8284	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8287	ستنتهي صلاحية بطاقتك المنتهية بـ 6728 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8289	Your online transfer of $5366.01 to account 5966 was successful.	2025-11-10 00:00:00	\N	en
8290	Payment of $5088.88 received to your account ending with 9970. Thank you.	2025-11-10 00:00:00	\N	en
8291	Payment of $669.18 received to your account ending with 2013. Thank you.	2025-11-10 00:00:00	\N	en
8292	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8295	Your OTP for transaction is 342034. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8298	Your online transfer of $8049.85 to account 5547 was successful.	2025-11-10 00:00:00	\N	en
8299	تذكير: قسط القرض بقيمة 6958.89 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8302	ستنتهي صلاحية بطاقتك المنتهية بـ 9867 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8303	التحويل المجدول اكتمل بنجاح. مرجع: 8866.	2025-11-10 00:00:00	\N	ar
8304	عزيزي العميل، رصيد حسابك هو 131.45. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8305	Your online transfer of $5954.43 to account 1068 was successful.	2025-11-10 00:00:00	\N	en
8306	تنبيه: بطاقتك المنتهية بـ 3795 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8309	رمز التحقق لعملية الدفع هو 174043. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8310	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8311	Your scheduled transfer completed successfully. Ref: 1777.	2025-11-10 00:00:00	\N	en
8312	Dear customer, your account balance is $2134.21. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8314	Your online transfer of $8375.89 to account 9352 was successful.	2025-11-10 00:00:00	\N	en
8315	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8316	Your transaction of $6286.63 at STORE was successful. Ref: 4772.	2025-11-10 00:00:00	\N	en
8317	Dear customer, your account balance is $1717.89. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8320	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8322	تنبيه: بطاقتك المنتهية بـ 2518 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8325	رمز التحقق لعملية الدفع هو 156114. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8326	تنبيه: بطاقتك المنتهية بـ 9838 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8329	تذكير: قسط القرض بقيمة 2453.59 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8330	تم استلام دفعة بقيمة 9579.43 في حسابك المنتهي بـ 3443. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8331	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8333	Payment of $5968.52 received to your account ending with 2634. Thank you.	2025-11-10 00:00:00	\N	en
8334	التحويل المجدول اكتمل بنجاح. مرجع: 8986.	2025-11-10 00:00:00	\N	ar
8335	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8337	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8338	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8339	تمت عملية بقيمة 6142.26 في المتجر. مرجع: 3722.	2025-11-10 00:00:00	\N	ar
8340	ستنتهي صلاحية بطاقتك المنتهية بـ 4759 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8342	Your OTP for transaction is 925279. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8343	Notification: Your card ending with 1836 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8345	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8346	Your debit card ending 6779 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8350	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8351	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8354	Your scheduled transfer completed successfully. Ref: 1800.	2025-11-10 00:00:00	\N	en
8355	ستنتهي صلاحية بطاقتك المنتهية بـ 7805 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8357	Dear customer, your account balance is $6982.82. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8359	عزيزي العميل، رصيد حسابك هو 6599.54. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8360	Your scheduled transfer completed successfully. Ref: 2971.	2025-11-10 00:00:00	\N	en
8361	عزيزي العميل، رصيد حسابك هو 3079.20. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8364	Your debit card ending 9992 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8369	تمت عملية بقيمة 7458.26 في المتجر. مرجع: 1919.	2025-11-10 00:00:00	\N	ar
8370	Your online transfer of $8519.09 to account 7437 was successful.	2025-11-10 00:00:00	\N	en
8374	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8376	Your debit card ending 5603 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8377	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8382	Payment of $5075.04 received to your account ending with 3462. Thank you.	2025-11-10 00:00:00	\N	en
8384	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8387	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8388	Your transaction of $8983.58 at STORE was successful. Ref: 5637.	2025-11-10 00:00:00	\N	en
8392	تم استلام دفعة بقيمة 2224.81 في حسابك المنتهي بـ 3220. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8393	تمت عملية بقيمة 5691.23 في المتجر. مرجع: 7053.	2025-11-10 00:00:00	\N	ar
8394	عزيزي العميل، رصيد حسابك هو 2981.43. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8395	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8397	Your OTP for transaction is 425522. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8400	تم استلام دفعة بقيمة 2412.58 في حسابك المنتهي بـ 4475. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8401	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8402	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8404	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8406	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8407	Your OTP for transaction is 946589. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8409	Your scheduled transfer completed successfully. Ref: 5558.	2025-11-10 00:00:00	\N	en
8415	Payment of $3988.63 received to your account ending with 1183. Thank you.	2025-11-10 00:00:00	\N	en
8422	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8423	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8427	Your transaction of $7993.78 at STORE was successful. Ref: 7276.	2025-11-10 00:00:00	\N	en
8429	تم استلام دفعة بقيمة 1234.95 في حسابك المنتهي بـ 3852. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8430	Your transaction of $7406.32 at STORE was successful. Ref: 9515.	2025-11-10 00:00:00	\N	en
8432	التحويل المجدول اكتمل بنجاح. مرجع: 3609.	2025-11-10 00:00:00	\N	ar
8434	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8436	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8438	تمت عملية بقيمة 1442.26 في المتجر. مرجع: 9282.	2025-11-10 00:00:00	\N	ar
8439	تمت عملية بقيمة 7129.93 في المتجر. مرجع: 5277.	2025-11-10 00:00:00	\N	ar
8444	Your debit card ending 9249 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8445	تذكير: قسط القرض بقيمة 3966.23 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8446	Reminder: Your loan payment of $7063.64 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8448	Reminder: Your loan payment of $9401.61 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8452	Your transaction of $70.53 at STORE was successful. Ref: 4422.	2025-11-10 00:00:00	\N	en
8458	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8459	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8464	Your transaction of $6605.91 at STORE was successful. Ref: 4890.	2025-11-10 00:00:00	\N	en
8466	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8468	رمز التحقق لعملية الدفع هو 171081. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8469	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8472	Payment of $6691.91 received to your account ending with 1644. Thank you.	2025-11-10 00:00:00	\N	en
8475	تمت عملية بقيمة 6088.03 في المتجر. مرجع: 4411.	2025-11-10 00:00:00	\N	ar
8481	التحويل المجدول اكتمل بنجاح. مرجع: 4865.	2025-11-10 00:00:00	\N	ar
8486	تنبيه: بطاقتك المنتهية بـ 8516 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8490	Your debit card ending 5573 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8491	Your OTP for transaction is 604908. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8493	ستنتهي صلاحية بطاقتك المنتهية بـ 2340 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8494	تم استلام دفعة بقيمة 5034.28 في حسابك المنتهي بـ 5289. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8496	تنبيه: بطاقتك المنتهية بـ 3253 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8497	رمز التحقق لعملية الدفع هو 677988. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8499	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8500	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8501	Your online transfer of $5737.22 to account 6685 was successful.	2025-11-10 00:00:00	\N	en
8504	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8505	التحويل المجدول اكتمل بنجاح. مرجع: 9391.	2025-11-10 00:00:00	\N	ar
8507	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8508	تم استلام دفعة بقيمة 2095.27 في حسابك المنتهي بـ 7782. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8513	ستنتهي صلاحية بطاقتك المنتهية بـ 3880 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8516	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8517	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8519	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8521	Your OTP for transaction is 657943. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8522	Notification: Your card ending with 8462 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8523	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8524	تمت عملية بقيمة 5226.16 في المتجر. مرجع: 7541.	2025-11-10 00:00:00	\N	ar
8526	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8528	Reminder: Your loan payment of $8182.74 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8529	Payment of $9809.43 received to your account ending with 6364. Thank you.	2025-11-10 00:00:00	\N	en
8530	ستنتهي صلاحية بطاقتك المنتهية بـ 5298 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8532	التحويل المجدول اكتمل بنجاح. مرجع: 2046.	2025-11-10 00:00:00	\N	ar
8534	تم استلام دفعة بقيمة 8312.98 في حسابك المنتهي بـ 6075. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8536	رمز التحقق لعملية الدفع هو 458749. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8539	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8543	تنبيه: بطاقتك المنتهية بـ 9050 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8545	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8547	Your online transfer of $8183.97 to account 1802 was successful.	2025-11-10 00:00:00	\N	en
8549	Your scheduled transfer completed successfully. Ref: 3810.	2025-11-10 00:00:00	\N	en
8550	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8552	عزيزي العميل، رصيد حسابك هو 1113.56. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8555	رمز التحقق لعملية الدفع هو 915489. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8556	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8561	تمت عملية بقيمة 52.63 في المتجر. مرجع: 3257.	2025-11-10 00:00:00	\N	ar
8563	رمز التحقق لعملية الدفع هو 127753. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8567	ستنتهي صلاحية بطاقتك المنتهية بـ 9252 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8568	Your online transfer of $9446.96 to account 8290 was successful.	2025-11-10 00:00:00	\N	en
8569	تمت عملية بقيمة 3338.44 في المتجر. مرجع: 6873.	2025-11-10 00:00:00	\N	ar
8571	التحويل المجدول اكتمل بنجاح. مرجع: 3429.	2025-11-10 00:00:00	\N	ar
8572	Reminder: Your loan payment of $2242.22 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8576	تذكير: قسط القرض بقيمة 4010.35 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8577	تذكير: قسط القرض بقيمة 3126.66 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8578	التحويل المجدول اكتمل بنجاح. مرجع: 5558.	2025-11-10 00:00:00	\N	ar
8579	ستنتهي صلاحية بطاقتك المنتهية بـ 2092 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8581	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8584	رمز التحقق لعملية الدفع هو 561064. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8585	Your online transfer of $5384.17 to account 5343 was successful.	2025-11-10 00:00:00	\N	en
8587	Your transaction of $9680.91 at STORE was successful. Ref: 6136.	2025-11-10 00:00:00	\N	en
8588	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8589	Your debit card ending 2095 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8590	Notification: Your card ending with 6053 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8593	تم استلام دفعة بقيمة 9427.35 في حسابك المنتهي بـ 6838. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8594	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8596	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8601	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8604	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8613	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8615	عزيزي العميل، رصيد حسابك هو 9629.70. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8617	Notification: Your card ending with 7077 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8625	Your OTP for transaction is 427127. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8626	Your scheduled transfer completed successfully. Ref: 3622.	2025-11-10 00:00:00	\N	en
8629	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8630	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8631	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8632	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8634	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8635	Your scheduled transfer completed successfully. Ref: 9572.	2025-11-10 00:00:00	\N	en
8636	التحويل المجدول اكتمل بنجاح. مرجع: 2498.	2025-11-10 00:00:00	\N	ar
8638	تم استلام دفعة بقيمة 5539.31 في حسابك المنتهي بـ 9545. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8644	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8646	تمت عملية بقيمة 253.17 في المتجر. مرجع: 7763.	2025-11-10 00:00:00	\N	ar
8652	Payment of $9158.05 received to your account ending with 8533. Thank you.	2025-11-10 00:00:00	\N	en
8653	تنبيه: بطاقتك المنتهية بـ 1099 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8654	Your debit card ending 4350 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8655	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8657	Payment of $3699.78 received to your account ending with 7330. Thank you.	2025-11-10 00:00:00	\N	en
8661	Your scheduled transfer completed successfully. Ref: 8853.	2025-11-10 00:00:00	\N	en
8662	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8669	Payment of $7960.96 received to your account ending with 1587. Thank you.	2025-11-10 00:00:00	\N	en
8671	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8672	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8674	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8675	عزيزي العميل، رصيد حسابك هو 6189.63. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8677	رمز التحقق لعملية الدفع هو 274103. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8678	Notification: Your card ending with 4767 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8679	Reminder: Your loan payment of $7043.63 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8681	رمز التحقق لعملية الدفع هو 332066. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8682	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8684	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8685	تم استلام دفعة بقيمة 9364.83 في حسابك المنتهي بـ 8949. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8686	Your OTP for transaction is 773669. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8687	Your scheduled transfer completed successfully. Ref: 7242.	2025-11-10 00:00:00	\N	en
8688	تنبيه: بطاقتك المنتهية بـ 7783 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8690	Dear customer, your account balance is $6334.69. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8691	Dear customer, your account balance is $832.07. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8694	Reminder: Your loan payment of $3418.09 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8695	Dear customer, your account balance is $7371.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8696	Your debit card ending 2252 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8698	Dear customer, your account balance is $5029.90. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8699	Your online transfer of $3155.68 to account 8345 was successful.	2025-11-10 00:00:00	\N	en
8700	Your OTP for transaction is 416916. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8704	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8705	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8708	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8709	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8710	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8716	Your scheduled transfer completed successfully. Ref: 5391.	2025-11-10 00:00:00	\N	en
8719	رمز التحقق لعملية الدفع هو 195584. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8720	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8722	تذكير: قسط القرض بقيمة 5667.73 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8724	Notification: Your card ending with 6887 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8729	تنبيه: بطاقتك المنتهية بـ 9781 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8735	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8737	التحويل المجدول اكتمل بنجاح. مرجع: 4295.	2025-11-10 00:00:00	\N	ar
8738	Dear customer, your account balance is $9527.50. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8739	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8741	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8742	Your scheduled transfer completed successfully. Ref: 2089.	2025-11-10 00:00:00	\N	en
8746	Your scheduled transfer completed successfully. Ref: 9611.	2025-11-10 00:00:00	\N	en
8747	ستنتهي صلاحية بطاقتك المنتهية بـ 3886 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8750	Your online transfer of $6210.15 to account 8981 was successful.	2025-11-10 00:00:00	\N	en
8752	رمز التحقق لعملية الدفع هو 592784. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8753	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8754	Your transaction of $9428.89 at STORE was successful. Ref: 9736.	2025-11-10 00:00:00	\N	en
8756	ستنتهي صلاحية بطاقتك المنتهية بـ 5058 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8759	Your online transfer of $3745.68 to account 2725 was successful.	2025-11-10 00:00:00	\N	en
8760	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8764	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8765	التحويل المجدول اكتمل بنجاح. مرجع: 6082.	2025-11-10 00:00:00	\N	ar
8772	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8773	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8774	Your online transfer of $8729.09 to account 9279 was successful.	2025-11-10 00:00:00	\N	en
8778	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8779	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8781	Your transaction of $7668.10 at STORE was successful. Ref: 9645.	2025-11-10 00:00:00	\N	en
8783	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8785	ستنتهي صلاحية بطاقتك المنتهية بـ 4139 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8786	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8789	Your scheduled transfer completed successfully. Ref: 5755.	2025-11-10 00:00:00	\N	en
8794	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8795	تمت عملية بقيمة 9212.11 في المتجر. مرجع: 3611.	2025-11-10 00:00:00	\N	ar
8800	التحويل المجدول اكتمل بنجاح. مرجع: 8368.	2025-11-10 00:00:00	\N	ar
8801	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8802	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8803	Your debit card ending 5106 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8805	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8806	Your transaction of $3586.47 at STORE was successful. Ref: 6088.	2025-11-10 00:00:00	\N	en
8807	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8808	Your OTP for transaction is 341003. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8810	Your transaction of $9461.14 at STORE was successful. Ref: 5953.	2025-11-10 00:00:00	\N	en
8816	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8817	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8818	Your transaction of $3623.24 at STORE was successful. Ref: 6361.	2025-11-10 00:00:00	\N	en
8819	Payment of $8759.51 received to your account ending with 5880. Thank you.	2025-11-10 00:00:00	\N	en
8820	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
8821	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8824	Your OTP for transaction is 527110. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8826	Your transaction of $8922.90 at STORE was successful. Ref: 8341.	2025-11-10 00:00:00	\N	en
8828	Your debit card ending 4626 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8830	تمت عملية بقيمة 4401.15 في المتجر. مرجع: 7515.	2025-11-10 00:00:00	\N	ar
8833	Payment of $1987.63 received to your account ending with 5676. Thank you.	2025-11-10 00:00:00	\N	en
8835	تمت عملية بقيمة 7719.09 في المتجر. مرجع: 7775.	2025-11-10 00:00:00	\N	ar
8836	رمز التحقق لعملية الدفع هو 648421. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8840	ستنتهي صلاحية بطاقتك المنتهية بـ 2799 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8841	Dear customer, your account balance is $9440.14. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8843	Dear customer, your account balance is $9844.98. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8844	التحويل المجدول اكتمل بنجاح. مرجع: 1693.	2025-11-10 00:00:00	\N	ar
8845	تذكير: قسط القرض بقيمة 1004.30 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8848	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
8849	Your debit card ending 1855 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8850	رمز التحقق لعملية الدفع هو 429365. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8851	Dear customer, your account balance is $955.39. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8854	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8857	رمز التحقق لعملية الدفع هو 701397. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8863	رمز التحقق لعملية الدفع هو 617907. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8864	ستنتهي صلاحية بطاقتك المنتهية بـ 6008 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8865	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8866	ستنتهي صلاحية بطاقتك المنتهية بـ 9152 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8867	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8869	تمت عملية بقيمة 8689.09 في المتجر. مرجع: 4000.	2025-11-10 00:00:00	\N	ar
8877	ستنتهي صلاحية بطاقتك المنتهية بـ 5790 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8878	تمت عملية بقيمة 6055.23 في المتجر. مرجع: 7859.	2025-11-10 00:00:00	\N	ar
8879	Notification: Your card ending with 8558 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8881	Your OTP for transaction is 367549. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8882	عزيزي العميل، رصيد حسابك هو 9362.84. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8883	Payment of $9716.51 received to your account ending with 4357. Thank you.	2025-11-10 00:00:00	\N	en
8884	Payment of $2619.59 received to your account ending with 4164. Thank you.	2025-11-10 00:00:00	\N	en
8886	Your transaction of $9034.30 at STORE was successful. Ref: 8587.	2025-11-10 00:00:00	\N	en
8890	Dear customer, your account balance is $2049.03. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8893	رمز التحقق لعملية الدفع هو 759348. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8894	Notification: Your card ending with 9116 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8895	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8896	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8897	Dear customer, your account balance is $5133.38. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8899	Payment of $7912.26 received to your account ending with 8523. Thank you.	2025-11-10 00:00:00	\N	en
8900	Your transaction of $4518.51 at STORE was successful. Ref: 8276.	2025-11-10 00:00:00	\N	en
8901	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
8902	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8903	تم استلام دفعة بقيمة 230.25 في حسابك المنتهي بـ 8171. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8907	تمت عملية بقيمة 9135.03 في المتجر. مرجع: 8967.	2025-11-10 00:00:00	\N	ar
8915	Notification: Your card ending with 1261 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8916	رمز التحقق لعملية الدفع هو 174286. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
8920	تمت عملية بقيمة 4536.59 في المتجر. مرجع: 2485.	2025-11-10 00:00:00	\N	ar
8922	Your scheduled transfer completed successfully. Ref: 8733.	2025-11-10 00:00:00	\N	en
8923	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8925	التحويل المجدول اكتمل بنجاح. مرجع: 6703.	2025-11-10 00:00:00	\N	ar
8926	Notification: Your card ending with 6195 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
8931	Your online transfer of $3759.15 to account 6286 was successful.	2025-11-10 00:00:00	\N	en
8936	Your debit card ending 8882 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8937	Dear customer, your account balance is $1643.71. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8938	التحويل المجدول اكتمل بنجاح. مرجع: 2564.	2025-11-10 00:00:00	\N	ar
8939	تذكير: قسط القرض بقيمة 268.63 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8940	Your transaction of $387.34 at STORE was successful. Ref: 8358.	2025-11-10 00:00:00	\N	en
8941	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8943	Payment of $4752.78 received to your account ending with 5836. Thank you.	2025-11-10 00:00:00	\N	en
8945	Your OTP for transaction is 742277. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8946	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
8947	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
8948	Your transaction of $7970.60 at STORE was successful. Ref: 2891.	2025-11-10 00:00:00	\N	en
8950	تذكير: قسط القرض بقيمة 3863.11 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
8957	تنبيه: بطاقتك المنتهية بـ 3217 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
8958	التحويل المجدول اكتمل بنجاح. مرجع: 3793.	2025-11-10 00:00:00	\N	ar
8959	التحويل المجدول اكتمل بنجاح. مرجع: 6635.	2025-11-10 00:00:00	\N	ar
8963	تم استلام دفعة بقيمة 2543.79 في حسابك المنتهي بـ 9333. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8967	Your debit card ending 7342 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
8968	Your online transfer of $5812.64 to account 6273 was successful.	2025-11-10 00:00:00	\N	en
8971	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
8972	Your scheduled transfer completed successfully. Ref: 6906.	2025-11-10 00:00:00	\N	en
8974	Reminder: Your loan payment of $4377.35 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8975	Dear customer, your account balance is $1359.94. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8976	تم استلام دفعة بقيمة 4856.30 في حسابك المنتهي بـ 6960. شكرًا لك.	2025-11-10 00:00:00	\N	ar
8978	Your OTP for transaction is 504203. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
8985	Dear customer, your account balance is $7337.66. Visit our branch for details.	2025-11-10 00:00:00	\N	en
8988	عزيزي العميل، رصيد حسابك هو 9289.93. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
8990	التحويل المجدول اكتمل بنجاح. مرجع: 5416.	2025-11-10 00:00:00	\N	ar
8993	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
8994	Reminder: Your loan payment of $5414.28 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
8995	ستنتهي صلاحية بطاقتك المنتهية بـ 5553 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
8997	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9000	تم استلام دفعة بقيمة 2412.96 في حسابك المنتهي بـ 8376. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9001	عزيزي العميل، رصيد حسابك هو 3319.98. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9005	رمز التحقق لعملية الدفع هو 508025. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9006	Your transaction of $5246.01 at STORE was successful. Ref: 8969.	2025-11-10 00:00:00	\N	en
9007	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9008	التحويل المجدول اكتمل بنجاح. مرجع: 1079.	2025-11-10 00:00:00	\N	ar
9014	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9017	التحويل المجدول اكتمل بنجاح. مرجع: 2767.	2025-11-10 00:00:00	\N	ar
9019	Reminder: Your loan payment of $5963.96 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9022	ستنتهي صلاحية بطاقتك المنتهية بـ 4615 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9027	ستنتهي صلاحية بطاقتك المنتهية بـ 2459 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9028	Dear customer, your account balance is $7801.94. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9029	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9030	Notification: Your card ending with 3682 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9033	Reminder: Your loan payment of $2451.64 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9035	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9036	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9037	تمت عملية بقيمة 4287.22 في المتجر. مرجع: 5227.	2025-11-10 00:00:00	\N	ar
9041	Reminder: Your loan payment of $1.37 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9042	Reminder: Your loan payment of $6330.26 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9043	Your OTP for transaction is 348838. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9044	Your OTP for transaction is 453507. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9045	Your scheduled transfer completed successfully. Ref: 2028.	2025-11-10 00:00:00	\N	en
9046	تم استلام دفعة بقيمة 3346.88 في حسابك المنتهي بـ 4409. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9048	تمت عملية بقيمة 3119.54 في المتجر. مرجع: 2155.	2025-11-10 00:00:00	\N	ar
9049	Dear customer, your account balance is $8721.43. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9051	Dear customer, your account balance is $3226.66. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9053	Your OTP for transaction is 363660. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9055	رمز التحقق لعملية الدفع هو 746056. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9058	التحويل المجدول اكتمل بنجاح. مرجع: 5271.	2025-11-10 00:00:00	\N	ar
9059	عزيزي العميل، رصيد حسابك هو 2791.69. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9062	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9063	Your transaction of $7495.91 at STORE was successful. Ref: 4852.	2025-11-10 00:00:00	\N	en
9064	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9066	Your debit card ending 4430 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9067	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9071	Notification: Your card ending with 1139 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9076	تنبيه: بطاقتك المنتهية بـ 6425 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9077	Your OTP for transaction is 642270. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9078	Your OTP for transaction is 580308. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9079	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9080	Dear customer, your account balance is $1236.09. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9084	Dear customer, your account balance is $7434.64. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9088	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9091	Your scheduled transfer completed successfully. Ref: 2928.	2025-11-10 00:00:00	\N	en
9093	Reminder: Your loan payment of $191.56 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9094	Your online transfer of $4189.56 to account 3323 was successful.	2025-11-10 00:00:00	\N	en
9095	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9098	Your transaction of $3684.88 at STORE was successful. Ref: 5235.	2025-11-10 00:00:00	\N	en
9099	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9100	التحويل المجدول اكتمل بنجاح. مرجع: 6291.	2025-11-10 00:00:00	\N	ar
9101	تم استلام دفعة بقيمة 4615.56 في حسابك المنتهي بـ 9020. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9103	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9104	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9107	Your debit card ending 6929 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9108	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9113	ستنتهي صلاحية بطاقتك المنتهية بـ 4085 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9114	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9116	Your OTP for transaction is 745824. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9117	Dear customer, your account balance is $2246.32. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9120	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9121	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9122	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9123	Your OTP for transaction is 592498. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9125	عزيزي العميل، رصيد حسابك هو 9873.00. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9127	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9128	التحويل المجدول اكتمل بنجاح. مرجع: 1222.	2025-11-10 00:00:00	\N	ar
9129	ستنتهي صلاحية بطاقتك المنتهية بـ 3563 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9131	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9133	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9137	Payment of $2200.01 received to your account ending with 7550. Thank you.	2025-11-10 00:00:00	\N	en
9140	Dear customer, your account balance is $7696.72. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9141	تم استلام دفعة بقيمة 1089.01 في حسابك المنتهي بـ 5574. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9142	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9143	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9144	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9145	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9147	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9149	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9150	Your online transfer of $2186.45 to account 8440 was successful.	2025-11-10 00:00:00	\N	en
9151	ستنتهي صلاحية بطاقتك المنتهية بـ 2934 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9155	Dear customer, your account balance is $9670.22. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9157	Payment of $5044.97 received to your account ending with 2982. Thank you.	2025-11-10 00:00:00	\N	en
9160	رمز التحقق لعملية الدفع هو 569978. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9162	Reminder: Your loan payment of $444.44 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9163	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9164	Dear customer, your account balance is $2560.05. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9168	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9170	Notification: Your card ending with 7024 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9171	Notification: Your card ending with 7271 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9172	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9173	رمز التحقق لعملية الدفع هو 701353. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9174	Your transaction of $900.67 at STORE was successful. Ref: 4949.	2025-11-10 00:00:00	\N	en
9175	Your scheduled transfer completed successfully. Ref: 5312.	2025-11-10 00:00:00	\N	en
9176	Your transaction of $7013.07 at STORE was successful. Ref: 8995.	2025-11-10 00:00:00	\N	en
9177	عزيزي العميل، رصيد حسابك هو 5938.83. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9179	رمز التحقق لعملية الدفع هو 756259. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9184	التحويل المجدول اكتمل بنجاح. مرجع: 5749.	2025-11-10 00:00:00	\N	ar
9185	ستنتهي صلاحية بطاقتك المنتهية بـ 4222 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9186	التحويل المجدول اكتمل بنجاح. مرجع: 3552.	2025-11-10 00:00:00	\N	ar
9187	رمز التحقق لعملية الدفع هو 303917. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9188	Your transaction of $3044.60 at STORE was successful. Ref: 5816.	2025-11-10 00:00:00	\N	en
9189	تنبيه: بطاقتك المنتهية بـ 2867 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9195	تمت عملية بقيمة 8472.93 في المتجر. مرجع: 6476.	2025-11-10 00:00:00	\N	ar
9196	تنبيه: بطاقتك المنتهية بـ 1178 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9197	Your scheduled transfer completed successfully. Ref: 5020.	2025-11-10 00:00:00	\N	en
9198	Dear customer, your account balance is $20.63. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9199	تمت عملية بقيمة 7949.91 في المتجر. مرجع: 6026.	2025-11-10 00:00:00	\N	ar
9205	عزيزي العميل، رصيد حسابك هو 6649.08. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9212	عزيزي العميل، رصيد حسابك هو 2733.70. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9213	ستنتهي صلاحية بطاقتك المنتهية بـ 6345 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9214	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9215	Dear customer, your account balance is $8719.60. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9217	تمت عملية بقيمة 9538.69 في المتجر. مرجع: 7168.	2025-11-10 00:00:00	\N	ar
9218	Dear customer, your account balance is $3950.91. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9219	Your online transfer of $9094.68 to account 1009 was successful.	2025-11-10 00:00:00	\N	en
9227	ستنتهي صلاحية بطاقتك المنتهية بـ 9312 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9228	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9229	Dear customer, your account balance is $2888.09. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9230	عزيزي العميل، رصيد حسابك هو 9970.86. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9231	Your transaction of $7996.62 at STORE was successful. Ref: 9599.	2025-11-10 00:00:00	\N	en
9234	Your scheduled transfer completed successfully. Ref: 3076.	2025-11-10 00:00:00	\N	en
9239	رمز التحقق لعملية الدفع هو 889166. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9241	تمت عملية بقيمة 6196.39 في المتجر. مرجع: 8787.	2025-11-10 00:00:00	\N	ar
9242	ستنتهي صلاحية بطاقتك المنتهية بـ 6397 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9243	Dear customer, your account balance is $6373.44. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9245	التحويل المجدول اكتمل بنجاح. مرجع: 3856.	2025-11-10 00:00:00	\N	ar
9249	تمت عملية بقيمة 1929.60 في المتجر. مرجع: 7293.	2025-11-10 00:00:00	\N	ar
9250	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9252	Your online transfer of $7416.92 to account 4092 was successful.	2025-11-10 00:00:00	\N	en
9253	Dear customer, your account balance is $6489.08. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9254	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9255	تمت عملية بقيمة 6586.67 في المتجر. مرجع: 9566.	2025-11-10 00:00:00	\N	ar
9257	تم استلام دفعة بقيمة 4912.33 في حسابك المنتهي بـ 9250. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9258	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9260	Your OTP for transaction is 361936. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9261	تمت عملية بقيمة 7734.05 في المتجر. مرجع: 5479.	2025-11-10 00:00:00	\N	ar
9262	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9263	Your debit card ending 9130 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9267	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9269	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9271	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9272	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9275	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9276	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9278	تم استلام دفعة بقيمة 5774.31 في حسابك المنتهي بـ 3775. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9281	تم استلام دفعة بقيمة 5459.19 في حسابك المنتهي بـ 7647. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9282	Your debit card ending 3114 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9287	ستنتهي صلاحية بطاقتك المنتهية بـ 4792 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9289	Reminder: Your loan payment of $9030.02 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9290	ستنتهي صلاحية بطاقتك المنتهية بـ 4126 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9291	التحويل المجدول اكتمل بنجاح. مرجع: 3421.	2025-11-10 00:00:00	\N	ar
9292	تمت عملية بقيمة 9174.53 في المتجر. مرجع: 9738.	2025-11-10 00:00:00	\N	ar
9293	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9295	التحويل المجدول اكتمل بنجاح. مرجع: 8555.	2025-11-10 00:00:00	\N	ar
9296	تذكير: قسط القرض بقيمة 3743.18 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9299	التحويل المجدول اكتمل بنجاح. مرجع: 2420.	2025-11-10 00:00:00	\N	ar
9306	Your transaction of $3193.57 at STORE was successful. Ref: 6761.	2025-11-10 00:00:00	\N	en
9312	التحويل المجدول اكتمل بنجاح. مرجع: 1305.	2025-11-10 00:00:00	\N	ar
9313	تم استلام دفعة بقيمة 7356.07 في حسابك المنتهي بـ 2215. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9317	Your OTP for transaction is 951013. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9318	Dear customer, your account balance is $8336.43. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9327	Payment of $785.72 received to your account ending with 7097. Thank you.	2025-11-10 00:00:00	\N	en
9329	Your transaction of $9998.16 at STORE was successful. Ref: 6281.	2025-11-10 00:00:00	\N	en
9331	رمز التحقق لعملية الدفع هو 303042. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9333	تم استلام دفعة بقيمة 5653.67 في حسابك المنتهي بـ 8948. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9334	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9335	عزيزي العميل، رصيد حسابك هو 3915.44. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9339	Reminder: Your loan payment of $9494.45 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9341	Payment of $9464.96 received to your account ending with 3508. Thank you.	2025-11-10 00:00:00	\N	en
9342	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9343	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9346	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9347	عزيزي العميل، رصيد حسابك هو 2628.45. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9348	تنبيه: بطاقتك المنتهية بـ 8938 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9349	تم استلام دفعة بقيمة 2910.22 في حسابك المنتهي بـ 6613. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9350	Your OTP for transaction is 215090. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9352	عزيزي العميل، رصيد حسابك هو 4456.49. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9353	ستنتهي صلاحية بطاقتك المنتهية بـ 7943 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9354	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9355	Notification: Your card ending with 8601 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9356	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9357	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9360	عزيزي العميل، رصيد حسابك هو 4043.28. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9366	Your scheduled transfer completed successfully. Ref: 8960.	2025-11-10 00:00:00	\N	en
9369	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9370	Your transaction of $6832.48 at STORE was successful. Ref: 7367.	2025-11-10 00:00:00	\N	en
9371	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9374	التحويل المجدول اكتمل بنجاح. مرجع: 5248.	2025-11-10 00:00:00	\N	ar
9375	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9378	تم استلام دفعة بقيمة 2346.42 في حسابك المنتهي بـ 1533. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9379	Your OTP for transaction is 777315. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9381	ستنتهي صلاحية بطاقتك المنتهية بـ 9979 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9382	Reminder: Your loan payment of $5149.00 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9385	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9386	Your online transfer of $5808.20 to account 2877 was successful.	2025-11-10 00:00:00	\N	en
9387	Your online transfer of $9426.38 to account 2796 was successful.	2025-11-10 00:00:00	\N	en
9388	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9391	Your debit card ending 3143 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9393	ستنتهي صلاحية بطاقتك المنتهية بـ 2772 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9398	رمز التحقق لعملية الدفع هو 831091. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9399	التحويل المجدول اكتمل بنجاح. مرجع: 4776.	2025-11-10 00:00:00	\N	ar
9400	تم استلام دفعة بقيمة 5854.53 في حسابك المنتهي بـ 9936. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9401	رمز التحقق لعملية الدفع هو 180842. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9402	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9404	تم استلام دفعة بقيمة 879.35 في حسابك المنتهي بـ 3938. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9405	Notification: Your card ending with 1757 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9407	Your transaction of $901.21 at STORE was successful. Ref: 9164.	2025-11-10 00:00:00	\N	en
9408	تم استلام دفعة بقيمة 5297.27 في حسابك المنتهي بـ 2368. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9409	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9410	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9411	Reminder: Your loan payment of $4020.17 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9414	التحويل المجدول اكتمل بنجاح. مرجع: 4894.	2025-11-10 00:00:00	\N	ar
9416	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9418	Your OTP for transaction is 919700. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9419	عزيزي العميل، رصيد حسابك هو 1206.23. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9421	Your OTP for transaction is 804219. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9423	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9425	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9427	Notification: Your card ending with 9268 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9429	Payment of $2120.80 received to your account ending with 1160. Thank you.	2025-11-10 00:00:00	\N	en
9433	تمت عملية بقيمة 2001.54 في المتجر. مرجع: 1985.	2025-11-10 00:00:00	\N	ar
9434	ستنتهي صلاحية بطاقتك المنتهية بـ 6021 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9435	Your online transfer of $9221.84 to account 9635 was successful.	2025-11-10 00:00:00	\N	en
9436	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9437	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9442	Dear customer, your account balance is $6006.57. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9443	Your debit card ending 4972 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9444	Your scheduled transfer completed successfully. Ref: 5788.	2025-11-10 00:00:00	\N	en
9447	رمز التحقق لعملية الدفع هو 951491. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9449	عزيزي العميل، رصيد حسابك هو 2704.90. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9451	تذكير: قسط القرض بقيمة 6447.36 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9452	Reminder: Your loan payment of $5602.58 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9453	Your OTP for transaction is 179328. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9456	Your scheduled transfer completed successfully. Ref: 8518.	2025-11-10 00:00:00	\N	en
9459	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9464	تم استلام دفعة بقيمة 4485.73 في حسابك المنتهي بـ 6748. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9465	تم استلام دفعة بقيمة 2417.49 في حسابك المنتهي بـ 1274. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9474	Your debit card ending 7745 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9475	Reminder: Your loan payment of $7395.52 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9476	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9478	Your OTP for transaction is 409323. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9479	Your debit card ending 4568 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9480	Reminder: Your loan payment of $4604.37 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9481	Your OTP for transaction is 374766. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9482	تمت عملية بقيمة 1794.77 في المتجر. مرجع: 5488.	2025-11-10 00:00:00	\N	ar
9484	Your scheduled transfer completed successfully. Ref: 7914.	2025-11-10 00:00:00	\N	en
9485	ستنتهي صلاحية بطاقتك المنتهية بـ 4333 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9487	التحويل المجدول اكتمل بنجاح. مرجع: 8892.	2025-11-10 00:00:00	\N	ar
9490	Your scheduled transfer completed successfully. Ref: 7707.	2025-11-10 00:00:00	\N	en
9491	تذكير: قسط القرض بقيمة 6117.79 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9493	Dear customer, your account balance is $4463.23. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9494	Your transaction of $9516.63 at STORE was successful. Ref: 5683.	2025-11-10 00:00:00	\N	en
9497	التحويل المجدول اكتمل بنجاح. مرجع: 9472.	2025-11-10 00:00:00	\N	ar
9499	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9501	تنبيه: بطاقتك المنتهية بـ 3077 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9502	تذكير: قسط القرض بقيمة 9471.14 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9505	رمز التحقق لعملية الدفع هو 495285. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9506	Your debit card ending 5671 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9507	Your transaction of $2501.50 at STORE was successful. Ref: 2843.	2025-11-10 00:00:00	\N	en
9508	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9512	Reminder: Your loan payment of $307.91 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9513	تم استلام دفعة بقيمة 6505.29 في حسابك المنتهي بـ 9938. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9518	Reminder: Your loan payment of $8980.13 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9523	Your scheduled transfer completed successfully. Ref: 2674.	2025-11-10 00:00:00	\N	en
9524	Your scheduled transfer completed successfully. Ref: 2710.	2025-11-10 00:00:00	\N	en
9525	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9529	ستنتهي صلاحية بطاقتك المنتهية بـ 5145 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9536	Notification: Your card ending with 8025 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9538	رمز التحقق لعملية الدفع هو 305882. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9543	Reminder: Your loan payment of $5979.42 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9544	تمت عملية بقيمة 3704.20 في المتجر. مرجع: 7826.	2025-11-10 00:00:00	\N	ar
9546	عزيزي العميل، رصيد حسابك هو 2260.12. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9548	Your debit card ending 5307 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9550	تمت عملية بقيمة 370.18 في المتجر. مرجع: 2674.	2025-11-10 00:00:00	\N	ar
9552	تنبيه: بطاقتك المنتهية بـ 1268 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9553	تمت عملية بقيمة 7137.31 في المتجر. مرجع: 1055.	2025-11-10 00:00:00	\N	ar
9555	Dear customer, your account balance is $9850.35. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9557	عزيزي العميل، رصيد حسابك هو 661.91. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9558	Your transaction of $1044.22 at STORE was successful. Ref: 9889.	2025-11-10 00:00:00	\N	en
9562	ستنتهي صلاحية بطاقتك المنتهية بـ 8871 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9565	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9566	عزيزي العميل، رصيد حسابك هو 1590.65. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9568	Your transaction of $2550.86 at STORE was successful. Ref: 5585.	2025-11-10 00:00:00	\N	en
9569	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9572	عزيزي العميل، رصيد حسابك هو 7259.94. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9573	Payment of $6198.00 received to your account ending with 4723. Thank you.	2025-11-10 00:00:00	\N	en
9574	Your online transfer of $4865.58 to account 4625 was successful.	2025-11-10 00:00:00	\N	en
9578	Reminder: Your loan payment of $8888.25 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9584	عزيزي العميل، رصيد حسابك هو 8691.63. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9586	Payment of $2345.08 received to your account ending with 6584. Thank you.	2025-11-10 00:00:00	\N	en
9588	Payment of $9483.40 received to your account ending with 8677. Thank you.	2025-11-10 00:00:00	\N	en
9589	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9590	تم استلام دفعة بقيمة 5283.72 في حسابك المنتهي بـ 7260. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9591	عزيزي العميل، رصيد حسابك هو 978.11. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9592	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9594	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9596	Your transaction of $8171.15 at STORE was successful. Ref: 8642.	2025-11-10 00:00:00	\N	en
9597	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9598	تم استلام دفعة بقيمة 331.29 في حسابك المنتهي بـ 9467. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9599	تم استلام دفعة بقيمة 5060.76 في حسابك المنتهي بـ 1613. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9600	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9602	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9603	Payment of $9663.15 received to your account ending with 2075. Thank you.	2025-11-10 00:00:00	\N	en
9606	Payment of $7287.61 received to your account ending with 2133. Thank you.	2025-11-10 00:00:00	\N	en
9610	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9611	تمت عملية بقيمة 8060.40 في المتجر. مرجع: 7870.	2025-11-10 00:00:00	\N	ar
9612	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9613	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9616	تمت عملية بقيمة 2074.45 في المتجر. مرجع: 8146.	2025-11-10 00:00:00	\N	ar
9617	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9621	Reminder: Your loan payment of $4649.07 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9622	Your OTP for transaction is 489718. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9623	Dear customer, your account balance is $2082.49. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9624	تم استلام دفعة بقيمة 3491.60 في حسابك المنتهي بـ 3974. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9625	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9627	تمت عملية بقيمة 1645.01 في المتجر. مرجع: 6602.	2025-11-10 00:00:00	\N	ar
9628	ستنتهي صلاحية بطاقتك المنتهية بـ 1316 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9629	تمت عملية بقيمة 7843.36 في المتجر. مرجع: 2462.	2025-11-10 00:00:00	\N	ar
9630	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9632	Your OTP for transaction is 316382. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9634	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9636	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9637	عزيزي العميل، رصيد حسابك هو 9520.15. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9638	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9639	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9641	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9642	Your scheduled transfer completed successfully. Ref: 3877.	2025-11-10 00:00:00	\N	en
9643	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9644	تم استلام دفعة بقيمة 9868.73 في حسابك المنتهي بـ 5362. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9650	ستنتهي صلاحية بطاقتك المنتهية بـ 5911 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9651	Payment of $3931.23 received to your account ending with 1653. Thank you.	2025-11-10 00:00:00	\N	en
9654	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9655	عزيزي العميل، رصيد حسابك هو 8480.58. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9656	عزيزي العميل، رصيد حسابك هو 2886.94. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9657	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9658	Your scheduled transfer completed successfully. Ref: 7260.	2025-11-10 00:00:00	\N	en
9661	تذكير: قسط القرض بقيمة 6811.34 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9662	ستنتهي صلاحية بطاقتك المنتهية بـ 6626 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9665	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9666	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9667	Your scheduled transfer completed successfully. Ref: 9877.	2025-11-10 00:00:00	\N	en
9669	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9671	تمت عملية بقيمة 5014.16 في المتجر. مرجع: 7907.	2025-11-10 00:00:00	\N	ar
9673	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9674	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9675	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9676	تنبيه: بطاقتك المنتهية بـ 3923 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9679	ستنتهي صلاحية بطاقتك المنتهية بـ 9987 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9681	تمت عملية بقيمة 6118.91 في المتجر. مرجع: 1912.	2025-11-10 00:00:00	\N	ar
9683	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9685	عزيزي العميل، رصيد حسابك هو 8901.64. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9686	Dear customer, your account balance is $1191.08. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9687	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9688	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9691	التحويل المجدول اكتمل بنجاح. مرجع: 5067.	2025-11-10 00:00:00	\N	ar
9694	Your transaction of $3910.02 at STORE was successful. Ref: 2532.	2025-11-10 00:00:00	\N	en
9699	Your debit card ending 5514 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9704	Your debit card ending 3011 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9711	Payment of $3199.66 received to your account ending with 9081. Thank you.	2025-11-10 00:00:00	\N	en
9712	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9714	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9716	تذكير: قسط القرض بقيمة 2969.40 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9719	Notification: Your card ending with 3516 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9721	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9723	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9724	التحويل المجدول اكتمل بنجاح. مرجع: 1467.	2025-11-10 00:00:00	\N	ar
9727	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9728	Your transaction of $2080.74 at STORE was successful. Ref: 1375.	2025-11-10 00:00:00	\N	en
9729	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9731	Payment of $8057.77 received to your account ending with 6582. Thank you.	2025-11-10 00:00:00	\N	en
9733	ستنتهي صلاحية بطاقتك المنتهية بـ 2539 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9736	Your online transfer of $2320.99 to account 9861 was successful.	2025-11-10 00:00:00	\N	en
9737	تنبيه: بطاقتك المنتهية بـ 6284 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9738	عزيزي العميل، رصيد حسابك هو 6674.61. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9740	Payment of $8650.72 received to your account ending with 3773. Thank you.	2025-11-10 00:00:00	\N	en
9742	Your online transfer of $7749.60 to account 6594 was successful.	2025-11-10 00:00:00	\N	en
9743	رمز التحقق لعملية الدفع هو 132240. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9746	ستنتهي صلاحية بطاقتك المنتهية بـ 9010 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9749	تذكير: قسط القرض بقيمة 2640.87 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9750	Dear customer, your account balance is $9411.10. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9753	Your scheduled transfer completed successfully. Ref: 8977.	2025-11-10 00:00:00	\N	en
9754	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9755	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9757	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9762	عزيزي العميل، رصيد حسابك هو 3084.38. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9763	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9764	التحويل المجدول اكتمل بنجاح. مرجع: 9124.	2025-11-10 00:00:00	\N	ar
9766	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9770	Reminder: Your loan payment of $748.28 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9771	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9772	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9775	تمت عملية بقيمة 5159.90 في المتجر. مرجع: 9743.	2025-11-10 00:00:00	\N	ar
9777	Your transaction of $8639.62 at STORE was successful. Ref: 4392.	2025-11-10 00:00:00	\N	en
9778	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9779	Your debit card ending 3739 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9782	Your scheduled transfer completed successfully. Ref: 5507.	2025-11-10 00:00:00	\N	en
9784	ستنتهي صلاحية بطاقتك المنتهية بـ 1763 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9785	ستنتهي صلاحية بطاقتك المنتهية بـ 5142 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9788	Your OTP for transaction is 783346. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9791	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9792	Your scheduled transfer completed successfully. Ref: 3970.	2025-11-10 00:00:00	\N	en
9795	ستنتهي صلاحية بطاقتك المنتهية بـ 5098 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9796	Your scheduled transfer completed successfully. Ref: 5475.	2025-11-10 00:00:00	\N	en
9798	التحويل المجدول اكتمل بنجاح. مرجع: 6475.	2025-11-10 00:00:00	\N	ar
9799	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9800	Your debit card ending 9850 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9801	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9805	Notification: Your card ending with 5668 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9808	ستنتهي صلاحية بطاقتك المنتهية بـ 2145 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9810	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9812	Your scheduled transfer completed successfully. Ref: 6626.	2025-11-10 00:00:00	\N	en
9818	تنبيه: بطاقتك المنتهية بـ 3616 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9821	عزيزي العميل، رصيد حسابك هو 5683.52. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9822	Your online transfer of $4479.27 to account 1911 was successful.	2025-11-10 00:00:00	\N	en
9824	Your debit card ending 2666 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9825	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9827	Reminder: Your loan payment of $9935.00 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9828	Your scheduled transfer completed successfully. Ref: 9240.	2025-11-10 00:00:00	\N	en
9829	رمز التحقق لعملية الدفع هو 281317. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9834	تنبيه: بطاقتك المنتهية بـ 3072 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9835	Payment of $1945.45 received to your account ending with 5841. Thank you.	2025-11-10 00:00:00	\N	en
9836	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9839	عزيزي العميل، رصيد حسابك هو 2130.00. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9843	Dear customer, your account balance is $7099.22. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9844	Payment of $5832.89 received to your account ending with 3831. Thank you.	2025-11-10 00:00:00	\N	en
9846	عزيزي العميل، رصيد حسابك هو 5120.31. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9850	تذكير: قسط القرض بقيمة 5344.77 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9853	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9858	Your scheduled transfer completed successfully. Ref: 1440.	2025-11-10 00:00:00	\N	en
9860	Reminder: Your loan payment of $4403.72 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9861	Reminder: Your loan payment of $4547.64 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9862	ستنتهي صلاحية بطاقتك المنتهية بـ 7963 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9863	تذكير: قسط القرض بقيمة 4758.09 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9865	عزيزي العميل، رصيد حسابك هو 6352.07. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9866	عزيزي العميل، رصيد حسابك هو 5482.44. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9867	Reminder: Your loan payment of $3140.73 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9868	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9869	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9870	Your OTP for transaction is 652260. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9871	Payment of $2332.40 received to your account ending with 2616. Thank you.	2025-11-10 00:00:00	\N	en
9875	Reminder: Your loan payment of $4111.28 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9876	تمت عملية بقيمة 1429.06 في المتجر. مرجع: 3699.	2025-11-10 00:00:00	\N	ar
9877	تذكير: قسط القرض بقيمة 7997.63 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9879	نود إبلاغك أن معلومات الاتصال الخاصة بك تم تحديثها بنجاح.	2025-11-10 00:00:00	\N	ar
9882	تذكير: قسط القرض بقيمة 9848.14 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9884	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9887	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9889	Your debit card ending 3176 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9890	Payment of $5461.33 received to your account ending with 9840. Thank you.	2025-11-10 00:00:00	\N	en
9891	التحويل المجدول اكتمل بنجاح. مرجع: 3359.	2025-11-10 00:00:00	\N	ar
9897	Dear customer, your account balance is $3235.69. Visit our branch for details.	2025-11-10 00:00:00	\N	en
9899	Payment of $3340.94 received to your account ending with 1605. Thank you.	2025-11-10 00:00:00	\N	en
9900	Your debit card ending 5281 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9901	ستنتهي صلاحية بطاقتك المنتهية بـ 9625 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9902	Payment of $6555.76 received to your account ending with 3652. Thank you.	2025-11-10 00:00:00	\N	en
9905	Your debit card ending 4706 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9906	التحويل المجدول اكتمل بنجاح. مرجع: 9976.	2025-11-10 00:00:00	\N	ar
9911	Your online transfer of $8684.88 to account 8756 was successful.	2025-11-10 00:00:00	\N	en
9914	Your transaction of $5295.99 at STORE was successful. Ref: 4683.	2025-11-10 00:00:00	\N	en
9915	Notification: Your card ending with 7124 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9916	Your transaction of $7824.81 at STORE was successful. Ref: 5780.	2025-11-10 00:00:00	\N	en
9917	Your scheduled transfer completed successfully. Ref: 4981.	2025-11-10 00:00:00	\N	en
9921	شكرًا لاستخدامك خدماتنا. للدعم اتصل بالرقم الرسمي.	2025-11-10 00:00:00	\N	ar
9924	تذكير: قسط القرض بقيمة 5477.83 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9926	Payment of $4481.48 received to your account ending with 9232. Thank you.	2025-11-10 00:00:00	\N	en
9927	تنبيه: بطاقتك المنتهية بـ 3845 استُخدمت في جهاز صراف بتاريخ 15-09-2025.	2025-11-10 00:00:00	\N	ar
9928	تم استلام دفعة بقيمة 9195.23 في حسابك المنتهي بـ 7138. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9929	التحويل المجدول اكتمل بنجاح. مرجع: 9990.	2025-11-10 00:00:00	\N	ar
9930	ستنتهي صلاحية بطاقتك المنتهية بـ 7607 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9931	إشعار: كشف حسابك جاهز لشهر مارس. تحقق عبر التطبيق الخاص بنا.	2025-11-10 00:00:00	\N	ar
9935	Your debit card ending 8126 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9937	عزيزي العميل، رصيد حسابك هو 1568.30. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9938	Your online transfer of $643.57 to account 5897 was successful.	2025-11-10 00:00:00	\N	en
9939	Your online transfer of $9518.81 to account 2691 was successful.	2025-11-10 00:00:00	\N	en
9942	Payment of $4838.63 received to your account ending with 7499. Thank you.	2025-11-10 00:00:00	\N	en
9944	Reminder: Your loan payment of $349.68 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9946	تمت عملية بقيمة 7004.74 في المتجر. مرجع: 9035.	2025-11-10 00:00:00	\N	ar
9947	تمت معالجة طلب استرداد الأموال بنجاح. ستصل خلال 3-5 أيام.	2025-11-10 00:00:00	\N	ar
9948	Bank Notice: Your statement for March is ready. Check it in our app.	2025-11-10 00:00:00	\N	en
9949	تذكير: قسط القرض بقيمة 3994.14 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9952	تمت عملية بقيمة 1207.22 في المتجر. مرجع: 9731.	2025-11-10 00:00:00	\N	ar
9953	عزيزي العميل، رصيد حسابك هو 4475.34. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9955	عزيزي العميل، رصيد حسابك هو 7419.67. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9956	ستنتهي صلاحية بطاقتك المنتهية بـ 1005 الشهر المقبل. زر الفرع للتجديد.	2025-11-10 00:00:00	\N	ar
9957	تمت عملية بقيمة 446.12 في المتجر. مرجع: 9646.	2025-11-10 00:00:00	\N	ar
9958	عزيزي العميل، رصيد حسابك هو 9404.98. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9959	Your OTP for transaction is 971322. Do not share it with anyone.	2025-11-10 00:00:00	\N	en
9961	Thank you for banking with us. For support call our official number.	2025-11-10 00:00:00	\N	en
9962	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9964	Your transaction of $1259.75 at STORE was successful. Ref: 8715.	2025-11-10 00:00:00	\N	en
9965	Your scheduled transfer completed successfully. Ref: 8343.	2025-11-10 00:00:00	\N	en
9967	Reminder: Your loan payment of $9873.90 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9968	عزيزي العميل، رصيد حسابك هو 5037.68. تفضل بزيارة الفرع لمزيد من التفاصيل.	2025-11-10 00:00:00	\N	ar
9977	تذكير: قسط القرض بقيمة 716.06 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9980	التحويل المجدول اكتمل بنجاح. مرجع: 9033.	2025-11-10 00:00:00	\N	ar
9983	تذكير: قسط القرض بقيمة 3008.16 مستحق في 01-10-2025.	2025-11-10 00:00:00	\N	ar
9984	Alert: A new device was used to access your account. If this wasn't you, contact us.	2025-11-10 00:00:00	\N	en
9985	Your scheduled transfer completed successfully. Ref: 4421.	2025-11-10 00:00:00	\N	en
9986	Your scheduled transfer completed successfully. Ref: 3238.	2025-11-10 00:00:00	\N	en
9987	رمز التحقق لعملية الدفع هو 624352. لا تشارك هذا الرمز مع أي شخص.	2025-11-10 00:00:00	\N	ar
9988	Your debit card ending 4642 will expire next month. Visit branch to replace.	2025-11-10 00:00:00	\N	en
9990	تم استلام دفعة بقيمة 9645.67 في حسابك المنتهي بـ 8427. شكرًا لك.	2025-11-10 00:00:00	\N	ar
9991	Notification: Your card ending with 9607 was used at ATM on 2025-09-15.	2025-11-10 00:00:00	\N	en
9992	Reminder: Your loan payment of $4079.26 is due on 2025-10-01.	2025-11-10 00:00:00	\N	en
9994	تمت عملية بقيمة 9829.40 في المتجر. مرجع: 8965.	2025-11-10 00:00:00	\N	ar
\.


--
-- TOC entry 5088 (class 0 OID 16401)
-- Dependencies: 223
-- Data for Name: trusted_senders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trusted_senders (sender_id, alphanumeric_sender_id, sender_phone, sender_email, is_trusted, verification_date, verified_by_admin) FROM stdin;
1	ALRAJHI	800-124-1222	\N	t	2025-09-30 00:00:00	1
2	ALRAJHI	920-003-344	\N	t	2025-09-30 00:00:00	1
3	ALRAJHI	800-124-4455	\N	t	2025-09-30 00:00:00	1
4	RIYADBANK	\N	care@alrajhibank.com.sa	t	2025-09-30 00:00:00	1
5	RIYADBANK	800-124-2225	\N	t	2025-09-30 00:00:00	1
6	RIYADBANK	800-122-6666	\N	t	2025-09-30 00:00:00	1
7	RIYADBANK	966-11-479-4611	\N	t	2025-09-30 00:00:00	1
8	RIYADBANK	800-610-0010	\N	t	2025-09-30 00:00:00	1
9	RIYADBANK	966-11-479-4611	\N	t	2025-09-30 00:00:00	1
10	RIYADBANK	800-124-2020	\N	t	2025-09-30 00:00:00	1
11	RIYADBANK	800-441-0000	\N	t	2025-09-30 00:00:00	1
12	SNB	966-11-479-4611	\N	t	2025-09-30 00:00:00	1
13	SNB	\N	contactus@alahli.com	t	2025-09-30 00:00:00	1
14	SNB	966920001000	\N	t	2025-09-30 00:00:00	1
15	SNB	800-244-1005	\N	t	2025-09-30 00:00:00	1
16	SNB	966920000891	\N	t	2025-09-30 00:00:00	1
17	SABB	\N	complaints@alahli.com	t	2025-09-30 00:00:00	1
18	SABB	800-124-8888	\N	t	2025-09-30 00:00:00	1
19	SABB	966-11-406-2800	\N	t	2025-09-30 00:00:00	1
20	SABB	966-9200-7222	\N	t	2025-09-30 00:00:00	1
21	SABB	800-116-0099	\N	t	2025-09-30 00:00:00	1
22	SABB	966-11-440-8999	\N	t	2025-09-30 00:00:00	1
23	SABB	800-124-8666	\N	t	2025-09-30 00:00:00	1
24	SABB	966-11-440-8666	\N	t	2025-09-30 00:00:00	1
25	SABB	966-9200-7222	\N	t	2025-09-30 00:00:00	1
26	SABB	9200-29829	\N	t	2025-09-30 00:00:00	1
27	SABB	800-124-5557	\N	t	2025-09-30 00:00:00	1
28	SABB	966-11-440-8800	\N	t	2025-09-30 00:00:00	1
29	SABB	800-249-3333	\N	t	2025-09-30 00:00:00	1
30	SABB	966-11-406-2810	\N	t	2025-09-30 00:00:00	1
31	SABB	800-119-4444	\N	t	2025-09-30 00:00:00	1
32	SABB	966-11-406-2809	\N	t	2025-09-30 00:00:00	1
33	SABB	011-440-8777	\N	t	2025-09-30 00:00:00	1
34	SABB	800-124-2525	\N	t	2025-09-30 00:00:00	1
35	SABB	966-11-406-2834	\N	t	2025-09-30 00:00:00	1
36	ALINMA	800-120-8000	\N	t	2025-09-30 00:00:00	1
37	ALINMA	\N	complaints@alinma.com	t	2025-09-30 00:00:00	1
38	ALINMA	966-11-218-5555	\N	t	2025-09-30 00:00:00	1
39	ALINMA	966-11-218-5000	\N	t	2025-09-30 00:00:00	1
40	ALINMA	9200-28000	\N	t	2025-09-30 00:00:00	1
41	ALINMA	966-9200-28000	\N	t	2025-09-30 00:00:00	1
42	ALINMA	966-11-203-9020	\N	t	2025-09-30 00:00:00	1
43	ALINMA	966-11-218-5099	\N	t	2025-09-30 00:00:00	1
44	ALINMA	\N	www.alinma.com	t	2025-09-30 00:00:00	1
45	BSF	800-124-2121	\N	t	2025-09-30 00:00:00	1
46	BSF	966-920000576	\N	t	2025-09-30 00:00:00	1
47	BSF	011-408-4631	\N	t	2025-09-30 00:00:00	1
48	BSF	800-124-0425	\N	t	2025-09-30 00:00:00	1
49	ANB	800-124-4141	\N	t	2025-09-30 00:00:00	1
50	ANB	800-116-0060	\N	t	2025-09-30 00:00:00	1
51	ANB	966-11-271-8611	\N	t	2025-09-30 00:00:00	1
52	ANB	800-124-4040	\N	t	2025-09-30 00:00:00	1
53	ANB	966-11-212-7555	\N	t	2025-09-30 00:00:00	1
54	ANB	800-119-0000	\N	t	2025-09-30 00:00:00	1
55	ANB	966-11-211-9800	\N	t	2025-09-30 00:00:00	1
56	ANB	800-121-3000	\N	t	2025-09-30 00:00:00	1
57	ANB	800-124-0088	\N	t	2025-09-30 00:00:00	1
58	ANB	\N	customercare@anb.com.sa	t	2025-09-30 00:00:00	1
59	ANB	800-119-1111	\N	t	2025-09-30 00:00:00	1
60	ANB	\N	careers.anb.com.sa	t	2025-09-30 00:00:00	1
61	ANB	800-119-2222	\N	t	2025-09-30 00:00:00	1
62	ANB	966-11-299-4022	\N	t	2025-09-30 00:00:00	1
63	ANB	966-11-402-9000	\N	t	2025-09-30 00:00:00	1
64	ANB	966-11-290-4900	\N	t	2025-09-30 00:00:00	1
65	ANB	966-11-402-7747	\N	t	2025-09-30 00:00:00	1
66	ANB	800-119-1919	\N	t	2025-09-30 00:00:00	1
67	ANB	966-11-402-9000	\N	t	2025-09-30 00:00:00	1
68	ANB	966-11-459-8999	\N	t	2025-09-30 00:00:00	1
69	BAJ	\N	Call_Center_Supervisor@bankaljazira.com	t	2025-09-30 00:00:00	1
70	BAJ	966-9-2000-6666	\N	t	2025-09-30 00:00:00	1
71	BAJ	800-244-0404	\N	t	2025-09-30 00:00:00	1
72	BAJ	800-244-9999	\N	t	2025-09-30 00:00:00	1
73	BAJ	\N	RADI@bankaljazira.com	t	2025-09-30 00:00:00	1
74	BAJ	\N	shakwa@bankaljazira.com	t	2025-09-30 00:00:00	1
75	BAJ	800-244-0505	\N	t	2025-09-30 00:00:00	1
76	BAJ	800-244-0404	\N	t	2025-09-30 00:00:00	1
77	BAJ	966-9-2000-6666	\N	t	2025-09-30 00:00:00	1
78	BILAD	011-479-8888	\N	t	2025-09-30 00:00:00	1
79	BILAD	966-1-479-8888	\N	t	2025-09-30 00:00:00	1
80	BILAD	966-11-479-8898	\N	t	2025-09-30 00:00:00	1
81	BILAD	800-123-0000	\N	t	2025-09-30 00:00:00	1
82	BILAD	966-9200-1002	\N	t	2025-09-30 00:00:00	1
83	BILAD	966-11-277-9509	\N	t	2025-09-30 00:00:00	1
84	BILAD	800-123-6666	\N	t	2025-09-30 00:00:00	1
85	BILAD	800-123-0000	\N	t	2025-09-30 00:00:00	1
86	BILAD	966-9200-1002	\N	t	2025-09-30 00:00:00	1
87	BILAD	800-123-7777	\N	t	2025-09-30 00:00:00	1
88	BILAD	800-124-8000	\N	t	2025-09-30 00:00:00	1
89	SAIB	966-11-479-8766	\N	t	2025-09-30 00:00:00	1
90	SAIB	966-11-418-3100	\N	t	2025-09-30 00:00:00	1
91	GIB	966-13-866-4000	\N	t	2025-09-30 00:00:00	1
92	GIB	641	\N	t	2025-09-30 00:00:00	1
\.


--
-- TOC entry 5090 (class 0 OID 16417)
-- Dependencies: 225
-- Data for Name: verification_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.verification_results (result_id, status, fraud_score, reason) FROM stdin;
0	Froud	100.00	Auto-imported for messages data
50	Suspicious	50.00	Auto-imported for messages data
100	Verified	0.00	Auto-imported for messages data
\.


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 220
-- Name: admin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_admin_id_seq', 1, false);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 228
-- Name: logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_log_id_seq', 1, false);


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 226
-- Name: messages_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_message_id_seq', 1, true);


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 222
-- Name: trusted_senders_sender_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trusted_senders_sender_id_seq', 1, false);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 224
-- Name: verification_results_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.verification_results_result_id_seq', 1, false);


--
-- TOC entry 4925 (class 2606 OID 16399)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);


--
-- TOC entry 4927 (class 2606 OID 16505)
-- Name: admin admin_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_username_unique UNIQUE (username);


--
-- TOC entry 4935 (class 2606 OID 16458)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (log_id);


--
-- TOC entry 4933 (class 2606 OID 16438)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (message_id);


--
-- TOC entry 4929 (class 2606 OID 16408)
-- Name: trusted_senders trusted_senders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trusted_senders
    ADD CONSTRAINT trusted_senders_pkey PRIMARY KEY (sender_id);


--
-- TOC entry 4931 (class 2606 OID 16426)
-- Name: verification_results verification_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification_results
    ADD CONSTRAINT verification_results_pkey PRIMARY KEY (result_id);


--
-- TOC entry 4937 (class 2606 OID 16444)
-- Name: messages messages_result_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_result_id_fkey FOREIGN KEY (result_id) REFERENCES public.verification_results(result_id) ON DELETE SET NULL;


--
-- TOC entry 4936 (class 2606 OID 16411)
-- Name: trusted_senders trusted_senders_verified_by_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trusted_senders
    ADD CONSTRAINT trusted_senders_verified_by_admin_fkey FOREIGN KEY (verified_by_admin) REFERENCES public.admin(admin_id) ON DELETE SET NULL;


-- Completed on 2025-11-02 09:58:39

--
-- PostgreSQL database dump complete
--

\unrestrict lNrfyVFfAOIbXBXuT1ES0QOdOfQCduydcCIX2wrCJs21oTotl480F1niBTaLSot


