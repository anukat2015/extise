--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: bugs_eclipse_org_attachments; Type: TABLE; Schema: public; Owner: -
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
    attacher_name character varying,
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
-- Name: bugs_eclipse_org_bugs; Type: TABLE; Schema: public; Owner: -
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
    reporter_name character varying,
    assigned_to character varying NOT NULL,
    assigned_to_name character varying,
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
-- Name: bugs_eclipse_org_bugzillas; Type: TABLE; Schema: public; Owner: -
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
-- Name: bugs_eclipse_org_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bugs_eclipse_org_comments (
    id integer NOT NULL,
    bug_id integer NOT NULL,
    author_id integer NOT NULL,
    commentid integer NOT NULL,
    comment_count integer NOT NULL,
    who character varying NOT NULL,
    who_name character varying,
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
-- Name: bugs_eclipse_org_interactions; Type: TABLE; Schema: public; Owner: -
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
    structure_kind character varying,
    structure_handle character varying(1024),
    navigation character varying,
    delta character varying,
    interest numeric(20,12) NOT NULL,
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
-- Name: bugs_eclipse_org_users; Type: TABLE; Schema: public; Owner: -
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
-- Name: extisimo_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_attachments (
    id integer NOT NULL,
    task_id integer NOT NULL,
    author_id integer NOT NULL,
    file character varying(2048) NOT NULL,
    type character varying NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_at timestamp without time zone NOT NULL,
    modified_at timestamp without time zone NOT NULL,
    bugs_eclipse_org_attachment_id integer NOT NULL
);


--
-- Name: extisimo_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_attachments_id_seq OWNED BY extisimo_attachments.id;


--
-- Name: extisimo_commits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_commits (
    id integer NOT NULL,
    repository_id integer NOT NULL,
    author_id integer NOT NULL,
    identifier character varying(40) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_commits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_commits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_commits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_commits_id_seq OWNED BY extisimo_commits.id;


--
-- Name: extisimo_concepts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_concepts (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_concepts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_concepts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_concepts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_concepts_id_seq OWNED BY extisimo_concepts.id;


--
-- Name: extisimo_conceptualities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_conceptualities (
    id integer NOT NULL,
    inferencer_id integer NOT NULL,
    subject_type character varying NOT NULL,
    subject_id integer NOT NULL,
    concept_id integer NOT NULL,
    inferencer_data json NOT NULL,
    probability numeric(9,8) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_conceptualities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_conceptualities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_conceptualities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_conceptualities_id_seq OWNED BY extisimo_conceptualities.id;


--
-- Name: extisimo_elements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_elements (
    id integer NOT NULL,
    commit_id integer NOT NULL,
    file character varying(2048) NOT NULL,
    path character varying(2048) NOT NULL,
    "offset" integer NOT NULL,
    length integer NOT NULL,
    line integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_elements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_elements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_elements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_elements_id_seq OWNED BY extisimo_elements.id;


--
-- Name: extisimo_expertises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_expertises (
    id integer NOT NULL,
    metric_id integer NOT NULL,
    subject_type character varying NOT NULL,
    subject_id integer NOT NULL,
    user_id integer NOT NULL,
    metric_data json NOT NULL,
    value numeric(9,8) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_expertises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_expertises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_expertises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_expertises_id_seq OWNED BY extisimo_expertises.id;


--
-- Name: extisimo_inferencers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_inferencers (
    id integer NOT NULL,
    target character varying NOT NULL,
    name character varying NOT NULL,
    file character varying NOT NULL,
    type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_inferencers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_inferencers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_inferencers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_inferencers_id_seq OWNED BY extisimo_inferencers.id;


--
-- Name: extisimo_interactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_interactions (
    id integer NOT NULL,
    attachment_id integer NOT NULL,
    session_id integer NOT NULL,
    kind character varying NOT NULL,
    file character varying(2048) NOT NULL,
    path character varying(2048) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone NOT NULL,
    finished_at timestamp without time zone NOT NULL,
    bugs_eclipse_org_interaction_id integer NOT NULL
);


--
-- Name: extisimo_interactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_interactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_interactions_id_seq OWNED BY extisimo_interactions.id;


--
-- Name: extisimo_metrics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_metrics (
    id integer NOT NULL,
    target character varying NOT NULL,
    name character varying NOT NULL,
    file character varying NOT NULL,
    type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_metrics_id_seq OWNED BY extisimo_metrics.id;


--
-- Name: extisimo_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_posts (
    id integer NOT NULL,
    task_id integer NOT NULL,
    author_id integer NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_at timestamp without time zone NOT NULL,
    modified_at timestamp without time zone NOT NULL,
    bugs_eclipse_org_comment_id integer NOT NULL
);


--
-- Name: extisimo_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_posts_id_seq OWNED BY extisimo_posts.id;


--
-- Name: extisimo_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_projects (
    id integer NOT NULL,
    product character varying NOT NULL,
    component character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_projects_id_seq OWNED BY extisimo_projects.id;


--
-- Name: extisimo_repositories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_repositories (
    id integer NOT NULL,
    project_id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    git_eclipse_org_project_id integer
);


--
-- Name: extisimo_repositories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_repositories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_repositories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_repositories_id_seq OWNED BY extisimo_repositories.id;


--
-- Name: extisimo_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_sessions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    previous_commit_id integer NOT NULL,
    revision_commit_id integer NOT NULL,
    previous_identifier character varying(40) NOT NULL,
    revision_identifier character varying(40) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone NOT NULL,
    finished_at timestamp without time zone NOT NULL
);


--
-- Name: extisimo_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_sessions_id_seq OWNED BY extisimo_sessions.id;


--
-- Name: extisimo_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_tasks (
    id integer NOT NULL,
    reporter_id integer NOT NULL,
    assignee_id integer NOT NULL,
    project_id integer NOT NULL,
    classification character varying NOT NULL,
    description text NOT NULL,
    status character varying NOT NULL,
    resolution character varying,
    severity character varying NOT NULL,
    priority character varying NOT NULL,
    platform character varying NOT NULL,
    operating_system character varying NOT NULL,
    project_version character varying,
    project_milestone character varying,
    cc character varying[] NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_at timestamp without time zone NOT NULL,
    modified_at timestamp without time zone NOT NULL,
    bugs_eclipse_org_bug_id integer NOT NULL,
    git_eclipse_org_change_id integer
);


--
-- Name: extisimo_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_tasks_id_seq OWNED BY extisimo_tasks.id;


--
-- Name: extisimo_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE extisimo_users (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    bugs_eclipse_org_user_id integer NOT NULL,
    git_eclipse_org_user_id integer
);


--
-- Name: extisimo_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE extisimo_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extisimo_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE extisimo_users_id_seq OWNED BY extisimo_users.id;


--
-- Name: git_eclipse_org_changes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE git_eclipse_org_changes (
    id integer NOT NULL,
    project_id integer NOT NULL,
    owner_id integer NOT NULL,
    changeid integer NOT NULL,
    status character varying NOT NULL,
    commit_identifier character varying(40) NOT NULL,
    change_identifier character varying(40) NOT NULL,
    history_size integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: git_eclipse_org_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE git_eclipse_org_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: git_eclipse_org_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE git_eclipse_org_changes_id_seq OWNED BY git_eclipse_org_changes.id;


--
-- Name: git_eclipse_org_labels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE git_eclipse_org_labels (
    id integer NOT NULL,
    change_id integer NOT NULL,
    key character varying NOT NULL,
    value character varying NOT NULL,
    names character varying[] NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: git_eclipse_org_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE git_eclipse_org_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: git_eclipse_org_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE git_eclipse_org_labels_id_seq OWNED BY git_eclipse_org_labels.id;


--
-- Name: git_eclipse_org_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE git_eclipse_org_projects (
    id integer NOT NULL,
    parent character varying NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: git_eclipse_org_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE git_eclipse_org_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: git_eclipse_org_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE git_eclipse_org_projects_id_seq OWNED BY git_eclipse_org_projects.id;


--
-- Name: git_eclipse_org_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE git_eclipse_org_reviews (
    id integer NOT NULL,
    change_id integer NOT NULL,
    reviewer_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: git_eclipse_org_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE git_eclipse_org_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: git_eclipse_org_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE git_eclipse_org_reviews_id_seq OWNED BY git_eclipse_org_reviews.id;


--
-- Name: git_eclipse_org_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE git_eclipse_org_users (
    id integer NOT NULL,
    name character varying NOT NULL,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: git_eclipse_org_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE git_eclipse_org_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: git_eclipse_org_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE git_eclipse_org_users_id_seq OWNED BY git_eclipse_org_users.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
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
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_attachments ALTER COLUMN id SET DEFAULT nextval('extisimo_attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_commits ALTER COLUMN id SET DEFAULT nextval('extisimo_commits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_concepts ALTER COLUMN id SET DEFAULT nextval('extisimo_concepts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_conceptualities ALTER COLUMN id SET DEFAULT nextval('extisimo_conceptualities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_elements ALTER COLUMN id SET DEFAULT nextval('extisimo_elements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_expertises ALTER COLUMN id SET DEFAULT nextval('extisimo_expertises_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_inferencers ALTER COLUMN id SET DEFAULT nextval('extisimo_inferencers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_interactions ALTER COLUMN id SET DEFAULT nextval('extisimo_interactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_metrics ALTER COLUMN id SET DEFAULT nextval('extisimo_metrics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_posts ALTER COLUMN id SET DEFAULT nextval('extisimo_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_projects ALTER COLUMN id SET DEFAULT nextval('extisimo_projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_repositories ALTER COLUMN id SET DEFAULT nextval('extisimo_repositories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_sessions ALTER COLUMN id SET DEFAULT nextval('extisimo_sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_tasks ALTER COLUMN id SET DEFAULT nextval('extisimo_tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_users ALTER COLUMN id SET DEFAULT nextval('extisimo_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_changes ALTER COLUMN id SET DEFAULT nextval('git_eclipse_org_changes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_labels ALTER COLUMN id SET DEFAULT nextval('git_eclipse_org_labels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_projects ALTER COLUMN id SET DEFAULT nextval('git_eclipse_org_projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_reviews ALTER COLUMN id SET DEFAULT nextval('git_eclipse_org_reviews_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_users ALTER COLUMN id SET DEFAULT nextval('git_eclipse_org_users_id_seq'::regclass);


--
-- Name: bugs_eclipse_org_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_attachments
    ADD CONSTRAINT bugs_eclipse_org_attachments_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_bugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_bugs
    ADD CONSTRAINT bugs_eclipse_org_bugs_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_bugzillas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_bugzillas
    ADD CONSTRAINT bugs_eclipse_org_bugzillas_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_comments
    ADD CONSTRAINT bugs_eclipse_org_comments_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_interactions
    ADD CONSTRAINT bugs_eclipse_org_interactions_pkey PRIMARY KEY (id);


--
-- Name: bugs_eclipse_org_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bugs_eclipse_org_users
    ADD CONSTRAINT bugs_eclipse_org_users_pkey PRIMARY KEY (id);


--
-- Name: extisimo_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_attachments
    ADD CONSTRAINT extisimo_attachments_pkey PRIMARY KEY (id);


--
-- Name: extisimo_commits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_commits
    ADD CONSTRAINT extisimo_commits_pkey PRIMARY KEY (id);


--
-- Name: extisimo_concepts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_concepts
    ADD CONSTRAINT extisimo_concepts_pkey PRIMARY KEY (id);


--
-- Name: extisimo_conceptualities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_conceptualities
    ADD CONSTRAINT extisimo_conceptualities_pkey PRIMARY KEY (id);


--
-- Name: extisimo_elements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_elements
    ADD CONSTRAINT extisimo_elements_pkey PRIMARY KEY (id);


--
-- Name: extisimo_expertises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_expertises
    ADD CONSTRAINT extisimo_expertises_pkey PRIMARY KEY (id);


--
-- Name: extisimo_inferencers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_inferencers
    ADD CONSTRAINT extisimo_inferencers_pkey PRIMARY KEY (id);


--
-- Name: extisimo_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_interactions
    ADD CONSTRAINT extisimo_interactions_pkey PRIMARY KEY (id);


--
-- Name: extisimo_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_metrics
    ADD CONSTRAINT extisimo_metrics_pkey PRIMARY KEY (id);


--
-- Name: extisimo_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_posts
    ADD CONSTRAINT extisimo_posts_pkey PRIMARY KEY (id);


--
-- Name: extisimo_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_projects
    ADD CONSTRAINT extisimo_projects_pkey PRIMARY KEY (id);


--
-- Name: extisimo_repositories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_repositories
    ADD CONSTRAINT extisimo_repositories_pkey PRIMARY KEY (id);


--
-- Name: extisimo_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_sessions
    ADD CONSTRAINT extisimo_sessions_pkey PRIMARY KEY (id);


--
-- Name: extisimo_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_tasks
    ADD CONSTRAINT extisimo_tasks_pkey PRIMARY KEY (id);


--
-- Name: extisimo_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY extisimo_users
    ADD CONSTRAINT extisimo_users_pkey PRIMARY KEY (id);


--
-- Name: git_eclipse_org_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_changes
    ADD CONSTRAINT git_eclipse_org_changes_pkey PRIMARY KEY (id);


--
-- Name: git_eclipse_org_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_labels
    ADD CONSTRAINT git_eclipse_org_labels_pkey PRIMARY KEY (id);


--
-- Name: git_eclipse_org_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_projects
    ADD CONSTRAINT git_eclipse_org_projects_pkey PRIMARY KEY (id);


--
-- Name: git_eclipse_org_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_reviews
    ADD CONSTRAINT git_eclipse_org_reviews_pkey PRIMARY KEY (id);


--
-- Name: git_eclipse_org_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_eclipse_org_users
    ADD CONSTRAINT git_eclipse_org_users_pkey PRIMARY KEY (id);


--
-- Name: index_bugs_eclipse_org_attachments_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_attachments_as_unique ON bugs_eclipse_org_attachments USING btree (attachid);


--
-- Name: index_bugs_eclipse_org_attachments_on_attacher; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_attacher ON bugs_eclipse_org_attachments USING btree (attacher);


--
-- Name: index_bugs_eclipse_org_attachments_on_attacher_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_attacher_name ON bugs_eclipse_org_attachments USING btree (attacher_name);


--
-- Name: index_bugs_eclipse_org_attachments_on_bug_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_bug_id ON bugs_eclipse_org_attachments USING btree (bug_id);


--
-- Name: index_bugs_eclipse_org_attachments_on_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_date ON bugs_eclipse_org_attachments USING btree (date);


--
-- Name: index_bugs_eclipse_org_attachments_on_delta_ts; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_delta_ts ON bugs_eclipse_org_attachments USING btree (delta_ts);


--
-- Name: index_bugs_eclipse_org_attachments_on_filename; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_filename ON bugs_eclipse_org_attachments USING btree (filename);


--
-- Name: index_bugs_eclipse_org_attachments_on_size; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_size ON bugs_eclipse_org_attachments USING btree (size);


--
-- Name: index_bugs_eclipse_org_attachments_on_submitter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_submitter_id ON bugs_eclipse_org_attachments USING btree (submitter_id);


--
-- Name: index_bugs_eclipse_org_attachments_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_attachments_on_type ON bugs_eclipse_org_attachments USING btree (type);


--
-- Name: index_bugs_eclipse_org_bugs_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_bugs_as_unique ON bugs_eclipse_org_bugs USING btree (bugid);


--
-- Name: index_bugs_eclipse_org_bugs_on_assigned_to; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_assigned_to ON bugs_eclipse_org_bugs USING btree (assigned_to);


--
-- Name: index_bugs_eclipse_org_bugs_on_assigned_to_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_assigned_to_name ON bugs_eclipse_org_bugs USING btree (assigned_to_name);


--
-- Name: index_bugs_eclipse_org_bugs_on_assignee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_assignee_id ON bugs_eclipse_org_bugs USING btree (assignee_id);


--
-- Name: index_bugs_eclipse_org_bugs_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_author_id ON bugs_eclipse_org_bugs USING btree (author_id);


--
-- Name: index_bugs_eclipse_org_bugs_on_bug_severity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_bug_severity ON bugs_eclipse_org_bugs USING btree (bug_severity);


--
-- Name: index_bugs_eclipse_org_bugs_on_bug_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_bug_status ON bugs_eclipse_org_bugs USING btree (bug_status);


--
-- Name: index_bugs_eclipse_org_bugs_on_bugzilla_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_bugzilla_id ON bugs_eclipse_org_bugs USING btree (bugzilla_id);


--
-- Name: index_bugs_eclipse_org_bugs_on_classification; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_classification ON bugs_eclipse_org_bugs USING btree (classification);


--
-- Name: index_bugs_eclipse_org_bugs_on_classificationid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_classificationid ON bugs_eclipse_org_bugs USING btree (classificationid);


--
-- Name: index_bugs_eclipse_org_bugs_on_component; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_component ON bugs_eclipse_org_bugs USING btree (component);


--
-- Name: index_bugs_eclipse_org_bugs_on_creation_ts; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_creation_ts ON bugs_eclipse_org_bugs USING btree (creation_ts);


--
-- Name: index_bugs_eclipse_org_bugs_on_delta_ts; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_delta_ts ON bugs_eclipse_org_bugs USING btree (delta_ts);


--
-- Name: index_bugs_eclipse_org_bugs_on_everconfirmed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_everconfirmed ON bugs_eclipse_org_bugs USING btree (everconfirmed);


--
-- Name: index_bugs_eclipse_org_bugs_on_op_sys; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_op_sys ON bugs_eclipse_org_bugs USING btree (op_sys);


--
-- Name: index_bugs_eclipse_org_bugs_on_priority; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_priority ON bugs_eclipse_org_bugs USING btree (priority);


--
-- Name: index_bugs_eclipse_org_bugs_on_product; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_product ON bugs_eclipse_org_bugs USING btree (product);


--
-- Name: index_bugs_eclipse_org_bugs_on_rep_platform; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_rep_platform ON bugs_eclipse_org_bugs USING btree (rep_platform);


--
-- Name: index_bugs_eclipse_org_bugs_on_reporter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_reporter ON bugs_eclipse_org_bugs USING btree (reporter);


--
-- Name: index_bugs_eclipse_org_bugs_on_reporter_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_reporter_name ON bugs_eclipse_org_bugs USING btree (reporter_name);


--
-- Name: index_bugs_eclipse_org_bugs_on_resolution; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_resolution ON bugs_eclipse_org_bugs USING btree (resolution);


--
-- Name: index_bugs_eclipse_org_bugs_on_target_milestone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_target_milestone ON bugs_eclipse_org_bugs USING btree (target_milestone);


--
-- Name: index_bugs_eclipse_org_bugs_on_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_version ON bugs_eclipse_org_bugs USING btree (version);


--
-- Name: index_bugs_eclipse_org_bugs_on_votes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugs_on_votes ON bugs_eclipse_org_bugs USING btree (votes);


--
-- Name: index_bugs_eclipse_org_bugzillas_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_bugzillas_as_unique ON bugs_eclipse_org_bugzillas USING btree (urlbase);


--
-- Name: index_bugs_eclipse_org_bugzillas_on_maintainer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugzillas_on_maintainer ON bugs_eclipse_org_bugzillas USING btree (maintainer);


--
-- Name: index_bugs_eclipse_org_bugzillas_on_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_bugzillas_on_version ON bugs_eclipse_org_bugzillas USING btree (version);


--
-- Name: index_bugs_eclipse_org_comments_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_comments_as_unique ON bugs_eclipse_org_comments USING btree (commentid);


--
-- Name: index_bugs_eclipse_org_comments_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_comments_on_author_id ON bugs_eclipse_org_comments USING btree (author_id);


--
-- Name: index_bugs_eclipse_org_comments_on_bug_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_comments_on_bug_id ON bugs_eclipse_org_comments USING btree (bug_id);


--
-- Name: index_bugs_eclipse_org_comments_on_bug_when; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_comments_on_bug_when ON bugs_eclipse_org_comments USING btree (bug_when);


--
-- Name: index_bugs_eclipse_org_comments_on_who; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_comments_on_who ON bugs_eclipse_org_comments USING btree (who);


--
-- Name: index_bugs_eclipse_org_comments_on_who_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_comments_on_who_name ON bugs_eclipse_org_comments USING btree (who_name);


--
-- Name: index_bugs_eclipse_org_interactions_on_attachment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_attachment_id ON bugs_eclipse_org_interactions USING btree (attachment_id);


--
-- Name: index_bugs_eclipse_org_interactions_on_bug_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_bug_url ON bugs_eclipse_org_interactions USING btree (bug_url);


--
-- Name: index_bugs_eclipse_org_interactions_on_end_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_end_date ON bugs_eclipse_org_interactions USING btree (end_date);


--
-- Name: index_bugs_eclipse_org_interactions_on_kind; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_kind ON bugs_eclipse_org_interactions USING btree (kind);


--
-- Name: index_bugs_eclipse_org_interactions_on_originid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_originid ON bugs_eclipse_org_interactions USING btree (originid);


--
-- Name: index_bugs_eclipse_org_interactions_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_start_date ON bugs_eclipse_org_interactions USING btree (start_date);


--
-- Name: index_bugs_eclipse_org_interactions_on_structure_kind; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_structure_kind ON bugs_eclipse_org_interactions USING btree (structure_kind);


--
-- Name: index_bugs_eclipse_org_interactions_on_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bugs_eclipse_org_interactions_on_version ON bugs_eclipse_org_interactions USING btree (version);


--
-- Name: index_bugs_eclipse_org_users_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bugs_eclipse_org_users_as_unique ON bugs_eclipse_org_users USING btree (login_name);


--
-- Name: index_extisimo_attachments_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_attachments_as_unique ON extisimo_attachments USING btree (submitted_at, author_id, task_id);


--
-- Name: index_extisimo_attachments_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_attachments_on_author_id ON extisimo_attachments USING btree (author_id);


--
-- Name: index_extisimo_attachments_on_bugs_eclipse_org_attachment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_attachments_on_bugs_eclipse_org_attachment_id ON extisimo_attachments USING btree (bugs_eclipse_org_attachment_id);


--
-- Name: index_extisimo_attachments_on_file; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_attachments_on_file ON extisimo_attachments USING btree (file);


--
-- Name: index_extisimo_attachments_on_modified_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_attachments_on_modified_at ON extisimo_attachments USING btree (modified_at);


--
-- Name: index_extisimo_attachments_on_submitted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_attachments_on_submitted_at ON extisimo_attachments USING btree (submitted_at);


--
-- Name: index_extisimo_attachments_on_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_attachments_on_task_id ON extisimo_attachments USING btree (task_id);


--
-- Name: index_extisimo_attachments_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_attachments_on_type ON extisimo_attachments USING btree (type);


--
-- Name: index_extisimo_commits_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_commits_as_unique ON extisimo_commits USING btree (repository_id, identifier);


--
-- Name: index_extisimo_commits_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_commits_on_author_id ON extisimo_commits USING btree (author_id);


--
-- Name: index_extisimo_commits_on_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_commits_on_identifier ON extisimo_commits USING btree (identifier);


--
-- Name: index_extisimo_commits_on_repository_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_commits_on_repository_id ON extisimo_commits USING btree (repository_id);


--
-- Name: index_extisimo_commits_on_submitted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_commits_on_submitted_at ON extisimo_commits USING btree (submitted_at);


--
-- Name: index_extisimo_conceptualities_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_conceptualities_as_unique ON extisimo_conceptualities USING btree (concept_id, subject_id, subject_type, inferencer_id);


--
-- Name: index_extisimo_conceptualities_on_concept_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_conceptualities_on_concept_id ON extisimo_conceptualities USING btree (concept_id);


--
-- Name: index_extisimo_conceptualities_on_inferencer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_conceptualities_on_inferencer_id ON extisimo_conceptualities USING btree (inferencer_id);


--
-- Name: index_extisimo_conceptualities_on_probability; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_conceptualities_on_probability ON extisimo_conceptualities USING btree (probability);


--
-- Name: index_extisimo_conceptualities_on_subject_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_conceptualities_on_subject_id ON extisimo_conceptualities USING btree (subject_id);


--
-- Name: index_extisimo_conceptualities_on_subject_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_conceptualities_on_subject_type ON extisimo_conceptualities USING btree (subject_type);


--
-- Name: index_extisimo_elements_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_elements_as_unique ON extisimo_elements USING btree (commit_id, file, path);


--
-- Name: index_extisimo_elements_on_commit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_elements_on_commit_id ON extisimo_elements USING btree (commit_id);


--
-- Name: index_extisimo_elements_on_file; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_elements_on_file ON extisimo_elements USING btree (file);


--
-- Name: index_extisimo_elements_on_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_elements_on_path ON extisimo_elements USING btree (path);


--
-- Name: index_extisimo_expertises_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_expertises_as_unique ON extisimo_expertises USING btree (user_id, subject_id, subject_type, metric_id);


--
-- Name: index_extisimo_expertises_on_metric_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_expertises_on_metric_id ON extisimo_expertises USING btree (metric_id);


--
-- Name: index_extisimo_expertises_on_subject_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_expertises_on_subject_id ON extisimo_expertises USING btree (subject_id);


--
-- Name: index_extisimo_expertises_on_subject_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_expertises_on_subject_type ON extisimo_expertises USING btree (subject_type);


--
-- Name: index_extisimo_expertises_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_expertises_on_user_id ON extisimo_expertises USING btree (user_id);


--
-- Name: index_extisimo_expertises_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_expertises_on_value ON extisimo_expertises USING btree (value);


--
-- Name: index_extisimo_inferencers_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_inferencers_as_unique ON extisimo_inferencers USING btree (target, name);


--
-- Name: index_extisimo_inferencers_on_file; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_inferencers_on_file ON extisimo_inferencers USING btree (file);


--
-- Name: index_extisimo_inferencers_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_inferencers_on_name ON extisimo_inferencers USING btree (name);


--
-- Name: index_extisimo_inferencers_on_target; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_inferencers_on_target ON extisimo_inferencers USING btree (target);


--
-- Name: index_extisimo_inferencers_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_inferencers_on_type ON extisimo_inferencers USING btree (type);


--
-- Name: index_extisimo_interactions_on_attachment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_interactions_on_attachment_id ON extisimo_interactions USING btree (attachment_id);


--
-- Name: index_extisimo_interactions_on_bugs_eclipse_org_interaction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_interactions_on_bugs_eclipse_org_interaction_id ON extisimo_interactions USING btree (bugs_eclipse_org_interaction_id);


--
-- Name: index_extisimo_interactions_on_file; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_interactions_on_file ON extisimo_interactions USING btree (file);


--
-- Name: index_extisimo_interactions_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_interactions_on_finished_at ON extisimo_interactions USING btree (finished_at);


--
-- Name: index_extisimo_interactions_on_kind; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_interactions_on_kind ON extisimo_interactions USING btree (kind);


--
-- Name: index_extisimo_interactions_on_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_interactions_on_path ON extisimo_interactions USING btree (path);


--
-- Name: index_extisimo_interactions_on_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_interactions_on_session_id ON extisimo_interactions USING btree (session_id);


--
-- Name: index_extisimo_interactions_on_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_interactions_on_started_at ON extisimo_interactions USING btree (started_at);


--
-- Name: index_extisimo_metrics_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_metrics_as_unique ON extisimo_metrics USING btree (target, name);


--
-- Name: index_extisimo_metrics_on_file; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_metrics_on_file ON extisimo_metrics USING btree (file);


--
-- Name: index_extisimo_metrics_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_metrics_on_name ON extisimo_metrics USING btree (name);


--
-- Name: index_extisimo_metrics_on_target; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_metrics_on_target ON extisimo_metrics USING btree (target);


--
-- Name: index_extisimo_metrics_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_metrics_on_type ON extisimo_metrics USING btree (type);


--
-- Name: index_extisimo_name_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_name_as_unique ON extisimo_concepts USING btree (name);


--
-- Name: index_extisimo_posts_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_posts_as_unique ON extisimo_posts USING btree (submitted_at, author_id, task_id);


--
-- Name: index_extisimo_posts_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_posts_on_author_id ON extisimo_posts USING btree (author_id);


--
-- Name: index_extisimo_posts_on_bugs_eclipse_org_comment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_posts_on_bugs_eclipse_org_comment_id ON extisimo_posts USING btree (bugs_eclipse_org_comment_id);


--
-- Name: index_extisimo_posts_on_modified_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_posts_on_modified_at ON extisimo_posts USING btree (modified_at);


--
-- Name: index_extisimo_posts_on_submitted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_posts_on_submitted_at ON extisimo_posts USING btree (submitted_at);


--
-- Name: index_extisimo_posts_on_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_posts_on_task_id ON extisimo_posts USING btree (task_id);


--
-- Name: index_extisimo_projects_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_projects_as_unique ON extisimo_projects USING btree (product, component);


--
-- Name: index_extisimo_projects_on_component; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_projects_on_component ON extisimo_projects USING btree (component);


--
-- Name: index_extisimo_projects_on_product; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_projects_on_product ON extisimo_projects USING btree (product);


--
-- Name: index_extisimo_repositories_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_repositories_as_unique ON extisimo_repositories USING btree (name);


--
-- Name: index_extisimo_repositories_on_git_eclipse_org_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_repositories_on_git_eclipse_org_project_id ON extisimo_repositories USING btree (git_eclipse_org_project_id);


--
-- Name: index_extisimo_repositories_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_repositories_on_project_id ON extisimo_repositories USING btree (project_id);


--
-- Name: index_extisimo_sessions_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_sessions_as_unique ON extisimo_sessions USING btree (revision_commit_id, user_id);


--
-- Name: index_extisimo_sessions_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_sessions_on_finished_at ON extisimo_sessions USING btree (finished_at);


--
-- Name: index_extisimo_sessions_on_previous_commit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_sessions_on_previous_commit_id ON extisimo_sessions USING btree (previous_commit_id);


--
-- Name: index_extisimo_sessions_on_previous_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_sessions_on_previous_identifier ON extisimo_sessions USING btree (previous_identifier);


--
-- Name: index_extisimo_sessions_on_revision_commit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_sessions_on_revision_commit_id ON extisimo_sessions USING btree (revision_commit_id);


--
-- Name: index_extisimo_sessions_on_revision_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_sessions_on_revision_identifier ON extisimo_sessions USING btree (revision_identifier);


--
-- Name: index_extisimo_sessions_on_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_sessions_on_started_at ON extisimo_sessions USING btree (started_at);


--
-- Name: index_extisimo_sessions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_sessions_on_user_id ON extisimo_sessions USING btree (user_id);


--
-- Name: index_extisimo_tasks_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_tasks_as_unique ON extisimo_tasks USING btree (submitted_at, reporter_id);


--
-- Name: index_extisimo_tasks_on_bugs_eclipse_org_bug_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_tasks_on_bugs_eclipse_org_bug_id ON extisimo_tasks USING btree (bugs_eclipse_org_bug_id);


--
-- Name: index_extisimo_tasks_on_classification; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_tasks_on_classification ON extisimo_tasks USING btree (classification);


--
-- Name: index_extisimo_tasks_on_git_eclipse_org_change_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_tasks_on_git_eclipse_org_change_id ON extisimo_tasks USING btree (git_eclipse_org_change_id);


--
-- Name: index_extisimo_tasks_on_modified_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_tasks_on_modified_at ON extisimo_tasks USING btree (modified_at);


--
-- Name: index_extisimo_tasks_on_priority; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_tasks_on_priority ON extisimo_tasks USING btree (priority);


--
-- Name: index_extisimo_tasks_on_resolution; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_tasks_on_resolution ON extisimo_tasks USING btree (resolution);


--
-- Name: index_extisimo_tasks_on_severity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_tasks_on_severity ON extisimo_tasks USING btree (severity);


--
-- Name: index_extisimo_tasks_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_tasks_on_status ON extisimo_tasks USING btree (status);


--
-- Name: index_extisimo_tasks_on_submitted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_extisimo_tasks_on_submitted_at ON extisimo_tasks USING btree (submitted_at);


--
-- Name: index_extisimo_users_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_users_as_unique ON extisimo_users USING btree (name);


--
-- Name: index_extisimo_users_on_bugs_eclipse_org_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_users_on_bugs_eclipse_org_user_id ON extisimo_users USING btree (bugs_eclipse_org_user_id);


--
-- Name: index_extisimo_users_on_git_eclipse_org_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_extisimo_users_on_git_eclipse_org_user_id ON extisimo_users USING btree (git_eclipse_org_user_id);


--
-- Name: index_git_eclipse_org_changes_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_git_eclipse_org_changes_as_unique ON git_eclipse_org_changes USING btree (changeid);


--
-- Name: index_git_eclipse_org_changes_on_change_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_changes_on_change_identifier ON git_eclipse_org_changes USING btree (change_identifier);


--
-- Name: index_git_eclipse_org_changes_on_commit_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_changes_on_commit_identifier ON git_eclipse_org_changes USING btree (commit_identifier);


--
-- Name: index_git_eclipse_org_changes_on_history_size; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_changes_on_history_size ON git_eclipse_org_changes USING btree (history_size);


--
-- Name: index_git_eclipse_org_changes_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_changes_on_owner_id ON git_eclipse_org_changes USING btree (owner_id);


--
-- Name: index_git_eclipse_org_changes_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_changes_on_project_id ON git_eclipse_org_changes USING btree (project_id);


--
-- Name: index_git_eclipse_org_changes_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_changes_on_status ON git_eclipse_org_changes USING btree (status);


--
-- Name: index_git_eclipse_org_labels_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_git_eclipse_org_labels_as_unique ON git_eclipse_org_labels USING btree (change_id, key);


--
-- Name: index_git_eclipse_org_labels_on_change_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_labels_on_change_id ON git_eclipse_org_labels USING btree (change_id);


--
-- Name: index_git_eclipse_org_labels_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_labels_on_key ON git_eclipse_org_labels USING btree (key);


--
-- Name: index_git_eclipse_org_projects_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_git_eclipse_org_projects_as_unique ON git_eclipse_org_projects USING btree (name);


--
-- Name: index_git_eclipse_org_projects_on_parent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_projects_on_parent ON git_eclipse_org_projects USING btree (parent);


--
-- Name: index_git_eclipse_org_reviews_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_git_eclipse_org_reviews_as_unique ON git_eclipse_org_reviews USING btree (change_id, reviewer_id);


--
-- Name: index_git_eclipse_org_reviews_on_change_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_reviews_on_change_id ON git_eclipse_org_reviews USING btree (change_id);


--
-- Name: index_git_eclipse_org_reviews_on_reviewer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_reviews_on_reviewer_id ON git_eclipse_org_reviews USING btree (reviewer_id);


--
-- Name: index_git_eclipse_org_users_as_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_git_eclipse_org_users_as_unique ON git_eclipse_org_users USING btree (name);


--
-- Name: index_git_eclipse_org_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_git_eclipse_org_users_on_email ON git_eclipse_org_users USING btree (email);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20151119035247');

INSERT INTO schema_migrations (version) VALUES ('20151119035252');

INSERT INTO schema_migrations (version) VALUES ('20151119035257');

INSERT INTO schema_migrations (version) VALUES ('20151119035307');

INSERT INTO schema_migrations (version) VALUES ('20151119035313');

INSERT INTO schema_migrations (version) VALUES ('20151119035321');

INSERT INTO schema_migrations (version) VALUES ('20151201164319');

INSERT INTO schema_migrations (version) VALUES ('20151201164329');

INSERT INTO schema_migrations (version) VALUES ('20151201164357');

INSERT INTO schema_migrations (version) VALUES ('20151201164409');

INSERT INTO schema_migrations (version) VALUES ('20151201164416');

INSERT INTO schema_migrations (version) VALUES ('20151214141051');

INSERT INTO schema_migrations (version) VALUES ('20151214141150');

INSERT INTO schema_migrations (version) VALUES ('20151214141155');

INSERT INTO schema_migrations (version) VALUES ('20151214141203');

INSERT INTO schema_migrations (version) VALUES ('20151214141208');

INSERT INTO schema_migrations (version) VALUES ('20151214141224');

INSERT INTO schema_migrations (version) VALUES ('20151214141226');

INSERT INTO schema_migrations (version) VALUES ('20151214141311');

INSERT INTO schema_migrations (version) VALUES ('20151214141321');

INSERT INTO schema_migrations (version) VALUES ('20151214141326');

INSERT INTO schema_migrations (version) VALUES ('20151214141339');

INSERT INTO schema_migrations (version) VALUES ('20151214141341');

INSERT INTO schema_migrations (version) VALUES ('20151214141344');

INSERT INTO schema_migrations (version) VALUES ('20151214142907');

INSERT INTO schema_migrations (version) VALUES ('20151214142912');

INSERT INTO schema_migrations (version) VALUES ('20151214143150');

