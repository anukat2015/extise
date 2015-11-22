--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bugs_eclipse_org_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bugs_eclipse_org_attachments (
    id integer NOT NULL,
    bug_id integer NOT NULL,
    submitter_id integer NOT NULL,
    attachid integer NOT NULL,
    date timestamp without time zone NOT NULL,
    delta_ts timestamp without time zone NOT NULL,
    "desc" text NOT NULL,
    filename character varying NOT NULL,
    type character varying NOT NULL,
    size integer NOT NULL,
    attacher character varying NOT NULL,
    attacher_name character varying NOT NULL,
    isobsolete boolean NOT NULL,
    ispatch boolean NOT NULL,
    isprivate boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bugs_eclipse_org_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bugs_eclipse_org_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bugs_eclipse_org_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bugs_eclipse_org_attachments_id_seq OWNED BY bugs_eclipse_org_attachments.id;


--
-- Name: bugs_eclipse_org_bugs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bugs_eclipse_org_bugs (
    id integer NOT NULL,
    bugzilla_id integer NOT NULL,
    author_id integer NOT NULL,
    assignee_id integer NOT NULL,
    bugid integer NOT NULL,
    creation_ts timestamp without time zone NOT NULL,
    short_desc text NOT NULL,
    delta_ts timestamp without time zone NOT NULL,
    reporter_accessible boolean NOT NULL,
    cclist_accessible boolean NOT NULL,
    classificationid integer NOT NULL,
    classification character varying NOT NULL,
    product character varying NOT NULL,
    component character varying NOT NULL,
    version character varying NOT NULL,
    rep_platform character varying NOT NULL,
    op_sys character varying NOT NULL,
    bug_status character varying NOT NULL,
    resolution character varying,
    bug_file_loc character varying,
    status_whiteboard character varying,
    keywords character varying[] NOT NULL,
    priority character varying NOT NULL,
    bug_severity character varying NOT NULL,
    target_milestone character varying NOT NULL,
    dependson integer[] NOT NULL,
    everconfirmed boolean NOT NULL,
    reporter character varying NOT NULL,
    reporter_name character varying NOT NULL,
    assigned_to character varying NOT NULL,
    assigned_to_name character varying NOT NULL,
    cc character varying[] NOT NULL,
    votes integer NOT NULL,
    comment_sort_order character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bugs_eclipse_org_bugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bugs_eclipse_org_bugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bugs_eclipse_org_bugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bugs_eclipse_org_bugs_id_seq OWNED BY bugs_eclipse_org_bugs.id;


--
-- Name: bugs_eclipse_org_bugzillas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bugs_eclipse_org_bugzillas (
    id integer NOT NULL,
    version character varying NOT NULL,
    urlbase character varying(2048) NOT NULL,
    maintainer character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bugs_eclipse_org_bugzillas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bugs_eclipse_org_bugzillas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bugs_eclipse_org_bugzillas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bugs_eclipse_org_bugzillas_id_seq OWNED BY bugs_eclipse_org_bugzillas.id;


--
-- Name: bugs_eclipse_org_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bugs_eclipse_org_comments (
    id integer NOT NULL,
    bug_id integer NOT NULL,
    author_id integer NOT NULL,
    commentid integer NOT NULL,
    comment_count integer NOT NULL,
    who character varying NOT NULL,
    who_name character varying NOT NULL,
    bug_when timestamp without time zone NOT NULL,
    thetext text NOT NULL,
    isprivate boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bugs_eclipse_org_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bugs_eclipse_org_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bugs_eclipse_org_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bugs_eclipse_org_comments_id_seq OWNED BY bugs_eclipse_org_comments.id;


--
-- Name: bugs_eclipse_org_interactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bugs_eclipse_org_interactions (
    id integer NOT NULL,
    attachment_id integer NOT NULL,
    bug_url character varying(2048) NOT NULL,
    version integer NOT NULL,
    kind character varying NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    originid character varying NOT NULL,
    structure_kind character varying NOT NULL,
    structure_handle text NOT NULL,
    navigation character varying,
    delta character varying,
    interest numeric(12,8) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bugs_eclipse_org_interactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bugs_eclipse_org_interactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bugs_eclipse_org_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bugs_eclipse_org_interactions_id_seq OWNED BY bugs_eclipse_org_interactions.id;


--
-- Name: bugs_eclipse_org_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bugs_eclipse_org_users (
    id integer NOT NULL,
    login_name character varying NOT NULL,
    realnames character varying[] NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bugs_eclipse_org_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bugs_eclipse_org_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bugs_eclipse_org_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bugs_eclipse_org_users_id_seq OWNED BY bugs_eclipse_org_users.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_attachments ALTER COLUMN id SET DEFAULT nextval('bugs_eclipse_org_attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_bugs ALTER COLUMN id SET DEFAULT nextval('bugs_eclipse_org_bugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_bugzillas ALTER COLUMN id SET DEFAULT nextval('bugs_eclipse_org_bugzillas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_comments ALTER COLUMN id SET DEFAULT nextval('bugs_eclipse_org_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_interactions ALTER COLUMN id SET DEFAULT nextval('bugs_eclipse_org_interactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_users ALTER COLUMN id SET DEFAULT nextval('bugs_eclipse_org_users_id_seq'::regclass);


--
-- Name: bugs_eclipse_org_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bugs_eclipse_org_attachments
    ADD CONSTRAINT bugs_eclipse_org_attachments_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_bugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bugs_eclipse_org_bugs
    ADD CONSTRAINT bugs_eclipse_org_bugs_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_bugzillas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bugs_eclipse_org_bugzillas
    ADD CONSTRAINT bugs_eclipse_org_bugzillas_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bugs_eclipse_org_comments
    ADD CONSTRAINT bugs_eclipse_org_comments_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bugs_eclipse_org_interactions
    ADD CONSTRAINT bugs_eclipse_org_interactions_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bugs_eclipse_org_users
    ADD CONSTRAINT bugs_eclipse_org_users_pkey PRIMARY KEY (id);


--
-- Name: index_bugs_eclipse_org_attachments_on_attacher; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_attacher ON bugs_eclipse_org_attachments USING btree (attacher);


--
-- Name: index_bugs_eclipse_org_attachments_on_attacher_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_attacher_name ON bugs_eclipse_org_attachments USING btree (attacher_name);


--
-- Name: index_bugs_eclipse_org_attachments_on_attachid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_attachments_on_attachid ON bugs_eclipse_org_attachments USING btree (attachid);


--
-- Name: index_bugs_eclipse_org_attachments_on_bug_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_bug_id ON bugs_eclipse_org_attachments USING btree (bug_id);


--
-- Name: index_bugs_eclipse_org_attachments_on_date; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_date ON bugs_eclipse_org_attachments USING btree (date);


--
-- Name: index_bugs_eclipse_org_attachments_on_delta_ts; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_delta_ts ON bugs_eclipse_org_attachments USING btree (delta_ts);


--
-- Name: index_bugs_eclipse_org_attachments_on_filename; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_filename ON bugs_eclipse_org_attachments USING btree (filename);


--
-- Name: index_bugs_eclipse_org_attachments_on_size; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_size ON bugs_eclipse_org_attachments USING btree (size);


--
-- Name: index_bugs_eclipse_org_attachments_on_submitter_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_submitter_id ON bugs_eclipse_org_attachments USING btree (submitter_id);


--
-- Name: index_bugs_eclipse_org_attachments_on_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_type ON bugs_eclipse_org_attachments USING btree (type);


--
-- Name: index_bugs_eclipse_org_bugs_on_assigned_to; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_assigned_to ON bugs_eclipse_org_bugs USING btree (assigned_to);


--
-- Name: index_bugs_eclipse_org_bugs_on_assigned_to_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_assigned_to_name ON bugs_eclipse_org_bugs USING btree (assigned_to_name);


--
-- Name: index_bugs_eclipse_org_bugs_on_assignee_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_assignee_id ON bugs_eclipse_org_bugs USING btree (assignee_id);


--
-- Name: index_bugs_eclipse_org_bugs_on_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_author_id ON bugs_eclipse_org_bugs USING btree (author_id);


--
-- Name: index_bugs_eclipse_org_bugs_on_bug_severity; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_bug_severity ON bugs_eclipse_org_bugs USING btree (bug_severity);


--
-- Name: index_bugs_eclipse_org_bugs_on_bug_status; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_bug_status ON bugs_eclipse_org_bugs USING btree (bug_status);


--
-- Name: index_bugs_eclipse_org_bugs_on_bugid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_bugs_on_bugid ON bugs_eclipse_org_bugs USING btree (bugid);


--
-- Name: index_bugs_eclipse_org_bugs_on_bugzilla_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_bugzilla_id ON bugs_eclipse_org_bugs USING btree (bugzilla_id);


--
-- Name: index_bugs_eclipse_org_bugs_on_classification; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_classification ON bugs_eclipse_org_bugs USING btree (classification);


--
-- Name: index_bugs_eclipse_org_bugs_on_classificationid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_classificationid ON bugs_eclipse_org_bugs USING btree (classificationid);


--
-- Name: index_bugs_eclipse_org_bugs_on_component; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_component ON bugs_eclipse_org_bugs USING btree (component);


--
-- Name: index_bugs_eclipse_org_bugs_on_creation_ts; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_creation_ts ON bugs_eclipse_org_bugs USING btree (creation_ts);


--
-- Name: index_bugs_eclipse_org_bugs_on_delta_ts; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_delta_ts ON bugs_eclipse_org_bugs USING btree (delta_ts);


--
-- Name: index_bugs_eclipse_org_bugs_on_everconfirmed; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_everconfirmed ON bugs_eclipse_org_bugs USING btree (everconfirmed);


--
-- Name: index_bugs_eclipse_org_bugs_on_op_sys; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_op_sys ON bugs_eclipse_org_bugs USING btree (op_sys);


--
-- Name: index_bugs_eclipse_org_bugs_on_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_priority ON bugs_eclipse_org_bugs USING btree (priority);


--
-- Name: index_bugs_eclipse_org_bugs_on_product; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_product ON bugs_eclipse_org_bugs USING btree (product);


--
-- Name: index_bugs_eclipse_org_bugs_on_rep_platform; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_rep_platform ON bugs_eclipse_org_bugs USING btree (rep_platform);


--
-- Name: index_bugs_eclipse_org_bugs_on_reporter; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_reporter ON bugs_eclipse_org_bugs USING btree (reporter);


--
-- Name: index_bugs_eclipse_org_bugs_on_reporter_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_reporter_name ON bugs_eclipse_org_bugs USING btree (reporter_name);


--
-- Name: index_bugs_eclipse_org_bugs_on_resolution; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_resolution ON bugs_eclipse_org_bugs USING btree (resolution);


--
-- Name: index_bugs_eclipse_org_bugs_on_target_milestone; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_target_milestone ON bugs_eclipse_org_bugs USING btree (target_milestone);


--
-- Name: index_bugs_eclipse_org_bugs_on_version; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_version ON bugs_eclipse_org_bugs USING btree (version);


--
-- Name: index_bugs_eclipse_org_bugs_on_votes; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_votes ON bugs_eclipse_org_bugs USING btree (votes);


--
-- Name: index_bugs_eclipse_org_bugzillas_on_maintainer; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugzillas_on_maintainer ON bugs_eclipse_org_bugzillas USING btree (maintainer);


--
-- Name: index_bugs_eclipse_org_bugzillas_on_urlbase; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_bugzillas_on_urlbase ON bugs_eclipse_org_bugzillas USING btree (urlbase);


--
-- Name: index_bugs_eclipse_org_bugzillas_on_version; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_bugzillas_on_version ON bugs_eclipse_org_bugzillas USING btree (version);


--
-- Name: index_bugs_eclipse_org_comments_on_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_comments_on_author_id ON bugs_eclipse_org_comments USING btree (author_id);


--
-- Name: index_bugs_eclipse_org_comments_on_bug_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_comments_on_bug_id ON bugs_eclipse_org_comments USING btree (bug_id);


--
-- Name: index_bugs_eclipse_org_comments_on_bug_when; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_comments_on_bug_when ON bugs_eclipse_org_comments USING btree (bug_when);


--
-- Name: index_bugs_eclipse_org_comments_on_commentid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_comments_on_commentid ON bugs_eclipse_org_comments USING btree (commentid);


--
-- Name: index_bugs_eclipse_org_comments_on_who; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_comments_on_who ON bugs_eclipse_org_comments USING btree (who);


--
-- Name: index_bugs_eclipse_org_comments_on_who_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_comments_on_who_name ON bugs_eclipse_org_comments USING btree (who_name);


--
-- Name: index_bugs_eclipse_org_interactions_on_attachment_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_attachment_id ON bugs_eclipse_org_interactions USING btree (attachment_id);


--
-- Name: index_bugs_eclipse_org_interactions_on_bug_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_bug_url ON bugs_eclipse_org_interactions USING btree (bug_url);


--
-- Name: index_bugs_eclipse_org_interactions_on_end_date; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_end_date ON bugs_eclipse_org_interactions USING btree (end_date);


--
-- Name: index_bugs_eclipse_org_interactions_on_kind; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_kind ON bugs_eclipse_org_interactions USING btree (kind);


--
-- Name: index_bugs_eclipse_org_interactions_on_originid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_originid ON bugs_eclipse_org_interactions USING btree (originid);


--
-- Name: index_bugs_eclipse_org_interactions_on_start_date; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_start_date ON bugs_eclipse_org_interactions USING btree (start_date);


--
-- Name: index_bugs_eclipse_org_interactions_on_structure_kind; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_structure_kind ON bugs_eclipse_org_interactions USING btree (structure_kind);


--
-- Name: index_bugs_eclipse_org_interactions_on_version; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_version ON bugs_eclipse_org_interactions USING btree (version);


--
-- Name: index_bugs_eclipse_org_users_on_login_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_users_on_login_name ON bugs_eclipse_org_users USING btree (login_name);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20151119035247');

INSERT INTO schema_migrations (version) VALUES ('20151119035252');

INSERT INTO schema_migrations (version) VALUES ('20151119035257');

INSERT INTO schema_migrations (version) VALUES ('20151119035307');

INSERT INTO schema_migrations (version) VALUES ('20151119035313');

INSERT INTO schema_migrations (version) VALUES ('20151119035321');

