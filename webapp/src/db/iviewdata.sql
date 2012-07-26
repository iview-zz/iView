-- ========================================================
--	Database - iViewdb
--	Version - 0.0.0.1 Beta
-- ========================================================


CREATE DATABASE iviewdb WITH TEMPLATE = template0 ENCODING = 'WIN1252';


ALTER DATABASE iviewdb OWNER TO postgres;

\connect iviewdb

CREATE PROCEDURAL LANGUAGE plpgsql;

ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;



drop table if exists tblauditlog;
create table tblauditlog (
	logid serial,
	actiontime timestamp default now(),
	message text,
	severity int,   
	username varchar(30),
	ipaddress varchar(15),
	categoryid int
);


--	Main DashBoard
--      Report: Allowed Traffic overview (bar chart)

drop table if exists tblftptrafficsummary_5min cascade;
drop table if exists tblmaindeniedtraffic_5min cascade;
drop table if exists tblwebtrafficsummary_5min cascade;
drop table if exists tblcontentfilteringdeniedsummary_5min cascade;
drop table if exists tblidpattacksummary_5min cascade;
drop table if exists tblmainallowedtraffic_5min cascade;
drop table if exists tblmailtrafficsummary_5min cascade;
drop table if exists tblvirussummary_5min cascade;

drop table if exists tblftptrafficsummary_4hr cascade;
drop table if exists tblmaindeniedtraffic_4hr cascade;
drop table if exists tblwebtrafficsummary_4hr cascade;
drop table if exists tblcontentfilteringdeniedsummary_4hr cascade;
drop table if exists tblidpattacksummary_4hr cascade;
drop table if exists tblmainallowedtraffic_4hr cascade;
drop table if exists tblmailtrafficsummary_4hr cascade;
drop table if exists tblvirussummary_4hr cascade;

drop table if exists tblftptrafficsummary_12hr cascade;
drop table if exists tblmaindeniedtraffic_12hr cascade;
drop table if exists tblwebtrafficsummary_12hr cascade;
drop table if exists tblcontentfilteringdeniedsummary_12hr cascade;
drop table if exists tblidpattacksummary_12hr cascade;
drop table if exists tblmainallowedtraffic_12hr cascade;
drop table if exists tblmailtrafficsummary_12hr cascade;
drop table if exists tblvirussummary_12hr cascade;

drop table if exists tblftptrafficsummary_24hr cascade;
drop table if exists tblmaindeniedtraffic_24hr cascade;
drop table if exists tblwebtrafficsummary_24hr cascade;
drop table if exists tblcontentfilteringdeniedsummary_24hr cascade;
drop table if exists tblidpattacksummary_24hr cascade;
drop table if exists tblmainallowedtraffic_24hr cascade;
drop table if exists tblmailtrafficsummary_24hr cascade;
drop table if exists tblvirussummary_24hr cascade;

CREATE TABLE tblftptrafficsummary_5min (   "5mintime" timestamp ,  traffic varchar(30) default ' ',  hits bigint default 0,  bytes bigint ,  appid varchar(64));
CREATE TABLE tblmaindeniedtraffic_5min( "5mintime" timestamp ,  traffic varchar(64) default ' ',  hits bigint ,  appid varchar(64) );
CREATE TABLE tblwebtrafficsummary_5min(  "5mintime" timestamp ,  traffic varchar(64) default ' ',  hits bigint  default 0,  bytes bigint ,  appid varchar(64) );
CREATE TABLE tblcontentfilteringdeniedsummary_5min (  "5mintime" timestamp ,  application varchar(64) default NULL,  hits bigint default 0,  appid varchar(64) );
CREATE TABLE tblmainallowedtraffic_5min ( "5mintime" timestamp , proto_group varchar(64) default ' ', bytes bigint ,  appid varchar(64) );
CREATE TABLE tblidpattacksummary_5min(  "5mintime" timestamp ,  attacktype varchar(30) default ' ',  protocolgroup varchar(30) default ' ',  hits bigint default 0,  appid varchar(64) );
CREATE TABLE tblmailtrafficsummary_5min(  "5mintime" timestamp ,  traffic varchar(30) default ' ',  hits bigint default 0,  bytes bigint ,  appid varchar(64) );
CREATE TABLE tblvirussummary_5min(  "5mintime" timestamp ,    proto_group varchar(30) default NULL,    hits bigint default 0,    bytes bigint ,    appid varchar(64) );


CREATE TABLE tblftptrafficsummary_4hr (   "5mintime" timestamp ,  traffic varchar(30) default ' ',  hits bigint default 0,  bytes bigint ,  appid varchar(64));
CREATE TABLE tblmaindeniedtraffic_4hr( "5mintime" timestamp ,  traffic varchar(64) default ' ',  hits bigint ,  appid varchar(64) );
CREATE TABLE tblwebtrafficsummary_4hr(  "5mintime" timestamp ,  traffic varchar(64) default ' ',  hits bigint  default 0,  bytes bigint ,  appid varchar(64) );
CREATE TABLE tblcontentfilteringdeniedsummary_4hr (  "5mintime" timestamp ,  application varchar(64) default NULL,  hits bigint default 0,  appid varchar(64) );
CREATE TABLE tblmainallowedtraffic_4hr ( "5mintime" timestamp , proto_group varchar(64) default ' ', bytes bigint ,  appid varchar(64) );
CREATE TABLE tblidpattacksummary_4hr(  "5mintime" timestamp ,  attacktype varchar(30) default ' ',  protocolgroup varchar(30) default ' ',  hits bigint default 0,  appid varchar(64) );
CREATE TABLE tblmailtrafficsummary_4hr(  "5mintime" timestamp ,  traffic varchar(30) default ' ',  hits bigint default 0,  bytes bigint ,  appid varchar(64) );
CREATE TABLE tblvirussummary_4hr(  "5mintime" timestamp ,    proto_group varchar(30) default NULL,    hits bigint default 0,    bytes bigint ,    appid varchar(64) );



CREATE TABLE tblftptrafficsummary_12hr (   "5mintime" timestamp ,  traffic varchar(30) default ' ',  hits bigint default 0,  bytes bigint ,  appid varchar(64));
CREATE TABLE tblmaindeniedtraffic_12hr( "5mintime" timestamp ,  traffic varchar(64) default ' ',  hits bigint ,  appid varchar(64) );
CREATE TABLE tblwebtrafficsummary_12hr(  "5mintime" timestamp ,  traffic varchar(64) default ' ',  hits bigint  default 0,  bytes bigint ,  appid varchar(64) );
CREATE TABLE tblcontentfilteringdeniedsummary_12hr (  "5mintime" timestamp ,  application varchar(64) default NULL,  hits bigint default 0,  appid varchar(64) );
CREATE TABLE tblmainallowedtraffic_12hr ( "5mintime" timestamp , proto_group varchar(64) default ' ', bytes bigint ,  appid varchar(64) );
CREATE TABLE tblidpattacksummary_12hr(  "5mintime" timestamp ,  attacktype varchar(30) default ' ',  protocolgroup varchar(30) default ' ',  hits bigint default 0,  appid varchar(64) );
CREATE TABLE tblmailtrafficsummary_12hr(  "5mintime" timestamp ,  traffic varchar(30) default ' ',  hits bigint default 0,  bytes bigint ,  appid varchar(64) );
CREATE TABLE tblvirussummary_12hr(  "5mintime" timestamp ,    proto_group varchar(30) default NULL,    hits bigint default 0,    bytes bigint ,    appid varchar(64) );


CREATE TABLE tblftptrafficsummary_24hr (   "5mintime" timestamp ,  traffic varchar(30) default ' ',  hits bigint default 0,  bytes bigint ,  appid varchar(64));
CREATE TABLE tblmaindeniedtraffic_24hr( "5mintime" timestamp ,  traffic varchar(64) default ' ',  hits bigint ,  appid varchar(64) );
CREATE TABLE tblwebtrafficsummary_24hr(  "5mintime" timestamp ,  traffic varchar(64) default ' ',  hits bigint  default 0,  bytes bigint ,  appid varchar(64) );
CREATE TABLE tblcontentfilteringdeniedsummary_24hr (  "5mintime" timestamp ,  application varchar(64) default NULL,  hits bigint default 0,  appid varchar(64) );
CREATE TABLE tblmainallowedtraffic_24hr ( "5mintime" timestamp , proto_group varchar(64) default ' ', bytes bigint ,  appid varchar(64) );
CREATE TABLE tblidpattacksummary_24hr(  "5mintime" timestamp ,  attacktype varchar(30) default ' ',  protocolgroup varchar(30) default ' ',  hits bigint default 0,  appid varchar(64) );
CREATE TABLE tblmailtrafficsummary_24hr(  "5mintime" timestamp ,  traffic varchar(30) default ' ',  hits bigint default 0,  bytes bigint ,  appid varchar(64) );
CREATE TABLE tblvirussummary_24hr(  "5mintime" timestamp ,    proto_group varchar(30) default NULL,    hits bigint default 0,    bytes bigint ,    appid varchar(64) );








-- ====================================
-- Merge Table Defination
-- ====================================


drop table if exists tmp_new_device;
CREATE TABLE tmp_new_device
(
	appid varchar(32) ,
	ipaddr varchar(16)
);

drop table if exists tmp_clean_ftp_data;
CREATE TABLE tmp_clean_ftp_data
(
  file character varying(64),
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  host bigint,
  destip bigint,  
  hits bigint DEFAULT 1,
  bytes bigint,
  direction int,
  appid character varying(32),
  src_zone varchar(32),
  dst_zone varchar(32)
);


drop table if exists tmp_denied_web_content_categorization_data;
CREATE TABLE tmp_denied_web_content_categorization_data
(
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  category character varying(64),
  "domain" character varying(512),
  host bigint,
  hits bigint DEFAULT 1,
  appid character varying(32),
  application character varying(64),
  url character varying(1024),
  src_zone varchar(32),
  dst_zone varchar(32)
);


drop table if exists tmp_firewall_blocked_traffic;
CREATE TABLE tmp_firewall_blocked_traffic
(
  srcip bigint,
  destip bigint,
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  proto_group character varying(64) DEFAULT 'UNKNOWN'::character varying,
  application character varying(64),
  hits bigint DEFAULT 1,
  appid character varying(32),
  src_zone varchar(32),
  dst_zone varchar(32),
  ruleid bigint,
  log_component smallint,
  "action" smallint
);


drop table if exists tmp_firewall_traffic;
CREATE TABLE tmp_firewall_traffic
(
  ruleid bigint,
  "action" smallint,  
  srcip bigint,
  destip bigint,
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  proto_group character varying(64) DEFAULT 'UNKNOWN'::character varying,
  application character varying(64),
  upload bigint,
  download bigint,
  hits bigint DEFAULT 1,
  appid character varying(32),
  log_component smallint,
  dst_port integer,
  applicationid integer,
  src_zone varchar(32),
  dst_zone varchar(32)
);

drop table if exists temp_firewall;
create table temp_firewall (like tmp_firewall_traffic) ;


drop table if exists tmp_idp_alerts_data;
CREATE TABLE tmp_idp_alerts_data
(
  attacker bigint,
  victim bigint,
  attack character varying(128),
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  severity smallint,
  "action" smallint,
  hits bigint DEFAULT 1,
  appid character varying(32),
  proto_group character varying(64) DEFAULT 'UNKNOWN'::character varying,
  application character varying(64),
  src_zone varchar(32),
  dst_zone varchar(32)
);


drop table if exists  tmp_mail_data;
CREATE TABLE tmp_mail_data
(
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  sender character varying(64),
  recipient character varying(1024),
  host bigint,
  destip bigint,
  hits bigint DEFAULT 1,
  bytes bigint,
  appid character varying(32),
  log_subtype smallint,
  application character varying(64),
  src_zone varchar(32),
  dst_zone varchar(32),
  subject varchar(64)
);



drop table if exists tmp_virus_data;
CREATE TABLE tmp_virus_data
(
  host bigint,
  destip bigint,
  virus varchar(32),
  file varchar(64),
  direction smallint,
  hits bigint DEFAULT 1,
  appid character varying(32),
  proto_group character varying(64) DEFAULT 'UNKNOWN'::character varying,
  upload bigint,
  download bigint,
  priority smallint,
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  application character varying(64),
  domain varchar(512),
  sender varchar(64), 
  recipient varchar(1024),
  url varchar(1024),
  subject varchar(64),
  src_zone varchar(32),
  dst_zone varchar(32),
  log_component smallint
);


drop table if exists tmpwebusagedata;
CREATE TABLE tmpwebusagedata
(
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  host bigint,
  src_zone varchar(32),
  "domain" character varying(512),
  dst_zone varchar(32),
  "content" character varying(64),
  category character varying(64),
  url character varying(1024),
  hits bigint DEFAULT 1,
  bytes integer,
  appid character varying(32),
  application character varying(64)
);








-- ==============================================================
-- Clean FTP Reports Group
-- ==============================================================


DROP TABLE IF EXISTS ftp_file_5min cascade;
DROP TABLE IF EXISTS ftp_host_5min cascade;
DROP TABLE IF EXISTS ftp_server_5min cascade;
DROP TABLE IF EXISTS ftp_user_5min cascade;

DROP TABLE IF EXISTS ftp_file_host_5min cascade;
DROP TABLE IF EXISTS ftp_file_server_5min cascade;
DROP TABLE IF EXISTS ftp_file_user_5min cascade;
DROP TABLE IF EXISTS ftp_host_server_5min cascade;
DROP TABLE IF EXISTS ftp_host_user_5min cascade;
DROP TABLE IF EXISTS ftp_server_user_5min cascade;

DROP TABLE IF EXISTS ftp_file_host_server_5min cascade;
DROP TABLE IF EXISTS ftp_file_server_user_5min cascade;

DROP TABLE IF EXISTS ftp_file_host_server_user_5min cascade;


DROP TABLE IF EXISTS ftp_file_4hr cascade;
DROP TABLE IF EXISTS ftp_host_4hr cascade;
DROP TABLE IF EXISTS ftp_server_4hr cascade;
DROP TABLE IF EXISTS ftp_user_4hr cascade;

DROP TABLE IF EXISTS ftp_file_host_4hr cascade;
DROP TABLE IF EXISTS ftp_file_server_4hr cascade;
DROP TABLE IF EXISTS ftp_file_user_4hr cascade;
DROP TABLE IF EXISTS ftp_host_server_4hr cascade;
DROP TABLE IF EXISTS ftp_host_user_4hr cascade;
DROP TABLE IF EXISTS ftp_server_user_4hr cascade;

DROP TABLE IF EXISTS ftp_file_host_server_4hr cascade;
DROP TABLE IF EXISTS ftp_file_server_user_4hr cascade;

DROP TABLE IF EXISTS ftp_file_host_server_user_4hr cascade;



DROP TABLE IF EXISTS ftp_file_12hr cascade;
DROP TABLE IF EXISTS ftp_host_12hr cascade;
DROP TABLE IF EXISTS ftp_server_12hr cascade;
DROP TABLE IF EXISTS ftp_user_12hr cascade;

DROP TABLE IF EXISTS ftp_file_host_12hr cascade;
DROP TABLE IF EXISTS ftp_file_server_12hr cascade;
DROP TABLE IF EXISTS ftp_file_user_12hr cascade;
DROP TABLE IF EXISTS ftp_host_server_12hr cascade;
DROP TABLE IF EXISTS ftp_host_user_12hr cascade;
DROP TABLE IF EXISTS ftp_server_user_12hr cascade;

DROP TABLE IF EXISTS ftp_file_host_server_12hr cascade;
DROP TABLE IF EXISTS ftp_file_server_user_12hr cascade;

DROP TABLE IF EXISTS ftp_file_host_server_user_12hr cascade;



DROP TABLE IF EXISTS ftp_file_24hr cascade;
DROP TABLE IF EXISTS ftp_host_24hr cascade;
DROP TABLE IF EXISTS ftp_server_24hr cascade;
DROP TABLE IF EXISTS ftp_user_24hr cascade;

DROP TABLE IF EXISTS ftp_file_host_24hr cascade;
DROP TABLE IF EXISTS ftp_file_server_24hr cascade;
DROP TABLE IF EXISTS ftp_file_user_24hr cascade;
DROP TABLE IF EXISTS ftp_host_server_24hr cascade;
DROP TABLE IF EXISTS ftp_host_user_24hr cascade;
DROP TABLE IF EXISTS ftp_server_user_24hr cascade;

DROP TABLE IF EXISTS ftp_file_host_server_24hr cascade;
DROP TABLE IF EXISTS ftp_file_server_user_24hr cascade;

DROP TABLE IF EXISTS ftp_file_host_server_user_24hr cascade;




Create table ftp_file_5min ( "5mintime" timestamp NOT NULL ,file varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_5min ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_server_5min ( "5mintime" timestamp NOT NULL ,destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_user_5min ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_server_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_user_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_server_5min ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_user_5min ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_server_user_5min ( "5mintime" timestamp NOT NULL ,destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_server_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_server_user_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_server_user_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));



Create table ftp_file_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_4hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_server_4hr ( "5mintime" timestamp NOT NULL ,destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_user_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_server_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_user_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_server_4hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_user_4hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_server_user_4hr ( "5mintime" timestamp NOT NULL ,destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_server_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_server_user_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_server_user_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));


Create table ftp_file_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_12hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_server_12hr ( "5mintime" timestamp NOT NULL ,destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_user_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_server_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_user_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_server_12hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_user_12hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_server_user_12hr ( "5mintime" timestamp NOT NULL ,destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_server_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_server_user_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_server_user_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));



Create table ftp_file_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_24hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_server_24hr ( "5mintime" timestamp NOT NULL ,destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_user_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_server_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_user_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_server_24hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_host_user_24hr ( "5mintime" timestamp NOT NULL ,host bigint,src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_server_user_24hr ( "5mintime" timestamp NOT NULL ,destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_server_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));
Create table ftp_file_server_user_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));

Create table ftp_file_host_server_user_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),host bigint,src_zone varchar(32),destip bigint,dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, upload bigint ,download bigint ,total bigint, appid varchar(64));




-- ==============================================================
-- Denied web Traffic Reports Group
-- ==============================================================


DROP TABLE IF EXISTS deniedweb_category_5min cascade;
DROP TABLE IF EXISTS deniedweb_domain_5min cascade;
DROP TABLE IF EXISTS deniedweb_host_5min cascade;
DROP TABLE IF EXISTS deniedweb_user_5min cascade;

DROP TABLE IF EXISTS deniedweb_app_host_5min cascade;
DROP TABLE IF EXISTS deniedweb_app_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_host_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_5min cascade;
DROP TABLE IF EXISTS deniedweb_domain_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_host_url_5min cascade;
DROP TABLE IF EXISTS deniedweb_host_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_url_user_5min cascade;

DROP TABLE IF EXISTS deniedweb_app_category_host_5min cascade;
DROP TABLE IF EXISTS deniedweb_app_category_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_app_host_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_host_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_url_5min cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_domain_url_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_host_url_user_5min cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_5min cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_app_category_host_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_url_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_url_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_url_user_5min cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_url_5min cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_host_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_url_user_5min cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_url_user_5min cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_url_user_5min cascade;




DROP TABLE IF EXISTS deniedweb_category_4hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_4hr cascade;
DROP TABLE IF EXISTS deniedweb_host_4hr cascade;
DROP TABLE IF EXISTS deniedweb_user_4hr cascade;

DROP TABLE IF EXISTS deniedweb_app_host_4hr cascade;
DROP TABLE IF EXISTS deniedweb_app_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_host_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_4hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_host_url_4hr cascade;
DROP TABLE IF EXISTS deniedweb_host_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_url_user_4hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_host_4hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_app_host_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_host_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_url_4hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_host_url_user_4hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_4hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_host_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_url_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_url_user_4hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_url_4hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_host_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_url_user_4hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_url_user_4hr cascade;




DROP TABLE IF EXISTS deniedweb_category_12hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_12hr cascade;
DROP TABLE IF EXISTS deniedweb_host_12hr cascade;
DROP TABLE IF EXISTS deniedweb_user_12hr cascade;

DROP TABLE IF EXISTS deniedweb_app_host_12hr cascade;
DROP TABLE IF EXISTS deniedweb_app_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_host_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_12hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_host_url_12hr cascade;
DROP TABLE IF EXISTS deniedweb_host_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_url_user_12hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_host_12hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_app_host_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_host_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_url_12hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_host_url_user_12hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_12hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_host_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_url_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_url_user_12hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_url_12hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_host_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_url_user_12hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_url_user_12hr cascade;




DROP TABLE IF EXISTS deniedweb_category_24hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_24hr cascade;
DROP TABLE IF EXISTS deniedweb_host_24hr cascade;
DROP TABLE IF EXISTS deniedweb_user_24hr cascade;

DROP TABLE IF EXISTS deniedweb_app_host_24hr cascade;
DROP TABLE IF EXISTS deniedweb_app_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_host_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_24hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_host_url_24hr cascade;
DROP TABLE IF EXISTS deniedweb_host_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_url_user_24hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_host_24hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_app_host_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_host_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_url_24hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_host_url_user_24hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_24hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_host_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_url_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_domain_host_url_user_24hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_url_24hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_host_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_app_category_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS deniedweb_category_domain_host_url_user_24hr cascade;

DROP TABLE IF EXISTS deniedweb_app_category_domain_host_url_user_24hr cascade;








Create table deniedweb_category_5min ( "5mintime" timestamp NOT NULL ,category varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_user_5min ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_host_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_url_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_user_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_url_user_5min ( "5mintime" timestamp NOT NULL ,url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_host_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_url_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_url_user_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_url_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_url_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_url_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_url_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_url_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));




Create table deniedweb_category_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_user_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_host_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_url_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_user_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_url_user_4hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_host_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_url_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_url_user_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_url_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_url_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_url_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_url_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_url_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));





Create table deniedweb_category_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_user_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_host_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_url_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_user_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_url_user_12hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_host_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_url_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_url_user_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_url_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_url_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_url_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_url_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_url_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));




Create table deniedweb_category_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_user_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_host_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_url_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_user_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_url_user_24hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_host_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_url_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_host_url_user_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_url_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_domain_host_url_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_url_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_app_category_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table deniedweb_category_domain_host_url_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table deniedweb_app_category_domain_host_url_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(32),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));




-- =============================================
--   IPS 
-- =============================================

DROP TABLE IF EXISTS ips_app_5min cascade;
DROP TABLE IF EXISTS ips_attack_5min cascade;
DROP TABLE IF EXISTS ips_attacker_5min cascade;
DROP TABLE IF EXISTS ips_svrt_5min cascade;
DROP TABLE IF EXISTS ips_victim_5min cascade;

DROP TABLE IF EXISTS ips_app_attack_5min cascade;
DROP TABLE IF EXISTS ips_app_attacker_5min cascade;
DROP TABLE IF EXISTS ips_app_svrt_5min cascade;
DROP TABLE IF EXISTS ips_app_victim_5min cascade;
DROP TABLE IF EXISTS ips_attack_attacker_5min cascade;
DROP TABLE IF EXISTS ips_attack_svrt_5min cascade;
DROP TABLE IF EXISTS ips_attack_victim_5min cascade;
DROP TABLE IF EXISTS ips_attacker_svrt_5min cascade;
DROP TABLE IF EXISTS ips_attacker_victim_5min cascade;
DROP TABLE IF EXISTS ips_svrt_victim_5min cascade;

DROP TABLE IF EXISTS ips_acnt_app_attack_5min cascade;
DROP TABLE IF EXISTS ips_acnt_attack_svrt_5min cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_victim_5min cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_svrt_victim_5min cascade;
DROP TABLE IF EXISTS ips_actn_app_attack_attacker_user_victim_5min cascade;
DROP TABLE IF EXISTS ips_app_attack_attacker_svrt_user_victim_5min cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_svrt_user_vctm_5min cascade;



DROP TABLE IF EXISTS ips_app_4hr cascade;
DROP TABLE IF EXISTS ips_attack_4hr cascade;
DROP TABLE IF EXISTS ips_attacker_4hr cascade;
DROP TABLE IF EXISTS ips_svrt_4hr cascade;
DROP TABLE IF EXISTS ips_victim_4hr cascade;

DROP TABLE IF EXISTS ips_app_attack_4hr cascade;
DROP TABLE IF EXISTS ips_app_attacker_4hr cascade;
DROP TABLE IF EXISTS ips_app_svrt_4hr cascade;
DROP TABLE IF EXISTS ips_app_victim_4hr cascade;
DROP TABLE IF EXISTS ips_attack_attacker_4hr cascade;
DROP TABLE IF EXISTS ips_attack_svrt_4hr cascade;
DROP TABLE IF EXISTS ips_attack_victim_4hr cascade;
DROP TABLE IF EXISTS ips_attacker_svrt_4hr cascade;
DROP TABLE IF EXISTS ips_attacker_victim_4hr cascade;
DROP TABLE IF EXISTS ips_svrt_victim_4hr cascade;

DROP TABLE IF EXISTS ips_acnt_app_attack_4hr cascade;
DROP TABLE IF EXISTS ips_acnt_attack_svrt_4hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_victim_4hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_svrt_victim_4hr cascade;
DROP TABLE IF EXISTS ips_actn_app_attack_attacker_user_victim_4hr cascade;
DROP TABLE IF EXISTS ips_app_attack_attacker_svrt_user_victim_4hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_svrt_user_vctm_4hr cascade;



DROP TABLE IF EXISTS ips_app_12hr cascade;
DROP TABLE IF EXISTS ips_attack_12hr cascade;
DROP TABLE IF EXISTS ips_attacker_12hr cascade;
DROP TABLE IF EXISTS ips_svrt_12hr cascade;
DROP TABLE IF EXISTS ips_victim_12hr cascade;

DROP TABLE IF EXISTS ips_app_attack_12hr cascade;
DROP TABLE IF EXISTS ips_app_attacker_12hr cascade;
DROP TABLE IF EXISTS ips_app_svrt_12hr cascade;
DROP TABLE IF EXISTS ips_app_victim_12hr cascade;
DROP TABLE IF EXISTS ips_attack_attacker_12hr cascade;
DROP TABLE IF EXISTS ips_attack_svrt_12hr cascade;
DROP TABLE IF EXISTS ips_attack_victim_12hr cascade;
DROP TABLE IF EXISTS ips_attacker_svrt_12hr cascade;
DROP TABLE IF EXISTS ips_attacker_victim_12hr cascade;
DROP TABLE IF EXISTS ips_svrt_victim_12hr cascade;

DROP TABLE IF EXISTS ips_acnt_app_attack_12hr cascade;
DROP TABLE IF EXISTS ips_acnt_attack_svrt_12hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_victim_12hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_svrt_victim_12hr cascade;
DROP TABLE IF EXISTS ips_actn_app_attack_attacker_user_victim_12hr cascade;
DROP TABLE IF EXISTS ips_app_attack_attacker_svrt_user_victim_12hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_svrt_user_vctm_12hr cascade;



DROP TABLE IF EXISTS ips_app_24hr cascade;
DROP TABLE IF EXISTS ips_attack_24hr cascade;
DROP TABLE IF EXISTS ips_attacker_24hr cascade;
DROP TABLE IF EXISTS ips_svrt_24hr cascade;
DROP TABLE IF EXISTS ips_victim_24hr cascade;

DROP TABLE IF EXISTS ips_app_attack_24hr cascade;
DROP TABLE IF EXISTS ips_app_attacker_24hr cascade;
DROP TABLE IF EXISTS ips_app_svrt_24hr cascade;
DROP TABLE IF EXISTS ips_app_victim_24hr cascade;
DROP TABLE IF EXISTS ips_attack_attacker_24hr cascade;
DROP TABLE IF EXISTS ips_attack_svrt_24hr cascade;
DROP TABLE IF EXISTS ips_attack_victim_24hr cascade;
DROP TABLE IF EXISTS ips_attacker_svrt_24hr cascade;
DROP TABLE IF EXISTS ips_attacker_victim_24hr cascade;
DROP TABLE IF EXISTS ips_svrt_victim_24hr cascade;

DROP TABLE IF EXISTS ips_acnt_app_attack_24hr cascade;
DROP TABLE IF EXISTS ips_acnt_attack_svrt_24hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_victim_24hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_svrt_victim_24hr cascade;
DROP TABLE IF EXISTS ips_actn_app_attack_attacker_user_victim_24hr cascade;
DROP TABLE IF EXISTS ips_app_attack_attacker_svrt_user_victim_24hr cascade;

DROP TABLE IF EXISTS ips_actn_app_attack_attacker_svrt_user_vctm_24hr cascade;




Create table ips_app_5min ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_5min ( "5mintime" timestamp NOT NULL ,attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_5min ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_svrt_5min ( "5mintime" timestamp NOT NULL ,severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_victim_5min ( "5mintime" timestamp NOT NULL ,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_app_attack_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_attacker_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_svrt_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_victim_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_attacker_5min ( "5mintime" timestamp NOT NULL ,attack varchar(128),attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_svrt_5min ( "5mintime" timestamp NOT NULL ,attack varchar(128),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_victim_5min ( "5mintime" timestamp NOT NULL ,attack varchar(128),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_svrt_5min ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_victim_5min ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_svrt_victim_5min ( "5mintime" timestamp NOT NULL ,severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_acnt_app_attack_5min ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_acnt_attack_svrt_5min ( "5mintime" timestamp NOT NULL ,action int,attack varchar(128),severity int, hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_actn_app_attack_attacker_victim_5min ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table ips_actn_app_attack_attacker_svrt_victim_5min ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table ips_actn_app_attack_attacker_user_victim_5min ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),username varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table ips_app_attack_attacker_svrt_user_victim_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),severity int,username varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table ips_actn_app_attack_attacker_svrt_user_vctm_5min ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),username varchar(64),severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));



Create table ips_app_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_4hr ( "5mintime" timestamp NOT NULL ,attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_4hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_svrt_4hr ( "5mintime" timestamp NOT NULL ,severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_victim_4hr ( "5mintime" timestamp NOT NULL ,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_app_attack_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_attacker_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_svrt_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_victim_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_attacker_4hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_svrt_4hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_victim_4hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_svrt_4hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_victim_4hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_svrt_victim_4hr ( "5mintime" timestamp NOT NULL ,severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_acnt_app_attack_4hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_acnt_attack_svrt_4hr ( "5mintime" timestamp NOT NULL ,action int,attack varchar(128),severity int, hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_actn_app_attack_attacker_victim_4hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table ips_actn_app_attack_attacker_svrt_victim_4hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table ips_actn_app_attack_attacker_user_victim_4hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),username varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table ips_app_attack_attacker_svrt_user_victim_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),severity int,username varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table ips_actn_app_attack_attacker_svrt_user_vctm_4hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),username varchar(64),severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));


Create table ips_app_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_12hr ( "5mintime" timestamp NOT NULL ,attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_12hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_svrt_12hr ( "5mintime" timestamp NOT NULL ,severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_victim_12hr ( "5mintime" timestamp NOT NULL ,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_app_attack_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_attacker_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_svrt_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_victim_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_attacker_12hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_svrt_12hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_victim_12hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_svrt_12hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_victim_12hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_svrt_victim_12hr ( "5mintime" timestamp NOT NULL ,severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_acnt_app_attack_12hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_acnt_attack_svrt_12hr ( "5mintime" timestamp NOT NULL ,action int,attack varchar(128),severity int, hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_actn_app_attack_attacker_victim_12hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table ips_actn_app_attack_attacker_svrt_victim_12hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table ips_actn_app_attack_attacker_user_victim_12hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),username varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table ips_app_attack_attacker_svrt_user_victim_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),severity int,username varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table ips_actn_app_attack_attacker_svrt_user_vctm_12hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),username varchar(64),severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));


Create table ips_app_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_24hr ( "5mintime" timestamp NOT NULL ,attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_24hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_svrt_24hr ( "5mintime" timestamp NOT NULL ,severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_victim_24hr ( "5mintime" timestamp NOT NULL ,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_app_attack_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_attacker_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_svrt_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_app_victim_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_attacker_24hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),attacker bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_svrt_24hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attack_victim_24hr ( "5mintime" timestamp NOT NULL ,attack varchar(128),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_svrt_24hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32),severity int, hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_attacker_victim_24hr ( "5mintime" timestamp NOT NULL ,attacker bigint, src_zone varchar(32),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_svrt_victim_24hr ( "5mintime" timestamp NOT NULL ,severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_acnt_app_attack_24hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128), hits bigint DEFAULT 1,  appid varchar(64));
Create table ips_acnt_attack_svrt_24hr ( "5mintime" timestamp NOT NULL ,action int,attack varchar(128),severity int, hits bigint DEFAULT 1,  appid varchar(64));

Create table ips_actn_app_attack_attacker_victim_24hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table ips_actn_app_attack_attacker_svrt_victim_24hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table ips_actn_app_attack_attacker_user_victim_24hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),username varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table ips_app_attack_attacker_svrt_user_victim_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),severity int,username varchar(64),victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table ips_actn_app_attack_attacker_svrt_user_vctm_24hr ( "5mintime" timestamp NOT NULL ,action int,application varchar(64),attack varchar(128),attacker bigint, src_zone varchar(32),username varchar(64),severity int,victim bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));





-- ===============================
-- 	Mail Reports
-- ===============================

DROP TABLE IF EXISTS mail_app_5min cascade;
DROP TABLE IF EXISTS mail_host_5min cascade;
DROP TABLE IF EXISTS mail_recipient_5min cascade;
DROP TABLE IF EXISTS mail_sender_5min cascade;
DROP TABLE IF EXISTS mail_user_5min cascade;

DROP TABLE IF EXISTS mail_app_dest_5min cascade;
DROP TABLE IF EXISTS mail_app_host_5min cascade;
DROP TABLE IF EXISTS mail_app_recipient_5min cascade;
DROP TABLE IF EXISTS mail_app_sender_5min cascade;
DROP TABLE IF EXISTS mail_app_user_5min cascade;
DROP TABLE IF EXISTS mail_dest_host_5min cascade;
DROP TABLE IF EXISTS mail_dest_recipient_5min cascade;
DROP TABLE IF EXISTS mail_dest_sender_5min cascade;
DROP TABLE IF EXISTS mail_dest_user_5min cascade;
DROP TABLE IF EXISTS mail_host_recipient_5min cascade;
DROP TABLE IF EXISTS mail_host_sender_5min cascade;
DROP TABLE IF EXISTS mail_host_user_5min cascade;
DROP TABLE IF EXISTS mail_recipient_sender_5min cascade;
DROP TABLE IF EXISTS mail_recipient_user_5min cascade;
DROP TABLE IF EXISTS mail_sender_user_5min cascade;

DROP TABLE IF EXISTS mail_detail_5min cascade;



DROP TABLE IF EXISTS spam_app_5min cascade;
DROP TABLE IF EXISTS spam_recipient_5min cascade;
DROP TABLE IF EXISTS spam_sender_5min cascade;

DROP TABLE IF EXISTS spam_app_dest_5min cascade;
DROP TABLE IF EXISTS spam_app_host_5min cascade;
DROP TABLE IF EXISTS spam_app_recipient_5min cascade;
DROP TABLE IF EXISTS spam_app_sender_5min cascade;
DROP TABLE IF EXISTS spam_app_user_5min cascade;
DROP TABLE IF EXISTS spam_dest_recipient_5min cascade;
DROP TABLE IF EXISTS spam_dest_sender_5min cascade;
DROP TABLE IF EXISTS spam_host_recipient_5min cascade;
DROP TABLE IF EXISTS spam_host_sender_5min cascade;
DROP TABLE IF EXISTS spam_recipient_sender_5min cascade;
DROP TABLE IF EXISTS spam_recipient_user_5min cascade;
DROP TABLE IF EXISTS spam_sender_user_5min cascade;

DROP TABLE IF EXISTS spam_detail_5min cascade;




DROP TABLE IF EXISTS mail_app_4hr cascade;
DROP TABLE IF EXISTS mail_host_4hr cascade;
DROP TABLE IF EXISTS mail_recipient_4hr cascade;
DROP TABLE IF EXISTS mail_sender_4hr cascade;
DROP TABLE IF EXISTS mail_user_4hr cascade;

DROP TABLE IF EXISTS mail_app_dest_4hr cascade;
DROP TABLE IF EXISTS mail_app_host_4hr cascade;
DROP TABLE IF EXISTS mail_app_recipient_4hr cascade;
DROP TABLE IF EXISTS mail_app_sender_4hr cascade;
DROP TABLE IF EXISTS mail_app_user_4hr cascade;
DROP TABLE IF EXISTS mail_dest_host_4hr cascade;
DROP TABLE IF EXISTS mail_dest_recipient_4hr cascade;
DROP TABLE IF EXISTS mail_dest_sender_4hr cascade;
DROP TABLE IF EXISTS mail_dest_user_4hr cascade;
DROP TABLE IF EXISTS mail_host_recipient_4hr cascade;
DROP TABLE IF EXISTS mail_host_sender_4hr cascade;
DROP TABLE IF EXISTS mail_host_user_4hr cascade;
DROP TABLE IF EXISTS mail_recipient_sender_4hr cascade;
DROP TABLE IF EXISTS mail_recipient_user_4hr cascade;
DROP TABLE IF EXISTS mail_sender_user_4hr cascade;

DROP TABLE IF EXISTS mail_detail_4hr cascade;



DROP TABLE IF EXISTS spam_app_4hr cascade;
DROP TABLE IF EXISTS spam_recipient_4hr cascade;
DROP TABLE IF EXISTS spam_sender_4hr cascade;

DROP TABLE IF EXISTS spam_app_dest_4hr cascade;
DROP TABLE IF EXISTS spam_app_host_4hr cascade;
DROP TABLE IF EXISTS spam_app_recipient_4hr cascade;
DROP TABLE IF EXISTS spam_app_sender_4hr cascade;
DROP TABLE IF EXISTS spam_app_user_4hr cascade;
DROP TABLE IF EXISTS spam_dest_recipient_4hr cascade;
DROP TABLE IF EXISTS spam_dest_sender_4hr cascade;
DROP TABLE IF EXISTS spam_host_recipient_4hr cascade;
DROP TABLE IF EXISTS spam_host_sender_4hr cascade;
DROP TABLE IF EXISTS spam_recipient_sender_4hr cascade;
DROP TABLE IF EXISTS spam_recipient_user_4hr cascade;
DROP TABLE IF EXISTS spam_sender_user_4hr cascade;

DROP TABLE IF EXISTS spam_detail_4hr cascade;



DROP TABLE IF EXISTS mail_app_12hr cascade;
DROP TABLE IF EXISTS mail_host_12hr cascade;
DROP TABLE IF EXISTS mail_recipient_12hr cascade;
DROP TABLE IF EXISTS mail_sender_12hr cascade;
DROP TABLE IF EXISTS mail_user_12hr cascade;

DROP TABLE IF EXISTS mail_app_dest_12hr cascade;
DROP TABLE IF EXISTS mail_app_host_12hr cascade;
DROP TABLE IF EXISTS mail_app_recipient_12hr cascade;
DROP TABLE IF EXISTS mail_app_sender_12hr cascade;
DROP TABLE IF EXISTS mail_app_user_12hr cascade;
DROP TABLE IF EXISTS mail_dest_host_12hr cascade;
DROP TABLE IF EXISTS mail_dest_recipient_12hr cascade;
DROP TABLE IF EXISTS mail_dest_sender_12hr cascade;
DROP TABLE IF EXISTS mail_dest_user_12hr cascade;
DROP TABLE IF EXISTS mail_host_recipient_12hr cascade;
DROP TABLE IF EXISTS mail_host_sender_12hr cascade;
DROP TABLE IF EXISTS mail_host_user_12hr cascade;
DROP TABLE IF EXISTS mail_recipient_sender_12hr cascade;
DROP TABLE IF EXISTS mail_recipient_user_12hr cascade;
DROP TABLE IF EXISTS mail_sender_user_12hr cascade;

DROP TABLE IF EXISTS mail_detail_12hr cascade;



DROP TABLE IF EXISTS spam_app_12hr cascade;
DROP TABLE IF EXISTS spam_recipient_12hr cascade;
DROP TABLE IF EXISTS spam_sender_12hr cascade;

DROP TABLE IF EXISTS spam_app_dest_12hr cascade;
DROP TABLE IF EXISTS spam_app_host_12hr cascade;
DROP TABLE IF EXISTS spam_app_recipient_12hr cascade;
DROP TABLE IF EXISTS spam_app_sender_12hr cascade;
DROP TABLE IF EXISTS spam_app_user_12hr cascade;
DROP TABLE IF EXISTS spam_dest_recipient_12hr cascade;
DROP TABLE IF EXISTS spam_dest_sender_12hr cascade;
DROP TABLE IF EXISTS spam_host_recipient_12hr cascade;
DROP TABLE IF EXISTS spam_host_sender_12hr cascade;
DROP TABLE IF EXISTS spam_recipient_sender_12hr cascade;
DROP TABLE IF EXISTS spam_recipient_user_12hr cascade;
DROP TABLE IF EXISTS spam_sender_user_12hr cascade;

DROP TABLE IF EXISTS spam_detail_12hr cascade;





DROP TABLE IF EXISTS mail_app_24hr cascade;
DROP TABLE IF EXISTS mail_host_24hr cascade;
DROP TABLE IF EXISTS mail_recipient_24hr cascade;
DROP TABLE IF EXISTS mail_sender_24hr cascade;
DROP TABLE IF EXISTS mail_user_24hr cascade;

DROP TABLE IF EXISTS mail_app_dest_24hr cascade;
DROP TABLE IF EXISTS mail_app_host_24hr cascade;
DROP TABLE IF EXISTS mail_app_recipient_24hr cascade;
DROP TABLE IF EXISTS mail_app_sender_24hr cascade;
DROP TABLE IF EXISTS mail_app_user_24hr cascade;
DROP TABLE IF EXISTS mail_dest_host_24hr cascade;
DROP TABLE IF EXISTS mail_dest_recipient_24hr cascade;
DROP TABLE IF EXISTS mail_dest_sender_24hr cascade;
DROP TABLE IF EXISTS mail_dest_user_24hr cascade;
DROP TABLE IF EXISTS mail_host_recipient_24hr cascade;
DROP TABLE IF EXISTS mail_host_sender_24hr cascade;
DROP TABLE IF EXISTS mail_host_user_24hr cascade;
DROP TABLE IF EXISTS mail_recipient_sender_24hr cascade;
DROP TABLE IF EXISTS mail_recipient_user_24hr cascade;
DROP TABLE IF EXISTS mail_sender_user_24hr cascade;

DROP TABLE IF EXISTS mail_detail_24hr cascade;



DROP TABLE IF EXISTS spam_app_24hr cascade;
DROP TABLE IF EXISTS spam_recipient_24hr cascade;
DROP TABLE IF EXISTS spam_sender_24hr cascade;

DROP TABLE IF EXISTS spam_app_dest_24hr cascade;
DROP TABLE IF EXISTS spam_app_host_24hr cascade;
DROP TABLE IF EXISTS spam_app_recipient_24hr cascade;
DROP TABLE IF EXISTS spam_app_sender_24hr cascade;
DROP TABLE IF EXISTS spam_app_user_24hr cascade;
DROP TABLE IF EXISTS spam_dest_recipient_24hr cascade;
DROP TABLE IF EXISTS spam_dest_sender_24hr cascade;
DROP TABLE IF EXISTS spam_host_recipient_24hr cascade;
DROP TABLE IF EXISTS spam_host_sender_24hr cascade;
DROP TABLE IF EXISTS spam_recipient_sender_24hr cascade;
DROP TABLE IF EXISTS spam_recipient_user_24hr cascade;
DROP TABLE IF EXISTS spam_sender_user_24hr cascade;

DROP TABLE IF EXISTS spam_detail_24hr cascade;




Create table mail_app_5min ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_5min ( "5mintime" timestamp NOT NULL ,recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_sender_5min ( "5mintime" timestamp NOT NULL ,sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_user_5min ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table mail_app_dest_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_recipient_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_sender_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_host_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_recipient_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_sender_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_user_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_recipient_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_sender_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_user_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_sender_5min ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_user_5min ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_sender_user_5min ( "5mintime" timestamp NOT NULL ,sender varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table mail_detail_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),recipient varchar(1024),sender varchar(64),subject varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));



Create table spam_app_5min ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_5min ( "5mintime" timestamp NOT NULL ,recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_sender_5min ( "5mintime" timestamp NOT NULL ,sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table spam_app_dest_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_recipient_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_sender_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_dest_recipient_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_dest_sender_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_host_recipient_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_host_sender_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_sender_5min ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_user_5min ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_sender_user_5min ( "5mintime" timestamp NOT NULL ,sender varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table spam_detail_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),recipient varchar(1024),sender varchar(64),subject varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));




Create table mail_app_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_4hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_sender_4hr ( "5mintime" timestamp NOT NULL ,sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_user_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table mail_app_dest_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_recipient_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_sender_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_host_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_recipient_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_sender_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_user_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_recipient_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_sender_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_user_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_sender_4hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_user_4hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_sender_user_4hr ( "5mintime" timestamp NOT NULL ,sender varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table mail_detail_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),recipient varchar(1024),sender varchar(64),subject varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));



Create table spam_app_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_4hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_sender_4hr ( "5mintime" timestamp NOT NULL ,sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table spam_app_dest_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_recipient_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_sender_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_dest_recipient_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_dest_sender_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_host_recipient_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_host_sender_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_sender_4hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_user_4hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_sender_user_4hr ( "5mintime" timestamp NOT NULL ,sender varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table spam_detail_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),recipient varchar(1024),sender varchar(64),subject varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));




Create table mail_app_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_12hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_sender_12hr ( "5mintime" timestamp NOT NULL ,sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_user_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table mail_app_dest_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_recipient_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_sender_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_host_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_recipient_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_sender_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_user_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_recipient_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_sender_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_user_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_sender_12hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_user_12hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_sender_user_12hr ( "5mintime" timestamp NOT NULL ,sender varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table mail_detail_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),recipient varchar(1024),sender varchar(64),subject varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));



Create table spam_app_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_12hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_sender_12hr ( "5mintime" timestamp NOT NULL ,sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table spam_app_dest_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_recipient_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_sender_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_dest_recipient_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_dest_sender_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_host_recipient_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_host_sender_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_sender_12hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_user_12hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_sender_user_12hr ( "5mintime" timestamp NOT NULL ,sender varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table spam_detail_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),recipient varchar(1024),sender varchar(64),subject varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));





Create table mail_app_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_24hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_sender_24hr ( "5mintime" timestamp NOT NULL ,sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_user_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table mail_app_dest_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_recipient_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_sender_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_app_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_host_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_recipient_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_sender_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_dest_user_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_recipient_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_sender_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_host_user_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_sender_24hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_recipient_user_24hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table mail_sender_user_24hr ( "5mintime" timestamp NOT NULL ,sender varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table mail_detail_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),recipient varchar(1024),sender varchar(64),subject varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));



Create table spam_app_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_24hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_sender_24hr ( "5mintime" timestamp NOT NULL ,sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table spam_app_dest_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_recipient_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_sender_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_app_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_dest_recipient_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_dest_sender_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_host_recipient_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_host_sender_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_sender_24hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_recipient_user_24hr ( "5mintime" timestamp NOT NULL ,recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table spam_sender_user_24hr ( "5mintime" timestamp NOT NULL ,sender varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table spam_detail_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),recipient varchar(1024),sender varchar(64),subject varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));









-- ==============================================================
--  Virus
-- ==============================================================


DROP TABLE IF EXISTS virus_app_5min cascade;
DROP TABLE IF EXISTS virus_domain_5min cascade;
DROP TABLE IF EXISTS virus_ftpvirus_5min cascade;
DROP TABLE IF EXISTS virus_mailvirus_5min cascade;
DROP TABLE IF EXISTS virus_user_5min cascade;
DROP TABLE IF EXISTS virus_virus_5min cascade;
DROP TABLE IF EXISTS virus_webvirus_5min cascade;

DROP TABLE IF EXISTS virus_app_mailvirus_5min cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_5min cascade;
DROP TABLE IF EXISTS virus_domain_host_5min cascade;
DROP TABLE IF EXISTS virus_domain_user_5min cascade;
DROP TABLE IF EXISTS virus_domain_webvirus_5min cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_5min cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_5min cascade;
DROP TABLE IF EXISTS virus_ftpvirus_server_5min cascade;
DROP TABLE IF EXISTS virus_ftpvirus_user_5min cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_5min cascade;
DROP TABLE IF EXISTS virus_host_user_5min cascade;
DROP TABLE IF EXISTS virus_host_webvirus_5min cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_5min cascade;
DROP TABLE IF EXISTS virus_mailvirus_sender_5min cascade;
DROP TABLE IF EXISTS virus_user_webvirus_5min cascade;

DROP TABLE IF EXISTS virus_app_dest_mailvirus_5min cascade;
DROP TABLE IF EXISTS virus_app_host_mailvirus_5min cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_recipient_5min cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_sender_5min cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_user_5min cascade;
DROP TABLE IF EXISTS virus_dest_host_mailvirus_5min cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_recipient_5min cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_sender_5min cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_user_5min cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_host_5min cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_server_5min cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_user_5min cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_server_5min cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_user_5min cascade;
DROP TABLE IF EXISTS virus_ftpvirus_server_user_5min cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_recipient_5min cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_sender_5min cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_user_5min cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_sender_5min cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_user_5min cascade;
DROP TABLE IF EXISTS virus_mailvirus_sender_user_5min cascade;

DROP TABLE IF EXISTS virus_host_url_user_webvirus_5min cascade;

DROP TABLE IF EXISTS virus_domain_host_url_user_webvirus_5min cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_host_server_user_5min cascade;

DROP TABLE IF EXISTS virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr_5min cascade;




DROP TABLE IF EXISTS virus_app_4hr cascade;
DROP TABLE IF EXISTS virus_domain_4hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_4hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_4hr cascade;
DROP TABLE IF EXISTS virus_user_4hr cascade;
DROP TABLE IF EXISTS virus_virus_4hr cascade;
DROP TABLE IF EXISTS virus_webvirus_4hr cascade;

DROP TABLE IF EXISTS virus_app_mailvirus_4hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_4hr cascade;
DROP TABLE IF EXISTS virus_domain_host_4hr cascade;
DROP TABLE IF EXISTS virus_domain_user_4hr cascade;
DROP TABLE IF EXISTS virus_domain_webvirus_4hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_4hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_4hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_server_4hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_user_4hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_4hr cascade;
DROP TABLE IF EXISTS virus_host_user_4hr cascade;
DROP TABLE IF EXISTS virus_host_webvirus_4hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_4hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_sender_4hr cascade;
DROP TABLE IF EXISTS virus_user_webvirus_4hr cascade;

DROP TABLE IF EXISTS virus_app_dest_mailvirus_4hr cascade;
DROP TABLE IF EXISTS virus_app_host_mailvirus_4hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_recipient_4hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_sender_4hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_user_4hr cascade;
DROP TABLE IF EXISTS virus_dest_host_mailvirus_4hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_recipient_4hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_sender_4hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_user_4hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_host_4hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_server_4hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_user_4hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_server_4hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_user_4hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_server_user_4hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_recipient_4hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_sender_4hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_user_4hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_sender_4hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_user_4hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_sender_user_4hr cascade;

DROP TABLE IF EXISTS virus_host_url_user_webvirus_4hr cascade;

DROP TABLE IF EXISTS virus_domain_host_url_user_webvirus_4hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_host_server_user_4hr cascade;

DROP TABLE IF EXISTS virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr_4hr cascade;



DROP TABLE IF EXISTS virus_app_12hr cascade;
DROP TABLE IF EXISTS virus_domain_12hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_12hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_12hr cascade;
DROP TABLE IF EXISTS virus_user_12hr cascade;
DROP TABLE IF EXISTS virus_virus_12hr cascade;
DROP TABLE IF EXISTS virus_webvirus_12hr cascade;

DROP TABLE IF EXISTS virus_app_mailvirus_12hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_12hr cascade;
DROP TABLE IF EXISTS virus_domain_host_12hr cascade;
DROP TABLE IF EXISTS virus_domain_user_12hr cascade;
DROP TABLE IF EXISTS virus_domain_webvirus_12hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_12hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_12hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_server_12hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_user_12hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_12hr cascade;
DROP TABLE IF EXISTS virus_host_user_12hr cascade;
DROP TABLE IF EXISTS virus_host_webvirus_12hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_12hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_sender_12hr cascade;
DROP TABLE IF EXISTS virus_user_webvirus_12hr cascade;

DROP TABLE IF EXISTS virus_app_dest_mailvirus_12hr cascade;
DROP TABLE IF EXISTS virus_app_host_mailvirus_12hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_recipient_12hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_sender_12hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_user_12hr cascade;
DROP TABLE IF EXISTS virus_dest_host_mailvirus_12hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_recipient_12hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_sender_12hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_user_12hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_host_12hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_server_12hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_user_12hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_server_12hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_user_12hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_server_user_12hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_recipient_12hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_sender_12hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_user_12hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_sender_12hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_user_12hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_sender_user_12hr cascade;

DROP TABLE IF EXISTS virus_host_url_user_webvirus_12hr cascade;

DROP TABLE IF EXISTS virus_domain_host_url_user_webvirus_12hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_host_server_user_12hr cascade;

DROP TABLE IF EXISTS virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr_12hr cascade;



DROP TABLE IF EXISTS virus_app_24hr cascade;
DROP TABLE IF EXISTS virus_domain_24hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_24hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_24hr cascade;
DROP TABLE IF EXISTS virus_user_24hr cascade;
DROP TABLE IF EXISTS virus_virus_24hr cascade;
DROP TABLE IF EXISTS virus_webvirus_24hr cascade;

DROP TABLE IF EXISTS virus_app_mailvirus_24hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_24hr cascade;
DROP TABLE IF EXISTS virus_domain_host_24hr cascade;
DROP TABLE IF EXISTS virus_domain_user_24hr cascade;
DROP TABLE IF EXISTS virus_domain_webvirus_24hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_24hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_24hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_server_24hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_user_24hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_24hr cascade;
DROP TABLE IF EXISTS virus_host_user_24hr cascade;
DROP TABLE IF EXISTS virus_host_webvirus_24hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_24hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_sender_24hr cascade;
DROP TABLE IF EXISTS virus_user_webvirus_24hr cascade;

DROP TABLE IF EXISTS virus_app_dest_mailvirus_24hr cascade;
DROP TABLE IF EXISTS virus_app_host_mailvirus_24hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_recipient_24hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_sender_24hr cascade;
DROP TABLE IF EXISTS virus_app_mailvirus_user_24hr cascade;
DROP TABLE IF EXISTS virus_dest_host_mailvirus_24hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_recipient_24hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_sender_24hr cascade;
DROP TABLE IF EXISTS virus_dest_mailvirus_user_24hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_host_24hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_server_24hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_user_24hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_server_24hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_host_user_24hr cascade;
DROP TABLE IF EXISTS virus_ftpvirus_server_user_24hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_recipient_24hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_sender_24hr cascade;
DROP TABLE IF EXISTS virus_host_mailvirus_user_24hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_sender_24hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_recipient_user_24hr cascade;
DROP TABLE IF EXISTS virus_mailvirus_sender_user_24hr cascade;

DROP TABLE IF EXISTS virus_host_url_user_webvirus_24hr cascade;

DROP TABLE IF EXISTS virus_domain_host_url_user_webvirus_24hr cascade;
DROP TABLE IF EXISTS virus_file_ftpvirus_host_server_user_24hr cascade;

DROP TABLE IF EXISTS virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr_24hr cascade;






Create table virus_app_5min ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_user_5min ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_virus_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_webvirus_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_mailvirus_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_dest_mailvirus_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_host_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_webvirus_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_file_ftpvirus_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_host_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_server_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_user_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_mailvirus_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_user_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_webvirus_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_recipient_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_sender_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_user_webvirus_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_dest_mailvirus_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_host_mailvirus_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_recipient_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_sender_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_host_mailvirus_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_recipient_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_sender_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_user_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_host_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_server_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_user_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_host_server_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_host_user_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_server_user_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_recipient_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_sender_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_user_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_recipient_sender_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_recipient_user_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_sender_user_5min ( "5mintime" timestamp NOT NULL ,virus varchar(32),sender varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table virus_host_url_user_webvirus_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024),username varchar(64),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table virus_domain_host_url_user_webvirus_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_file_ftpvirus_host_server_user_5min ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),host bigint, src_zone varchar(32),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),virus varchar(32),recipient varchar(1024),subject varchar(64),sender varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));


Create table virus_app_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_user_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_virus_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_webvirus_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_mailvirus_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_dest_mailvirus_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_host_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_webvirus_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_file_ftpvirus_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_host_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_server_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_user_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_mailvirus_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_user_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_webvirus_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_recipient_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_sender_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_user_webvirus_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_dest_mailvirus_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_host_mailvirus_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_recipient_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_sender_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_host_mailvirus_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_recipient_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_sender_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_user_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_host_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_server_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_user_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_host_server_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_host_user_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_server_user_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_recipient_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_sender_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_user_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_recipient_sender_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_recipient_user_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_sender_user_4hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),sender varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table virus_host_url_user_webvirus_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024),username varchar(64),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table virus_domain_host_url_user_webvirus_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_file_ftpvirus_host_server_user_4hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),host bigint, src_zone varchar(32),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),virus varchar(32),recipient varchar(1024),subject varchar(64),sender varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));


Create table virus_app_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_user_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_virus_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_webvirus_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_mailvirus_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_dest_mailvirus_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_host_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_webvirus_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_file_ftpvirus_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_host_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_server_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_user_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_mailvirus_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_user_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_webvirus_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_recipient_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_sender_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_user_webvirus_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_dest_mailvirus_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_host_mailvirus_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_recipient_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_sender_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_host_mailvirus_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_recipient_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_sender_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_user_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_host_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_server_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_user_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_host_server_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_host_user_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_server_user_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_recipient_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_sender_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_user_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_recipient_sender_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_recipient_user_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_sender_user_12hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),sender varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table virus_host_url_user_webvirus_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024),username varchar(64),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table virus_domain_host_url_user_webvirus_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_file_ftpvirus_host_server_user_12hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),host bigint, src_zone varchar(32),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),virus varchar(32),recipient varchar(1024),subject varchar(64),sender varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));




Create table virus_app_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_user_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_virus_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_webvirus_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_mailvirus_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_dest_mailvirus_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_host_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_domain_webvirus_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_file_ftpvirus_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_host_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_server_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_ftpvirus_user_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_mailvirus_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_user_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_host_webvirus_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_recipient_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_mailvirus_sender_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),sender varchar(64), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_user_webvirus_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_dest_mailvirus_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_host_mailvirus_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_recipient_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_sender_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_app_mailvirus_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_host_mailvirus_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_recipient_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_sender_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_dest_mailvirus_user_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_host_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_server_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_file_ftpvirus_user_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_host_server_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32),destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_host_user_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_ftpvirus_server_user_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_recipient_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),recipient varchar(1024), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_sender_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_host_mailvirus_user_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),virus varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_recipient_sender_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024),sender varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_recipient_user_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),recipient varchar(1024),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table virus_mailvirus_sender_user_24hr ( "5mintime" timestamp NOT NULL ,virus varchar(32),sender varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table virus_host_url_user_webvirus_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),url varchar(1024),username varchar(64),virus varchar(32), hits bigint DEFAULT 1, appid varchar(64));

Create table virus_domain_host_url_user_webvirus_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),url varchar(1024),username varchar(64),virus varchar(32), hits bigint DEFAULT 1,  appid varchar(64));
Create table virus_file_ftpvirus_host_server_user_24hr ( "5mintime" timestamp NOT NULL ,file varchar(64),virus varchar(32),host bigint, src_zone varchar(32),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));

Create table virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),host bigint, src_zone varchar(32),virus varchar(32),recipient varchar(1024),subject varchar(64),sender varchar(64),username varchar(64), hits bigint DEFAULT 1,  appid varchar(64));






-- ===================================
--	Web Usage Report   
-- ===================================

DROP TABLE IF EXISTS web_app_5min cascade;
DROP TABLE IF EXISTS web_category_5min cascade;
DROP TABLE IF EXISTS web_content_5min cascade;
DROP TABLE IF EXISTS web_domain_5min cascade;
DROP TABLE IF EXISTS web_host_5min cascade;
DROP TABLE IF EXISTS web_user_5min cascade;

DROP TABLE IF EXISTS web_app_category_5min cascade;
DROP TABLE IF EXISTS web_app_content_5min cascade;
DROP TABLE IF EXISTS web_app_domain_5min cascade;
DROP TABLE IF EXISTS web_app_host_5min cascade;
DROP TABLE IF EXISTS web_app_user_5min cascade;
DROP TABLE IF EXISTS web_category_content_5min cascade;
DROP TABLE IF EXISTS web_category_domain_5min cascade;
DROP TABLE IF EXISTS web_category_host_5min cascade;
DROP TABLE IF EXISTS web_category_user_5min cascade;
DROP TABLE IF EXISTS web_content_domain_5min cascade;
DROP TABLE IF EXISTS web_content_host_5min cascade;
DROP TABLE IF EXISTS web_content_user_5min cascade;
DROP TABLE IF EXISTS web_domain_host_5min cascade;
DROP TABLE IF EXISTS web_domain_user_5min cascade;
DROP TABLE IF EXISTS web_url_host_5min cascade;
DROP TABLE IF EXISTS web_url_user_5min cascade;
DROP TABLE IF EXISTS web_host_user_5min cascade;

DROP TABLE IF EXISTS web_app_category_content_5min cascade;
DROP TABLE IF EXISTS web_app_category_domain_5min cascade;
DROP TABLE IF EXISTS web_app_category_host_5min cascade;
DROP TABLE IF EXISTS web_app_category_user_5min cascade;
DROP TABLE IF EXISTS web_app_content_domain_5min cascade;
DROP TABLE IF EXISTS web_app_content_host_5min cascade;
DROP TABLE IF EXISTS web_app_content_user_5min cascade;
DROP TABLE IF EXISTS web_app_domain_user_5min cascade;
DROP TABLE IF EXISTS web_app_url_user_5min cascade;
DROP TABLE IF EXISTS web_app_host_user_5min cascade;
DROP TABLE IF EXISTS web_category_content_domain_5min cascade;
DROP TABLE IF EXISTS web_category_content_user_5min cascade;
DROP TABLE IF EXISTS web_category_domain_host_5min cascade;
DROP TABLE IF EXISTS web_category_domain_user_5min cascade;
DROP TABLE IF EXISTS web_category_host_user_5min cascade;
DROP TABLE IF EXISTS web_content_domain_host_5min cascade;
DROP TABLE IF EXISTS web_content_domain_user_5min cascade;
DROP TABLE IF EXISTS web_content_host_user_5min cascade;
DROP TABLE IF EXISTS web_domain_url_host_5min cascade;
DROP TABLE IF EXISTS web_domain_url_user_5min cascade;
DROP TABLE IF EXISTS web_domain_host_user_5min cascade;
DROP TABLE IF EXISTS web_url_host_user_5min cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_5min cascade;
DROP TABLE IF EXISTS web_app_category_content_user_5min cascade;
DROP TABLE IF EXISTS web_app_category_domain_host_5min cascade;
DROP TABLE IF EXISTS web_app_category_domain_user_5min cascade;
DROP TABLE IF EXISTS web_app_category_host_user_5min cascade;
DROP TABLE IF EXISTS web_app_content_domain_host_5min cascade;
DROP TABLE IF EXISTS web_app_content_domain_user_5min cascade;
DROP TABLE IF EXISTS web_app_content_host_user_5min cascade;
DROP TABLE IF EXISTS web_app_domain_url_user_5min cascade;
DROP TABLE IF EXISTS web_category_content_domain_url_5min cascade;
DROP TABLE IF EXISTS web_category_content_domain_user_5min cascade;
DROP TABLE IF EXISTS web_category_domain_url_host_5min cascade;
DROP TABLE IF EXISTS web_category_domain_url_user_5min cascade;
DROP TABLE IF EXISTS web_category_domain_host_user_5min cascade;
DROP TABLE IF EXISTS web_content_domain_url_host_5min cascade;
DROP TABLE IF EXISTS web_content_domain_url_user_5min cascade;
DROP TABLE IF EXISTS web_content_domain_host_user_5min cascade;
DROP TABLE IF EXISTS web_domain_url_host_user_5min cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_url_5min cascade;
DROP TABLE IF EXISTS web_app_category_content_domain_user_5min cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_host_5min cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_user_5min cascade;
DROP TABLE IF EXISTS web_app_category_domain_host_user_5min cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_host_5min cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_user_5min cascade;
DROP TABLE IF EXISTS web_app_content_domain_host_user_5min cascade;
DROP TABLE IF EXISTS web_category_content_domain_url_user_5min cascade;
DROP TABLE IF EXISTS web_category_domain_url_host_user_5min cascade;
DROP TABLE IF EXISTS web_content_domain_url_host_user_5min cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_url_user_5min cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_host_user_5min cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_host_user_5min cascade;





DROP TABLE IF EXISTS web_app_4hr cascade;
DROP TABLE IF EXISTS web_category_4hr cascade;
DROP TABLE IF EXISTS web_content_4hr cascade;
DROP TABLE IF EXISTS web_domain_4hr cascade;
DROP TABLE IF EXISTS web_host_4hr cascade;
DROP TABLE IF EXISTS web_user_4hr cascade;

DROP TABLE IF EXISTS web_app_category_4hr cascade;
DROP TABLE IF EXISTS web_app_content_4hr cascade;
DROP TABLE IF EXISTS web_app_domain_4hr cascade;
DROP TABLE IF EXISTS web_app_host_4hr cascade;
DROP TABLE IF EXISTS web_app_user_4hr cascade;
DROP TABLE IF EXISTS web_category_content_4hr cascade;
DROP TABLE IF EXISTS web_category_domain_4hr cascade;
DROP TABLE IF EXISTS web_category_host_4hr cascade;
DROP TABLE IF EXISTS web_category_user_4hr cascade;
DROP TABLE IF EXISTS web_content_domain_4hr cascade;
DROP TABLE IF EXISTS web_content_host_4hr cascade;
DROP TABLE IF EXISTS web_content_user_4hr cascade;
DROP TABLE IF EXISTS web_domain_host_4hr cascade;
DROP TABLE IF EXISTS web_domain_user_4hr cascade;
DROP TABLE IF EXISTS web_url_host_4hr cascade;
DROP TABLE IF EXISTS web_url_user_4hr cascade;
DROP TABLE IF EXISTS web_host_user_4hr cascade;

DROP TABLE IF EXISTS web_app_category_content_4hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_4hr cascade;
DROP TABLE IF EXISTS web_app_category_host_4hr cascade;
DROP TABLE IF EXISTS web_app_category_user_4hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_4hr cascade;
DROP TABLE IF EXISTS web_app_content_host_4hr cascade;
DROP TABLE IF EXISTS web_app_content_user_4hr cascade;
DROP TABLE IF EXISTS web_app_domain_user_4hr cascade;
DROP TABLE IF EXISTS web_app_url_user_4hr cascade;
DROP TABLE IF EXISTS web_app_host_user_4hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_4hr cascade;
DROP TABLE IF EXISTS web_category_content_user_4hr cascade;
DROP TABLE IF EXISTS web_category_domain_host_4hr cascade;
DROP TABLE IF EXISTS web_category_domain_user_4hr cascade;
DROP TABLE IF EXISTS web_category_host_user_4hr cascade;
DROP TABLE IF EXISTS web_content_domain_host_4hr cascade;
DROP TABLE IF EXISTS web_content_domain_user_4hr cascade;
DROP TABLE IF EXISTS web_content_host_user_4hr cascade;
DROP TABLE IF EXISTS web_domain_url_host_4hr cascade;
DROP TABLE IF EXISTS web_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS web_domain_host_user_4hr cascade;
DROP TABLE IF EXISTS web_url_host_user_4hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_4hr cascade;
DROP TABLE IF EXISTS web_app_category_content_user_4hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_host_4hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_user_4hr cascade;
DROP TABLE IF EXISTS web_app_category_host_user_4hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_host_4hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_user_4hr cascade;
DROP TABLE IF EXISTS web_app_content_host_user_4hr cascade;
DROP TABLE IF EXISTS web_app_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_url_4hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_user_4hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_host_4hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS web_category_domain_host_user_4hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_host_4hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS web_content_domain_host_user_4hr cascade;
DROP TABLE IF EXISTS web_domain_url_host_user_4hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_url_4hr cascade;
DROP TABLE IF EXISTS web_app_category_content_domain_user_4hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_host_4hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_host_user_4hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_host_4hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_host_user_4hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_host_user_4hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_host_user_4hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_url_user_4hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_host_user_4hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_host_user_4hr cascade;






DROP TABLE IF EXISTS web_app_12hr cascade;
DROP TABLE IF EXISTS web_category_12hr cascade;
DROP TABLE IF EXISTS web_content_12hr cascade;
DROP TABLE IF EXISTS web_domain_12hr cascade;
DROP TABLE IF EXISTS web_host_12hr cascade;
DROP TABLE IF EXISTS web_user_12hr cascade;

DROP TABLE IF EXISTS web_app_category_12hr cascade;
DROP TABLE IF EXISTS web_app_content_12hr cascade;
DROP TABLE IF EXISTS web_app_domain_12hr cascade;
DROP TABLE IF EXISTS web_app_host_12hr cascade;
DROP TABLE IF EXISTS web_app_user_12hr cascade;
DROP TABLE IF EXISTS web_category_content_12hr cascade;
DROP TABLE IF EXISTS web_category_domain_12hr cascade;
DROP TABLE IF EXISTS web_category_host_12hr cascade;
DROP TABLE IF EXISTS web_category_user_12hr cascade;
DROP TABLE IF EXISTS web_content_domain_12hr cascade;
DROP TABLE IF EXISTS web_content_host_12hr cascade;
DROP TABLE IF EXISTS web_content_user_12hr cascade;
DROP TABLE IF EXISTS web_domain_host_12hr cascade;
DROP TABLE IF EXISTS web_domain_user_12hr cascade;
DROP TABLE IF EXISTS web_url_host_12hr cascade;
DROP TABLE IF EXISTS web_url_user_12hr cascade;
DROP TABLE IF EXISTS web_host_user_12hr cascade;

DROP TABLE IF EXISTS web_app_category_content_12hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_12hr cascade;
DROP TABLE IF EXISTS web_app_category_host_12hr cascade;
DROP TABLE IF EXISTS web_app_category_user_12hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_12hr cascade;
DROP TABLE IF EXISTS web_app_content_host_12hr cascade;
DROP TABLE IF EXISTS web_app_content_user_12hr cascade;
DROP TABLE IF EXISTS web_app_domain_user_12hr cascade;
DROP TABLE IF EXISTS web_app_url_user_12hr cascade;
DROP TABLE IF EXISTS web_app_host_user_12hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_12hr cascade;
DROP TABLE IF EXISTS web_category_content_user_12hr cascade;
DROP TABLE IF EXISTS web_category_domain_host_12hr cascade;
DROP TABLE IF EXISTS web_category_domain_user_12hr cascade;
DROP TABLE IF EXISTS web_category_host_user_12hr cascade;
DROP TABLE IF EXISTS web_content_domain_host_12hr cascade;
DROP TABLE IF EXISTS web_content_domain_user_12hr cascade;
DROP TABLE IF EXISTS web_content_host_user_12hr cascade;
DROP TABLE IF EXISTS web_domain_url_host_12hr cascade;
DROP TABLE IF EXISTS web_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS web_domain_host_user_12hr cascade;
DROP TABLE IF EXISTS web_url_host_user_12hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_12hr cascade;
DROP TABLE IF EXISTS web_app_category_content_user_12hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_host_12hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_user_12hr cascade;
DROP TABLE IF EXISTS web_app_category_host_user_12hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_host_12hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_user_12hr cascade;
DROP TABLE IF EXISTS web_app_content_host_user_12hr cascade;
DROP TABLE IF EXISTS web_app_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_url_12hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_user_12hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_host_12hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS web_category_domain_host_user_12hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_host_12hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS web_content_domain_host_user_12hr cascade;
DROP TABLE IF EXISTS web_domain_url_host_user_12hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_url_12hr cascade;
DROP TABLE IF EXISTS web_app_category_content_domain_user_12hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_host_12hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_host_user_12hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_host_12hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_host_user_12hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_host_user_12hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_host_user_12hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_url_user_12hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_host_user_12hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_host_user_12hr cascade;







DROP TABLE IF EXISTS web_app_24hr cascade;
DROP TABLE IF EXISTS web_category_24hr cascade;
DROP TABLE IF EXISTS web_content_24hr cascade;
DROP TABLE IF EXISTS web_domain_24hr cascade;
DROP TABLE IF EXISTS web_host_24hr cascade;
DROP TABLE IF EXISTS web_user_24hr cascade;

DROP TABLE IF EXISTS web_app_category_24hr cascade;
DROP TABLE IF EXISTS web_app_content_24hr cascade;
DROP TABLE IF EXISTS web_app_domain_24hr cascade;
DROP TABLE IF EXISTS web_app_host_24hr cascade;
DROP TABLE IF EXISTS web_app_user_24hr cascade;
DROP TABLE IF EXISTS web_category_content_24hr cascade;
DROP TABLE IF EXISTS web_category_domain_24hr cascade;
DROP TABLE IF EXISTS web_category_host_24hr cascade;
DROP TABLE IF EXISTS web_category_user_24hr cascade;
DROP TABLE IF EXISTS web_content_domain_24hr cascade;
DROP TABLE IF EXISTS web_content_host_24hr cascade;
DROP TABLE IF EXISTS web_content_user_24hr cascade;
DROP TABLE IF EXISTS web_domain_host_24hr cascade;
DROP TABLE IF EXISTS web_domain_user_24hr cascade;
DROP TABLE IF EXISTS web_url_host_24hr cascade;
DROP TABLE IF EXISTS web_url_user_24hr cascade;
DROP TABLE IF EXISTS web_host_user_24hr cascade;

DROP TABLE IF EXISTS web_app_category_content_24hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_24hr cascade;
DROP TABLE IF EXISTS web_app_category_host_24hr cascade;
DROP TABLE IF EXISTS web_app_category_user_24hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_24hr cascade;
DROP TABLE IF EXISTS web_app_content_host_24hr cascade;
DROP TABLE IF EXISTS web_app_content_user_24hr cascade;
DROP TABLE IF EXISTS web_app_domain_user_24hr cascade;
DROP TABLE IF EXISTS web_app_url_user_24hr cascade;
DROP TABLE IF EXISTS web_app_host_user_24hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_24hr cascade;
DROP TABLE IF EXISTS web_category_content_user_24hr cascade;
DROP TABLE IF EXISTS web_category_domain_host_24hr cascade;
DROP TABLE IF EXISTS web_category_domain_user_24hr cascade;
DROP TABLE IF EXISTS web_category_host_user_24hr cascade;
DROP TABLE IF EXISTS web_content_domain_host_24hr cascade;
DROP TABLE IF EXISTS web_content_domain_user_24hr cascade;
DROP TABLE IF EXISTS web_content_host_user_24hr cascade;
DROP TABLE IF EXISTS web_domain_url_host_24hr cascade;
DROP TABLE IF EXISTS web_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS web_domain_host_user_24hr cascade;
DROP TABLE IF EXISTS web_url_host_user_24hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_24hr cascade;
DROP TABLE IF EXISTS web_app_category_content_user_24hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_host_24hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_user_24hr cascade;
DROP TABLE IF EXISTS web_app_category_host_user_24hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_host_24hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_user_24hr cascade;
DROP TABLE IF EXISTS web_app_content_host_user_24hr cascade;
DROP TABLE IF EXISTS web_app_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_url_24hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_user_24hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_host_24hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS web_category_domain_host_user_24hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_host_24hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS web_content_domain_host_user_24hr cascade;
DROP TABLE IF EXISTS web_domain_url_host_user_24hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_url_24hr cascade;
DROP TABLE IF EXISTS web_app_category_content_domain_user_24hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_host_24hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_host_user_24hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_host_24hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_host_user_24hr cascade;
DROP TABLE IF EXISTS web_category_content_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS web_category_domain_url_host_user_24hr cascade;
DROP TABLE IF EXISTS web_content_domain_url_host_user_24hr cascade;

DROP TABLE IF EXISTS web_app_category_content_domain_url_user_24hr cascade;
DROP TABLE IF EXISTS web_app_category_domain_url_host_user_24hr cascade;
DROP TABLE IF EXISTS web_app_content_domain_url_host_user_24hr cascade;




-- ==============================================================
--	Web Usage Report 
-- ==============================================================

Create table web_app_5min ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_5min ( "5mintime" timestamp NOT NULL ,category varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_5min ( "5mintime" timestamp NOT NULL ,content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_host_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_user_5min ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_host_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_host_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_user_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_host_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_host_5min ( "5mintime" timestamp NOT NULL ,url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_user_5min ( "5mintime" timestamp NOT NULL ,url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_host_user_5min ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_url_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_host_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_host_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_host_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_user_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_host_user_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_host_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_host_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_host_user_5min ( "5mintime" timestamp NOT NULL ,url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_content_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_url_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_host_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_host_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_host_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_host_user_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_host_user_5min ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_url_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_content_domain_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_host_user_5min ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_host_user_5min ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_url_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));









Create table web_app_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_host_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_user_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_host_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_host_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_user_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_host_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_host_4hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_user_4hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_host_user_4hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_url_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_host_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_host_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_host_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_user_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_host_user_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_host_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_host_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_host_user_4hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_content_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_url_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_host_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_host_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_host_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_host_user_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_host_user_4hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_url_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_content_domain_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_host_user_4hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_host_user_4hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_url_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));







Create table web_app_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_host_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_user_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_host_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_host_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_user_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_host_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_host_12hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_user_12hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_host_user_12hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_url_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_host_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_host_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_host_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_user_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_host_user_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_host_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_host_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_host_user_12hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_content_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_url_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_host_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_host_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_host_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_host_user_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_host_user_12hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_url_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_content_domain_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_host_user_12hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_host_user_12hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_url_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));








Create table web_app_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_host_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_user_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_host_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_host_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_user_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_host_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_host_24hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_user_24hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_host_user_24hr ( "5mintime" timestamp NOT NULL ,host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_url_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_host_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_host_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_host_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_user_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_host_user_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_host_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_host_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_url_host_user_24hr ( "5mintime" timestamp NOT NULL ,url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_content_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_url_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_host_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_host_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_host_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_host_user_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_domain_url_host_user_24hr ( "5mintime" timestamp NOT NULL ,domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_url_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_content_domain_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_content_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_category_domain_url_host_user_24hr ( "5mintime" timestamp NOT NULL ,category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_content_domain_url_host_user_24hr ( "5mintime" timestamp NOT NULL ,content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));

Create table web_app_category_content_domain_url_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_category_domain_url_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),category varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));
Create table web_app_content_domain_url_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),content varchar(64),domain varchar(512), dst_zone varchar(32),url varchar(1024),host bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, bytes bigint, appid varchar(64));






-- ==============================
-- changes for new Firewall table groups
-- ==============================



DROP TABLE IF EXISTS top_hosts_5min cascade ;
DROP TABLE IF EXISTS top_user_5min cascade ;
DROP TABLE IF EXISTS top_protogroup_5min cascade ;
DROP TABLE IF EXISTS top_rules_5min cascade ;
DROP TABLE IF EXISTS srcip_protogroup_5min cascade ;
DROP TABLE IF EXISTS srcip_dest_5min cascade ;
DROP TABLE IF EXISTS srcip_user_5min cascade ;
DROP TABLE IF EXISTS srcip_ruleid_5min cascade ;
DROP TABLE IF EXISTS user_protogroup_5min cascade ;
DROP TABLE IF EXISTS user_dest_5min cascade ;
DROP TABLE IF EXISTS user_ruleid_5min cascade ;
DROP TABLE IF EXISTS protogroup_hosts_5min cascade ;
DROP TABLE IF EXISTS protogroup_user_5min cascade ;
DROP TABLE IF EXISTS protogroup_dest_5min cascade ;
DROP TABLE IF EXISTS protogroup_rules_5min cascade ;
DROP TABLE IF EXISTS hosts_protogroup_users_5min cascade ;
DROP TABLE IF EXISTS hosts_protogroup_dest_5min cascade ;
DROP TABLE IF EXISTS hosts_protogroup_rules_5min cascade ;
DROP TABLE IF EXISTS users_protogroup_dest_5min cascade ;
DROP TABLE IF EXISTS users_protogroup_rules_5min cascade ;
DROP TABLE IF EXISTS protogroup_application_5min cascade ;
DROP TABLE IF EXISTS hosts_protogroup_application_5min cascade ;
DROP TABLE IF EXISTS users_protogroup_application_5min cascade ;
DROP TABLE IF EXISTS rules_detail_5min cascade ;
DROP TABLE IF EXISTS protogroup_application_dest_5min cascade ;
DROP TABLE IF EXISTS protogroup_application_ruleid_5min cascade ;



DROP TABLE IF EXISTS top_hosts_protogroup_5min cascade ;
DROP TABLE IF EXISTS top_users_protogroup_5min cascade ;
DROP TABLE IF EXISTS top_applications_5min cascade ;
DROP TABLE IF EXISTS application_hosts_5min cascade ;
DROP TABLE IF EXISTS application_user_5min cascade ;
DROP TABLE IF EXISTS application_dest_5min cascade ;
DROP TABLE IF EXISTS application_rules_5min cascade ;
DROP TABLE IF EXISTS hosts_protogroup_application_5min cascade ;
DROP TABLE IF EXISTS users_protogroup_application_5min cascade ;



DROP TABLE IF EXISTS top_acceptrules_5min cascade ;
DROP TABLE IF EXISTS top_denyrules_5min cascade ;
DROP TABLE IF EXISTS top_acceptrules_protogroup_5min cascade ;
DROP TABLE IF EXISTS top_denyrules_protogroup_5min cascade ;
DROP TABLE IF EXISTS top_acceptrules_host_5min cascade ;
DROP TABLE IF EXISTS top_denyrules_host_5min cascade ;
DROP TABLE IF EXISTS top_acceptrules_dest_5min cascade ;
DROP TABLE IF EXISTS top_denyrules_dest_5min cascade ;
DROP TABLE IF EXISTS accept_rules_host_application_dest_user_5min cascade ;
DROP TABLE IF EXISTS deny_rules_host_application_dest_user_5min cascade ;
DROP TABLE IF EXISTS accept_rules_host_app_protog_dest_user_5min cascade ;
DROP TABLE IF EXISTS deny_rules_host_app_protogroup_dest_user_5min cascade ;
DROP TABLE IF EXISTS accept_host_application_dest_user_5min cascade ;
DROP TABLE IF EXISTS deny_host_application_dest_user_5min cascade ;




DROP TABLE IF EXISTS top_hosts_4hr cascade ;
DROP TABLE IF EXISTS top_user_4hr cascade ;
DROP TABLE IF EXISTS top_protogroup_4hr cascade ;
DROP TABLE IF EXISTS top_rules_4hr cascade ;
DROP TABLE IF EXISTS srcip_protogroup_4hr cascade ;
DROP TABLE IF EXISTS srcip_dest_4hr cascade ;
DROP TABLE IF EXISTS srcip_user_4hr cascade ;
DROP TABLE IF EXISTS srcip_ruleid_4hr cascade ;
DROP TABLE IF EXISTS user_protogroup_4hr cascade ;
DROP TABLE IF EXISTS user_dest_4hr cascade ;
DROP TABLE IF EXISTS user_ruleid_4hr cascade ;
DROP TABLE IF EXISTS protogroup_hosts_4hr cascade ;
DROP TABLE IF EXISTS protogroup_user_4hr cascade ;
DROP TABLE IF EXISTS protogroup_dest_4hr cascade ;
DROP TABLE IF EXISTS protogroup_rules_4hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_users_4hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_dest_4hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_rules_4hr cascade ;
DROP TABLE IF EXISTS users_protogroup_dest_4hr cascade ;
DROP TABLE IF EXISTS users_protogroup_rules_4hr cascade ;
DROP TABLE IF EXISTS protogroup_application_4hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_application_4hr cascade ;
DROP TABLE IF EXISTS users_protogroup_application_4hr cascade ;
DROP TABLE IF EXISTS rules_detail_4hr cascade ;
DROP TABLE IF EXISTS protogroup_application_dest_4hr cascade ;
DROP TABLE IF EXISTS protogroup_application_ruleid_4hr cascade ;


DROP TABLE IF EXISTS top_hosts_protogroup_4hr cascade ;
DROP TABLE IF EXISTS top_users_protogroup_4hr cascade ;
DROP TABLE IF EXISTS top_applications_4hr cascade ;
DROP TABLE IF EXISTS application_hosts_4hr cascade ;
DROP TABLE IF EXISTS application_user_4hr cascade ;
DROP TABLE IF EXISTS application_dest_4hr cascade ;
DROP TABLE IF EXISTS application_rules_4hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_application_4hr cascade ;
DROP TABLE IF EXISTS users_protogroup_application_4hr cascade ;


DROP TABLE IF EXISTS top_acceptrules_4hr cascade ;
DROP TABLE IF EXISTS top_denyrules_4hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_protogroup_4hr cascade ;
DROP TABLE IF EXISTS top_denyrules_protogroup_4hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_host_4hr cascade ;
DROP TABLE IF EXISTS top_denyrules_host_4hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_dest_4hr cascade ;
DROP TABLE IF EXISTS top_denyrules_dest_4hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_application_dest_user_4hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_application_dest_user_4hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_app_protog_dest_user_4hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_app_protogroup_dest_user_4hr cascade ;
DROP TABLE IF EXISTS accept_host_application_dest_user_4hr cascade ;
DROP TABLE IF EXISTS deny_host_application_dest_user_4hr cascade ;


DROP TABLE IF EXISTS top_hosts_12hr cascade ;
DROP TABLE IF EXISTS top_user_12hr cascade ;
DROP TABLE IF EXISTS top_protogroup_12hr cascade ;
DROP TABLE IF EXISTS top_rules_12hr cascade ;
DROP TABLE IF EXISTS srcip_protogroup_12hr cascade ;
DROP TABLE IF EXISTS srcip_dest_12hr cascade ;
DROP TABLE IF EXISTS srcip_user_12hr cascade ;
DROP TABLE IF EXISTS srcip_ruleid_12hr cascade ;
DROP TABLE IF EXISTS user_protogroup_12hr cascade ;
DROP TABLE IF EXISTS user_dest_12hr cascade ;
DROP TABLE IF EXISTS user_ruleid_12hr cascade ;
DROP TABLE IF EXISTS protogroup_hosts_12hr cascade ;
DROP TABLE IF EXISTS protogroup_user_12hr cascade ;
DROP TABLE IF EXISTS protogroup_dest_12hr cascade ;
DROP TABLE IF EXISTS protogroup_rules_12hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_users_12hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_dest_12hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_rules_12hr cascade ;
DROP TABLE IF EXISTS users_protogroup_dest_12hr cascade ;
DROP TABLE IF EXISTS users_protogroup_rules_12hr cascade ;
DROP TABLE IF EXISTS protogroup_application_12hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_application_12hr cascade ;
DROP TABLE IF EXISTS users_protogroup_application_12hr cascade ;
DROP TABLE IF EXISTS rules_detail_12hr cascade ;
DROP TABLE IF EXISTS protogroup_application_dest_12hr cascade ;
DROP TABLE IF EXISTS protogroup_application_ruleid_12hr cascade ;


DROP TABLE IF EXISTS top_hosts_protogroup_12hr cascade ;
DROP TABLE IF EXISTS top_users_protogroup_12hr cascade ;
DROP TABLE IF EXISTS top_applications_12hr cascade ;
DROP TABLE IF EXISTS application_hosts_12hr cascade ;
DROP TABLE IF EXISTS application_user_12hr cascade ;
DROP TABLE IF EXISTS application_dest_12hr cascade ;
DROP TABLE IF EXISTS application_rules_12hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_application_12hr cascade ;
DROP TABLE IF EXISTS users_protogroup_application_12hr cascade ;


DROP TABLE IF EXISTS top_acceptrules_12hr cascade ;
DROP TABLE IF EXISTS top_denyrules_12hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_protogroup_12hr cascade ;
DROP TABLE IF EXISTS top_denyrules_protogroup_12hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_host_12hr cascade ;
DROP TABLE IF EXISTS top_denyrules_host_12hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_dest_12hr cascade ;
DROP TABLE IF EXISTS top_denyrules_dest_12hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_application_dest_user_12hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_application_dest_user_12hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_app_protog_dest_user_12hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_app_protogroup_dest_user_12hr cascade ;
DROP TABLE IF EXISTS accept_host_application_dest_user_12hr cascade ;
DROP TABLE IF EXISTS deny_host_application_dest_user_12hr cascade ;




DROP TABLE IF EXISTS top_hosts_24hr cascade ;
DROP TABLE IF EXISTS top_user_24hr cascade ;
DROP TABLE IF EXISTS top_protogroup_24hr cascade ;
DROP TABLE IF EXISTS top_rules_24hr cascade ;
DROP TABLE IF EXISTS srcip_protogroup_24hr cascade ;
DROP TABLE IF EXISTS srcip_dest_24hr cascade ;
DROP TABLE IF EXISTS srcip_user_24hr cascade ;
DROP TABLE IF EXISTS srcip_ruleid_24hr cascade ;
DROP TABLE IF EXISTS user_protogroup_24hr cascade ;
DROP TABLE IF EXISTS user_dest_24hr cascade ;
DROP TABLE IF EXISTS user_ruleid_24hr cascade ;
DROP TABLE IF EXISTS protogroup_hosts_24hr cascade ;
DROP TABLE IF EXISTS protogroup_user_24hr cascade ;
DROP TABLE IF EXISTS protogroup_dest_24hr cascade ;
DROP TABLE IF EXISTS protogroup_rules_24hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_users_24hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_dest_24hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_rules_24hr cascade ;
DROP TABLE IF EXISTS users_protogroup_dest_24hr cascade ;
DROP TABLE IF EXISTS users_protogroup_rules_24hr cascade ;
DROP TABLE IF EXISTS protogroup_application_24hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_application_24hr cascade ;
DROP TABLE IF EXISTS users_protogroup_application_24hr cascade ;
DROP TABLE IF EXISTS rules_detail_24hr cascade ;
DROP TABLE IF EXISTS protogroup_application_dest_24hr cascade ;
DROP TABLE IF EXISTS protogroup_application_ruleid_24hr cascade ;


DROP TABLE IF EXISTS top_hosts_protogroup_24hr cascade ;
DROP TABLE IF EXISTS top_users_protogroup_24hr cascade ;
DROP TABLE IF EXISTS top_applications_24hr cascade ;
DROP TABLE IF EXISTS application_hosts_24hr cascade ;
DROP TABLE IF EXISTS application_user_24hr cascade ;
DROP TABLE IF EXISTS application_dest_24hr cascade ;
DROP TABLE IF EXISTS application_rules_24hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_application_24hr cascade ;
DROP TABLE IF EXISTS users_protogroup_application_24hr cascade ;

DROP TABLE IF EXISTS top_acceptrules_24hr cascade ;
DROP TABLE IF EXISTS top_denyrules_24hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_protogroup_24hr cascade ;
DROP TABLE IF EXISTS top_denyrules_protogroup_24hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_host_24hr cascade ;
DROP TABLE IF EXISTS top_denyrules_host_24hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_dest_24hr cascade ;
DROP TABLE IF EXISTS top_denyrules_dest_24hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_application_dest_user_24hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_application_dest_user_24hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_app_protog_dest_user_24hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_app_protogroup_dest_user_24hr cascade ;
DROP TABLE IF EXISTS accept_host_application_dest_user_24hr cascade ;
DROP TABLE IF EXISTS deny_host_application_dest_user_24hr cascade ;











-- ==============================================================
-- Traffic/Firewall reporting table
-- ==============================================================

Create table top_hosts_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table top_user_5min ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table top_protogroup_5min ( "5mintime" timestamp NOT NULL ,proto_group varchar(64), hits bigint  default 1,  sent bigint , received bigint , total bigint ,appid varchar(64));

Create table top_rules_5min ( "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1, total bigint ,appid varchar(64));

Create table srcip_protogroup_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table srcip_dest_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table srcip_user_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table srcip_ruleid_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_protogroup_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_dest_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_ruleid_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_hosts_5min ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),srcip bigint ,src_zone varchar(32)  ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


Create table protogroup_user_5min ( "5mintime" timestamp NOT NULL , proto_group varchar(64),username varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_dest_5min ( "5mintime" timestamp NOT NULL , proto_group varchar(64),destip bigint ,dst_zone varchar(32) ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_rules_5min ( "5mintime" timestamp NOT NULL , proto_group varchar(64),ruleid bigint,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


Create table hosts_protogroup_users_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_dest_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_rules_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_dest_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_rules_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_application_5min ( "5mintime" timestamp NOT NULL , proto_group varchar(64),application varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_application_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_application_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table rules_detail_5min ( "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32)  ,username varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) ,action int, hits bigint  default 1,appid varchar(64) ) ;

Create table protogroup_application_dest_5min ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_application_ruleid_5min ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;



-- ==============================================================
-- Protocol Group Based Traffic Reports
-- ==============================================================

Create table top_hosts_protogroup_5min (  "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  top_users_protogroup_5min (  "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  top_applications_5min (  "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_hosts_5min (  "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_user_5min (  "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_dest_5min (  "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_rules_5min (  "5mintime" timestamp NOT NULL ,application varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;





-- ==============================================================
-- Firewall Rules Report
-- ==============================================================

Create table top_acceptrules_5min  (  "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_protogroup_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_protogroup_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_host_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_host_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_dest_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint,destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_dest_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint,destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;


Create table accept_rules_host_application_dest_user_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table deny_rules_host_application_dest_user_5min (  "5mintime" timestamp NOT NULL , ruleid bigint,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table accept_rules_host_app_protog_dest_user_5min (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table deny_rules_host_app_protogroup_dest_user_5min (  "5mintime" timestamp NOT NULL , ruleid bigint,proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table  accept_host_application_dest_user_5min (  "5mintime" timestamp NOT NULL ,srcip bigint,src_zone varchar(32),application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table  deny_host_application_dest_user_5min (  "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;




-- ==============================================================
--	4hr table
-- ==============================================================


-- ==============================================================
-- Traffic/Firewall reporting table
-- ==============================================================

Create table top_hosts_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table top_user_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table top_protogroup_4hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64), hits bigint  default 1,  sent bigint , received bigint , total bigint ,appid varchar(64));

Create table top_rules_4hr ( "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1, total bigint ,appid varchar(64));

Create table srcip_protogroup_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table srcip_dest_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table srcip_user_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table srcip_ruleid_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_protogroup_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_dest_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_ruleid_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_hosts_4hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),srcip bigint ,src_zone varchar(32)  ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_user_4hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),username varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_dest_4hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),destip bigint ,dst_zone varchar(32) ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_rules_4hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),ruleid bigint,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_users_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_dest_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_rules_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_dest_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_rules_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_application_4hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),application varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_application_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_application_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table rules_detail_4hr ( "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32)  ,username varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) ,action int, hits bigint  default 1,appid varchar(64) ) ;

Create table protogroup_application_dest_4hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_application_ruleid_4hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


-- ==============================================================
-- Protocol Group Based Traffic Reports
-- ==============================================================

Create table top_hosts_protogroup_4hr (  "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  top_users_protogroup_4hr (  "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  top_applications_4hr (  "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_hosts_4hr (  "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_user_4hr (  "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_dest_4hr (  "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_rules_4hr (  "5mintime" timestamp NOT NULL ,application varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


-- ==============================================================
-- Firewall Rules Report
-- ==============================================================

Create table top_acceptrules_4hr  (  "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_protogroup_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_protogroup_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_host_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_host_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_dest_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_dest_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table accept_rules_host_application_dest_user_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table deny_rules_host_application_dest_user_4hr (  "5mintime" timestamp NOT NULL , ruleid bigint,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table accept_rules_host_app_protog_dest_user_4hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table deny_rules_host_app_protogroup_dest_user_4hr (  "5mintime" timestamp NOT NULL , ruleid bigint,proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table  accept_host_application_dest_user_4hr (  "5mintime" timestamp NOT NULL ,srcip bigint,src_zone varchar(32),application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table  deny_host_application_dest_user_4hr (  "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;




-- ========================================================
--	12hr table
-- ========================================================

-- ==============================================================
-- Traffic/Firewall reporting table
-- ==============================================================

Create table top_hosts_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table top_user_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table top_protogroup_12hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64), hits bigint  default 1,  sent bigint , received bigint , total bigint ,appid varchar(64));

Create table top_rules_12hr ( "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1, total bigint ,appid varchar(64));

Create table srcip_protogroup_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table srcip_dest_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table srcip_user_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table srcip_ruleid_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_protogroup_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_dest_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_ruleid_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_hosts_12hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),srcip bigint ,src_zone varchar(32)  ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


Create table protogroup_user_12hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),username varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_dest_12hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),destip bigint ,dst_zone varchar(32) ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_rules_12hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),ruleid bigint,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


Create table hosts_protogroup_users_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_dest_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_rules_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_dest_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_rules_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;



Create table protogroup_application_12hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),application varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_application_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_application_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table rules_detail_12hr ( "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32)  ,username varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) ,action int, hits bigint  default 1,appid varchar(64) ) ;

Create table protogroup_application_dest_12hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_application_ruleid_12hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


-- ==============================================================
-- Protocol Group Based Traffic Reports
-- ==============================================================

Create table top_hosts_protogroup_12hr (  "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  top_users_protogroup_12hr (  "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  top_applications_12hr (  "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_hosts_12hr (  "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_user_12hr (  "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_dest_12hr (  "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_rules_12hr (  "5mintime" timestamp NOT NULL ,application varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


-- ==============================================================
-- Firewall Rules Report
-- ==============================================================

Create table top_acceptrules_12hr  (  "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_protogroup_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_protogroup_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_host_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_host_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_dest_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_dest_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table accept_rules_host_application_dest_user_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table deny_rules_host_application_dest_user_12hr (  "5mintime" timestamp NOT NULL , ruleid bigint,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table accept_rules_host_app_protog_dest_user_12hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table deny_rules_host_app_protogroup_dest_user_12hr (  "5mintime" timestamp NOT NULL , ruleid bigint,proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table  accept_host_application_dest_user_12hr (  "5mintime" timestamp NOT NULL ,srcip bigint,src_zone varchar(32),application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table  deny_host_application_dest_user_12hr (  "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;



-- =============================================================
--      24hr table
-- =============================================================

-- ==============================================================
-- Traffic/Firewall reporting table
-- ==============================================================

Create table top_hosts_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table top_user_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table top_protogroup_24hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64), hits bigint  default 1,  sent bigint , received bigint , total bigint ,appid varchar(64));

Create table top_rules_24hr ( "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1, total bigint ,appid varchar(64));

Create table srcip_protogroup_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table srcip_dest_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table srcip_user_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table srcip_ruleid_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_protogroup_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_dest_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table user_ruleid_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_hosts_24hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),srcip bigint ,src_zone varchar(32)  ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


Create table protogroup_user_24hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),username varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_dest_24hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),destip bigint ,dst_zone varchar(32) ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_rules_24hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),ruleid bigint,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


Create table hosts_protogroup_users_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_dest_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_rules_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


Create table users_protogroup_dest_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_rules_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;



Create table protogroup_application_24hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),application varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table hosts_protogroup_application_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table users_protogroup_application_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table rules_detail_24hr ( "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32)  ,username varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) ,action int, hits bigint  default 1,appid varchar(64) );

Create table protogroup_application_dest_24hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table protogroup_application_ruleid_24hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;


-- ==============================================================
-- Protocol Group Based Traffic Reports
-- ==============================================================

Create table top_hosts_protogroup_24hr (  "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  top_users_protogroup_24hr (  "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  top_applications_24hr (  "5mintime" timestamp NOT NULL ,application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_hosts_24hr (  "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_user_24hr (  "5mintime" timestamp NOT NULL ,application varchar(64),username varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_dest_24hr (  "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;

Create table  application_rules_24hr (  "5mintime" timestamp NOT NULL ,application varchar(64),ruleid bigint, hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;




-- ==============================================================
-- Firewall Rules Report
-- ==============================================================

Create table top_acceptrules_24hr  (  "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint, hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_protogroup_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_protogroup_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_host_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_host_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_acceptrules_dest_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table top_denyrules_dest_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;


Create table accept_rules_host_application_dest_user_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table deny_rules_host_application_dest_user_24hr (  "5mintime" timestamp NOT NULL , ruleid bigint,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table accept_rules_host_app_protog_dest_user_24hr (  "5mintime" timestamp NOT NULL ,ruleid bigint,proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table deny_rules_host_app_protogroup_dest_user_24hr (  "5mintime" timestamp NOT NULL , ruleid bigint,proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table  accept_host_application_dest_user_24hr (  "5mintime" timestamp NOT NULL ,srcip bigint,src_zone varchar(32),application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

Create table  deny_host_application_dest_user_24hr (  "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;







-- Revised table to be added

DROP TABLE IF EXISTS host_user_application_5min cascade ;
DROP TABLE IF EXISTS host_dest_application_5min cascade ;
DROP TABLE IF EXISTS host_dest_user_5min cascade ;
DROP TABLE IF EXISTS user_dest_application_5min cascade ;
DROP TABLE IF EXISTS host_protogroup_application_dest_5min cascade ;
DROP TABLE IF EXISTS user_protogroup_application_dest_5min cascade ;
DROP TABLE IF EXISTS user_protogroup_host_application_5min cascade ;
DROP TABLE IF EXISTS user_dest_application_host_5min cascade ;
DROP TABLE IF EXISTS protogroup_host_dest_user_5min cascade ;
DROP TABLE IF EXISTS host_protogroup_application_user_dest_5min cascade ;

DROP TABLE IF EXISTS host_user_application_4hr cascade ;
DROP TABLE IF EXISTS host_dest_application_4hr cascade ;
DROP TABLE IF EXISTS host_dest_user_4hr cascade ;
DROP TABLE IF EXISTS user_dest_application_4hr cascade ;
DROP TABLE IF EXISTS host_protogroup_application_dest_4hr cascade ;
DROP TABLE IF EXISTS user_protogroup_application_dest_4hr cascade ;
DROP TABLE IF EXISTS user_protogroup_host_application_4hr cascade ;
DROP TABLE IF EXISTS user_dest_application_host_4hr cascade ;
DROP TABLE IF EXISTS protogroup_host_dest_user_4hr cascade ;
DROP TABLE IF EXISTS host_protogroup_application_user_dest_4hr cascade ;

DROP TABLE IF EXISTS host_user_application_12hr cascade ;
DROP TABLE IF EXISTS host_dest_application_12hr cascade ;
DROP TABLE IF EXISTS host_dest_user_12hr cascade ;
DROP TABLE IF EXISTS user_dest_application_12hr cascade ;
DROP TABLE IF EXISTS host_protogroup_application_dest_12hr cascade ;
DROP TABLE IF EXISTS user_protogroup_application_dest_12hr cascade ;
DROP TABLE IF EXISTS user_protogroup_host_application_12hr cascade ;
DROP TABLE IF EXISTS user_dest_application_host_12hr cascade ;
DROP TABLE IF EXISTS protogroup_host_dest_user_12hr cascade ;
DROP TABLE IF EXISTS host_protogroup_application_user_dest_12hr cascade ;

DROP TABLE IF EXISTS host_user_application_24hr cascade ;
DROP TABLE IF EXISTS host_dest_application_24hr cascade ;
DROP TABLE IF EXISTS host_dest_user_24hr cascade ;
DROP TABLE IF EXISTS user_dest_application_24hr cascade ;
DROP TABLE IF EXISTS host_protogroup_application_dest_24hr cascade ;
DROP TABLE IF EXISTS user_protogroup_application_dest_24hr cascade ;
DROP TABLE IF EXISTS user_protogroup_host_application_24hr cascade ;
DROP TABLE IF EXISTS user_dest_application_host_24hr cascade ;
DROP TABLE IF EXISTS protogroup_host_dest_user_24hr cascade ;
DROP TABLE IF EXISTS host_protogroup_application_user_dest_24hr cascade ;





Create table host_user_application_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,username varchar(64), application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_dest_application_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,destip bigint ,dst_zone varchar(32), application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_dest_user_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) ,username varchar(64),  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_dest_application_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),destip bigint ,dst_zone varchar(32) ,application varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_protogroup_application_dest_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64),application varchar(64) ,destip bigint ,dst_zone varchar(32) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_protogroup_application_dest_5min ( "5mintime" timestamp NOT NULL ,username varchar(64) ,proto_group varchar(64) ,application varchar(64) ,destip bigint ,dst_zone varchar(32)  ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_protogroup_host_application_5min ( "5mintime" timestamp NOT NULL ,username varchar(64) ,proto_group varchar(64) ,srcip bigint ,src_zone varchar(32) ,application varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_dest_application_host_5min ( "5mintime" timestamp NOT NULL ,username varchar(64) ,destip bigint ,dst_zone varchar(32) ,application varchar(64) ,srcip bigint ,src_zone varchar(32) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table protogroup_host_dest_user_5min ( "5mintime" timestamp NOT NULL ,proto_group varchar(64) ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) ,username varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_protogroup_application_user_dest_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64) ,application varchar(64) ,username varchar(64),destip bigint ,dst_zone varchar(32) ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table host_user_application_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,username varchar(64), application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_dest_application_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,destip bigint ,dst_zone varchar(32), application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_dest_user_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) ,username varchar(64),  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_dest_application_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),destip bigint ,dst_zone varchar(32) ,application varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_protogroup_application_dest_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64),application varchar(64) ,destip bigint ,dst_zone varchar(32) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_protogroup_application_dest_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,proto_group varchar(64) ,application varchar(64) ,destip bigint ,dst_zone varchar(32)  ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_protogroup_host_application_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,proto_group varchar(64) ,srcip bigint ,src_zone varchar(32) ,application varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_dest_application_host_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,destip bigint ,dst_zone varchar(32) ,application varchar(64) ,srcip bigint ,src_zone varchar(32) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table protogroup_host_dest_user_4hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64) ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) ,username varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_protogroup_application_user_dest_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64) ,application varchar(64) ,username varchar(64),destip bigint ,dst_zone varchar(32) ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table host_user_application_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,username varchar(64), application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_dest_application_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,destip bigint ,dst_zone varchar(32), application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_dest_user_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) ,username varchar(64),  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_dest_application_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),destip bigint ,dst_zone varchar(32) ,application varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_protogroup_application_dest_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64),application varchar(64) ,destip bigint ,dst_zone varchar(32) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_protogroup_application_dest_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,proto_group varchar(64) ,application varchar(64) ,destip bigint ,dst_zone varchar(32)  ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_protogroup_host_application_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,proto_group varchar(64) ,srcip bigint ,src_zone varchar(32) ,application varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_dest_application_host_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,destip bigint ,dst_zone varchar(32) ,application varchar(64) ,srcip bigint ,src_zone varchar(32) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table protogroup_host_dest_user_12hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64) ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) ,username varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_protogroup_application_user_dest_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64) ,application varchar(64) ,username varchar(64),destip bigint ,dst_zone varchar(32) ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));

Create table host_user_application_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,username varchar(64), application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_dest_application_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,destip bigint ,dst_zone varchar(32), application varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_dest_user_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) ,username varchar(64),  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_dest_application_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),destip bigint ,dst_zone varchar(32) ,application varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_protogroup_application_dest_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64),application varchar(64) ,destip bigint ,dst_zone varchar(32) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_protogroup_application_dest_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,proto_group varchar(64) ,application varchar(64) ,destip bigint ,dst_zone varchar(32)  ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_protogroup_host_application_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,proto_group varchar(64) ,srcip bigint ,src_zone varchar(32) ,application varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table user_dest_application_host_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64) ,destip bigint ,dst_zone varchar(32) ,application varchar(64) ,srcip bigint ,src_zone varchar(32) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table protogroup_host_dest_user_24hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64) ,srcip bigint ,src_zone varchar(32) ,destip bigint ,dst_zone varchar(32) ,username varchar(64) ,  hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));
Create table host_protogroup_application_user_dest_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32) ,proto_group varchar(64) ,application varchar(64) ,username varchar(64),destip bigint ,dst_zone varchar(32) ,hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64));








DROP TABLE IF EXISTS top_denied_hosts_5min cascade ;
DROP TABLE IF EXISTS top_denied_destinations_5min cascade ;
DROP TABLE IF EXISTS top_denied_users_5min cascade ;
DROP TABLE IF EXISTS top_denied_users_protogroup_5min cascade ;
DROP TABLE IF EXISTS top_denied_trafficapplication_5min cascade ;
DROP TABLE IF EXISTS hosts_dest_application_user_5min cascade ;

DROP TABLE IF EXISTS top_denied_hosts_4hr cascade ;
DROP TABLE IF EXISTS top_denied_destinations_4hr cascade ;
DROP TABLE IF EXISTS top_denied_users_4hr cascade ;
DROP TABLE IF EXISTS top_denied_users_protogroup_4hr cascade ;
DROP TABLE IF EXISTS top_denied_trafficapplication_4hr cascade ;
DROP TABLE IF EXISTS hosts_dest_application_user_4hr cascade ;

DROP TABLE IF EXISTS top_denied_hosts_12hr cascade ;
DROP TABLE IF EXISTS top_denied_destinations_12hr cascade ;
DROP TABLE IF EXISTS top_denied_users_12hr cascade ;
DROP TABLE IF EXISTS top_denied_users_protogroup_12hr cascade ;
DROP TABLE IF EXISTS top_denied_trafficapplication_12hr cascade ;
DROP TABLE IF EXISTS hosts_dest_application_user_12hr cascade ;

DROP TABLE IF EXISTS top_denied_hosts_24hr cascade ;
DROP TABLE IF EXISTS top_denied_destinations_24hr cascade ;
DROP TABLE IF EXISTS top_denied_users_24hr cascade ;
DROP TABLE IF EXISTS top_denied_users_protogroup_24hr cascade ;
DROP TABLE IF EXISTS top_denied_trafficapplication_24hr cascade ;
DROP TABLE IF EXISTS hosts_dest_application_user_24hr cascade ;




-- new table

-- 5min

DROP TABLE IF EXISTS blocked_dest_5min cascade;
DROP TABLE IF EXISTS blocked_host_5min cascade;
DROP TABLE IF EXISTS blocked_protogroup_5min cascade;
DROP TABLE IF EXISTS blocked_user_5min cascade;

DROP TABLE IF EXISTS blocked_app_protogroup_5min cascade;
DROP TABLE IF EXISTS blocked_dest_host_5min cascade;
DROP TABLE IF EXISTS blocked_dest_protogroup_5min cascade;
DROP TABLE IF EXISTS blocked_dest_user_5min cascade;
DROP TABLE IF EXISTS blocked_host_protogroup_5min cascade;
DROP TABLE IF EXISTS blocked_host_user_5min cascade;
DROP TABLE IF EXISTS blocked_protogroup_user_5min cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_5min cascade;
DROP TABLE IF EXISTS blocked_app_dest_protogroup_5min cascade;
DROP TABLE IF EXISTS blocked_app_dest_user_5min cascade;
DROP TABLE IF EXISTS blocked_app_host_protogroup_5min cascade;
DROP TABLE IF EXISTS blocked_app_host_user_5min cascade;
DROP TABLE IF EXISTS blocked_app_protogroup_user_5min cascade;
DROP TABLE IF EXISTS blocked_dest_host_protogroup_5min cascade;
DROP TABLE IF EXISTS blocked_dest_host_user_5min cascade;
DROP TABLE IF EXISTS blocked_dest_protogroup_user_5min cascade;
DROP TABLE IF EXISTS blocked_host_protogroup_user_5min cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_protogroup_5min cascade;
DROP TABLE IF EXISTS blocked_app_dest_host_user_5min cascade;
DROP TABLE IF EXISTS blocked_app_dest_protogroup_user_5min cascade;
DROP TABLE IF EXISTS blocked_app_host_protogroup_user_5min cascade;
DROP TABLE IF EXISTS blocked_dest_host_protogroup_user_5min cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_protogroup_user_5min cascade;



-- 4hr 

DROP TABLE IF EXISTS blocked_dest_4hr cascade;
DROP TABLE IF EXISTS blocked_host_4hr cascade;
DROP TABLE IF EXISTS blocked_protogroup_4hr cascade;
DROP TABLE IF EXISTS blocked_user_4hr cascade;

DROP TABLE IF EXISTS blocked_app_protogroup_4hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_4hr cascade;
DROP TABLE IF EXISTS blocked_dest_protogroup_4hr cascade;
DROP TABLE IF EXISTS blocked_dest_user_4hr cascade;
DROP TABLE IF EXISTS blocked_host_protogroup_4hr cascade;
DROP TABLE IF EXISTS blocked_host_user_4hr cascade;
DROP TABLE IF EXISTS blocked_protogroup_user_4hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_4hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_protogroup_4hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_user_4hr cascade;
DROP TABLE IF EXISTS blocked_app_host_protogroup_4hr cascade;
DROP TABLE IF EXISTS blocked_app_host_user_4hr cascade;
DROP TABLE IF EXISTS blocked_app_protogroup_user_4hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_protogroup_4hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_user_4hr cascade;
DROP TABLE IF EXISTS blocked_dest_protogroup_user_4hr cascade;
DROP TABLE IF EXISTS blocked_host_protogroup_user_4hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_protogroup_4hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_host_user_4hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_protogroup_user_4hr cascade;
DROP TABLE IF EXISTS blocked_app_host_protogroup_user_4hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_protogroup_user_4hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_protogroup_user_4hr cascade;




-- 12 hr

DROP TABLE IF EXISTS blocked_dest_12hr cascade;
DROP TABLE IF EXISTS blocked_host_12hr cascade;
DROP TABLE IF EXISTS blocked_protogroup_12hr cascade;
DROP TABLE IF EXISTS blocked_user_12hr cascade;

DROP TABLE IF EXISTS blocked_app_protogroup_12hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_12hr cascade;
DROP TABLE IF EXISTS blocked_dest_protogroup_12hr cascade;
DROP TABLE IF EXISTS blocked_dest_user_12hr cascade;
DROP TABLE IF EXISTS blocked_host_protogroup_12hr cascade;
DROP TABLE IF EXISTS blocked_host_user_12hr cascade;
DROP TABLE IF EXISTS blocked_protogroup_user_12hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_12hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_protogroup_12hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_user_12hr cascade;
DROP TABLE IF EXISTS blocked_app_host_protogroup_12hr cascade;
DROP TABLE IF EXISTS blocked_app_host_user_12hr cascade;
DROP TABLE IF EXISTS blocked_app_protogroup_user_12hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_protogroup_12hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_user_12hr cascade;
DROP TABLE IF EXISTS blocked_dest_protogroup_user_12hr cascade;
DROP TABLE IF EXISTS blocked_host_protogroup_user_12hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_protogroup_12hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_host_user_12hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_protogroup_user_12hr cascade;
DROP TABLE IF EXISTS blocked_app_host_protogroup_user_12hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_protogroup_user_12hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_protogroup_user_12hr cascade;




-- 24hr


DROP TABLE IF EXISTS blocked_dest_24hr cascade;
DROP TABLE IF EXISTS blocked_host_24hr cascade;
DROP TABLE IF EXISTS blocked_protogroup_24hr cascade;
DROP TABLE IF EXISTS blocked_user_24hr cascade;

DROP TABLE IF EXISTS blocked_app_protogroup_24hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_24hr cascade;
DROP TABLE IF EXISTS blocked_dest_protogroup_24hr cascade;
DROP TABLE IF EXISTS blocked_dest_user_24hr cascade;
DROP TABLE IF EXISTS blocked_host_protogroup_24hr cascade;
DROP TABLE IF EXISTS blocked_host_user_24hr cascade;
DROP TABLE IF EXISTS blocked_protogroup_user_24hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_24hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_protogroup_24hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_user_24hr cascade;
DROP TABLE IF EXISTS blocked_app_host_protogroup_24hr cascade;
DROP TABLE IF EXISTS blocked_app_host_user_24hr cascade;
DROP TABLE IF EXISTS blocked_app_protogroup_user_24hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_protogroup_24hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_user_24hr cascade;
DROP TABLE IF EXISTS blocked_dest_protogroup_user_24hr cascade;
DROP TABLE IF EXISTS blocked_host_protogroup_user_24hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_protogroup_24hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_host_user_24hr cascade;
DROP TABLE IF EXISTS blocked_app_dest_protogroup_user_24hr cascade;
DROP TABLE IF EXISTS blocked_app_host_protogroup_user_24hr cascade;
DROP TABLE IF EXISTS blocked_dest_host_protogroup_user_24hr cascade;

DROP TABLE IF EXISTS blocked_app_dest_host_protogroup_user_24hr cascade;




-- ==============================================================
-- Denied Traffic Reports Group
-- ==============================================================


Create table blocked_dest_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_5min ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_protogroup_5min ( "5mintime" timestamp NOT NULL ,proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_user_5min ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_protogroup_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_protogroup_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_user_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_protogroup_5min ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_user_5min ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_protogroup_user_5min ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_protogroup_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_protogroup_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_protogroup_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_protogroup_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_user_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_protogroup_user_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_protogroup_user_5min ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_protogroup_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_host_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_protogroup_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_protogroup_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_protogroup_user_5min ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_protogroup_user_5min ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));




-- ==============================================================
--	4hr table
-- ==============================================================


-- ==============================================================
-- Denied Traffic Reports Group
-- ==============================================================


Create table blocked_dest_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_protogroup_4hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_user_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_protogroup_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_protogroup_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_user_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_protogroup_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_user_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_protogroup_user_4hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_protogroup_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_protogroup_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_protogroup_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_protogroup_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_user_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_protogroup_user_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_protogroup_user_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_protogroup_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_host_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_protogroup_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_protogroup_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_protogroup_user_4hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_protogroup_user_4hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));






-- ========================================================
--	12hr table
-- ========================================================


-- ==============================================================
-- Denied Traffic Reports Group
-- ==============================================================



Create table blocked_dest_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_protogroup_12hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_user_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_protogroup_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_protogroup_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_user_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_protogroup_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_user_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_protogroup_user_12hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_protogroup_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_protogroup_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_protogroup_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_protogroup_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_user_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_protogroup_user_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_protogroup_user_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_protogroup_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_host_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_protogroup_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_protogroup_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_protogroup_user_12hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_protogroup_user_12hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));






-- =============================================================
--      24hr table
-- =============================================================


-- ==============================================================
-- Denied Traffic Reports Group
-- ==============================================================

Create table blocked_dest_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_protogroup_24hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_user_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_protogroup_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_protogroup_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_user_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_protogroup_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_user_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_protogroup_user_24hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_protogroup_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_protogroup_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_protogroup_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_protogroup_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_user_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_protogroup_user_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_host_protogroup_user_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_protogroup_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_host_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_dest_protogroup_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_app_host_protogroup_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));
Create table blocked_dest_host_protogroup_user_24hr ( "5mintime" timestamp NOT NULL ,destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));

Create table blocked_app_dest_host_protogroup_user_24hr ( "5mintime" timestamp NOT NULL ,application varchar(64),destip bigint, dst_zone varchar(32),srcip bigint, src_zone varchar(32),proto_group varchar(64),username varchar(64), hits bigint DEFAULT 1, appid varchar(64));



DROP TABLE IF EXISTS tbl_device_event_4hr cascade;
Create table tbl_device_event_4hr ("5mintime" timestamp NOT NULL ,proc_name varchar(50),appid varchar(64), events int) ;




-- ==================
-- Update for firewallid int to varchar.
-- ==================


drop table if exists tmp_firewall_blocked_traffic;
CREATE TABLE tmp_firewall_blocked_traffic
(
  srcip bigint,
  destip bigint,
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  proto_group character varying(64) DEFAULT 'UNKNOWN'::character varying,
  application character varying(64),
  hits bigint DEFAULT 1,
  appid character varying(32),
  src_zone varchar(32),
  dst_zone varchar(32),
  ruleid varchar(64),
  log_component smallint,
  "action" smallint
);


drop table if exists tmp_firewall_traffic;
CREATE TABLE tmp_firewall_traffic
(
  ruleid varchar(64),
  "action" smallint,  
  srcip bigint,
  destip bigint,
  username character varying(64) DEFAULT 'UNKNOWN'::character varying,
  proto_group character varying(64) DEFAULT 'UNKNOWN'::character varying,
  application character varying(64),
  upload bigint,
  download bigint,
  hits bigint DEFAULT 1,
  appid character varying(32),
  log_component smallint,
  dst_port integer,
  applicationid integer,
  src_zone varchar(32),
  dst_zone varchar(32)
);

drop table if exists temp_firewall;
create table temp_firewall (like tmp_firewall_traffic) ;






DROP TABLE IF EXISTS top_rules_5min cascade ;
DROP TABLE IF EXISTS srcip_ruleid_5min cascade ;
DROP TABLE IF EXISTS user_ruleid_5min cascade ;
DROP TABLE IF EXISTS protogroup_rules_5min cascade ;
DROP TABLE IF EXISTS hosts_protogroup_rules_5min cascade ;
DROP TABLE IF EXISTS users_protogroup_rules_5min cascade ;
DROP TABLE IF EXISTS rules_detail_5min cascade ;
DROP TABLE IF EXISTS protogroup_application_ruleid_5min cascade ;
DROP TABLE IF EXISTS application_rules_5min cascade ;
DROP TABLE IF EXISTS top_acceptrules_5min cascade ;
DROP TABLE IF EXISTS top_denyrules_5min cascade ;
DROP TABLE IF EXISTS top_acceptrules_protogroup_5min cascade ;
DROP TABLE IF EXISTS top_denyrules_protogroup_5min cascade ;
DROP TABLE IF EXISTS top_acceptrules_host_5min cascade ;
DROP TABLE IF EXISTS top_denyrules_host_5min cascade ;
DROP TABLE IF EXISTS top_acceptrules_dest_5min cascade ;
DROP TABLE IF EXISTS top_denyrules_dest_5min cascade ;
DROP TABLE IF EXISTS accept_rules_host_application_dest_user_5min cascade ;
DROP TABLE IF EXISTS deny_rules_host_application_dest_user_5min cascade ;
DROP TABLE IF EXISTS accept_rules_host_app_protog_dest_user_5min cascade ;
DROP TABLE IF EXISTS deny_rules_host_app_protogroup_dest_user_5min cascade ;

DROP TABLE IF EXISTS top_rules_4hr cascade ;
DROP TABLE IF EXISTS srcip_ruleid_4hr cascade ;
DROP TABLE IF EXISTS user_ruleid_4hr cascade ;
DROP TABLE IF EXISTS protogroup_rules_4hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_rules_4hr cascade ;
DROP TABLE IF EXISTS users_protogroup_rules_4hr cascade ;
DROP TABLE IF EXISTS rules_detail_4hr cascade ;
DROP TABLE IF EXISTS protogroup_application_ruleid_4hr cascade ;
DROP TABLE IF EXISTS application_rules_4hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_4hr cascade ;
DROP TABLE IF EXISTS top_denyrules_4hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_protogroup_4hr cascade ;
DROP TABLE IF EXISTS top_denyrules_protogroup_4hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_host_4hr cascade ;
DROP TABLE IF EXISTS top_denyrules_host_4hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_dest_4hr cascade ;
DROP TABLE IF EXISTS top_denyrules_dest_4hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_application_dest_user_4hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_application_dest_user_4hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_app_protog_dest_user_4hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_app_protogroup_dest_user_4hr cascade ;

DROP TABLE IF EXISTS top_rules_12hr cascade ;
DROP TABLE IF EXISTS srcip_ruleid_12hr cascade ;
DROP TABLE IF EXISTS user_ruleid_12hr cascade ;
DROP TABLE IF EXISTS protogroup_rules_12hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_rules_12hr cascade ;
DROP TABLE IF EXISTS users_protogroup_rules_12hr cascade ;
DROP TABLE IF EXISTS rules_detail_12hr cascade ;
DROP TABLE IF EXISTS protogroup_application_ruleid_12hr cascade ;
DROP TABLE IF EXISTS application_rules_12hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_12hr cascade ;
DROP TABLE IF EXISTS top_denyrules_12hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_protogroup_12hr cascade ;
DROP TABLE IF EXISTS top_denyrules_protogroup_12hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_host_12hr cascade ;
DROP TABLE IF EXISTS top_denyrules_host_12hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_dest_12hr cascade ;
DROP TABLE IF EXISTS top_denyrules_dest_12hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_application_dest_user_12hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_application_dest_user_12hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_app_protog_dest_user_12hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_app_protogroup_dest_user_12hr cascade ;

DROP TABLE IF EXISTS top_rules_24hr cascade ;
DROP TABLE IF EXISTS srcip_ruleid_24hr cascade ;
DROP TABLE IF EXISTS user_ruleid_24hr cascade ;
DROP TABLE IF EXISTS protogroup_rules_24hr cascade ;
DROP TABLE IF EXISTS hosts_protogroup_rules_24hr cascade ;
DROP TABLE IF EXISTS users_protogroup_rules_24hr cascade ;
DROP TABLE IF EXISTS rules_detail_24hr cascade ;
DROP TABLE IF EXISTS protogroup_application_ruleid_24hr cascade ;
DROP TABLE IF EXISTS application_rules_24hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_24hr cascade ;
DROP TABLE IF EXISTS top_denyrules_24hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_protogroup_24hr cascade ;
DROP TABLE IF EXISTS top_denyrules_protogroup_24hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_host_24hr cascade ;
DROP TABLE IF EXISTS top_denyrules_host_24hr cascade ;
DROP TABLE IF EXISTS top_acceptrules_dest_24hr cascade ;
DROP TABLE IF EXISTS top_denyrules_dest_24hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_application_dest_user_24hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_application_dest_user_24hr cascade ;
DROP TABLE IF EXISTS accept_rules_host_app_protog_dest_user_24hr cascade ;
DROP TABLE IF EXISTS deny_rules_host_app_protogroup_dest_user_24hr cascade ;

Create table top_rules_5min ( "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1, total bigint ,appid varchar(64));
Create table srcip_ruleid_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table user_ruleid_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table protogroup_rules_5min ( "5mintime" timestamp NOT NULL , proto_group varchar(64),ruleid varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table hosts_protogroup_rules_5min ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table users_protogroup_rules_5min ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table rules_detail_5min ( "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32)  ,username varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) ,action int, hits bigint  default 1,appid varchar(64) ) ;
Create table protogroup_application_ruleid_5min ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table  application_rules_5min (  "5mintime" timestamp NOT NULL ,application varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table top_acceptrules_5min  (  "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_protogroup_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_protogroup_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_host_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_host_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_dest_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_dest_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table accept_rules_host_application_dest_user_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table deny_rules_host_application_dest_user_5min (  "5mintime" timestamp NOT NULL , ruleid varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table accept_rules_host_app_protog_dest_user_5min (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table deny_rules_host_app_protogroup_dest_user_5min (  "5mintime" timestamp NOT NULL , ruleid varchar(64),proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;


Create table top_rules_4hr ( "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1, total bigint ,appid varchar(64));
Create table srcip_ruleid_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table user_ruleid_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table protogroup_rules_4hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),ruleid varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table hosts_protogroup_rules_4hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table users_protogroup_rules_4hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table rules_detail_4hr ( "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32)  ,username varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) ,action int, hits bigint  default 1,appid varchar(64) ) ;
Create table protogroup_application_ruleid_4hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table  application_rules_4hr (  "5mintime" timestamp NOT NULL ,application varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table top_acceptrules_4hr  (  "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_protogroup_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_protogroup_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_host_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_host_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_dest_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_dest_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table accept_rules_host_application_dest_user_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table deny_rules_host_application_dest_user_4hr (  "5mintime" timestamp NOT NULL , ruleid varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table accept_rules_host_app_protog_dest_user_4hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table deny_rules_host_app_protogroup_dest_user_4hr (  "5mintime" timestamp NOT NULL , ruleid varchar(64),proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;


Create table top_rules_12hr ( "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1, total bigint ,appid varchar(64));
Create table srcip_ruleid_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table user_ruleid_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table protogroup_rules_12hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),ruleid varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table hosts_protogroup_rules_12hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table users_protogroup_rules_12hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table rules_detail_12hr ( "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32)  ,username varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) ,action int, hits bigint  default 1,appid varchar(64) ) ;
Create table protogroup_application_ruleid_12hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table  application_rules_12hr (  "5mintime" timestamp NOT NULL ,application varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table top_acceptrules_12hr  (  "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_protogroup_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_protogroup_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_host_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_host_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_dest_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_dest_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table accept_rules_host_application_dest_user_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table deny_rules_host_application_dest_user_12hr (  "5mintime" timestamp NOT NULL , ruleid varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table accept_rules_host_app_protog_dest_user_12hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table deny_rules_host_app_protogroup_dest_user_12hr (  "5mintime" timestamp NOT NULL , ruleid varchar(64),proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;


Create table top_rules_24hr ( "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1, total bigint ,appid varchar(64));
Create table srcip_ruleid_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table user_ruleid_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table protogroup_rules_24hr ( "5mintime" timestamp NOT NULL , proto_group varchar(64),ruleid varchar(64),hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table hosts_protogroup_rules_24hr ( "5mintime" timestamp NOT NULL ,srcip bigint ,src_zone varchar(32)  ,proto_group varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table users_protogroup_rules_24hr ( "5mintime" timestamp NOT NULL ,username varchar(64),proto_group varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table rules_detail_24hr ( "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32)  ,username varchar(64),application varchar(64),destip bigint ,dst_zone varchar(32) ,action int, hits bigint  default 1,appid varchar(64) ) ;
Create table protogroup_application_ruleid_24hr ( "5mintime" timestamp NOT NULL ,proto_group varchar(64),application varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table  application_rules_24hr (  "5mintime" timestamp NOT NULL ,application varchar(64),ruleid varchar(64), hits bigint  default 1, sent bigint , received bigint , total bigint ,appid varchar(64) ) ;
Create table top_acceptrules_24hr  (  "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_protogroup_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_protogroup_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_host_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_host_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_acceptrules_dest_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table top_denyrules_dest_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),destip bigint ,dst_zone varchar(32) , hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table accept_rules_host_application_dest_user_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table deny_rules_host_application_dest_user_24hr (  "5mintime" timestamp NOT NULL , ruleid varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table accept_rules_host_app_protog_dest_user_24hr (  "5mintime" timestamp NOT NULL ,ruleid varchar(64),proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;
Create table deny_rules_host_app_protogroup_dest_user_24hr (  "5mintime" timestamp NOT NULL , ruleid varchar(64),proto_group varchar(64),srcip bigint ,src_zone varchar(32) ,application varchar(64),destip bigint ,dst_zone varchar(32) ,username varchar(64), hits bigint  default 1,bytes bigint ,appid varchar(64) ) ;

