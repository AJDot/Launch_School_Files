--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.8
-- Dumped by pg_dump version 9.5.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bidders; Type: TABLE; Schema: public; Owner: ajdot
--

CREATE TABLE bidders (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE bidders OWNER TO ajdot;

--
-- Name: bidders_id_seq; Type: SEQUENCE; Schema: public; Owner: ajdot
--

CREATE SEQUENCE bidders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bidders_id_seq OWNER TO ajdot;

--
-- Name: bidders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ajdot
--

ALTER SEQUENCE bidders_id_seq OWNED BY bidders.id;


--
-- Name: bids; Type: TABLE; Schema: public; Owner: ajdot
--

CREATE TABLE bids (
    id integer NOT NULL,
    bidder_id integer NOT NULL,
    item_id integer NOT NULL,
    amount numeric(6,2) NOT NULL,
    CONSTRAINT bids_amount_check CHECK (((amount >= 0.01) AND (amount <= 1000.00)))
);


ALTER TABLE bids OWNER TO ajdot;

--
-- Name: bids_id_seq; Type: SEQUENCE; Schema: public; Owner: ajdot
--

CREATE SEQUENCE bids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bids_id_seq OWNER TO ajdot;

--
-- Name: bids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ajdot
--

ALTER SEQUENCE bids_id_seq OWNED BY bids.id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: ajdot
--

CREATE TABLE items (
    id integer NOT NULL,
    name text NOT NULL,
    initial_price numeric(6,2) NOT NULL,
    sales_price numeric(6,2),
    CONSTRAINT items_initial_price_check CHECK (((initial_price >= 0.01) AND (initial_price <= 1000.00))),
    CONSTRAINT items_sales_price_check CHECK (((sales_price >= 0.01) AND (sales_price <= 1000.00)))
);


ALTER TABLE items OWNER TO ajdot;

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: ajdot
--

CREATE SEQUENCE items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE items_id_seq OWNER TO ajdot;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ajdot
--

ALTER SEQUENCE items_id_seq OWNED BY items.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ajdot
--

ALTER TABLE ONLY bidders ALTER COLUMN id SET DEFAULT nextval('bidders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ajdot
--

ALTER TABLE ONLY bids ALTER COLUMN id SET DEFAULT nextval('bids_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ajdot
--

ALTER TABLE ONLY items ALTER COLUMN id SET DEFAULT nextval('items_id_seq'::regclass);


--
-- Data for Name: bidders; Type: TABLE DATA; Schema: public; Owner: ajdot
--

COPY bidders (id, name) FROM stdin;
1	Alison Walker
2	James Quinn
3	Taylor Williams
4	Alexis Jones
5	Gwen Miller
6	Alan Parker
7	Sam Carter
\.


--
-- Name: bidders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ajdot
--

SELECT pg_catalog.setval('bidders_id_seq', 1, false);


--
-- Data for Name: bids; Type: TABLE DATA; Schema: public; Owner: ajdot
--

COPY bids (id, bidder_id, item_id, amount) FROM stdin;
1	1	1	40.00
2	3	1	52.00
3	1	1	53.00
4	3	1	70.87
5	5	2	83.25
6	2	3	110.00
7	4	3	140.00
8	2	3	150.00
9	6	3	175.00
10	4	3	185.00
11	2	3	200.00
12	6	3	225.00
13	4	3	250.00
14	1	4	222.00
15	2	4	262.00
16	1	4	290.00
17	1	4	300.00
18	2	5	21.72
19	6	5	23.00
20	2	5	25.00
21	6	5	30.00
22	2	5	32.00
23	6	5	33.00
24	2	5	38.00
25	6	5	40.00
26	2	5	42.00
\.


--
-- Name: bids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ajdot
--

SELECT pg_catalog.setval('bids_id_seq', 1, false);


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: ajdot
--

COPY items (id, name, initial_price, sales_price) FROM stdin;
1	Video Game	39.99	70.87
2	Outdoor Grill	51.00	83.25
3	Painting	100.00	250.00
4	Tent	220.00	300.00
5	Vase	20.00	42.00
6	Television	550.00	\N
\.


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ajdot
--

SELECT pg_catalog.setval('items_id_seq', 1, false);


--
-- Name: bidders_pkey; Type: CONSTRAINT; Schema: public; Owner: ajdot
--

ALTER TABLE ONLY bidders
    ADD CONSTRAINT bidders_pkey PRIMARY KEY (id);


--
-- Name: bids_pkey; Type: CONSTRAINT; Schema: public; Owner: ajdot
--

ALTER TABLE ONLY bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (id);


--
-- Name: items_pkey; Type: CONSTRAINT; Schema: public; Owner: ajdot
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: bids_bidder_id_item_id_idx; Type: INDEX; Schema: public; Owner: ajdot
--

CREATE INDEX bids_bidder_id_item_id_idx ON bids USING btree (bidder_id, item_id);


--
-- Name: bids_bidder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ajdot
--

ALTER TABLE ONLY bids
    ADD CONSTRAINT bids_bidder_id_fkey FOREIGN KEY (bidder_id) REFERENCES bidders(id) ON DELETE CASCADE;


--
-- Name: bids_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ajdot
--

ALTER TABLE ONLY bids
    ADD CONSTRAINT bids_item_id_fkey FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

