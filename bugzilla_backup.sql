--
-- PostgreSQL database dump
--

-- Dumped from database version 10.21 (Debian 10.21-1.pgdg90+1)
-- Dumped by pg_dump version 10.21 (Debian 10.21-1.pgdg90+1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: anyarray_uniq(anyarray); Type: FUNCTION; Schema: public; Owner: bugs
--

CREATE FUNCTION public.anyarray_uniq(with_array anyarray) RETURNS anyarray
    LANGUAGE plpgsql
    AS $$
            DECLARE
                -- The variable used to track iteration over "with_array".
                loop_offset integer;

                -- The array to be returned by this function.
                return_array with_array%TYPE := '{}';
            BEGIN
                IF with_array IS NULL THEN
                    return NULL;
                END IF;

                -- Iterate over each element in "concat_array".
                FOR loop_offset IN ARRAY_LOWER(with_array, 1)..ARRAY_UPPER(with_array, 1) LOOP
                    IF NOT with_array[loop_offset] = ANY(return_array) THEN
                        return_array = ARRAY_APPEND(return_array, with_array[loop_offset]);
                    END IF;
                END LOOP;

                RETURN return_array;
            END;
            $$;


ALTER FUNCTION public.anyarray_uniq(with_array anyarray) OWNER TO bugs;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: attach_data; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.attach_data (
    id integer NOT NULL,
    thedata bytea NOT NULL
);


ALTER TABLE public.attach_data OWNER TO bugs;

--
-- Name: attachments; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.attachments (
    attach_id integer NOT NULL,
    bug_id integer NOT NULL,
    creation_ts timestamp(0) without time zone NOT NULL,
    modification_time timestamp(0) without time zone NOT NULL,
    description character varying(255) NOT NULL,
    mimetype character varying(255) NOT NULL,
    ispatch smallint DEFAULT 0 NOT NULL,
    filename character varying(255) NOT NULL,
    submitter_id integer NOT NULL,
    isobsolete smallint DEFAULT 0 NOT NULL,
    isprivate smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.attachments OWNER TO bugs;

--
-- Name: attachments_attach_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.attachments_attach_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attachments_attach_id_seq OWNER TO bugs;

--
-- Name: attachments_attach_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.attachments_attach_id_seq OWNED BY public.attachments.attach_id;


--
-- Name: audit_log; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.audit_log (
    user_id integer,
    class character varying(255) NOT NULL,
    object_id integer NOT NULL,
    field character varying(64) NOT NULL,
    removed text,
    added text,
    at_time timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.audit_log OWNER TO bugs;

--
-- Name: bug_group_map; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bug_group_map (
    bug_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.bug_group_map OWNER TO bugs;

--
-- Name: bug_see_also; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bug_see_also (
    id integer NOT NULL,
    bug_id integer NOT NULL,
    value character varying(255) NOT NULL,
    class character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.bug_see_also OWNER TO bugs;

--
-- Name: bug_see_also_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.bug_see_also_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bug_see_also_id_seq OWNER TO bugs;

--
-- Name: bug_see_also_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.bug_see_also_id_seq OWNED BY public.bug_see_also.id;


--
-- Name: bug_severity; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bug_severity (
    id integer NOT NULL,
    value character varying(64) NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL,
    visibility_value_id integer
);


ALTER TABLE public.bug_severity OWNER TO bugs;

--
-- Name: bug_severity_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.bug_severity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bug_severity_id_seq OWNER TO bugs;

--
-- Name: bug_severity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.bug_severity_id_seq OWNED BY public.bug_severity.id;


--
-- Name: bug_status; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bug_status (
    id integer NOT NULL,
    value character varying(64) NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL,
    visibility_value_id integer,
    is_open smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.bug_status OWNER TO bugs;

--
-- Name: bug_status_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.bug_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bug_status_id_seq OWNER TO bugs;

--
-- Name: bug_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.bug_status_id_seq OWNED BY public.bug_status.id;


--
-- Name: bug_tag; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bug_tag (
    bug_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.bug_tag OWNER TO bugs;

--
-- Name: bug_user_last_visit; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bug_user_last_visit (
    id integer NOT NULL,
    user_id integer NOT NULL,
    bug_id integer NOT NULL,
    last_visit_ts timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.bug_user_last_visit OWNER TO bugs;

--
-- Name: bug_user_last_visit_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.bug_user_last_visit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bug_user_last_visit_id_seq OWNER TO bugs;

--
-- Name: bug_user_last_visit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.bug_user_last_visit_id_seq OWNED BY public.bug_user_last_visit.id;


--
-- Name: bugs; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bugs (
    bug_id integer NOT NULL,
    assigned_to integer NOT NULL,
    bug_file_loc text DEFAULT ''::text NOT NULL,
    bug_severity character varying(64) NOT NULL,
    bug_status character varying(64) NOT NULL,
    creation_ts timestamp(0) without time zone,
    delta_ts timestamp(0) without time zone NOT NULL,
    short_desc character varying(255) NOT NULL,
    op_sys character varying(64) NOT NULL,
    priority character varying(64) NOT NULL,
    product_id integer NOT NULL,
    rep_platform character varying(64) NOT NULL,
    reporter integer NOT NULL,
    version character varying(64) NOT NULL,
    component_id integer NOT NULL,
    resolution character varying(64) DEFAULT ''::character varying NOT NULL,
    target_milestone character varying(64) DEFAULT '---'::character varying NOT NULL,
    qa_contact integer,
    status_whiteboard text DEFAULT ''::text NOT NULL,
    lastdiffed timestamp(0) without time zone,
    everconfirmed smallint NOT NULL,
    reporter_accessible smallint DEFAULT 1 NOT NULL,
    cclist_accessible smallint DEFAULT 1 NOT NULL,
    estimated_time numeric(7,2) DEFAULT 0 NOT NULL,
    remaining_time numeric(7,2) DEFAULT 0 NOT NULL,
    deadline timestamp(0) without time zone
);


ALTER TABLE public.bugs OWNER TO bugs;

--
-- Name: bugs_activity; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bugs_activity (
    id integer NOT NULL,
    bug_id integer NOT NULL,
    attach_id integer,
    who integer NOT NULL,
    bug_when timestamp(0) without time zone NOT NULL,
    fieldid integer NOT NULL,
    added character varying(255),
    removed character varying(255),
    comment_id integer
);


ALTER TABLE public.bugs_activity OWNER TO bugs;

--
-- Name: bugs_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.bugs_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bugs_activity_id_seq OWNER TO bugs;

--
-- Name: bugs_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.bugs_activity_id_seq OWNED BY public.bugs_activity.id;


--
-- Name: bugs_aliases; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bugs_aliases (
    alias character varying(40) NOT NULL,
    bug_id integer
);


ALTER TABLE public.bugs_aliases OWNER TO bugs;

--
-- Name: bugs_bug_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.bugs_bug_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bugs_bug_id_seq OWNER TO bugs;

--
-- Name: bugs_bug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.bugs_bug_id_seq OWNED BY public.bugs.bug_id;


--
-- Name: bugs_fulltext; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bugs_fulltext (
    bug_id integer NOT NULL,
    short_desc character varying(255) NOT NULL,
    comments text,
    comments_noprivate text
);


ALTER TABLE public.bugs_fulltext OWNER TO bugs;

--
-- Name: bz_schema; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.bz_schema (
    schema_data bytea NOT NULL,
    version numeric(3,2) NOT NULL
);


ALTER TABLE public.bz_schema OWNER TO bugs;

--
-- Name: category_group_map; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.category_group_map (
    category_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.category_group_map OWNER TO bugs;

--
-- Name: cc; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.cc (
    bug_id integer NOT NULL,
    who integer NOT NULL
);


ALTER TABLE public.cc OWNER TO bugs;

--
-- Name: classifications; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.classifications (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text,
    sortkey integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.classifications OWNER TO bugs;

--
-- Name: classifications_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.classifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classifications_id_seq OWNER TO bugs;

--
-- Name: classifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.classifications_id_seq OWNED BY public.classifications.id;


--
-- Name: component_cc; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.component_cc (
    user_id integer NOT NULL,
    component_id integer NOT NULL
);


ALTER TABLE public.component_cc OWNER TO bugs;

--
-- Name: components; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.components (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    product_id integer NOT NULL,
    initialowner integer NOT NULL,
    initialqacontact integer,
    description text NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.components OWNER TO bugs;

--
-- Name: components_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_id_seq OWNER TO bugs;

--
-- Name: components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.components_id_seq OWNED BY public.components.id;


--
-- Name: dependencies; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.dependencies (
    blocked integer NOT NULL,
    dependson integer NOT NULL
);


ALTER TABLE public.dependencies OWNER TO bugs;

--
-- Name: duplicates; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.duplicates (
    dupe_of integer NOT NULL,
    dupe integer NOT NULL
);


ALTER TABLE public.duplicates OWNER TO bugs;

--
-- Name: email_bug_ignore; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.email_bug_ignore (
    user_id integer NOT NULL,
    bug_id integer NOT NULL
);


ALTER TABLE public.email_bug_ignore OWNER TO bugs;

--
-- Name: email_setting; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.email_setting (
    user_id integer NOT NULL,
    relationship integer NOT NULL,
    event integer NOT NULL
);


ALTER TABLE public.email_setting OWNER TO bugs;

--
-- Name: field_visibility; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.field_visibility (
    field_id integer,
    value_id integer NOT NULL
);


ALTER TABLE public.field_visibility OWNER TO bugs;

--
-- Name: fielddefs; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.fielddefs (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    custom smallint DEFAULT 0 NOT NULL,
    description character varying(255) NOT NULL,
    long_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    mailhead smallint DEFAULT 0 NOT NULL,
    sortkey integer NOT NULL,
    obsolete smallint DEFAULT 0 NOT NULL,
    enter_bug smallint DEFAULT 0 NOT NULL,
    buglist smallint DEFAULT 0 NOT NULL,
    visibility_field_id integer,
    value_field_id integer,
    reverse_desc character varying(255),
    is_mandatory smallint DEFAULT 0 NOT NULL,
    is_numeric smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.fielddefs OWNER TO bugs;

--
-- Name: fielddefs_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.fielddefs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fielddefs_id_seq OWNER TO bugs;

--
-- Name: fielddefs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.fielddefs_id_seq OWNED BY public.fielddefs.id;


--
-- Name: flagexclusions; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.flagexclusions (
    type_id integer NOT NULL,
    product_id integer,
    component_id integer
);


ALTER TABLE public.flagexclusions OWNER TO bugs;

--
-- Name: flaginclusions; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.flaginclusions (
    type_id integer NOT NULL,
    product_id integer,
    component_id integer
);


ALTER TABLE public.flaginclusions OWNER TO bugs;

--
-- Name: flags; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.flags (
    id integer NOT NULL,
    type_id integer NOT NULL,
    status character(1) NOT NULL,
    bug_id integer NOT NULL,
    attach_id integer,
    creation_date timestamp(0) without time zone NOT NULL,
    modification_date timestamp(0) without time zone,
    setter_id integer NOT NULL,
    requestee_id integer
);


ALTER TABLE public.flags OWNER TO bugs;

--
-- Name: flags_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.flags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flags_id_seq OWNER TO bugs;

--
-- Name: flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.flags_id_seq OWNED BY public.flags.id;


--
-- Name: flagtypes; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.flagtypes (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text NOT NULL,
    cc_list character varying(200),
    target_type character(1) DEFAULT 'b'::bpchar NOT NULL,
    is_active smallint DEFAULT 1 NOT NULL,
    is_requestable smallint DEFAULT 0 NOT NULL,
    is_requesteeble smallint DEFAULT 0 NOT NULL,
    is_multiplicable smallint DEFAULT 0 NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    grant_group_id integer,
    request_group_id integer
);


ALTER TABLE public.flagtypes OWNER TO bugs;

--
-- Name: flagtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.flagtypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flagtypes_id_seq OWNER TO bugs;

--
-- Name: flagtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.flagtypes_id_seq OWNED BY public.flagtypes.id;


--
-- Name: group_control_map; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.group_control_map (
    group_id integer NOT NULL,
    product_id integer NOT NULL,
    entry smallint DEFAULT 0 NOT NULL,
    membercontrol integer DEFAULT 0 NOT NULL,
    othercontrol integer DEFAULT 0 NOT NULL,
    canedit smallint DEFAULT 0 NOT NULL,
    editcomponents smallint DEFAULT 0 NOT NULL,
    editbugs smallint DEFAULT 0 NOT NULL,
    canconfirm smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.group_control_map OWNER TO bugs;

--
-- Name: group_group_map; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.group_group_map (
    member_id integer NOT NULL,
    grantor_id integer NOT NULL,
    grant_type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.group_group_map OWNER TO bugs;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    isbuggroup smallint NOT NULL,
    userregexp character varying(255) DEFAULT ''::character varying NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL,
    icon_url character varying(255)
);


ALTER TABLE public.groups OWNER TO bugs;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO bugs;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: keyworddefs; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.keyworddefs (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.keyworddefs OWNER TO bugs;

--
-- Name: keyworddefs_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.keyworddefs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.keyworddefs_id_seq OWNER TO bugs;

--
-- Name: keyworddefs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.keyworddefs_id_seq OWNED BY public.keyworddefs.id;


--
-- Name: keywords; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.keywords (
    bug_id integer NOT NULL,
    keywordid integer NOT NULL
);


ALTER TABLE public.keywords OWNER TO bugs;

--
-- Name: login_failure; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.login_failure (
    user_id integer NOT NULL,
    login_time timestamp(0) without time zone NOT NULL,
    ip_addr character varying(40) NOT NULL
);


ALTER TABLE public.login_failure OWNER TO bugs;

--
-- Name: logincookies; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.logincookies (
    cookie character varying(16) NOT NULL,
    userid integer NOT NULL,
    ipaddr character varying(40),
    lastused timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.logincookies OWNER TO bugs;

--
-- Name: longdescs; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.longdescs (
    comment_id integer NOT NULL,
    bug_id integer NOT NULL,
    who integer NOT NULL,
    bug_when timestamp(0) without time zone NOT NULL,
    work_time numeric(7,2) DEFAULT 0 NOT NULL,
    thetext text NOT NULL,
    isprivate smallint DEFAULT 0 NOT NULL,
    already_wrapped smallint DEFAULT 0 NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    extra_data character varying(255)
);


ALTER TABLE public.longdescs OWNER TO bugs;

--
-- Name: longdescs_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.longdescs_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.longdescs_comment_id_seq OWNER TO bugs;

--
-- Name: longdescs_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.longdescs_comment_id_seq OWNED BY public.longdescs.comment_id;


--
-- Name: longdescs_tags; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.longdescs_tags (
    id integer NOT NULL,
    comment_id integer,
    tag character varying(24) NOT NULL
);


ALTER TABLE public.longdescs_tags OWNER TO bugs;

--
-- Name: longdescs_tags_activity; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.longdescs_tags_activity (
    id integer NOT NULL,
    bug_id integer NOT NULL,
    comment_id integer,
    who integer NOT NULL,
    bug_when timestamp(0) without time zone NOT NULL,
    added character varying(24),
    removed character varying(24)
);


ALTER TABLE public.longdescs_tags_activity OWNER TO bugs;

--
-- Name: longdescs_tags_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.longdescs_tags_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.longdescs_tags_activity_id_seq OWNER TO bugs;

--
-- Name: longdescs_tags_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.longdescs_tags_activity_id_seq OWNED BY public.longdescs_tags_activity.id;


--
-- Name: longdescs_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.longdescs_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.longdescs_tags_id_seq OWNER TO bugs;

--
-- Name: longdescs_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.longdescs_tags_id_seq OWNED BY public.longdescs_tags.id;


--
-- Name: longdescs_tags_weights; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.longdescs_tags_weights (
    id integer NOT NULL,
    tag character varying(24) NOT NULL,
    weight integer NOT NULL
);


ALTER TABLE public.longdescs_tags_weights OWNER TO bugs;

--
-- Name: longdescs_tags_weights_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.longdescs_tags_weights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.longdescs_tags_weights_id_seq OWNER TO bugs;

--
-- Name: longdescs_tags_weights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.longdescs_tags_weights_id_seq OWNED BY public.longdescs_tags_weights.id;


--
-- Name: mail_staging; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.mail_staging (
    id integer NOT NULL,
    message bytea NOT NULL
);


ALTER TABLE public.mail_staging OWNER TO bugs;

--
-- Name: mail_staging_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.mail_staging_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mail_staging_id_seq OWNER TO bugs;

--
-- Name: mail_staging_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.mail_staging_id_seq OWNED BY public.mail_staging.id;


--
-- Name: milestones; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.milestones (
    id integer NOT NULL,
    product_id integer NOT NULL,
    value character varying(64) NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.milestones OWNER TO bugs;

--
-- Name: milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.milestones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.milestones_id_seq OWNER TO bugs;

--
-- Name: milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.milestones_id_seq OWNED BY public.milestones.id;


--
-- Name: namedqueries; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.namedqueries (
    id integer NOT NULL,
    userid integer NOT NULL,
    name character varying(64) NOT NULL,
    query text NOT NULL
);


ALTER TABLE public.namedqueries OWNER TO bugs;

--
-- Name: namedqueries_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.namedqueries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.namedqueries_id_seq OWNER TO bugs;

--
-- Name: namedqueries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.namedqueries_id_seq OWNED BY public.namedqueries.id;


--
-- Name: namedqueries_link_in_footer; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.namedqueries_link_in_footer (
    namedquery_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.namedqueries_link_in_footer OWNER TO bugs;

--
-- Name: namedquery_group_map; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.namedquery_group_map (
    namedquery_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.namedquery_group_map OWNER TO bugs;

--
-- Name: op_sys; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.op_sys (
    id integer NOT NULL,
    value character varying(64) NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL,
    visibility_value_id integer
);


ALTER TABLE public.op_sys OWNER TO bugs;

--
-- Name: op_sys_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.op_sys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.op_sys_id_seq OWNER TO bugs;

--
-- Name: op_sys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.op_sys_id_seq OWNED BY public.op_sys.id;


--
-- Name: priority; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.priority (
    id integer NOT NULL,
    value character varying(64) NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL,
    visibility_value_id integer
);


ALTER TABLE public.priority OWNER TO bugs;

--
-- Name: priority_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.priority_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.priority_id_seq OWNER TO bugs;

--
-- Name: priority_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.priority_id_seq OWNED BY public.priority.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    classification_id integer DEFAULT 1 NOT NULL,
    description text NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL,
    defaultmilestone character varying(64) DEFAULT '---'::character varying NOT NULL,
    allows_unconfirmed smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.products OWNER TO bugs;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO bugs;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: profile_search; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.profile_search (
    id integer NOT NULL,
    user_id integer NOT NULL,
    bug_list text NOT NULL,
    list_order text
);


ALTER TABLE public.profile_search OWNER TO bugs;

--
-- Name: profile_search_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.profile_search_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_search_id_seq OWNER TO bugs;

--
-- Name: profile_search_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.profile_search_id_seq OWNED BY public.profile_search.id;


--
-- Name: profile_setting; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.profile_setting (
    user_id integer NOT NULL,
    setting_name character varying(32) NOT NULL,
    setting_value character varying(32) NOT NULL
);


ALTER TABLE public.profile_setting OWNER TO bugs;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.profiles (
    userid integer NOT NULL,
    login_name character varying(255) NOT NULL,
    cryptpassword character varying(128),
    realname character varying(255) DEFAULT ''::character varying NOT NULL,
    disabledtext text DEFAULT ''::text NOT NULL,
    disable_mail smallint DEFAULT 0 NOT NULL,
    mybugslink smallint DEFAULT 1 NOT NULL,
    extern_id character varying(64),
    is_enabled smallint DEFAULT 1 NOT NULL,
    last_seen_date timestamp(0) without time zone
);


ALTER TABLE public.profiles OWNER TO bugs;

--
-- Name: profiles_activity; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.profiles_activity (
    id integer NOT NULL,
    userid integer NOT NULL,
    who integer NOT NULL,
    profiles_when timestamp(0) without time zone NOT NULL,
    fieldid integer NOT NULL,
    oldvalue character varying(255),
    newvalue character varying(255)
);


ALTER TABLE public.profiles_activity OWNER TO bugs;

--
-- Name: profiles_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.profiles_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_activity_id_seq OWNER TO bugs;

--
-- Name: profiles_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.profiles_activity_id_seq OWNED BY public.profiles_activity.id;


--
-- Name: profiles_userid_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.profiles_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_userid_seq OWNER TO bugs;

--
-- Name: profiles_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.profiles_userid_seq OWNED BY public.profiles.userid;


--
-- Name: quips; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.quips (
    quipid integer NOT NULL,
    userid integer,
    quip character varying(512) NOT NULL,
    approved smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.quips OWNER TO bugs;

--
-- Name: quips_quipid_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.quips_quipid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quips_quipid_seq OWNER TO bugs;

--
-- Name: quips_quipid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.quips_quipid_seq OWNED BY public.quips.quipid;


--
-- Name: rep_platform; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.rep_platform (
    id integer NOT NULL,
    value character varying(64) NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL,
    visibility_value_id integer
);


ALTER TABLE public.rep_platform OWNER TO bugs;

--
-- Name: rep_platform_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.rep_platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rep_platform_id_seq OWNER TO bugs;

--
-- Name: rep_platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.rep_platform_id_seq OWNED BY public.rep_platform.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(64) NOT NULL,
    query text NOT NULL
);


ALTER TABLE public.reports OWNER TO bugs;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_id_seq OWNER TO bugs;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: resolution; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.resolution (
    id integer NOT NULL,
    value character varying(64) NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL,
    visibility_value_id integer
);


ALTER TABLE public.resolution OWNER TO bugs;

--
-- Name: resolution_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.resolution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resolution_id_seq OWNER TO bugs;

--
-- Name: resolution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.resolution_id_seq OWNED BY public.resolution.id;


--
-- Name: series; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.series (
    series_id integer NOT NULL,
    creator integer,
    category integer NOT NULL,
    subcategory integer NOT NULL,
    name character varying(64) NOT NULL,
    frequency integer NOT NULL,
    query text NOT NULL,
    is_public smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.series OWNER TO bugs;

--
-- Name: series_categories; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.series_categories (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.series_categories OWNER TO bugs;

--
-- Name: series_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.series_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_categories_id_seq OWNER TO bugs;

--
-- Name: series_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.series_categories_id_seq OWNED BY public.series_categories.id;


--
-- Name: series_data; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.series_data (
    series_id integer NOT NULL,
    series_date timestamp(0) without time zone NOT NULL,
    series_value integer NOT NULL
);


ALTER TABLE public.series_data OWNER TO bugs;

--
-- Name: series_series_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.series_series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_series_id_seq OWNER TO bugs;

--
-- Name: series_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.series_series_id_seq OWNED BY public.series.series_id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.setting (
    name character varying(32) NOT NULL,
    default_value character varying(32) NOT NULL,
    is_enabled smallint DEFAULT 1 NOT NULL,
    subclass character varying(32)
);


ALTER TABLE public.setting OWNER TO bugs;

--
-- Name: setting_value; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.setting_value (
    name character varying(32) NOT NULL,
    value character varying(32) NOT NULL,
    sortindex integer NOT NULL
);


ALTER TABLE public.setting_value OWNER TO bugs;

--
-- Name: status_workflow; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.status_workflow (
    old_status integer,
    new_status integer NOT NULL,
    require_comment integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.status_workflow OWNER TO bugs;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.tag OWNER TO bugs;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO bugs;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.tokens (
    userid integer,
    issuedate timestamp(0) without time zone NOT NULL,
    token character varying(16) NOT NULL,
    tokentype character varying(16) NOT NULL,
    eventdata character varying(255)
);


ALTER TABLE public.tokens OWNER TO bugs;

--
-- Name: ts_error; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.ts_error (
    error_time integer NOT NULL,
    jobid integer NOT NULL,
    message character varying(255) NOT NULL,
    funcid integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.ts_error OWNER TO bugs;

--
-- Name: ts_exitstatus; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.ts_exitstatus (
    jobid integer NOT NULL,
    funcid integer DEFAULT 0 NOT NULL,
    status integer,
    completion_time integer,
    delete_after integer
);


ALTER TABLE public.ts_exitstatus OWNER TO bugs;

--
-- Name: ts_exitstatus_jobid_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.ts_exitstatus_jobid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ts_exitstatus_jobid_seq OWNER TO bugs;

--
-- Name: ts_exitstatus_jobid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.ts_exitstatus_jobid_seq OWNED BY public.ts_exitstatus.jobid;


--
-- Name: ts_funcmap; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.ts_funcmap (
    funcid integer NOT NULL,
    funcname character varying(255) NOT NULL
);


ALTER TABLE public.ts_funcmap OWNER TO bugs;

--
-- Name: ts_funcmap_funcid_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.ts_funcmap_funcid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ts_funcmap_funcid_seq OWNER TO bugs;

--
-- Name: ts_funcmap_funcid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.ts_funcmap_funcid_seq OWNED BY public.ts_funcmap.funcid;


--
-- Name: ts_job; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.ts_job (
    jobid integer NOT NULL,
    funcid integer NOT NULL,
    arg bytea,
    uniqkey character varying(255),
    insert_time integer,
    run_after integer NOT NULL,
    grabbed_until integer NOT NULL,
    priority integer,
    "coalesce" character varying(255)
);


ALTER TABLE public.ts_job OWNER TO bugs;

--
-- Name: ts_job_jobid_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.ts_job_jobid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ts_job_jobid_seq OWNER TO bugs;

--
-- Name: ts_job_jobid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.ts_job_jobid_seq OWNED BY public.ts_job.jobid;


--
-- Name: ts_note; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.ts_note (
    jobid integer NOT NULL,
    notekey character varying(255),
    value bytea
);


ALTER TABLE public.ts_note OWNER TO bugs;

--
-- Name: user_api_keys; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.user_api_keys (
    id integer NOT NULL,
    user_id integer NOT NULL,
    api_key character varying(40) NOT NULL,
    description character varying(255),
    revoked smallint DEFAULT 0 NOT NULL,
    last_used timestamp(0) without time zone
);


ALTER TABLE public.user_api_keys OWNER TO bugs;

--
-- Name: user_api_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.user_api_keys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_api_keys_id_seq OWNER TO bugs;

--
-- Name: user_api_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.user_api_keys_id_seq OWNED BY public.user_api_keys.id;


--
-- Name: user_group_map; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.user_group_map (
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    isbless smallint DEFAULT 0 NOT NULL,
    grant_type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_group_map OWNER TO bugs;

--
-- Name: versions; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    value character varying(64) NOT NULL,
    product_id integer NOT NULL,
    isactive smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.versions OWNER TO bugs;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO bugs;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: watch; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.watch (
    watcher integer NOT NULL,
    watched integer NOT NULL
);


ALTER TABLE public.watch OWNER TO bugs;

--
-- Name: whine_events; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.whine_events (
    id integer NOT NULL,
    owner_userid integer NOT NULL,
    subject character varying(128),
    body text,
    mailifnobugs smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.whine_events OWNER TO bugs;

--
-- Name: whine_events_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.whine_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.whine_events_id_seq OWNER TO bugs;

--
-- Name: whine_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.whine_events_id_seq OWNED BY public.whine_events.id;


--
-- Name: whine_queries; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.whine_queries (
    id integer NOT NULL,
    eventid integer NOT NULL,
    query_name character varying(64) DEFAULT ''::character varying NOT NULL,
    sortkey integer DEFAULT 0 NOT NULL,
    onemailperbug smallint DEFAULT 0 NOT NULL,
    title character varying(128) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.whine_queries OWNER TO bugs;

--
-- Name: whine_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.whine_queries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.whine_queries_id_seq OWNER TO bugs;

--
-- Name: whine_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.whine_queries_id_seq OWNED BY public.whine_queries.id;


--
-- Name: whine_schedules; Type: TABLE; Schema: public; Owner: bugs
--

CREATE TABLE public.whine_schedules (
    id integer NOT NULL,
    eventid integer NOT NULL,
    run_day character varying(32),
    run_time character varying(32),
    run_next timestamp(0) without time zone,
    mailto integer NOT NULL,
    mailto_type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.whine_schedules OWNER TO bugs;

--
-- Name: whine_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: bugs
--

CREATE SEQUENCE public.whine_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.whine_schedules_id_seq OWNER TO bugs;

--
-- Name: whine_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bugs
--

ALTER SEQUENCE public.whine_schedules_id_seq OWNED BY public.whine_schedules.id;


--
-- Name: attachments attach_id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.attachments ALTER COLUMN attach_id SET DEFAULT nextval('public.attachments_attach_id_seq'::regclass);


--
-- Name: bug_see_also id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_see_also ALTER COLUMN id SET DEFAULT nextval('public.bug_see_also_id_seq'::regclass);


--
-- Name: bug_severity id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_severity ALTER COLUMN id SET DEFAULT nextval('public.bug_severity_id_seq'::regclass);


--
-- Name: bug_status id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_status ALTER COLUMN id SET DEFAULT nextval('public.bug_status_id_seq'::regclass);


--
-- Name: bug_user_last_visit id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_user_last_visit ALTER COLUMN id SET DEFAULT nextval('public.bug_user_last_visit_id_seq'::regclass);


--
-- Name: bugs bug_id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs ALTER COLUMN bug_id SET DEFAULT nextval('public.bugs_bug_id_seq'::regclass);


--
-- Name: bugs_activity id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_activity ALTER COLUMN id SET DEFAULT nextval('public.bugs_activity_id_seq'::regclass);


--
-- Name: classifications id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.classifications ALTER COLUMN id SET DEFAULT nextval('public.classifications_id_seq'::regclass);


--
-- Name: components id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.components ALTER COLUMN id SET DEFAULT nextval('public.components_id_seq'::regclass);


--
-- Name: fielddefs id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.fielddefs ALTER COLUMN id SET DEFAULT nextval('public.fielddefs_id_seq'::regclass);


--
-- Name: flags id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flags ALTER COLUMN id SET DEFAULT nextval('public.flags_id_seq'::regclass);


--
-- Name: flagtypes id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flagtypes ALTER COLUMN id SET DEFAULT nextval('public.flagtypes_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: keyworddefs id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.keyworddefs ALTER COLUMN id SET DEFAULT nextval('public.keyworddefs_id_seq'::regclass);


--
-- Name: longdescs comment_id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs ALTER COLUMN comment_id SET DEFAULT nextval('public.longdescs_comment_id_seq'::regclass);


--
-- Name: longdescs_tags id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags ALTER COLUMN id SET DEFAULT nextval('public.longdescs_tags_id_seq'::regclass);


--
-- Name: longdescs_tags_activity id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags_activity ALTER COLUMN id SET DEFAULT nextval('public.longdescs_tags_activity_id_seq'::regclass);


--
-- Name: longdescs_tags_weights id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags_weights ALTER COLUMN id SET DEFAULT nextval('public.longdescs_tags_weights_id_seq'::regclass);


--
-- Name: mail_staging id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.mail_staging ALTER COLUMN id SET DEFAULT nextval('public.mail_staging_id_seq'::regclass);


--
-- Name: milestones id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.milestones ALTER COLUMN id SET DEFAULT nextval('public.milestones_id_seq'::regclass);


--
-- Name: namedqueries id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.namedqueries ALTER COLUMN id SET DEFAULT nextval('public.namedqueries_id_seq'::regclass);


--
-- Name: op_sys id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.op_sys ALTER COLUMN id SET DEFAULT nextval('public.op_sys_id_seq'::regclass);


--
-- Name: priority id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.priority ALTER COLUMN id SET DEFAULT nextval('public.priority_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: profile_search id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profile_search ALTER COLUMN id SET DEFAULT nextval('public.profile_search_id_seq'::regclass);


--
-- Name: profiles userid; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profiles ALTER COLUMN userid SET DEFAULT nextval('public.profiles_userid_seq'::regclass);


--
-- Name: profiles_activity id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profiles_activity ALTER COLUMN id SET DEFAULT nextval('public.profiles_activity_id_seq'::regclass);


--
-- Name: quips quipid; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.quips ALTER COLUMN quipid SET DEFAULT nextval('public.quips_quipid_seq'::regclass);


--
-- Name: rep_platform id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.rep_platform ALTER COLUMN id SET DEFAULT nextval('public.rep_platform_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: resolution id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.resolution ALTER COLUMN id SET DEFAULT nextval('public.resolution_id_seq'::regclass);


--
-- Name: series series_id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.series ALTER COLUMN series_id SET DEFAULT nextval('public.series_series_id_seq'::regclass);


--
-- Name: series_categories id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.series_categories ALTER COLUMN id SET DEFAULT nextval('public.series_categories_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: ts_exitstatus jobid; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.ts_exitstatus ALTER COLUMN jobid SET DEFAULT nextval('public.ts_exitstatus_jobid_seq'::regclass);


--
-- Name: ts_funcmap funcid; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.ts_funcmap ALTER COLUMN funcid SET DEFAULT nextval('public.ts_funcmap_funcid_seq'::regclass);


--
-- Name: ts_job jobid; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.ts_job ALTER COLUMN jobid SET DEFAULT nextval('public.ts_job_jobid_seq'::regclass);


--
-- Name: user_api_keys id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.user_api_keys ALTER COLUMN id SET DEFAULT nextval('public.user_api_keys_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: whine_events id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_events ALTER COLUMN id SET DEFAULT nextval('public.whine_events_id_seq'::regclass);


--
-- Name: whine_queries id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_queries ALTER COLUMN id SET DEFAULT nextval('public.whine_queries_id_seq'::regclass);


--
-- Name: whine_schedules id; Type: DEFAULT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_schedules ALTER COLUMN id SET DEFAULT nextval('public.whine_schedules_id_seq'::regclass);


--
-- Data for Name: attach_data; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.attach_data (id, thedata) FROM stdin;
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.attachments (attach_id, bug_id, creation_ts, modification_time, description, mimetype, ispatch, filename, submitter_id, isobsolete, isprivate) FROM stdin;
\.


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.audit_log (user_id, class, object_id, field, removed, added, at_time) FROM stdin;
\N	Bugzilla::Field	1	__create__	\N	bug_id	2023-12-20 10:54:59
\N	Bugzilla::Field	2	__create__	\N	short_desc	2023-12-20 10:54:59
\N	Bugzilla::Field	3	__create__	\N	classification	2023-12-20 10:54:59
\N	Bugzilla::Field	4	__create__	\N	product	2023-12-20 10:54:59
\N	Bugzilla::Field	5	__create__	\N	version	2023-12-20 10:54:59
\N	Bugzilla::Field	6	__create__	\N	rep_platform	2023-12-20 10:54:59
\N	Bugzilla::Field	7	__create__	\N	bug_file_loc	2023-12-20 10:54:59
\N	Bugzilla::Field	8	__create__	\N	op_sys	2023-12-20 10:54:59
\N	Bugzilla::Field	9	__create__	\N	bug_status	2023-12-20 10:54:59
\N	Bugzilla::Field	10	__create__	\N	status_whiteboard	2023-12-20 10:54:59
\N	Bugzilla::Field	11	__create__	\N	keywords	2023-12-20 10:54:59
\N	Bugzilla::Field	12	__create__	\N	resolution	2023-12-20 10:54:59
\N	Bugzilla::Field	13	__create__	\N	bug_severity	2023-12-20 10:54:59
\N	Bugzilla::Field	14	__create__	\N	priority	2023-12-20 10:54:59
\N	Bugzilla::Field	15	__create__	\N	component	2023-12-20 10:54:59
\N	Bugzilla::Field	16	__create__	\N	assigned_to	2023-12-20 10:54:59
\N	Bugzilla::Field	17	__create__	\N	reporter	2023-12-20 10:54:59
\N	Bugzilla::Field	18	__create__	\N	qa_contact	2023-12-20 10:54:59
\N	Bugzilla::Field	19	__create__	\N	assigned_to_realname	2023-12-20 10:54:59
\N	Bugzilla::Field	20	__create__	\N	reporter_realname	2023-12-20 10:54:59
\N	Bugzilla::Field	21	__create__	\N	qa_contact_realname	2023-12-20 10:54:59
\N	Bugzilla::Field	22	__create__	\N	cc	2023-12-20 10:54:59
\N	Bugzilla::Field	23	__create__	\N	dependson	2023-12-20 10:54:59
\N	Bugzilla::Field	24	__create__	\N	blocked	2023-12-20 10:54:59
\N	Bugzilla::Field	25	__create__	\N	attachments.description	2023-12-20 10:54:59
\N	Bugzilla::Field	26	__create__	\N	attachments.filename	2023-12-20 10:54:59
\N	Bugzilla::Field	27	__create__	\N	attachments.mimetype	2023-12-20 10:54:59
\N	Bugzilla::Field	28	__create__	\N	attachments.ispatch	2023-12-20 10:54:59
\N	Bugzilla::Field	29	__create__	\N	attachments.isobsolete	2023-12-20 10:54:59
\N	Bugzilla::Field	30	__create__	\N	attachments.isprivate	2023-12-20 10:54:59
\N	Bugzilla::Field	31	__create__	\N	attachments.submitter	2023-12-20 10:54:59
\N	Bugzilla::Field	32	__create__	\N	target_milestone	2023-12-20 10:54:59
\N	Bugzilla::Field	33	__create__	\N	creation_ts	2023-12-20 10:54:59
\N	Bugzilla::Field	34	__create__	\N	delta_ts	2023-12-20 10:54:59
\N	Bugzilla::Field	35	__create__	\N	longdesc	2023-12-20 10:54:59
\N	Bugzilla::Field	36	__create__	\N	longdescs.isprivate	2023-12-20 10:54:59
\N	Bugzilla::Field	37	__create__	\N	longdescs.count	2023-12-20 10:54:59
\N	Bugzilla::Field	38	__create__	\N	alias	2023-12-20 10:54:59
\N	Bugzilla::Field	39	__create__	\N	everconfirmed	2023-12-20 10:54:59
\N	Bugzilla::Field	40	__create__	\N	reporter_accessible	2023-12-20 10:54:59
\N	Bugzilla::Field	41	__create__	\N	cclist_accessible	2023-12-20 10:54:59
\N	Bugzilla::Field	42	__create__	\N	bug_group	2023-12-20 10:54:59
\N	Bugzilla::Field	43	__create__	\N	estimated_time	2023-12-20 10:54:59
\N	Bugzilla::Field	44	__create__	\N	remaining_time	2023-12-20 10:54:59
\N	Bugzilla::Field	45	__create__	\N	deadline	2023-12-20 10:54:59
\N	Bugzilla::Field	46	__create__	\N	commenter	2023-12-20 10:54:59
\N	Bugzilla::Field	47	__create__	\N	flagtypes.name	2023-12-20 10:54:59
\N	Bugzilla::Field	48	__create__	\N	requestees.login_name	2023-12-20 10:54:59
\N	Bugzilla::Field	49	__create__	\N	setters.login_name	2023-12-20 10:54:59
\N	Bugzilla::Field	50	__create__	\N	work_time	2023-12-20 10:54:59
\N	Bugzilla::Field	51	__create__	\N	percentage_complete	2023-12-20 10:54:59
\N	Bugzilla::Field	52	__create__	\N	content	2023-12-20 10:54:59
\N	Bugzilla::Field	53	__create__	\N	attach_data.thedata	2023-12-20 10:54:59
\N	Bugzilla::Field	54	__create__	\N	owner_idle_time	2023-12-20 10:54:59
\N	Bugzilla::Field	55	__create__	\N	see_also	2023-12-20 10:54:59
\N	Bugzilla::Field	56	__create__	\N	tag	2023-12-20 10:54:59
\N	Bugzilla::Field	57	__create__	\N	last_visit_ts	2023-12-20 10:54:59
\N	Bugzilla::Field	58	__create__	\N	comment_tag	2023-12-20 10:54:59
\N	Bugzilla::Field	59	__create__	\N	days_elapsed	2023-12-20 10:54:59
\N	Bugzilla::Classification	1	__create__	\N	Unclassified	2023-12-20 10:54:59
\N	Bugzilla::Group	1	__create__	\N	admin	2023-12-20 10:55:01
\N	Bugzilla::Group	2	__create__	\N	tweakparams	2023-12-20 10:55:01
\N	Bugzilla::Group	3	__create__	\N	editusers	2023-12-20 10:55:01
\N	Bugzilla::Group	4	__create__	\N	creategroups	2023-12-20 10:55:01
\N	Bugzilla::Group	5	__create__	\N	editclassifications	2023-12-20 10:55:01
\N	Bugzilla::Group	6	__create__	\N	editcomponents	2023-12-20 10:55:01
\N	Bugzilla::Group	7	__create__	\N	editkeywords	2023-12-20 10:55:01
\N	Bugzilla::Group	8	__create__	\N	editbugs	2023-12-20 10:55:01
\N	Bugzilla::Group	9	__create__	\N	canconfirm	2023-12-20 10:55:01
\N	Bugzilla::Group	10	__create__	\N	bz_canusewhineatothers	2023-12-20 10:55:01
\N	Bugzilla::Group	11	__create__	\N	bz_canusewhines	2023-12-20 10:55:01
\N	Bugzilla::Group	12	__create__	\N	bz_sudoers	2023-12-20 10:55:01
\N	Bugzilla::Group	13	__create__	\N	bz_sudo_protect	2023-12-20 10:55:01
\N	Bugzilla::Group	14	__create__	\N	bz_quip_moderators	2023-12-20 10:55:01
\N	Bugzilla::User	1	__create__	\N	khazi.devops@gmail.com	2023-12-20 10:55:01
\N	Bugzilla::Product	1	__create__	\N	TestProduct	2023-12-20 10:55:01
\N	Bugzilla::Version	1	__create__	\N	unspecified	2023-12-20 10:55:01
\N	Bugzilla::Milestone	1	__create__	\N	---	2023-12-20 10:55:01
\N	Bugzilla::Component	1	__create__	\N	TestComponent	2023-12-20 10:55:01
1	Bugzilla::User	2	__create__	\N	rj.ravindra@kenestechnology.net	2023-12-20 11:29:57
\.


--
-- Data for Name: bug_group_map; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bug_group_map (bug_id, group_id) FROM stdin;
\.


--
-- Data for Name: bug_see_also; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bug_see_also (id, bug_id, value, class) FROM stdin;
\.


--
-- Data for Name: bug_severity; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bug_severity (id, value, sortkey, isactive, visibility_value_id) FROM stdin;
1	blocker	100	1	\N
2	critical	200	1	\N
3	major	300	1	\N
4	normal	400	1	\N
5	minor	500	1	\N
6	trivial	600	1	\N
7	enhancement	700	1	\N
\.


--
-- Data for Name: bug_status; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bug_status (id, value, sortkey, isactive, visibility_value_id, is_open) FROM stdin;
1	UNCONFIRMED	100	1	\N	1
2	CONFIRMED	200	1	\N	1
3	IN_PROGRESS	300	1	\N	1
4	RESOLVED	400	1	\N	0
5	VERIFIED	500	1	\N	0
\.


--
-- Data for Name: bug_tag; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bug_tag (bug_id, tag_id) FROM stdin;
\.


--
-- Data for Name: bug_user_last_visit; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bug_user_last_visit (id, user_id, bug_id, last_visit_ts) FROM stdin;
\.


--
-- Data for Name: bugs; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bugs (bug_id, assigned_to, bug_file_loc, bug_severity, bug_status, creation_ts, delta_ts, short_desc, op_sys, priority, product_id, rep_platform, reporter, version, component_id, resolution, target_milestone, qa_contact, status_whiteboard, lastdiffed, everconfirmed, reporter_accessible, cclist_accessible, estimated_time, remaining_time, deadline) FROM stdin;
\.


--
-- Data for Name: bugs_activity; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bugs_activity (id, bug_id, attach_id, who, bug_when, fieldid, added, removed, comment_id) FROM stdin;
\.


--
-- Data for Name: bugs_aliases; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bugs_aliases (alias, bug_id) FROM stdin;
\.


--
-- Data for Name: bugs_fulltext; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bugs_fulltext (bug_id, short_desc, comments, comments_noprivate) FROM stdin;
\.


--
-- Data for Name: bz_schema; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.bz_schema (schema_data, version) FROM stdin;
\\x2456415231203d207b0a20202020202020202020276174746163685f6461746127203d3e207b0a2020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276174746163685f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276174746163686d656e7473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202774686564617461272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e47424c4f42270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276174746163686d656e747327203d3e207b0a2020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276174746163685f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174696f6e5f7473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d6f64696669636174696f6e5f74696d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d696d6574797065272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202769737061746368272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202766696c656e616d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020277375626d69747465725f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202769736f62736f6c657465272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202027697370726976617465272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276174746163686d656e74735f6275675f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276174746163686d656e74735f6372656174696f6e5f74735f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174696f6e5f7473270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276174746163686d656e74735f6d6f64696669636174696f6e5f74696d655f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d6f64696669636174696f6e5f74696d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276174746163686d656e74735f7375626d69747465725f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277375626d69747465725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202761756469745f6c6f6727203d3e207b0a202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e2027534554204e554c4c272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027636c617373272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276f626a6563745f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c64272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202772656d6f766564272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276164646564272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202761745f74696d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202761756469745f6c6f675f636c6173735f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636c617373272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202761745f74696d65270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276275675f67726f75705f6d617027203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f67726f75705f6d61705f6275675f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f67726f75705f6d61705f67726f75705f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276275675f7365655f616c736f27203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636c617373272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7365655f616c736f5f6275675f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276275675f736576657269747927203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f73657665726974795f76616c75655f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f73657665726974795f736f72746b65795f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f73657665726974795f7669736962696c6974795f76616c75655f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276275675f73746174757327203d3e207b0a20202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f6f70656e272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7374617475735f76616c75655f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7374617475735f736f72746b65795f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7374617475735f7669736962696c6974795f76616c75655f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276275675f74616727203d3e207b0a20202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020277461675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027746167272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7461675f6275675f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277461675f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020207d2c0a20202020202020202020276275675f757365725f6c6173745f766973697427203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6173745f76697369745f7473272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f757365725f6c6173745f76697369745f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f757365725f6c6173745f76697369745f6c6173745f76697369745f74735f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6173745f76697369745f7473270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276275677327203d3e207b0a20202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202761737369676e65645f746f272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020276275675f66696c655f6c6f63272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020276275675f7365766572697479272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020276275675f737461747573272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020276372656174696f6e5f7473272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202764656c74615f7473272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202773686f72745f64657363272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020276f705f737973272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020277072696f72697479272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f6475637473272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020277265705f706c6174666f726d272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020277265706f72746572272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202776657273696f6e272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027636f6d706f6e656e7473272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020277265736f6c7574696f6e272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020277461726765745f6d696c6573746f6e65272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c272d2d2d5c27272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202771615f636f6e74616374272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020277374617475735f7768697465626f617264272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020276c617374646966666564272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202765766572636f6e6669726d6564272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020277265706f727465725f61636365737369626c65272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202763636c6973745f61636365737369626c65272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202027657374696d617465645f74696d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027646563696d616c28372c3229270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202772656d61696e696e675f74696d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027646563696d616c28372c3229270a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202027646561646c696e65272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a2020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f61737369676e65645f746f5f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202761737369676e65645f746f270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f6372656174696f6e5f74735f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174696f6e5f7473270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f64656c74615f74735f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202764656c74615f7473270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f6275675f73657665726974795f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7365766572697479270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f6275675f7374617475735f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f737461747573270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f6f705f7379735f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276f705f737973270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f7072696f726974795f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020277072696f72697479270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f70726f647563745f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f7265706f727465725f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020277265706f72746572270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f76657273696f6e5f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202776657273696f6e270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f636f6d706f6e656e745f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f6964270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f7265736f6c7574696f6e5f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020277265736f6c7574696f6e270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f7461726765745f6d696c6573746f6e655f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020277461726765745f6d696c6573746f6e65270a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027627567735f71615f636f6e746163745f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202771615f636f6e74616374270a202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020207d2c0a2020202020202020202027627567735f616374697669747927203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276174746163685f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276174746163685f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276174746163686d656e7473272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202777686f272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7768656e272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c646964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276669656c6464656673272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276164646564272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772656d6f766564272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d6d656e745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027636f6d6d656e745f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276c6f6e676465736373272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f61637469766974795f6275675f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f61637469766974795f77686f5f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202777686f270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f61637469766974795f6275675f7768656e5f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7768656e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f61637469766974795f6669656c6469645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c646964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f61637469766974795f61646465645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276164646564270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f61637469766974795f72656d6f7665645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772656d6f766564270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027627567735f616c696173657327203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027616c696173272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228343029270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f616c69617365735f6275675f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f616c69617365735f616c6961735f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027616c696173270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027627567735f66756c6c7465787427203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202773686f72745f64657363272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d6d656e7473272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e4754455854270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d6d656e74735f6e6f70726976617465272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e4754455854270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027627567735f66756c6c746578745f73686f72745f646573635f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202773686f72745f64657363270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027627a5f736368656d6127203d3e207b0a202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027736368656d615f64617461272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e47424c4f42270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202776657273696f6e272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027646563696d616c28332c3229270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020207d2c0a202020202020202020202763617465676f72795f67726f75705f6d617027203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202763617465676f72795f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20277365726965735f63617465676f72696573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202763617465676f72795f67726f75705f6d61705f63617465676f72795f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202763617465676f72795f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027636327203d3e207b0a2020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202777686f272c0a202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202763635f6275675f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202777686f270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202763635f77686f5f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202777686f270a20202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020207d2c0a2020202020202020202027636c617373696669636174696f6e7327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636c617373696669636174696f6e735f6e616d655f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027636f6d706f6e656e745f636327203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027636f6d706f6e656e7473272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f63635f757365725f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027636f6d706f6e656e747327203d3e207b0a20202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f6475637473272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202027696e697469616c6f776e6572272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202027696e697469616c7161636f6e74616374272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e2027534554204e554c4c272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e74735f70726f647563745f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e74735f6e616d655f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027646570656e64656e6369657327203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027626c6f636b6564272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027646570656e64736f6e272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027646570656e64656e636965735f626c6f636b65645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027626c6f636b6564272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027646570656e64736f6e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027646570656e64656e636965735f646570656e64736f6e5f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027646570656e64736f6e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276475706c69636174657327203d3e207b0a20202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202027647570655f6f66272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202764757065272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027656d61696c5f6275675f69676e6f726527203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027656d61696c5f6275675f69676e6f72655f757365725f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027656d61696c5f73657474696e6727203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772656c6174696f6e73686970272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5431270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276576656e74272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5431270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027656d61696c5f73657474696e675f757365725f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772656c6174696f6e73686970272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276576656e74270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276669656c645f7669736962696c69747927203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c645f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276669656c6464656673272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c75655f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c645f7669736962696c6974795f6669656c645f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c645f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c75655f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276669656c646465667327203d3e207b0a202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202774797065272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027637573746f6d272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f6e675f64657363272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276d61696c68656164272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276f62736f6c657465272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027656e7465725f627567272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276275676c697374272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f6669656c645f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276669656c6464656673272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c75655f6669656c645f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276669656c6464656673272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027726576657273655f64657363272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f6d616e6461746f7279272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f6e756d65726963272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c64646566735f6e616d655f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c64646566735f736f72746b65795f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c64646566735f76616c75655f6669656c645f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c75655f6669656c645f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c64646566735f69735f6d616e6461746f72795f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f6d616e6461746f7279270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c64646566735f6e616d655f6c6f7765725f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274c4f574552286e616d6529270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027666c61676578636c7573696f6e7327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027747970655f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027666c61677479706573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f6475637473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027636f6d706f6e656e7473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027666c61676578636c7573696f6e735f747970655f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027747970655f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027666c6167696e636c7573696f6e7327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027747970655f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027666c61677479706573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f6475637473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027636f6d706f6e656e7473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027666c6167696e636c7573696f6e735f747970655f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027747970655f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706f6e656e745f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027666c61677327203d3e207b0a2020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027747970655f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027666c61677479706573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027737461747573272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202763686172283129270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020276174746163685f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276174746163685f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276174746163686d656e7473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020276372656174696f6e5f64617465272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020276d6f64696669636174696f6e5f64617465272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020277365747465725f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020277265717565737465655f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202027666c6167735f6275675f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276174746163685f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027666c6167735f7365747465725f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020277365747465725f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027666c6167735f7265717565737465655f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020277265717565737465655f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027666c6167735f747970655f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202027747970655f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020207d2c0a2020202020202020202027666c6167747970657327203d3e207b0a202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228353029270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202763635f6c697374272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832303029270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020277461726765745f74797065272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c27625c27272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202763686172283129270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f616374697665272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f7265717565737461626c65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f726571756573746565626c65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f6d756c7469706c696361626c65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276772616e745f67726f75705f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e2027534554204e554c4c272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027726571756573745f67726f75705f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e2027534554204e554c4c272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020207d2c0a202020202020202020202767726f75705f636f6e74726f6c5f6d617027203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f6475637473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027656e747279272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d656d626572636f6e74726f6c272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5431270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276f74686572636f6e74726f6c272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5431270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202763616e65646974272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202765646974636f6d706f6e656e7473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276564697462756773272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202763616e636f6e6669726d272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f636f6e74726f6c5f6d61705f70726f647563745f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f636f6e74726f6c5f6d61705f67726f75705f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202767726f75705f67726f75705f6d617027203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d656d6265725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276772616e746f725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276772616e745f74797065272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5431270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f67726f75705f6d61705f6d656d6265725f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d656d6265725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276772616e746f725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276772616e745f74797065270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202767726f75707327203d3e207b0a202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027697362756767726f7570272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202775736572726567657870272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202769636f6e5f75726c272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a20202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202767726f7570735f6e616d655f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020207d2c0a20202020202020202020276b6579776f72646465667327203d3e207b0a2020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276b6579776f7264646566735f6e616d655f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276b6579776f7264646566735f6e616d655f6c6f7765725f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274c4f574552286e616d6529270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276b6579776f72647327203d3e207b0a2020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276b6579776f72646964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276b6579776f726464656673272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276b6579776f7264735f6275675f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276b6579776f72646964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276b6579776f7264735f6b6579776f726469645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276b6579776f72646964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020207d2c0a20202020202020202020276c6f67696e5f6661696c75726527203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f67696e5f74696d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202769705f61646472272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228343029270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f67696e5f6661696c7572655f757365725f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276c6f67696e636f6f6b69657327203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6f6b6965272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228313629270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027697061646472272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228343029270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c61737475736564272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f67696e636f6f6b6965735f6c617374757365645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c61737475736564270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276c6f6e67646573637327203d3e207b0a202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d6d656e745f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202777686f272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7768656e272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027776f726b5f74696d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027646563696d616c28372c3229270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202774686574657874272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e4754455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027697370726976617465272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027616c72656164795f77726170706564272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202774797065272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202765787472615f64617461272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f6e6764657363735f6275675f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027776f726b5f74696d65270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f6e6764657363735f77686f5f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202777686f272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f6e6764657363735f6275675f7768656e5f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7768656e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276c6f6e6764657363735f7461677327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d6d656e745f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027636f6d6d656e745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276c6f6e676465736373272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027746167272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228323429270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f6e6764657363735f746167735f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d6d656e745f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027746167270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276c6f6e6764657363735f746167735f616374697669747927203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276275675f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202762756773272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d6d656e745f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027636f6d6d656e745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276c6f6e676465736373272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202777686f272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f7768656e272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276164646564272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228323429270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772656d6f766564272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228323429270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f6e6764657363735f746167735f61637469766974795f6275675f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276c6f6e6764657363735f746167735f7765696768747327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027746167272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228323429270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027776569676874272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f6e6764657363735f746167735f776569676874735f7461675f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027746167270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276d61696c5f73746167696e6727203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d657373616765272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e47424c4f42270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276d696c6573746f6e657327203d3e207b0a20202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f6475637473272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d696c6573746f6e65735f70726f647563745f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276e616d65647175657269657327203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277175657279272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e4754455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d6564717565726965735f7573657269645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276e616d6564717565726965735f6c696e6b5f696e5f666f6f74657227203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d656471756572795f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276e616d656471756572696573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d6564717565726965735f6c696e6b5f696e5f666f6f7465725f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d656471756572795f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d6564717565726965735f6c696e6b5f696e5f666f6f7465725f7573657269645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276e616d656471756572795f67726f75705f6d617027203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d656471756572795f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276e616d656471756572696573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d656471756572795f67726f75705f6d61705f6e616d656471756572795f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d656471756572795f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d656471756572795f67726f75705f6d61705f67726f75705f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020276f705f73797327203d3e207b0a202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276f705f7379735f76616c75655f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020276f705f7379735f736f72746b65795f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a2020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020276f705f7379735f7669736962696c6974795f76616c75655f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020207d2c0a20202020202020202020277072696f7269747927203d3e207b0a2020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020277072696f726974795f76616c75655f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020277072696f726974795f736f72746b65795f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020277072696f726974795f7669736962696c6974795f76616c75655f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020207d2c0a202020202020202020202770726f647563747327203d3e207b0a2020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202027636c617373696669636174696f6e5f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202731272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027636c617373696669636174696f6e73272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202764656661756c746d696c6573746f6e65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c272d2d2d5c27272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202027616c6c6f77735f756e636f6e6669726d6564272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f64756374735f6e616d655f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f64756374735f6e616d655f6c6f7765725f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274c4f574552286e616d6529270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020207d2c0a202020202020202020202770726f66696c655f73656172636827203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276275675f6c697374272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6973745f6f72646572272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c655f7365617263685f757365725f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202770726f66696c655f73657474696e6727203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202773657474696e675f6e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276e616d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202773657474696e67272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202773657474696e675f76616c7565272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c655f73657474696e675f76616c75655f756e697175655f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202773657474696e675f6e616d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202770726f66696c657327203d3e207b0a2020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f67696e5f6e616d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202027637279707470617373776f7264272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722831323829270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020277265616c6e616d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202764697361626c656474657874272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202764697361626c655f6d61696c272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276d79627567736c696e6b272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202765787465726e5f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202769735f656e61626c6564272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276c6173745f7365656e5f64617465272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c65735f6c6f67696e5f6e616d655f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6f67696e5f6e616d65270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c65735f65787465726e5f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202765787465726e5f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c65735f6c6f67696e5f6e616d655f6c6f7765725f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274c4f574552286c6f67696e5f6e616d6529270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020207d2c0a202020202020202020202770726f66696c65735f616374697669747927203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202777686f272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c65735f7768656e272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c646964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276669656c6464656673272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276f6c6476616c7565272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e657776616c7565272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c65735f61637469766974795f7573657269645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365726964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c65735f61637469766974795f70726f66696c65735f7768656e5f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c65735f7768656e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f66696c65735f61637469766974795f6669656c6469645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276669656c646964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027717569707327203d3e207b0a2020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202027717569706964272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e2027534554204e554c4c272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202771756970272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722835313229270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202027617070726f766564272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020207d2c0a20202020202020202020277265705f706c6174666f726d27203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277265705f706c6174666f726d5f76616c75655f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277265705f706c6174666f726d5f736f72746b65795f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277265705f706c6174666f726d5f7669736962696c6974795f76616c75655f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020277265706f72747327203d3e207b0a20202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020277175657279272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e4754455854270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020277265706f7274735f757365725f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020207d2c0a20202020202020202020277265736f6c7574696f6e27203d3e207b0a20202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020277265736f6c7574696f6e5f76616c75655f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020277265736f6c7574696f6e5f736f72746b65795f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020277265736f6c7574696f6e5f7669736962696c6974795f76616c75655f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277669736962696c6974795f76616c75655f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020207d2c0a202020202020202020202773657269657327203d3e207b0a202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202763726561746f72272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202763617465676f7279272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20277365726965735f63617465676f72696573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202773756263617465676f7279272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20277365726965735f63617465676f72696573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020276672657175656e6379272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020277175657279272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202769735f7075626c6963272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f63726561746f725f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202763726561746f72270a2020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f63617465676f72795f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202763617465676f7279272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202773756263617465676f7279272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020207d2c0a20202020202020202020277365726965735f63617465676f7269657327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027534d414c4c53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f63617465676f726965735f6e616d655f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020277365726965735f6461746127203d3e207b0a2020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20277365726965735f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e2027736572696573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f64617465272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f76616c7565272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f646174615f7365726965735f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277365726965735f64617465270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202773657474696e6727203d3e207b0a20202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202764656661756c745f76616c7565272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202769735f656e61626c6564272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202027737562636c617373272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020207d2c0a202020202020202020202773657474696e675f76616c756527203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202773657474696e67272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f7274696e646578272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202773657474696e675f76616c75655f6e765f756e697175655f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202773657474696e675f76616c75655f6e735f756e697175655f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f7274696e646578270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020277374617475735f776f726b666c6f7727203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276f6c645f737461747573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276275675f737461747573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e65775f737461747573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20276275675f737461747573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027726571756972655f636f6d6d656e74272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5431270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277374617475735f776f726b666c6f775f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276f6c645f737461747573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e65775f737461747573270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202774616727203d3e207b0a202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020276e616d65272c0a20202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a20202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020277461675f757365725f69645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e616d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020207d2c0a2020202020202020202027746f6b656e7327203d3e207b0a202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027697373756564617465272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027746f6b656e272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228313629270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027746f6b656e74797065272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228313629270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020276576656e7464617461272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e202754494e5954455854270a20202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202027746f6b656e735f7573657269645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365726964270a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020207d2c0a202020202020202020202774735f6572726f7227203d3e207b0a2020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276572726f725f74696d65272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276a6f626964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276d657373616765272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202774735f6572726f725f66756e6369645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276572726f725f74696d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202774735f6572726f725f6572726f725f74696d655f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276572726f725f74696d65270a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202774735f6572726f725f6a6f6269645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020276a6f626964270a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020207d2c0a202020202020202020202774735f6578697473746174757327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276a6f626964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027737461747573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f6d706c6574696f6e5f74696d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202764656c6574655f6166746572272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202774735f657869747374617475735f66756e6369645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202774735f657869747374617475735f64656c6574655f61667465725f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202764656c6574655f6166746572270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202774735f66756e636d617027203d3e207b0a20202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636e616d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202774735f66756e636d61705f66756e636e616d655f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636e616d65270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020207d2c0a202020202020202020202774735f6a6f6227203d3e207b0a202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020276a6f626964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027617267272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e47424c4f42270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027756e69716b6579272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027696e736572745f74696d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202772756e5f6166746572272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027677261626265645f756e74696c272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020277072696f72697479272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202027636f616c65736365272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a20202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202774735f6a6f625f66756e6369645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027756e69716b6579270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202774735f6a6f625f72756e5f61667465725f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202772756e5f6166746572272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964270a2020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202774735f6a6f625f636f616c657363655f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202027636f616c65736365272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202766756e636964270a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020207d2c0a202020202020202020202774735f6e6f746527203d3e207b0a20202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020276a6f626964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5434270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020276e6f74656b6579272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722832353529270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274c4f4e47424c4f42270a2020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202774735f6e6f74655f6a6f6269645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276a6f626964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276e6f74656b6579270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020207d2c0a2020202020202020202027757365725f6170695f6b65797327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5453455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276170695f6b6579272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20275641524348415228343029270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276465736372697074696f6e272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027564152434841522832353529270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277265766f6b6564272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276c6173745f75736564272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6170695f6b6579735f6170695f6b65795f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276170695f6b6579270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6170695f6b6579735f757365725f69645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202027757365725f67726f75705f6d617027203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202767726f757073272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276973626c657373272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276772616e745f74797065272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20302c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5431270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f67726f75705f6d61705f757365725f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027757365725f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202767726f75705f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276772616e745f74797065272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276973626c657373270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202776657273696f6e7327203d3e207b0a2020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f6475637473272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020276973616374697665272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202754525545272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202776657273696f6e735f70726f647563745f69645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202770726f647563745f6964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202776616c7565270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020207d2c0a2020202020202020202027776174636827203d3e207b0a2020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202777617463686572272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202777617463686564272c0a202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a202020202020202020202020202020202020202020202020202020202020202020202020207d0a20202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202777617463685f776174636865725f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202777617463686572272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202777617463686564270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027554e49515545270a20202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202777617463685f776174636865645f696478272c0a20202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202777617463686564270a20202020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020202020202020202020202020202020205d0a2020202020202020202020202020202020202020207d2c0a20202020202020202020277768696e655f6576656e747327203d3e207b0a202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276f776e65725f757365726964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e2027757365726964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e202770726f66696c6573272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277375626a656374272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722831323829270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027626f6479272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d54455854270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d61696c69666e6f62756773272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020277768696e655f7175657269657327203d3e207b0a20202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276576656e746964272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20277768696e655f6576656e7473272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202771756572795f6e616d65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228363429270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027736f72746b6579272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276f6e656d61696c706572627567272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202746414c5345272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027424f4f4c45414e270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277469746c65272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e20275c275c27272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027766172636861722831323829270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a2020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277768696e655f717565726965735f6576656e7469645f696478272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276576656e746964270a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a20202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020277768696e655f7363686564756c657327203d3e207b0a202020202020202020202020202020202020202020202020202020202020202020274649454c445327203d3e205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275052494d4152594b455927203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274d454449554d53455249414c270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276576656e746964272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275245464552454e43455327203d3e207b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202027434f4c554d4e27203d3e20276964272c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454c45544527203d3e202743415343414445272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275441424c4527203d3e20277768696e655f6576656e7473272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276372656174656427203d3e20310a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772756e5f646179272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772756e5f74696d65272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20277661726368617228333229270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772756e5f6e657874272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e20274441544554494d45270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d61696c746f272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5433270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d2c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276d61696c746f5f74797065272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202744454641554c5427203d3e202730272c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020274e4f544e554c4c27203d3e20312c0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020275459504527203d3e2027494e5432270a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a20202020202020202020202020202020202020202020202020202020202020202027494e444558455327203d3e205b0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277768696e655f7363686564756c65735f72756e5f6e6578745f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202772756e5f6e657874270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d2c0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020277768696e655f7363686564756c65735f6576656e7469645f696478272c0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205b0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020276576656e746964270a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020205d0a202020202020202020202020202020202020202020202020202020202020207d0a20202020202020207d3b0a	3.00
\.


--
-- Data for Name: category_group_map; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.category_group_map (category_id, group_id) FROM stdin;
\.


--
-- Data for Name: cc; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.cc (bug_id, who) FROM stdin;
\.


--
-- Data for Name: classifications; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.classifications (id, name, description, sortkey) FROM stdin;
1	Unclassified	Not assigned to any classification	0
\.


--
-- Data for Name: component_cc; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.component_cc (user_id, component_id) FROM stdin;
\.


--
-- Data for Name: components; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.components (id, name, product_id, initialowner, initialqacontact, description, isactive) FROM stdin;
1	TestComponent	1	1	\N	This is a test component in the test product database. This ought to be blown away and replaced with real stuff in a finished installation of Bugzilla.	1
\.


--
-- Data for Name: dependencies; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.dependencies (blocked, dependson) FROM stdin;
\.


--
-- Data for Name: duplicates; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.duplicates (dupe_of, dupe) FROM stdin;
\.


--
-- Data for Name: email_bug_ignore; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.email_bug_ignore (user_id, bug_id) FROM stdin;
\.


--
-- Data for Name: email_setting; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.email_setting (user_id, relationship, event) FROM stdin;
1	3	0
1	3	1
1	3	2
1	3	3
1	3	4
1	3	5
1	3	6
1	3	7
1	3	9
1	3	10
1	3	11
1	3	50
1	5	0
1	5	1
1	5	2
1	5	3
1	5	4
1	5	5
1	5	6
1	5	7
1	5	9
1	5	10
1	5	11
1	5	50
1	2	0
1	2	1
1	2	2
1	2	3
1	2	4
1	2	5
1	2	6
1	2	7
1	2	8
1	2	9
1	2	10
1	2	11
1	2	50
1	0	0
1	0	1
1	0	2
1	0	3
1	0	4
1	0	5
1	0	6
1	0	7
1	0	9
1	0	10
1	0	11
1	0	50
1	1	0
1	1	1
1	1	2
1	1	3
1	1	4
1	1	5
1	1	6
1	1	7
1	1	9
1	1	10
1	1	11
1	1	50
1	100	100
1	100	101
2	0	0
2	0	1
2	0	2
2	0	3
2	0	4
2	0	5
2	0	6
2	0	7
2	0	9
2	0	10
2	0	11
2	0	50
2	1	0
2	1	1
2	1	2
2	1	3
2	1	4
2	1	5
2	1	6
2	1	7
2	1	9
2	1	10
2	1	11
2	1	50
2	2	0
2	2	1
2	2	2
2	2	3
2	2	4
2	2	5
2	2	6
2	2	7
2	2	8
2	2	9
2	2	10
2	2	11
2	2	50
2	3	0
2	3	1
2	3	2
2	3	3
2	3	4
2	3	5
2	3	6
2	3	7
2	3	9
2	3	10
2	3	11
2	3	50
2	5	0
2	5	1
2	5	2
2	5	3
2	5	4
2	5	5
2	5	6
2	5	7
2	5	9
2	5	10
2	5	11
2	5	50
2	100	100
2	100	101
\.


--
-- Data for Name: field_visibility; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.field_visibility (field_id, value_id) FROM stdin;
\.


--
-- Data for Name: fielddefs; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.fielddefs (id, name, type, custom, description, long_desc, mailhead, sortkey, obsolete, enter_bug, buglist, visibility_field_id, value_field_id, reverse_desc, is_mandatory, is_numeric) FROM stdin;
1	bug_id	0	0	Bug #		1	100	0	0	1	\N	\N	\N	0	1
2	short_desc	0	0	Summary		1	200	0	0	1	\N	\N	\N	1	0
3	classification	2	0	Classification		1	300	0	0	1	\N	\N	\N	0	0
4	product	2	0	Product		1	400	0	0	1	\N	\N	\N	1	0
5	version	0	0	Version		1	500	0	0	1	\N	\N	\N	1	0
6	rep_platform	2	0	Platform		1	600	0	0	1	\N	\N	\N	0	0
7	bug_file_loc	0	0	URL		1	700	0	0	1	\N	\N	\N	0	0
8	op_sys	2	0	OS/Version		1	800	0	0	1	\N	\N	\N	0	0
9	bug_status	2	0	Status		1	900	0	0	1	\N	\N	\N	0	0
10	status_whiteboard	0	0	Status Whiteboard		1	1000	0	0	1	\N	\N	\N	0	0
11	keywords	8	0	Keywords		1	1100	0	0	1	\N	\N	\N	0	0
12	resolution	2	0	Resolution		0	1200	0	0	1	\N	\N	\N	0	0
13	bug_severity	2	0	Severity		1	1300	0	0	1	\N	\N	\N	0	0
14	priority	2	0	Priority		1	1400	0	0	1	\N	\N	\N	0	0
15	component	2	0	Component		1	1500	0	0	1	\N	\N	\N	1	0
16	assigned_to	0	0	AssignedTo		1	1600	0	0	1	\N	\N	\N	0	0
17	reporter	0	0	ReportedBy		1	1700	0	0	1	\N	\N	\N	0	0
18	qa_contact	0	0	QAContact		1	1800	0	0	1	\N	\N	\N	0	0
19	assigned_to_realname	0	0	AssignedToName		0	1900	0	0	1	\N	\N	\N	0	0
20	reporter_realname	0	0	ReportedByName		0	2000	0	0	1	\N	\N	\N	0	0
21	qa_contact_realname	0	0	QAContactName		0	2100	0	0	1	\N	\N	\N	0	0
22	cc	0	0	CC		1	2200	0	0	0	\N	\N	\N	0	0
23	dependson	0	0	Depends on		1	2300	0	0	1	\N	\N	\N	0	1
24	blocked	0	0	Blocks		1	2400	0	0	1	\N	\N	\N	0	1
25	attachments.description	0	0	Attachment description		0	2500	0	0	0	\N	\N	\N	0	0
26	attachments.filename	0	0	Attachment filename		0	2600	0	0	0	\N	\N	\N	0	0
27	attachments.mimetype	0	0	Attachment mime type		0	2700	0	0	0	\N	\N	\N	0	0
28	attachments.ispatch	0	0	Attachment is patch		0	2800	0	0	0	\N	\N	\N	0	1
29	attachments.isobsolete	0	0	Attachment is obsolete		0	2900	0	0	0	\N	\N	\N	0	1
30	attachments.isprivate	0	0	Attachment is private		0	3000	0	0	0	\N	\N	\N	0	1
31	attachments.submitter	0	0	Attachment creator		0	3100	0	0	0	\N	\N	\N	0	0
32	target_milestone	0	0	Target Milestone		1	3200	0	0	1	\N	\N	\N	0	0
33	creation_ts	0	0	Creation date		0	3300	0	0	1	\N	\N	\N	0	0
34	delta_ts	0	0	Last changed date		0	3400	0	0	1	\N	\N	\N	0	0
35	longdesc	0	0	Comment		0	3500	0	0	0	\N	\N	\N	0	0
36	longdescs.isprivate	0	0	Comment is private		0	3600	0	0	0	\N	\N	\N	0	1
37	longdescs.count	0	0	Number of Comments		0	3700	0	0	1	\N	\N	\N	0	1
38	alias	0	0	Alias		0	3800	0	0	1	\N	\N	\N	0	0
39	everconfirmed	0	0	Ever Confirmed		0	3900	0	0	0	\N	\N	\N	0	1
40	reporter_accessible	0	0	Reporter Accessible		0	4000	0	0	0	\N	\N	\N	0	1
41	cclist_accessible	0	0	CC Accessible		0	4100	0	0	0	\N	\N	\N	0	1
42	bug_group	0	0	Group		1	4200	0	0	0	\N	\N	\N	0	0
43	estimated_time	0	0	Estimated Hours		1	4300	0	0	1	\N	\N	\N	0	1
44	remaining_time	0	0	Remaining Hours		0	4400	0	0	1	\N	\N	\N	0	1
45	deadline	5	0	Deadline		1	4500	0	0	1	\N	\N	\N	0	0
46	commenter	0	0	Commenter		0	4600	0	0	0	\N	\N	\N	0	0
47	flagtypes.name	0	0	Flags		0	4700	0	0	1	\N	\N	\N	0	0
48	requestees.login_name	0	0	Flag Requestee		0	4800	0	0	0	\N	\N	\N	0	0
49	setters.login_name	0	0	Flag Setter		0	4900	0	0	0	\N	\N	\N	0	0
50	work_time	0	0	Hours Worked		0	5000	0	0	1	\N	\N	\N	0	1
51	percentage_complete	0	0	Percentage Complete		0	5100	0	0	1	\N	\N	\N	0	1
52	content	0	0	Content		0	5200	0	0	0	\N	\N	\N	0	0
53	attach_data.thedata	0	0	Attachment data		0	5300	0	0	0	\N	\N	\N	0	0
54	owner_idle_time	0	0	Time Since Assignee Touched		0	5400	0	0	0	\N	\N	\N	0	0
55	see_also	7	0	See Also		0	5500	0	0	0	\N	\N	\N	0	0
56	tag	8	0	Personal Tags		0	5600	0	0	1	\N	\N	\N	0	0
57	last_visit_ts	5	0	Last Visit		0	5700	0	0	1	\N	\N	\N	0	0
58	comment_tag	0	0	Comment Tag		0	5800	0	0	0	\N	\N	\N	0	0
59	days_elapsed	0	0	Days since bug changed		0	5900	0	0	0	\N	\N	\N	0	0
\.


--
-- Data for Name: flagexclusions; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.flagexclusions (type_id, product_id, component_id) FROM stdin;
\.


--
-- Data for Name: flaginclusions; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.flaginclusions (type_id, product_id, component_id) FROM stdin;
\.


--
-- Data for Name: flags; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.flags (id, type_id, status, bug_id, attach_id, creation_date, modification_date, setter_id, requestee_id) FROM stdin;
\.


--
-- Data for Name: flagtypes; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.flagtypes (id, name, description, cc_list, target_type, is_active, is_requestable, is_requesteeble, is_multiplicable, sortkey, grant_group_id, request_group_id) FROM stdin;
\.


--
-- Data for Name: group_control_map; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.group_control_map (group_id, product_id, entry, membercontrol, othercontrol, canedit, editcomponents, editbugs, canconfirm) FROM stdin;
\.


--
-- Data for Name: group_group_map; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.group_group_map (member_id, grantor_id, grant_type) FROM stdin;
1	1	0
1	1	1
1	1	2
1	2	0
1	2	1
1	2	2
1	3	0
1	3	1
1	3	2
1	4	0
1	4	1
1	4	2
1	5	0
1	5	1
1	5	2
1	6	0
1	6	1
1	6	2
1	7	0
1	7	1
1	7	2
1	8	0
1	8	1
1	8	2
1	9	0
1	9	1
1	9	2
1	10	0
1	10	1
1	10	2
1	11	0
1	11	1
1	11	2
8	11	0
10	11	0
1	12	0
1	12	1
1	12	2
1	13	0
1	13	1
1	13	2
12	13	0
1	14	0
1	14	1
1	14	2
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.groups (id, name, description, isbuggroup, userregexp, isactive, icon_url) FROM stdin;
1	admin	Administrators	0		1	\N
2	tweakparams	Can change Parameters	0		1	\N
3	editusers	Can edit or disable users	0		1	\N
4	creategroups	Can create and destroy groups	0		1	\N
5	editclassifications	Can create, destroy, and edit classifications	0		1	\N
6	editcomponents	Can create, destroy, and edit components	0		1	\N
7	editkeywords	Can create, destroy, and edit keywords	0		1	\N
8	editbugs	Can edit all bug fields	0	.*	1	\N
9	canconfirm	Can confirm a bug or mark it a duplicate	0		1	\N
10	bz_canusewhineatothers	Can configure whine reports for other users	0		1	\N
11	bz_canusewhines	User can configure whine reports for self	0		1	\N
12	bz_sudoers	Can perform actions as other users	0		1	\N
13	bz_sudo_protect	Can not be impersonated by other users	0		1	\N
14	bz_quip_moderators	Can moderate quips	0		1	\N
\.


--
-- Data for Name: keyworddefs; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.keyworddefs (id, name, description) FROM stdin;
\.


--
-- Data for Name: keywords; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.keywords (bug_id, keywordid) FROM stdin;
\.


--
-- Data for Name: login_failure; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.login_failure (user_id, login_time, ip_addr) FROM stdin;
\.


--
-- Data for Name: logincookies; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.logincookies (cookie, userid, ipaddr, lastused) FROM stdin;
aMt7W96iBJ	1	\N	2023-12-21 03:39:54
\.


--
-- Data for Name: longdescs; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.longdescs (comment_id, bug_id, who, bug_when, work_time, thetext, isprivate, already_wrapped, type, extra_data) FROM stdin;
\.


--
-- Data for Name: longdescs_tags; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.longdescs_tags (id, comment_id, tag) FROM stdin;
\.


--
-- Data for Name: longdescs_tags_activity; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.longdescs_tags_activity (id, bug_id, comment_id, who, bug_when, added, removed) FROM stdin;
\.


--
-- Data for Name: longdescs_tags_weights; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.longdescs_tags_weights (id, tag, weight) FROM stdin;
\.


--
-- Data for Name: mail_staging; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.mail_staging (id, message) FROM stdin;
\.


--
-- Data for Name: milestones; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.milestones (id, product_id, value, sortkey, isactive) FROM stdin;
1	1	---	0	1
\.


--
-- Data for Name: namedqueries; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.namedqueries (id, userid, name, query) FROM stdin;
\.


--
-- Data for Name: namedqueries_link_in_footer; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.namedqueries_link_in_footer (namedquery_id, user_id) FROM stdin;
\.


--
-- Data for Name: namedquery_group_map; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.namedquery_group_map (namedquery_id, group_id) FROM stdin;
\.


--
-- Data for Name: op_sys; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.op_sys (id, value, sortkey, isactive, visibility_value_id) FROM stdin;
1	All	100	1	\N
2	Windows	200	1	\N
3	Mac OS	300	1	\N
4	Linux	400	1	\N
5	Other	500	1	\N
\.


--
-- Data for Name: priority; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.priority (id, value, sortkey, isactive, visibility_value_id) FROM stdin;
1	Highest	100	1	\N
2	High	200	1	\N
3	Normal	300	1	\N
4	Low	400	1	\N
5	Lowest	500	1	\N
6	---	600	1	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.products (id, name, classification_id, description, isactive, defaultmilestone, allows_unconfirmed) FROM stdin;
1	TestProduct	1	This is a test product. This ought to be blown away and replaced with real stuff in a finished installation of bugzilla.	1	---	1
\.


--
-- Data for Name: profile_search; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.profile_search (id, user_id, bug_list, list_order) FROM stdin;
\.


--
-- Data for Name: profile_setting; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.profile_setting (user_id, setting_name, setting_value) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.profiles (userid, login_name, cryptpassword, realname, disabledtext, disable_mail, mybugslink, extern_id, is_enabled, last_seen_date) FROM stdin;
2	rj.ravindra@kenestechnology.net	KOVZxtxt,uiWsNZgBRmsPsBypzuy2ZypCUCbBSGMFfi3MR/8EZkg{SHA-256}	rj.ravindra@kenestechnology.net		1	1	\N	1	\N
1	khazi.devops@gmail.com	F8mQbLm6,5wep5mJGtzaWgrcLlVoLUgVFhnorfs0Fy0gqra1uUjU{SHA-256}	administrator		0	1	\N	1	2023-12-21 00:00:00
\.


--
-- Data for Name: profiles_activity; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.profiles_activity (id, userid, who, profiles_when, fieldid, oldvalue, newvalue) FROM stdin;
1	1	1	2023-12-20 10:55:01	33	\N	2023-12-20 10:55:00.713158+00
2	2	1	2023-12-20 11:29:57	33	\N	2023-12-20 11:29:56.553495+00
\.


--
-- Data for Name: quips; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.quips (quipid, userid, quip, approved) FROM stdin;
\.


--
-- Data for Name: rep_platform; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.rep_platform (id, value, sortkey, isactive, visibility_value_id) FROM stdin;
1	All	100	1	\N
2	PC	200	1	\N
3	Macintosh	300	1	\N
4	Other	400	1	\N
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.reports (id, user_id, name, query) FROM stdin;
\.


--
-- Data for Name: resolution; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.resolution (id, value, sortkey, isactive, visibility_value_id) FROM stdin;
1		100	1	\N
2	FIXED	200	1	\N
3	INVALID	300	1	\N
4	WONTFIX	400	1	\N
5	DUPLICATE	500	1	\N
6	WORKSFORME	600	1	\N
\.


--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.series (series_id, creator, category, subcategory, name, frequency, query, is_public) FROM stdin;
\.


--
-- Data for Name: series_categories; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.series_categories (id, name) FROM stdin;
\.


--
-- Data for Name: series_data; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.series_data (series_id, series_date, series_value) FROM stdin;
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.setting (name, default_value, is_enabled, subclass) FROM stdin;
state_addselfcc	cc_unless_role	1	\N
timezone	local	1	Timezone
zoom_textareas	on	1	\N
comment_sort_order	oldest_to_newest	1	\N
possible_duplicates	on	1	\N
lang	en	1	Lang
email_format	html	1	\N
display_quips	on	1	\N
quicksearch_fulltext	on	1	\N
requestee_cc	on	1	\N
comment_box_position	before_comments	1	\N
csv_colsepchar	,	1	\N
bugmail_new_prefix	on	1	\N
quote_replies	quoted_reply	1	\N
skin	Dusk	1	Skin
post_bug_submit_action	next_bug	1	\N
\.


--
-- Data for Name: setting_value; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.setting_value (name, value, sortindex) FROM stdin;
state_addselfcc	always	5
state_addselfcc	never	10
state_addselfcc	cc_unless_role	15
zoom_textareas	on	5
zoom_textareas	off	10
comment_sort_order	oldest_to_newest	5
comment_sort_order	newest_to_oldest	10
comment_sort_order	newest_to_oldest_desc_first	15
possible_duplicates	on	5
possible_duplicates	off	10
email_format	html	5
email_format	text_only	10
display_quips	on	5
display_quips	off	10
quicksearch_fulltext	on	5
quicksearch_fulltext	off	10
requestee_cc	on	5
requestee_cc	off	10
comment_box_position	before_comments	5
comment_box_position	after_comments	10
csv_colsepchar	,	5
csv_colsepchar	;	10
bugmail_new_prefix	on	5
bugmail_new_prefix	off	10
quote_replies	quoted_reply	5
quote_replies	simple_reply	10
quote_replies	off	15
post_bug_submit_action	next_bug	5
post_bug_submit_action	same_bug	10
post_bug_submit_action	nothing	15
\.


--
-- Data for Name: status_workflow; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.status_workflow (old_status, new_status, require_comment) FROM stdin;
\N	1	0
\N	2	0
\N	3	0
1	2	0
1	3	0
1	4	0
2	3	0
2	4	0
3	2	0
3	4	0
4	1	0
4	2	0
4	5	0
5	1	0
5	2	0
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.tag (id, name, user_id) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.tokens (userid, issuedate, token, tokentype, eventdata) FROM stdin;
1	2023-12-20 11:30:10	FwTX1FZZ1C	session	add_user
1	2023-12-20 11:31:03	PwQSoz3wCA	session	add_user
1	2023-12-21 03:38:32	DvejektGmZ	session	edit_user_prefs
1	2023-12-21 03:38:32	dY5mrYVtn8	api_token	
1	2023-12-21 03:39:51	bLvH3CzYHf	session	edit_user_prefs
1	2023-12-21 03:39:54	a6AlkhRjOp	session	create_bug
\.


--
-- Data for Name: ts_error; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.ts_error (error_time, jobid, message, funcid) FROM stdin;
\.


--
-- Data for Name: ts_exitstatus; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.ts_exitstatus (jobid, funcid, status, completion_time, delete_after) FROM stdin;
\.


--
-- Data for Name: ts_funcmap; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.ts_funcmap (funcid, funcname) FROM stdin;
\.


--
-- Data for Name: ts_job; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.ts_job (jobid, funcid, arg, uniqkey, insert_time, run_after, grabbed_until, priority, "coalesce") FROM stdin;
\.


--
-- Data for Name: ts_note; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.ts_note (jobid, notekey, value) FROM stdin;
\.


--
-- Data for Name: user_api_keys; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.user_api_keys (id, user_id, api_key, description, revoked, last_used) FROM stdin;
\.


--
-- Data for Name: user_group_map; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.user_group_map (user_id, group_id, isbless, grant_type) FROM stdin;
1	8	0	2
1	1	0	0
1	1	1	0
1	3	0	0
2	8	0	2
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.versions (id, value, product_id, isactive) FROM stdin;
1	unspecified	1	1
\.


--
-- Data for Name: watch; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.watch (watcher, watched) FROM stdin;
\.


--
-- Data for Name: whine_events; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.whine_events (id, owner_userid, subject, body, mailifnobugs) FROM stdin;
\.


--
-- Data for Name: whine_queries; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.whine_queries (id, eventid, query_name, sortkey, onemailperbug, title) FROM stdin;
\.


--
-- Data for Name: whine_schedules; Type: TABLE DATA; Schema: public; Owner: bugs
--

COPY public.whine_schedules (id, eventid, run_day, run_time, run_next, mailto, mailto_type) FROM stdin;
\.


--
-- Name: attachments_attach_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.attachments_attach_id_seq', 1, false);


--
-- Name: bug_see_also_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.bug_see_also_id_seq', 1, false);


--
-- Name: bug_severity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.bug_severity_id_seq', 7, true);


--
-- Name: bug_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.bug_status_id_seq', 5, true);


--
-- Name: bug_user_last_visit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.bug_user_last_visit_id_seq', 1, false);


--
-- Name: bugs_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.bugs_activity_id_seq', 1, false);


--
-- Name: bugs_bug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.bugs_bug_id_seq', 1, false);


--
-- Name: classifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.classifications_id_seq', 1, true);


--
-- Name: components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.components_id_seq', 1, true);


--
-- Name: fielddefs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.fielddefs_id_seq', 59, true);


--
-- Name: flags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.flags_id_seq', 1, false);


--
-- Name: flagtypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.flagtypes_id_seq', 1, false);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.groups_id_seq', 14, true);


--
-- Name: keyworddefs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.keyworddefs_id_seq', 1, false);


--
-- Name: longdescs_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.longdescs_comment_id_seq', 1, false);


--
-- Name: longdescs_tags_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.longdescs_tags_activity_id_seq', 1, false);


--
-- Name: longdescs_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.longdescs_tags_id_seq', 1, false);


--
-- Name: longdescs_tags_weights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.longdescs_tags_weights_id_seq', 1, false);


--
-- Name: mail_staging_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.mail_staging_id_seq', 1, false);


--
-- Name: milestones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.milestones_id_seq', 1, true);


--
-- Name: namedqueries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.namedqueries_id_seq', 1, false);


--
-- Name: op_sys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.op_sys_id_seq', 5, true);


--
-- Name: priority_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.priority_id_seq', 6, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.products_id_seq', 1, true);


--
-- Name: profile_search_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.profile_search_id_seq', 1, false);


--
-- Name: profiles_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.profiles_activity_id_seq', 2, true);


--
-- Name: profiles_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.profiles_userid_seq', 2, true);


--
-- Name: quips_quipid_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.quips_quipid_seq', 1, false);


--
-- Name: rep_platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.rep_platform_id_seq', 4, true);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.reports_id_seq', 1, false);


--
-- Name: resolution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.resolution_id_seq', 6, true);


--
-- Name: series_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.series_categories_id_seq', 1, false);


--
-- Name: series_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.series_series_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: ts_exitstatus_jobid_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.ts_exitstatus_jobid_seq', 1, false);


--
-- Name: ts_funcmap_funcid_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.ts_funcmap_funcid_seq', 1, false);


--
-- Name: ts_job_jobid_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.ts_job_jobid_seq', 1, false);


--
-- Name: user_api_keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.user_api_keys_id_seq', 1, false);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.versions_id_seq', 1, true);


--
-- Name: whine_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.whine_events_id_seq', 1, false);


--
-- Name: whine_queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.whine_queries_id_seq', 1, false);


--
-- Name: whine_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bugs
--

SELECT pg_catalog.setval('public.whine_schedules_id_seq', 1, false);


--
-- Name: attach_data attach_data_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.attach_data
    ADD CONSTRAINT attach_data_pkey PRIMARY KEY (id);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (attach_id);


--
-- Name: bug_see_also bug_see_also_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_see_also
    ADD CONSTRAINT bug_see_also_pkey PRIMARY KEY (id);


--
-- Name: bug_severity bug_severity_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_severity
    ADD CONSTRAINT bug_severity_pkey PRIMARY KEY (id);


--
-- Name: bug_status bug_status_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_status
    ADD CONSTRAINT bug_status_pkey PRIMARY KEY (id);


--
-- Name: bug_user_last_visit bug_user_last_visit_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_user_last_visit
    ADD CONSTRAINT bug_user_last_visit_pkey PRIMARY KEY (id);


--
-- Name: bugs_activity bugs_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_activity
    ADD CONSTRAINT bugs_activity_pkey PRIMARY KEY (id);


--
-- Name: bugs_fulltext bugs_fulltext_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_fulltext
    ADD CONSTRAINT bugs_fulltext_pkey PRIMARY KEY (bug_id);


--
-- Name: bugs bugs_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs
    ADD CONSTRAINT bugs_pkey PRIMARY KEY (bug_id);


--
-- Name: classifications classifications_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.classifications
    ADD CONSTRAINT classifications_pkey PRIMARY KEY (id);


--
-- Name: components components_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);


--
-- Name: duplicates duplicates_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.duplicates
    ADD CONSTRAINT duplicates_pkey PRIMARY KEY (dupe);


--
-- Name: fielddefs fielddefs_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.fielddefs
    ADD CONSTRAINT fielddefs_pkey PRIMARY KEY (id);


--
-- Name: flags flags_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT flags_pkey PRIMARY KEY (id);


--
-- Name: flagtypes flagtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flagtypes
    ADD CONSTRAINT flagtypes_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: keyworddefs keyworddefs_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.keyworddefs
    ADD CONSTRAINT keyworddefs_pkey PRIMARY KEY (id);


--
-- Name: logincookies logincookies_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.logincookies
    ADD CONSTRAINT logincookies_pkey PRIMARY KEY (cookie);


--
-- Name: longdescs longdescs_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs
    ADD CONSTRAINT longdescs_pkey PRIMARY KEY (comment_id);


--
-- Name: longdescs_tags_activity longdescs_tags_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags_activity
    ADD CONSTRAINT longdescs_tags_activity_pkey PRIMARY KEY (id);


--
-- Name: longdescs_tags longdescs_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags
    ADD CONSTRAINT longdescs_tags_pkey PRIMARY KEY (id);


--
-- Name: longdescs_tags_weights longdescs_tags_weights_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags_weights
    ADD CONSTRAINT longdescs_tags_weights_pkey PRIMARY KEY (id);


--
-- Name: mail_staging mail_staging_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.mail_staging
    ADD CONSTRAINT mail_staging_pkey PRIMARY KEY (id);


--
-- Name: milestones milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id);


--
-- Name: namedqueries namedqueries_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.namedqueries
    ADD CONSTRAINT namedqueries_pkey PRIMARY KEY (id);


--
-- Name: op_sys op_sys_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.op_sys
    ADD CONSTRAINT op_sys_pkey PRIMARY KEY (id);


--
-- Name: priority priority_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.priority
    ADD CONSTRAINT priority_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: profile_search profile_search_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profile_search
    ADD CONSTRAINT profile_search_pkey PRIMARY KEY (id);


--
-- Name: profiles_activity profiles_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profiles_activity
    ADD CONSTRAINT profiles_activity_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (userid);


--
-- Name: quips quips_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.quips
    ADD CONSTRAINT quips_pkey PRIMARY KEY (quipid);


--
-- Name: rep_platform rep_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.rep_platform
    ADD CONSTRAINT rep_platform_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: resolution resolution_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.resolution
    ADD CONSTRAINT resolution_pkey PRIMARY KEY (id);


--
-- Name: series_categories series_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.series_categories
    ADD CONSTRAINT series_categories_pkey PRIMARY KEY (id);


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (series_id);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (name);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (token);


--
-- Name: ts_exitstatus ts_exitstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.ts_exitstatus
    ADD CONSTRAINT ts_exitstatus_pkey PRIMARY KEY (jobid);


--
-- Name: ts_funcmap ts_funcmap_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.ts_funcmap
    ADD CONSTRAINT ts_funcmap_pkey PRIMARY KEY (funcid);


--
-- Name: ts_job ts_job_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.ts_job
    ADD CONSTRAINT ts_job_pkey PRIMARY KEY (jobid);


--
-- Name: user_api_keys user_api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.user_api_keys
    ADD CONSTRAINT user_api_keys_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: whine_events whine_events_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_events
    ADD CONSTRAINT whine_events_pkey PRIMARY KEY (id);


--
-- Name: whine_queries whine_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_queries
    ADD CONSTRAINT whine_queries_pkey PRIMARY KEY (id);


--
-- Name: whine_schedules whine_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_schedules
    ADD CONSTRAINT whine_schedules_pkey PRIMARY KEY (id);


--
-- Name: attachments_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX attachments_bug_id_idx ON public.attachments USING btree (bug_id);


--
-- Name: attachments_creation_ts_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX attachments_creation_ts_idx ON public.attachments USING btree (creation_ts);


--
-- Name: attachments_modification_time_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX attachments_modification_time_idx ON public.attachments USING btree (modification_time);


--
-- Name: attachments_submitter_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX attachments_submitter_id_idx ON public.attachments USING btree (submitter_id, bug_id);


--
-- Name: audit_log_class_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX audit_log_class_idx ON public.audit_log USING btree (class, at_time);


--
-- Name: bug_group_map_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX bug_group_map_bug_id_idx ON public.bug_group_map USING btree (bug_id, group_id);


--
-- Name: bug_group_map_group_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bug_group_map_group_id_idx ON public.bug_group_map USING btree (group_id);


--
-- Name: bug_see_also_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX bug_see_also_bug_id_idx ON public.bug_see_also USING btree (bug_id, value);


--
-- Name: bug_severity_sortkey_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bug_severity_sortkey_idx ON public.bug_severity USING btree (sortkey, value);


--
-- Name: bug_severity_value_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX bug_severity_value_idx ON public.bug_severity USING btree (value);


--
-- Name: bug_severity_visibility_value_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bug_severity_visibility_value_id_idx ON public.bug_severity USING btree (visibility_value_id);


--
-- Name: bug_status_sortkey_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bug_status_sortkey_idx ON public.bug_status USING btree (sortkey, value);


--
-- Name: bug_status_value_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX bug_status_value_idx ON public.bug_status USING btree (value);


--
-- Name: bug_status_visibility_value_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bug_status_visibility_value_id_idx ON public.bug_status USING btree (visibility_value_id);


--
-- Name: bug_tag_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX bug_tag_bug_id_idx ON public.bug_tag USING btree (bug_id, tag_id);


--
-- Name: bug_user_last_visit_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX bug_user_last_visit_idx ON public.bug_user_last_visit USING btree (user_id, bug_id);


--
-- Name: bug_user_last_visit_last_visit_ts_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bug_user_last_visit_last_visit_ts_idx ON public.bug_user_last_visit USING btree (last_visit_ts);


--
-- Name: bugs_activity_added_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_activity_added_idx ON public.bugs_activity USING btree (added);


--
-- Name: bugs_activity_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_activity_bug_id_idx ON public.bugs_activity USING btree (bug_id);


--
-- Name: bugs_activity_bug_when_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_activity_bug_when_idx ON public.bugs_activity USING btree (bug_when);


--
-- Name: bugs_activity_fieldid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_activity_fieldid_idx ON public.bugs_activity USING btree (fieldid);


--
-- Name: bugs_activity_removed_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_activity_removed_idx ON public.bugs_activity USING btree (removed);


--
-- Name: bugs_activity_who_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_activity_who_idx ON public.bugs_activity USING btree (who);


--
-- Name: bugs_aliases_alias_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX bugs_aliases_alias_idx ON public.bugs_aliases USING btree (alias);


--
-- Name: bugs_aliases_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_aliases_bug_id_idx ON public.bugs_aliases USING btree (bug_id);


--
-- Name: bugs_assigned_to_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_assigned_to_idx ON public.bugs USING btree (assigned_to);


--
-- Name: bugs_bug_severity_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_bug_severity_idx ON public.bugs USING btree (bug_severity);


--
-- Name: bugs_bug_status_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_bug_status_idx ON public.bugs USING btree (bug_status);


--
-- Name: bugs_component_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_component_id_idx ON public.bugs USING btree (component_id);


--
-- Name: bugs_creation_ts_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_creation_ts_idx ON public.bugs USING btree (creation_ts);


--
-- Name: bugs_delta_ts_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_delta_ts_idx ON public.bugs USING btree (delta_ts);


--
-- Name: bugs_fulltext_short_desc_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_fulltext_short_desc_idx ON public.bugs_fulltext USING btree (short_desc);


--
-- Name: bugs_op_sys_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_op_sys_idx ON public.bugs USING btree (op_sys);


--
-- Name: bugs_priority_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_priority_idx ON public.bugs USING btree (priority);


--
-- Name: bugs_product_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_product_id_idx ON public.bugs USING btree (product_id);


--
-- Name: bugs_qa_contact_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_qa_contact_idx ON public.bugs USING btree (qa_contact);


--
-- Name: bugs_reporter_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_reporter_idx ON public.bugs USING btree (reporter);


--
-- Name: bugs_resolution_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_resolution_idx ON public.bugs USING btree (resolution);


--
-- Name: bugs_target_milestone_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_target_milestone_idx ON public.bugs USING btree (target_milestone);


--
-- Name: bugs_version_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX bugs_version_idx ON public.bugs USING btree (version);


--
-- Name: category_group_map_category_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX category_group_map_category_id_idx ON public.category_group_map USING btree (category_id, group_id);


--
-- Name: cc_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX cc_bug_id_idx ON public.cc USING btree (bug_id, who);


--
-- Name: cc_who_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX cc_who_idx ON public.cc USING btree (who);


--
-- Name: classifications_name_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX classifications_name_idx ON public.classifications USING btree (name);


--
-- Name: component_cc_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX component_cc_user_id_idx ON public.component_cc USING btree (component_id, user_id);


--
-- Name: components_name_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX components_name_idx ON public.components USING btree (name);


--
-- Name: components_product_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX components_product_id_idx ON public.components USING btree (product_id, name);


--
-- Name: dependencies_blocked_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX dependencies_blocked_idx ON public.dependencies USING btree (blocked, dependson);


--
-- Name: dependencies_dependson_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX dependencies_dependson_idx ON public.dependencies USING btree (dependson);


--
-- Name: email_bug_ignore_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX email_bug_ignore_user_id_idx ON public.email_bug_ignore USING btree (user_id, bug_id);


--
-- Name: email_setting_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX email_setting_user_id_idx ON public.email_setting USING btree (user_id, relationship, event);


--
-- Name: field_visibility_field_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX field_visibility_field_id_idx ON public.field_visibility USING btree (field_id, value_id);


--
-- Name: fielddefs_is_mandatory_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX fielddefs_is_mandatory_idx ON public.fielddefs USING btree (is_mandatory);


--
-- Name: fielddefs_name_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX fielddefs_name_idx ON public.fielddefs USING btree (name);


--
-- Name: fielddefs_name_lower_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX fielddefs_name_lower_idx ON public.fielddefs USING btree (lower((name)::text));


--
-- Name: fielddefs_sortkey_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX fielddefs_sortkey_idx ON public.fielddefs USING btree (sortkey);


--
-- Name: fielddefs_value_field_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX fielddefs_value_field_id_idx ON public.fielddefs USING btree (value_field_id);


--
-- Name: flagexclusions_type_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX flagexclusions_type_id_idx ON public.flagexclusions USING btree (type_id, product_id, component_id);


--
-- Name: flaginclusions_type_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX flaginclusions_type_id_idx ON public.flaginclusions USING btree (type_id, product_id, component_id);


--
-- Name: flags_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX flags_bug_id_idx ON public.flags USING btree (bug_id, attach_id);


--
-- Name: flags_requestee_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX flags_requestee_id_idx ON public.flags USING btree (requestee_id);


--
-- Name: flags_setter_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX flags_setter_id_idx ON public.flags USING btree (setter_id);


--
-- Name: flags_type_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX flags_type_id_idx ON public.flags USING btree (type_id);


--
-- Name: group_control_map_group_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX group_control_map_group_id_idx ON public.group_control_map USING btree (group_id);


--
-- Name: group_control_map_product_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX group_control_map_product_id_idx ON public.group_control_map USING btree (product_id, group_id);


--
-- Name: group_group_map_member_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX group_group_map_member_id_idx ON public.group_group_map USING btree (member_id, grantor_id, grant_type);


--
-- Name: groups_name_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX groups_name_idx ON public.groups USING btree (name);


--
-- Name: keyworddefs_name_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX keyworddefs_name_idx ON public.keyworddefs USING btree (name);


--
-- Name: keyworddefs_name_lower_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX keyworddefs_name_lower_idx ON public.keyworddefs USING btree (lower((name)::text));


--
-- Name: keywords_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX keywords_bug_id_idx ON public.keywords USING btree (bug_id, keywordid);


--
-- Name: keywords_keywordid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX keywords_keywordid_idx ON public.keywords USING btree (keywordid);


--
-- Name: login_failure_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX login_failure_user_id_idx ON public.login_failure USING btree (user_id);


--
-- Name: logincookies_lastused_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX logincookies_lastused_idx ON public.logincookies USING btree (lastused);


--
-- Name: longdescs_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX longdescs_bug_id_idx ON public.longdescs USING btree (bug_id, work_time);


--
-- Name: longdescs_bug_when_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX longdescs_bug_when_idx ON public.longdescs USING btree (bug_when);


--
-- Name: longdescs_tags_activity_bug_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX longdescs_tags_activity_bug_id_idx ON public.longdescs_tags_activity USING btree (bug_id);


--
-- Name: longdescs_tags_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX longdescs_tags_idx ON public.longdescs_tags USING btree (comment_id, tag);


--
-- Name: longdescs_tags_weights_tag_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX longdescs_tags_weights_tag_idx ON public.longdescs_tags_weights USING btree (tag);


--
-- Name: longdescs_who_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX longdescs_who_idx ON public.longdescs USING btree (who, bug_id);


--
-- Name: milestones_product_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX milestones_product_id_idx ON public.milestones USING btree (product_id, value);


--
-- Name: namedqueries_link_in_footer_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX namedqueries_link_in_footer_id_idx ON public.namedqueries_link_in_footer USING btree (namedquery_id, user_id);


--
-- Name: namedqueries_link_in_footer_userid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX namedqueries_link_in_footer_userid_idx ON public.namedqueries_link_in_footer USING btree (user_id);


--
-- Name: namedqueries_userid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX namedqueries_userid_idx ON public.namedqueries USING btree (userid, name);


--
-- Name: namedquery_group_map_group_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX namedquery_group_map_group_id_idx ON public.namedquery_group_map USING btree (group_id);


--
-- Name: namedquery_group_map_namedquery_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX namedquery_group_map_namedquery_id_idx ON public.namedquery_group_map USING btree (namedquery_id);


--
-- Name: op_sys_sortkey_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX op_sys_sortkey_idx ON public.op_sys USING btree (sortkey, value);


--
-- Name: op_sys_value_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX op_sys_value_idx ON public.op_sys USING btree (value);


--
-- Name: op_sys_visibility_value_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX op_sys_visibility_value_id_idx ON public.op_sys USING btree (visibility_value_id);


--
-- Name: priority_sortkey_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX priority_sortkey_idx ON public.priority USING btree (sortkey, value);


--
-- Name: priority_value_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX priority_value_idx ON public.priority USING btree (value);


--
-- Name: priority_visibility_value_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX priority_visibility_value_id_idx ON public.priority USING btree (visibility_value_id);


--
-- Name: products_name_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX products_name_idx ON public.products USING btree (name);


--
-- Name: products_name_lower_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX products_name_lower_idx ON public.products USING btree (lower((name)::text));


--
-- Name: profile_search_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX profile_search_user_id_idx ON public.profile_search USING btree (user_id);


--
-- Name: profile_setting_value_unique_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX profile_setting_value_unique_idx ON public.profile_setting USING btree (user_id, setting_name);


--
-- Name: profiles_activity_fieldid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX profiles_activity_fieldid_idx ON public.profiles_activity USING btree (fieldid);


--
-- Name: profiles_activity_profiles_when_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX profiles_activity_profiles_when_idx ON public.profiles_activity USING btree (profiles_when);


--
-- Name: profiles_activity_userid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX profiles_activity_userid_idx ON public.profiles_activity USING btree (userid);


--
-- Name: profiles_extern_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX profiles_extern_id_idx ON public.profiles USING btree (extern_id);


--
-- Name: profiles_login_name_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX profiles_login_name_idx ON public.profiles USING btree (login_name);


--
-- Name: profiles_login_name_lower_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX profiles_login_name_lower_idx ON public.profiles USING btree (lower((login_name)::text));


--
-- Name: rep_platform_sortkey_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX rep_platform_sortkey_idx ON public.rep_platform USING btree (sortkey, value);


--
-- Name: rep_platform_value_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX rep_platform_value_idx ON public.rep_platform USING btree (value);


--
-- Name: rep_platform_visibility_value_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX rep_platform_visibility_value_id_idx ON public.rep_platform USING btree (visibility_value_id);


--
-- Name: reports_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX reports_user_id_idx ON public.reports USING btree (user_id, name);


--
-- Name: resolution_sortkey_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX resolution_sortkey_idx ON public.resolution USING btree (sortkey, value);


--
-- Name: resolution_value_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX resolution_value_idx ON public.resolution USING btree (value);


--
-- Name: resolution_visibility_value_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX resolution_visibility_value_id_idx ON public.resolution USING btree (visibility_value_id);


--
-- Name: series_categories_name_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX series_categories_name_idx ON public.series_categories USING btree (name);


--
-- Name: series_category_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX series_category_idx ON public.series USING btree (category, subcategory, name);


--
-- Name: series_creator_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX series_creator_idx ON public.series USING btree (creator);


--
-- Name: series_data_series_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX series_data_series_id_idx ON public.series_data USING btree (series_id, series_date);


--
-- Name: setting_value_ns_unique_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX setting_value_ns_unique_idx ON public.setting_value USING btree (name, sortindex);


--
-- Name: setting_value_nv_unique_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX setting_value_nv_unique_idx ON public.setting_value USING btree (name, value);


--
-- Name: status_workflow_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX status_workflow_idx ON public.status_workflow USING btree (old_status, new_status);


--
-- Name: tag_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX tag_user_id_idx ON public.tag USING btree (user_id, name);


--
-- Name: tokens_userid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX tokens_userid_idx ON public.tokens USING btree (userid);


--
-- Name: ts_error_error_time_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX ts_error_error_time_idx ON public.ts_error USING btree (error_time);


--
-- Name: ts_error_funcid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX ts_error_funcid_idx ON public.ts_error USING btree (funcid, error_time);


--
-- Name: ts_error_jobid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX ts_error_jobid_idx ON public.ts_error USING btree (jobid);


--
-- Name: ts_exitstatus_delete_after_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX ts_exitstatus_delete_after_idx ON public.ts_exitstatus USING btree (delete_after);


--
-- Name: ts_exitstatus_funcid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX ts_exitstatus_funcid_idx ON public.ts_exitstatus USING btree (funcid);


--
-- Name: ts_funcmap_funcname_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX ts_funcmap_funcname_idx ON public.ts_funcmap USING btree (funcname);


--
-- Name: ts_job_coalesce_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX ts_job_coalesce_idx ON public.ts_job USING btree ("coalesce", funcid);


--
-- Name: ts_job_funcid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX ts_job_funcid_idx ON public.ts_job USING btree (funcid, uniqkey);


--
-- Name: ts_job_run_after_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX ts_job_run_after_idx ON public.ts_job USING btree (run_after, funcid);


--
-- Name: ts_note_jobid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX ts_note_jobid_idx ON public.ts_note USING btree (jobid, notekey);


--
-- Name: user_api_keys_api_key_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX user_api_keys_api_key_idx ON public.user_api_keys USING btree (api_key);


--
-- Name: user_api_keys_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX user_api_keys_user_id_idx ON public.user_api_keys USING btree (user_id);


--
-- Name: user_group_map_user_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX user_group_map_user_id_idx ON public.user_group_map USING btree (user_id, group_id, grant_type, isbless);


--
-- Name: versions_product_id_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX versions_product_id_idx ON public.versions USING btree (product_id, value);


--
-- Name: watch_watched_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX watch_watched_idx ON public.watch USING btree (watched);


--
-- Name: watch_watcher_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE UNIQUE INDEX watch_watcher_idx ON public.watch USING btree (watcher, watched);


--
-- Name: whine_queries_eventid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX whine_queries_eventid_idx ON public.whine_queries USING btree (eventid);


--
-- Name: whine_schedules_eventid_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX whine_schedules_eventid_idx ON public.whine_schedules USING btree (eventid);


--
-- Name: whine_schedules_run_next_idx; Type: INDEX; Schema: public; Owner: bugs
--

CREATE INDEX whine_schedules_run_next_idx ON public.whine_schedules USING btree (run_next);


--
-- Name: attach_data fk_attach_data_id_attachments_attach_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.attach_data
    ADD CONSTRAINT fk_attach_data_id_attachments_attach_id FOREIGN KEY (id) REFERENCES public.attachments(attach_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: attachments fk_attachments_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT fk_attachments_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: attachments fk_attachments_submitter_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT fk_attachments_submitter_id_profiles_userid FOREIGN KEY (submitter_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: audit_log fk_audit_log_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT fk_audit_log_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: bug_group_map fk_bug_group_map_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_group_map
    ADD CONSTRAINT fk_bug_group_map_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bug_group_map fk_bug_group_map_group_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_group_map
    ADD CONSTRAINT fk_bug_group_map_group_id_groups_id FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bug_see_also fk_bug_see_also_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_see_also
    ADD CONSTRAINT fk_bug_see_also_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bug_tag fk_bug_tag_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_tag
    ADD CONSTRAINT fk_bug_tag_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bug_tag fk_bug_tag_tag_id_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_tag
    ADD CONSTRAINT fk_bug_tag_tag_id_tag_id FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bug_user_last_visit fk_bug_user_last_visit_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_user_last_visit
    ADD CONSTRAINT fk_bug_user_last_visit_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bug_user_last_visit fk_bug_user_last_visit_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bug_user_last_visit
    ADD CONSTRAINT fk_bug_user_last_visit_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bugs_activity fk_bugs_activity_attach_id_attachments_attach_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_activity
    ADD CONSTRAINT fk_bugs_activity_attach_id_attachments_attach_id FOREIGN KEY (attach_id) REFERENCES public.attachments(attach_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bugs_activity fk_bugs_activity_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_activity
    ADD CONSTRAINT fk_bugs_activity_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bugs_activity fk_bugs_activity_comment_id_longdescs_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_activity
    ADD CONSTRAINT fk_bugs_activity_comment_id_longdescs_comment_id FOREIGN KEY (comment_id) REFERENCES public.longdescs(comment_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bugs_activity fk_bugs_activity_fieldid_fielddefs_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_activity
    ADD CONSTRAINT fk_bugs_activity_fieldid_fielddefs_id FOREIGN KEY (fieldid) REFERENCES public.fielddefs(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bugs_activity fk_bugs_activity_who_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_activity
    ADD CONSTRAINT fk_bugs_activity_who_profiles_userid FOREIGN KEY (who) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bugs_aliases fk_bugs_aliases_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_aliases
    ADD CONSTRAINT fk_bugs_aliases_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bugs fk_bugs_assigned_to_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs
    ADD CONSTRAINT fk_bugs_assigned_to_profiles_userid FOREIGN KEY (assigned_to) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bugs fk_bugs_component_id_components_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs
    ADD CONSTRAINT fk_bugs_component_id_components_id FOREIGN KEY (component_id) REFERENCES public.components(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bugs_fulltext fk_bugs_fulltext_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs_fulltext
    ADD CONSTRAINT fk_bugs_fulltext_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bugs fk_bugs_product_id_products_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs
    ADD CONSTRAINT fk_bugs_product_id_products_id FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bugs fk_bugs_qa_contact_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs
    ADD CONSTRAINT fk_bugs_qa_contact_profiles_userid FOREIGN KEY (qa_contact) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bugs fk_bugs_reporter_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.bugs
    ADD CONSTRAINT fk_bugs_reporter_profiles_userid FOREIGN KEY (reporter) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: category_group_map fk_category_group_map_category_id_series_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.category_group_map
    ADD CONSTRAINT fk_category_group_map_category_id_series_categories_id FOREIGN KEY (category_id) REFERENCES public.series_categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category_group_map fk_category_group_map_group_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.category_group_map
    ADD CONSTRAINT fk_category_group_map_group_id_groups_id FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cc fk_cc_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.cc
    ADD CONSTRAINT fk_cc_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cc fk_cc_who_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.cc
    ADD CONSTRAINT fk_cc_who_profiles_userid FOREIGN KEY (who) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: component_cc fk_component_cc_component_id_components_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.component_cc
    ADD CONSTRAINT fk_component_cc_component_id_components_id FOREIGN KEY (component_id) REFERENCES public.components(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: component_cc fk_component_cc_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.component_cc
    ADD CONSTRAINT fk_component_cc_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: components fk_components_initialowner_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT fk_components_initialowner_profiles_userid FOREIGN KEY (initialowner) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: components fk_components_initialqacontact_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT fk_components_initialqacontact_profiles_userid FOREIGN KEY (initialqacontact) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: components fk_components_product_id_products_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT fk_components_product_id_products_id FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dependencies fk_dependencies_blocked_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.dependencies
    ADD CONSTRAINT fk_dependencies_blocked_bugs_bug_id FOREIGN KEY (blocked) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dependencies fk_dependencies_dependson_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.dependencies
    ADD CONSTRAINT fk_dependencies_dependson_bugs_bug_id FOREIGN KEY (dependson) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: duplicates fk_duplicates_dupe_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.duplicates
    ADD CONSTRAINT fk_duplicates_dupe_bugs_bug_id FOREIGN KEY (dupe) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: duplicates fk_duplicates_dupe_of_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.duplicates
    ADD CONSTRAINT fk_duplicates_dupe_of_bugs_bug_id FOREIGN KEY (dupe_of) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: email_bug_ignore fk_email_bug_ignore_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.email_bug_ignore
    ADD CONSTRAINT fk_email_bug_ignore_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: email_bug_ignore fk_email_bug_ignore_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.email_bug_ignore
    ADD CONSTRAINT fk_email_bug_ignore_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: email_setting fk_email_setting_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.email_setting
    ADD CONSTRAINT fk_email_setting_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: field_visibility fk_field_visibility_field_id_fielddefs_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.field_visibility
    ADD CONSTRAINT fk_field_visibility_field_id_fielddefs_id FOREIGN KEY (field_id) REFERENCES public.fielddefs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fielddefs fk_fielddefs_value_field_id_fielddefs_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.fielddefs
    ADD CONSTRAINT fk_fielddefs_value_field_id_fielddefs_id FOREIGN KEY (value_field_id) REFERENCES public.fielddefs(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fielddefs fk_fielddefs_visibility_field_id_fielddefs_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.fielddefs
    ADD CONSTRAINT fk_fielddefs_visibility_field_id_fielddefs_id FOREIGN KEY (visibility_field_id) REFERENCES public.fielddefs(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: flagexclusions fk_flagexclusions_component_id_components_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flagexclusions
    ADD CONSTRAINT fk_flagexclusions_component_id_components_id FOREIGN KEY (component_id) REFERENCES public.components(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flagexclusions fk_flagexclusions_product_id_products_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flagexclusions
    ADD CONSTRAINT fk_flagexclusions_product_id_products_id FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flagexclusions fk_flagexclusions_type_id_flagtypes_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flagexclusions
    ADD CONSTRAINT fk_flagexclusions_type_id_flagtypes_id FOREIGN KEY (type_id) REFERENCES public.flagtypes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flaginclusions fk_flaginclusions_component_id_components_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flaginclusions
    ADD CONSTRAINT fk_flaginclusions_component_id_components_id FOREIGN KEY (component_id) REFERENCES public.components(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flaginclusions fk_flaginclusions_product_id_products_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flaginclusions
    ADD CONSTRAINT fk_flaginclusions_product_id_products_id FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flaginclusions fk_flaginclusions_type_id_flagtypes_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flaginclusions
    ADD CONSTRAINT fk_flaginclusions_type_id_flagtypes_id FOREIGN KEY (type_id) REFERENCES public.flagtypes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flags fk_flags_attach_id_attachments_attach_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT fk_flags_attach_id_attachments_attach_id FOREIGN KEY (attach_id) REFERENCES public.attachments(attach_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flags fk_flags_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT fk_flags_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flags fk_flags_requestee_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT fk_flags_requestee_id_profiles_userid FOREIGN KEY (requestee_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: flags fk_flags_setter_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT fk_flags_setter_id_profiles_userid FOREIGN KEY (setter_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: flags fk_flags_type_id_flagtypes_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT fk_flags_type_id_flagtypes_id FOREIGN KEY (type_id) REFERENCES public.flagtypes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flagtypes fk_flagtypes_grant_group_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flagtypes
    ADD CONSTRAINT fk_flagtypes_grant_group_id_groups_id FOREIGN KEY (grant_group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: flagtypes fk_flagtypes_request_group_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.flagtypes
    ADD CONSTRAINT fk_flagtypes_request_group_id_groups_id FOREIGN KEY (request_group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: group_control_map fk_group_control_map_group_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.group_control_map
    ADD CONSTRAINT fk_group_control_map_group_id_groups_id FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_control_map fk_group_control_map_product_id_products_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.group_control_map
    ADD CONSTRAINT fk_group_control_map_product_id_products_id FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_group_map fk_group_group_map_grantor_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.group_group_map
    ADD CONSTRAINT fk_group_group_map_grantor_id_groups_id FOREIGN KEY (grantor_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_group_map fk_group_group_map_member_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.group_group_map
    ADD CONSTRAINT fk_group_group_map_member_id_groups_id FOREIGN KEY (member_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: keywords fk_keywords_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.keywords
    ADD CONSTRAINT fk_keywords_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: keywords fk_keywords_keywordid_keyworddefs_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.keywords
    ADD CONSTRAINT fk_keywords_keywordid_keyworddefs_id FOREIGN KEY (keywordid) REFERENCES public.keyworddefs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: login_failure fk_login_failure_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.login_failure
    ADD CONSTRAINT fk_login_failure_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: logincookies fk_logincookies_userid_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.logincookies
    ADD CONSTRAINT fk_logincookies_userid_profiles_userid FOREIGN KEY (userid) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: longdescs fk_longdescs_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs
    ADD CONSTRAINT fk_longdescs_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: longdescs_tags_activity fk_longdescs_tags_activity_bug_id_bugs_bug_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags_activity
    ADD CONSTRAINT fk_longdescs_tags_activity_bug_id_bugs_bug_id FOREIGN KEY (bug_id) REFERENCES public.bugs(bug_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: longdescs_tags_activity fk_longdescs_tags_activity_comment_id_longdescs_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags_activity
    ADD CONSTRAINT fk_longdescs_tags_activity_comment_id_longdescs_comment_id FOREIGN KEY (comment_id) REFERENCES public.longdescs(comment_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: longdescs_tags_activity fk_longdescs_tags_activity_who_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags_activity
    ADD CONSTRAINT fk_longdescs_tags_activity_who_profiles_userid FOREIGN KEY (who) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: longdescs_tags fk_longdescs_tags_comment_id_longdescs_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs_tags
    ADD CONSTRAINT fk_longdescs_tags_comment_id_longdescs_comment_id FOREIGN KEY (comment_id) REFERENCES public.longdescs(comment_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: longdescs fk_longdescs_who_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.longdescs
    ADD CONSTRAINT fk_longdescs_who_profiles_userid FOREIGN KEY (who) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: milestones fk_milestones_product_id_products_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT fk_milestones_product_id_products_id FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: namedqueries_link_in_footer fk_namedqueries_link_in_footer_namedquery_id_namedqueries_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.namedqueries_link_in_footer
    ADD CONSTRAINT fk_namedqueries_link_in_footer_namedquery_id_namedqueries_id FOREIGN KEY (namedquery_id) REFERENCES public.namedqueries(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: namedqueries_link_in_footer fk_namedqueries_link_in_footer_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.namedqueries_link_in_footer
    ADD CONSTRAINT fk_namedqueries_link_in_footer_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: namedqueries fk_namedqueries_userid_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.namedqueries
    ADD CONSTRAINT fk_namedqueries_userid_profiles_userid FOREIGN KEY (userid) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: namedquery_group_map fk_namedquery_group_map_group_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.namedquery_group_map
    ADD CONSTRAINT fk_namedquery_group_map_group_id_groups_id FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: namedquery_group_map fk_namedquery_group_map_namedquery_id_namedqueries_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.namedquery_group_map
    ADD CONSTRAINT fk_namedquery_group_map_namedquery_id_namedqueries_id FOREIGN KEY (namedquery_id) REFERENCES public.namedqueries(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products fk_products_classification_id_classifications_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_products_classification_id_classifications_id FOREIGN KEY (classification_id) REFERENCES public.classifications(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profile_search fk_profile_search_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profile_search
    ADD CONSTRAINT fk_profile_search_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profile_setting fk_profile_setting_setting_name_setting_name; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profile_setting
    ADD CONSTRAINT fk_profile_setting_setting_name_setting_name FOREIGN KEY (setting_name) REFERENCES public.setting(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profile_setting fk_profile_setting_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profile_setting
    ADD CONSTRAINT fk_profile_setting_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profiles_activity fk_profiles_activity_fieldid_fielddefs_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profiles_activity
    ADD CONSTRAINT fk_profiles_activity_fieldid_fielddefs_id FOREIGN KEY (fieldid) REFERENCES public.fielddefs(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: profiles_activity fk_profiles_activity_userid_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profiles_activity
    ADD CONSTRAINT fk_profiles_activity_userid_profiles_userid FOREIGN KEY (userid) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profiles_activity fk_profiles_activity_who_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.profiles_activity
    ADD CONSTRAINT fk_profiles_activity_who_profiles_userid FOREIGN KEY (who) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: quips fk_quips_userid_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.quips
    ADD CONSTRAINT fk_quips_userid_profiles_userid FOREIGN KEY (userid) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reports fk_reports_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_reports_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: series fk_series_category_series_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT fk_series_category_series_categories_id FOREIGN KEY (category) REFERENCES public.series_categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: series fk_series_creator_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT fk_series_creator_profiles_userid FOREIGN KEY (creator) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: series_data fk_series_data_series_id_series_series_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.series_data
    ADD CONSTRAINT fk_series_data_series_id_series_series_id FOREIGN KEY (series_id) REFERENCES public.series(series_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: series fk_series_subcategory_series_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT fk_series_subcategory_series_categories_id FOREIGN KEY (subcategory) REFERENCES public.series_categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: setting_value fk_setting_value_name_setting_name; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.setting_value
    ADD CONSTRAINT fk_setting_value_name_setting_name FOREIGN KEY (name) REFERENCES public.setting(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: status_workflow fk_status_workflow_new_status_bug_status_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.status_workflow
    ADD CONSTRAINT fk_status_workflow_new_status_bug_status_id FOREIGN KEY (new_status) REFERENCES public.bug_status(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: status_workflow fk_status_workflow_old_status_bug_status_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.status_workflow
    ADD CONSTRAINT fk_status_workflow_old_status_bug_status_id FOREIGN KEY (old_status) REFERENCES public.bug_status(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tag fk_tag_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT fk_tag_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tokens fk_tokens_userid_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT fk_tokens_userid_profiles_userid FOREIGN KEY (userid) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_api_keys fk_user_api_keys_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.user_api_keys
    ADD CONSTRAINT fk_user_api_keys_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_group_map fk_user_group_map_group_id_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.user_group_map
    ADD CONSTRAINT fk_user_group_map_group_id_groups_id FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_group_map fk_user_group_map_user_id_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.user_group_map
    ADD CONSTRAINT fk_user_group_map_user_id_profiles_userid FOREIGN KEY (user_id) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: versions fk_versions_product_id_products_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT fk_versions_product_id_products_id FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: watch fk_watch_watched_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.watch
    ADD CONSTRAINT fk_watch_watched_profiles_userid FOREIGN KEY (watched) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: watch fk_watch_watcher_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.watch
    ADD CONSTRAINT fk_watch_watcher_profiles_userid FOREIGN KEY (watcher) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: whine_events fk_whine_events_owner_userid_profiles_userid; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_events
    ADD CONSTRAINT fk_whine_events_owner_userid_profiles_userid FOREIGN KEY (owner_userid) REFERENCES public.profiles(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: whine_queries fk_whine_queries_eventid_whine_events_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_queries
    ADD CONSTRAINT fk_whine_queries_eventid_whine_events_id FOREIGN KEY (eventid) REFERENCES public.whine_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: whine_schedules fk_whine_schedules_eventid_whine_events_id; Type: FK CONSTRAINT; Schema: public; Owner: bugs
--

ALTER TABLE ONLY public.whine_schedules
    ADD CONSTRAINT fk_whine_schedules_eventid_whine_events_id FOREIGN KEY (eventid) REFERENCES public.whine_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

