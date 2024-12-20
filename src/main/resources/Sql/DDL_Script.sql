-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.requests
(
    id serial NOT NULL,
    user_id integer,
    software_id integer,
    access_type text COLLATE pg_catalog."default",
    reason text COLLATE pg_catalog."default",
    status text COLLATE pg_catalog."default" DEFAULT 'Pending'::text,
    CONSTRAINT requests_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.software
(
    id serial NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    access_levels text COLLATE pg_catalog."default",
    CONSTRAINT software_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.users
(
    id serial NOT NULL,
    username text COLLATE pg_catalog."default" NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    role text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT users_username_key UNIQUE (username)
);

ALTER TABLE IF EXISTS public.requests
    ADD CONSTRAINT requests_software_id_fkey FOREIGN KEY (software_id)
    REFERENCES public.software (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.requests
    ADD CONSTRAINT requests_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;