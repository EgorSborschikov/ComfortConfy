--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)

-- Started on 2024-11-04 23:19:51 +07

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

--
-- TOC entry 3446 (class 1262 OID 17532)
-- Name: video_calls_and_confereces_app_database; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE video_calls_and_confereces_app_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru_RU.UTF-8';


ALTER DATABASE video_calls_and_confereces_app_database OWNER TO postgres;

\connect video_calls_and_confereces_app_database

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17628)
-- Name: blocked_in_conference_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blocked_in_conference_users (
    "IDBlockedInConferenceUser" integer NOT NULL,
    "IDConferenceParticipant" integer NOT NULL
);


ALTER TABLE public.blocked_in_conference_users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17618)
-- Name: blocked_in_system_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blocked_in_system_users (
    "IDBlockedInSystemUser" integer NOT NULL,
    "IDUser" integer NOT NULL,
    "IDReasonForBlocking" integer NOT NULL
);


ALTER TABLE public.blocked_in_system_users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17593)
-- Name: conference_links_invitation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conference_links_invitation (
    "IDConferenceLinkInvitation" integer NOT NULL,
    "Link" character varying(255) NOT NULL
);


ALTER TABLE public.conference_links_invitation OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17545)
-- Name: conference_paticipants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conference_paticipants (
    "IDConferenceParticipant" integer NOT NULL,
    "IDConference" integer NOT NULL,
    "IDUser" integer NOT NULL,
    "IDUserConferenceRole" integer NOT NULL,
    "MicroEnabled" boolean NOT NULL,
    "CameraEnabled" boolean NOT NULL,
    "DemonstrationScreenEnabled" boolean NOT NULL
);


ALTER TABLE public.conference_paticipants OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17555)
-- Name: conference_user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conference_user_roles (
    "IDConferenceUserRole" integer NOT NULL,
    "Role" character varying(100) NOT NULL
);


ALTER TABLE public.conference_user_roles OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17598)
-- Name: conferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conferences (
    "IDConference" integer NOT NULL,
    "IDUserAdmin" integer NOT NULL,
    "IDConferenceLinkInvitation" integer NOT NULL,
    "ConferenceName" character varying(100) NOT NULL,
    "TimeCreatedAt" time(6) with time zone NOT NULL,
    "StartTime" timestamp(6) without time zone
);


ALTER TABLE public.conferences OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17653)
-- Name: reasons_for_blocked; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reasons_for_blocked (
    "IDReasonForBlocked" integer NOT NULL,
    "Reason" character varying(255) NOT NULL
);


ALTER TABLE public.reasons_for_blocked OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17540)
-- Name: statuses_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statuses_activity (
    "IDStatusActivity" integer NOT NULL,
    "StatusActivity" character varying(30) NOT NULL
);


ALTER TABLE public.statuses_activity OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17533)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    "IDUser" integer NOT NULL,
    "IDStatusActivity" integer NOT NULL,
    "UserName" character varying(50) NOT NULL,
    "Email(Login)" character varying(255) NOT NULL,
    "PasswordHash" character varying(255) NOT NULL,
    "UserProfilePicture" character varying(255),
    "InformationStatus" character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17638)
-- Name: users_blocked_by_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_blocked_by_users (
    "IDUserBlockedByUsers" integer NOT NULL,
    "IDUser" integer NOT NULL,
    "IDBlockedUser" integer NOT NULL
);


ALTER TABLE public.users_blocked_by_users OWNER TO postgres;

--
-- TOC entry 3438 (class 0 OID 17628)
-- Dependencies: 222
-- Data for Name: blocked_in_conference_users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3437 (class 0 OID 17618)
-- Dependencies: 221
-- Data for Name: blocked_in_system_users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3435 (class 0 OID 17593)
-- Dependencies: 219
-- Data for Name: conference_links_invitation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3433 (class 0 OID 17545)
-- Dependencies: 217
-- Data for Name: conference_paticipants; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3434 (class 0 OID 17555)
-- Dependencies: 218
-- Data for Name: conference_user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3436 (class 0 OID 17598)
-- Dependencies: 220
-- Data for Name: conferences; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3440 (class 0 OID 17653)
-- Dependencies: 224
-- Data for Name: reasons_for_blocked; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3432 (class 0 OID 17540)
-- Dependencies: 216
-- Data for Name: statuses_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3431 (class 0 OID 17533)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3439 (class 0 OID 17638)
-- Dependencies: 223
-- Data for Name: users_blocked_by_users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3272 (class 2606 OID 17632)
-- Name: blocked_in_conference_users blocked_in_conference_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocked_in_conference_users
    ADD CONSTRAINT blocked_in_conference_users_pkey PRIMARY KEY ("IDBlockedInConferenceUser");


--
-- TOC entry 3270 (class 2606 OID 17622)
-- Name: blocked_in_system_users blocked_in_system_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocked_in_system_users
    ADD CONSTRAINT blocked_in_system_users_pkey PRIMARY KEY ("IDBlockedInSystemUser");


--
-- TOC entry 3266 (class 2606 OID 17597)
-- Name: conference_links_invitation conference_links_invitation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference_links_invitation
    ADD CONSTRAINT conference_links_invitation_pkey PRIMARY KEY ("IDConferenceLinkInvitation");


--
-- TOC entry 3262 (class 2606 OID 17549)
-- Name: conference_paticipants conference_paticipants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference_paticipants
    ADD CONSTRAINT conference_paticipants_pkey PRIMARY KEY ("IDConferenceParticipant");


--
-- TOC entry 3264 (class 2606 OID 17559)
-- Name: conference_user_roles conference_user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference_user_roles
    ADD CONSTRAINT conference_user_roles_pkey PRIMARY KEY ("IDConferenceUserRole");


--
-- TOC entry 3268 (class 2606 OID 17602)
-- Name: conferences conferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferences
    ADD CONSTRAINT conferences_pkey PRIMARY KEY ("IDConference");


--
-- TOC entry 3276 (class 2606 OID 17657)
-- Name: reasons_for_blocked reasons_for_blocked_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reasons_for_blocked
    ADD CONSTRAINT reasons_for_blocked_pkey PRIMARY KEY ("IDReasonForBlocked");


--
-- TOC entry 3260 (class 2606 OID 17544)
-- Name: statuses_activity statuses_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statuses_activity
    ADD CONSTRAINT statuses_activity_pkey PRIMARY KEY ("IDStatusActivity");


--
-- TOC entry 3274 (class 2606 OID 17642)
-- Name: users_blocked_by_users users_blocked_by_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_blocked_by_users
    ADD CONSTRAINT users_blocked_by_users_pkey PRIMARY KEY ("IDUserBlockedByUsers");


--
-- TOC entry 3258 (class 2606 OID 17539)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY ("IDUser");


--
-- TOC entry 3285 (class 2606 OID 17633)
-- Name: blocked_in_conference_users blocked_in_conference_users_IDConferenceParticipant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocked_in_conference_users
    ADD CONSTRAINT "blocked_in_conference_users_IDConferenceParticipant_fkey" FOREIGN KEY ("IDConferenceParticipant") REFERENCES public.conference_paticipants("IDConferenceParticipant");


--
-- TOC entry 3283 (class 2606 OID 17658)
-- Name: blocked_in_system_users blocked_in_system_users_IDReasonForBlocking_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocked_in_system_users
    ADD CONSTRAINT "blocked_in_system_users_IDReasonForBlocking_fkey" FOREIGN KEY ("IDReasonForBlocking") REFERENCES public.reasons_for_blocked("IDReasonForBlocked") NOT VALID;


--
-- TOC entry 3284 (class 2606 OID 17623)
-- Name: blocked_in_system_users blocked_in_system_users_IDUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocked_in_system_users
    ADD CONSTRAINT "blocked_in_system_users_IDUser_fkey" FOREIGN KEY ("IDUser") REFERENCES public.users("IDUser") NOT VALID;


--
-- TOC entry 3278 (class 2606 OID 17613)
-- Name: conference_paticipants conference_paticipants_IDConference_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference_paticipants
    ADD CONSTRAINT "conference_paticipants_IDConference_fkey" FOREIGN KEY ("IDConference") REFERENCES public.conferences("IDConference") NOT VALID;


--
-- TOC entry 3279 (class 2606 OID 17580)
-- Name: conference_paticipants conference_paticipants_IDUserConferenceRole_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference_paticipants
    ADD CONSTRAINT "conference_paticipants_IDUserConferenceRole_fkey" FOREIGN KEY ("IDUserConferenceRole") REFERENCES public.conference_user_roles("IDConferenceUserRole") NOT VALID;


--
-- TOC entry 3280 (class 2606 OID 17575)
-- Name: conference_paticipants conference_paticipants_IDUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference_paticipants
    ADD CONSTRAINT "conference_paticipants_IDUser_fkey" FOREIGN KEY ("IDUser") REFERENCES public.users("IDUser") NOT VALID;


--
-- TOC entry 3281 (class 2606 OID 17608)
-- Name: conferences conferences_IDConferenceLinkInvitation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferences
    ADD CONSTRAINT "conferences_IDConferenceLinkInvitation_fkey" FOREIGN KEY ("IDConferenceLinkInvitation") REFERENCES public.conference_links_invitation("IDConferenceLinkInvitation") NOT VALID;


--
-- TOC entry 3282 (class 2606 OID 17603)
-- Name: conferences conferences_IDUserAdmin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferences
    ADD CONSTRAINT "conferences_IDUserAdmin_fkey" FOREIGN KEY ("IDUserAdmin") REFERENCES public.users("IDUser");


--
-- TOC entry 3277 (class 2606 OID 17560)
-- Name: users users_IDStatusActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_IDStatusActivity_fkey" FOREIGN KEY ("IDStatusActivity") REFERENCES public.statuses_activity("IDStatusActivity") NOT VALID;


--
-- TOC entry 3286 (class 2606 OID 17648)
-- Name: users_blocked_by_users users_blocked_by_users_IDBlockedUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_blocked_by_users
    ADD CONSTRAINT "users_blocked_by_users_IDBlockedUser_fkey" FOREIGN KEY ("IDBlockedUser") REFERENCES public.users("IDUser") NOT VALID;


--
-- TOC entry 3287 (class 2606 OID 17643)
-- Name: users_blocked_by_users users_blocked_by_users_IDUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_blocked_by_users
    ADD CONSTRAINT "users_blocked_by_users_IDUser_fkey" FOREIGN KEY ("IDUser") REFERENCES public.users("IDUser");


-- Completed on 2024-11-04 23:19:51 +07

--
-- PostgreSQL database dump complete
--

