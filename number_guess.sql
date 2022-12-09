--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    user_id integer NOT NULL,
    game_id integer NOT NULL,
    number_of_guesses integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(30) NOT NULL,
    games_played integer,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 24);
INSERT INTO public.games VALUES (2, 1, 15);
INSERT INTO public.games VALUES (1, 2, 18);
INSERT INTO public.games VALUES (3, 1, 26);
INSERT INTO public.games VALUES (3, 2, 19);
INSERT INTO public.games VALUES (1, 3, 21);
INSERT INTO public.games VALUES (3, 3, 24);
INSERT INTO public.games VALUES (6, 1, 15);
INSERT INTO public.games VALUES (1, 4, 5);
INSERT INTO public.games VALUES (7, 1, 6);
INSERT INTO public.games VALUES (7, 2, 8);
INSERT INTO public.games VALUES (2, 2, 6);
INSERT INTO public.games VALUES (53, 1, 8);
INSERT INTO public.games VALUES (54, 1, 470);
INSERT INTO public.games VALUES (54, 2, 641);
INSERT INTO public.games VALUES (55, 1, 497);
INSERT INTO public.games VALUES (55, 2, 273);
INSERT INTO public.games VALUES (54, 3, 922);
INSERT INTO public.games VALUES (54, 4, 532);
INSERT INTO public.games VALUES (54, 5, 155);
INSERT INTO public.games VALUES (56, 1, 12);
INSERT INTO public.games VALUES (56, 2, 8);
INSERT INTO public.games VALUES (57, 1, 397);
INSERT INTO public.games VALUES (57, 2, 401);
INSERT INTO public.games VALUES (58, 1, 593);
INSERT INTO public.games VALUES (58, 2, 577);
INSERT INTO public.games VALUES (57, 3, 127);
INSERT INTO public.games VALUES (57, 4, 86);
INSERT INTO public.games VALUES (57, 5, 599);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (3, 'Cathy', 3, 19);
INSERT INTO public.users VALUES (6, 'Brenda', 1, 15);
INSERT INTO public.users VALUES (1, 'Ashley', 4, 5);
INSERT INTO public.users VALUES (7, 'Arianna', 2, 6);
INSERT INTO public.users VALUES (2, 'Brian', 2, 6);
INSERT INTO public.users VALUES (53, 'Mia', 1, 8);
INSERT INTO public.users VALUES (55, 'user_1670597792119', 2, 273);
INSERT INTO public.users VALUES (54, 'user_1670597792120', 5, 155);
INSERT INTO public.users VALUES (56, 'Butler', 2, 8);
INSERT INTO public.users VALUES (58, 'user_1670599102432', 2, 577);
INSERT INTO public.users VALUES (57, 'user_1670599102433', 5, 86);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 58, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (user_id, game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--
