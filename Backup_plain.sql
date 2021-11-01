--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2021-11-01 20:46:38

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
-- TOC entry 3010 (class 1262 OID 24931)
-- Name: test; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE test3 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Czech_Czechia.1250';


\connect test3

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
-- TOC entry 6 (class 2615 OID 24932)
-- Name: data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA data;


--
-- TOC entry 3011 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA data; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA data IS 'data';


--
-- TOC entry 205 (class 1255 OID 33397)
-- Name: set_hq_and_agent(); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.set_hq_and_agent() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
         INSERT INTO adresses (company, office_type, country,	city, street, descriptive_number, orientation_number, ZIP_code)
         VALUES(NEW.company, 'headquarters', 'Czech Republic', 'Prague', 'Nová ulice', '2000', '13', '16700');
		 INSERT INTO employees
		 VALUES ('Richard', 'King',(SELECT office_id FROM adresses WHERE company = NEW.company), 'Agent');
 
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 33337)
-- Name: adresses; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.adresses (
    office_id integer NOT NULL,
    company character varying(255),
    office_type character(14),
    country character varying(255),
    city character varying(255),
    street character varying(255),
    descriptive_number character(10),
    orientation_number character(10),
    zip_code character varying(10),
    CONSTRAINT adresses_office_type_check CHECK ((office_type = ANY (ARRAY['headquarters'::bpchar, 'branch'::bpchar, 'foreign_branch'::bpchar])))
);


--
-- TOC entry 202 (class 1259 OID 33335)
-- Name: adresses_office_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.adresses_office_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 202
-- Name: adresses_office_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.adresses_office_id_seq OWNED BY data.adresses.office_id;


--
-- TOC entry 201 (class 1259 OID 33330)
-- Name: companies; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.companies (
    company character varying(255) NOT NULL,
    "iČo" character(8)
);


--
-- TOC entry 204 (class 1259 OID 33352)
-- Name: employees; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.employees (
    first_name character varying(50),
    last_name character varying(50),
    office_id integer,
    job_position character varying(50),
    CONSTRAINT employees_job_position_check CHECK (((job_position)::text = ANY ((ARRAY['Agent'::character varying, 'Director'::character varying, 'Technical Staff'::character varying, 'Economist'::character varying, 'Receptionist'::character varying])::text[])))
);


--
-- TOC entry 2861 (class 2604 OID 33340)
-- Name: adresses office_id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.adresses ALTER COLUMN office_id SET DEFAULT nextval('data.adresses_office_id_seq'::regclass);


--
-- TOC entry 3003 (class 0 OID 33337)
-- Dependencies: 203
-- Data for Name: adresses; Type: TABLE DATA; Schema: data; Owner: -
--

INSERT INTO data.adresses (office_id, company, office_type, country, city, street, descriptive_number, orientation_number, zip_code) VALUES (1, 'Giant Company', 'headquarters  ', 'Czech Republic', 'Prague', 'Přímá', '1956      ', '8         ', '16800');
INSERT INTO data.adresses (office_id, company, office_type, country, city, street, descriptive_number, orientation_number, zip_code) VALUES (2, 'Giant Company', 'branch        ', 'Czech Republic', 'Brno', 'Vedlejší', '3452      ', '5         ', '60200');
INSERT INTO data.adresses (office_id, company, office_type, country, city, street, descriptive_number, orientation_number, zip_code) VALUES (3, 'Giant Company', 'foreign_branch', 'Germany', 'Hamburg', 'Direkt Strasse', '1584      ', '3         ', '20095');
INSERT INTO data.adresses (office_id, company, office_type, country, city, street, descriptive_number, orientation_number, zip_code) VALUES (4, 'Giant Company', 'foreign_branch', 'Australia', 'Canberra', 'Rainy Street', '8941      ', '2         ', '2601');
INSERT INTO data.adresses (office_id, company, office_type, country, city, street, descriptive_number, orientation_number, zip_code) VALUES (5, 'Shipper Inc.', 'headquarters  ', 'Czech Republic', 'Prague', 'Radimova', '2561      ', '14        ', '36301');
INSERT INTO data.adresses (office_id, company, office_type, country, city, street, descriptive_number, orientation_number, zip_code) VALUES (6, 'Shipper Inc.', 'branch        ', 'Czech Republic', 'Jihlava', 'Palackého', '2152      ', '51        ', '45610');
INSERT INTO data.adresses (office_id, company, office_type, country, city, street, descriptive_number, orientation_number, zip_code) VALUES (7, 'Nut Business', 'headquarters  ', 'Czech Republic', 'Prague', 'Národní', '10010     ', '54        ', '1100');


--
-- TOC entry 3001 (class 0 OID 33330)
-- Dependencies: 201
-- Data for Name: companies; Type: TABLE DATA; Schema: data; Owner: -
--

INSERT INTO data.companies (company, "iČo") VALUES ('Giant Company', '12345678');
INSERT INTO data.companies (company, "iČo") VALUES ('Shipper Inc.', '84256842');
INSERT INTO data.companies (company, "iČo") VALUES ('Nut Business', '76842839');


--
-- TOC entry 3004 (class 0 OID 33352)
-- Dependencies: 204
-- Data for Name: employees; Type: TABLE DATA; Schema: data; Owner: -
--

INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Ctibor', 'Čejka', 1, 'Agent');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Slavomír', 'Plášil', 1, 'Director');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Kryštof', 'Štrobl', 1, 'Technical Staff');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Hanuš', 'Bursík', 1, 'Economist');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Julie', 'Šemberová', 1, 'Receptionist');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Emílie', 'Rokosová', 1, 'Agent');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Bronislav', 'Holek', 2, 'Technical Staff');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Viktor', 'Kukačka', 2, 'Economist');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Oto', 'Vydra', 3, 'Agent');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Marián', 'Záhora', 3, 'Technical Staff');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Alena', 'Šnajdrová', 4, 'Agent');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Danuše', 'Wawrzyczková', 4, 'Receptionist');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Vojtěch', 'Košmider', 4, 'Economist');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Marie', 'Hynková', 5, 'Agent');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Bronislav', 'Vrabec', 5, 'Economist');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Jiří', 'Tanics', 6, 'Agent');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Zuzana', 'Zídková', 6, 'Economist');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Ladislav', 'Kudela', 6, 'Technical Staff');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Alžbeta', 'Adamíková', 7, 'Agent');
INSERT INTO data.employees (first_name, last_name, office_id, job_position) VALUES ('Libuše', 'Baroňová', 7, 'Economist');


--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 202
-- Name: adresses_office_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.adresses_office_id_seq', 7, true);


--
-- TOC entry 2867 (class 2606 OID 33346)
-- Name: adresses adresses_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.adresses
    ADD CONSTRAINT adresses_pkey PRIMARY KEY (office_id);


--
-- TOC entry 2865 (class 2606 OID 33334)
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (company);


--
-- TOC entry 2870 (class 2620 OID 33398)
-- Name: companies new_company; Type: TRIGGER; Schema: data; Owner: -
--

CREATE TRIGGER new_company AFTER INSERT ON data.companies FOR EACH ROW EXECUTE FUNCTION data.set_hq_and_agent();


--
-- TOC entry 2868 (class 2606 OID 33347)
-- Name: adresses adresses_company_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.adresses
    ADD CONSTRAINT adresses_company_fkey FOREIGN KEY (company) REFERENCES data.companies(company);


--
-- TOC entry 2869 (class 2606 OID 33356)
-- Name: employees employees_office_id_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.employees
    ADD CONSTRAINT employees_office_id_fkey FOREIGN KEY (office_id) REFERENCES data.adresses(office_id);


-- Completed on 2021-11-01 20:46:47

--
-- PostgreSQL database dump complete
--

