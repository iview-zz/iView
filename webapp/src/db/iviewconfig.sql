
-- ========================================================
--	Database - iViewdb
--	Version - 0.0.0.1 Beta
-- ========================================================

DROP DATABASE IF EXISTS iviewdb ;
CREATE DATABASE iviewdb WITH TEMPLATE = template0 ENCODING = 'WIN1252';


ALTER DATABASE iviewdb OWNER TO postgres;

\connect iviewdb

CREATE PROCEDURAL LANGUAGE plpgsql;

ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

DROP TABLE IF EXISTS tbl_next_summarization;
CREATE TABLE tbl_next_summarization (
  table_name varchar(64) NOT NULL,
  next_time timestamp NOT NULL 
);

INSERT INTO tbl_next_summarization (table_name,next_time) VALUES  
('WebUsage4hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 4) THEN date_trunc('day',current_timestamp) + INTERVAL '0 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 8) THEN date_trunc('day',current_timestamp) + INTERVAL '4 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN date_trunc('day',current_timestamp) + INTERVAL '8 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 16) THEN date_trunc('day',current_timestamp) + INTERVAL '12 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 20) THEN date_trunc('day',current_timestamp) + INTERVAL '16 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '20 hour' END),  
('WebUsage12hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN  date_trunc('day',current_timestamp) + INTERVAL '0 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '12 hour' END ), 
('WebUsage24hr',date_trunc('day',current_timestamp) ), 
('FirewallTraffic4hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 4) THEN date_trunc('day',current_timestamp) + INTERVAL '0 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 8) THEN date_trunc('day',current_timestamp) + INTERVAL '4 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN date_trunc('day',current_timestamp) + INTERVAL '8 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 16) THEN date_trunc('day',current_timestamp) + INTERVAL '12 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 20) THEN date_trunc('day',current_timestamp) + INTERVAL '16 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '20 hour' END), 
('FirewallTraffic12hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN  date_trunc('day',current_timestamp) + INTERVAL '0 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '12 hour' END ), 
('FirewallTraffic24hr',date_trunc('day',current_timestamp) ), 
('MailNSpam4hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 4) THEN date_trunc('day',current_timestamp) + INTERVAL '0 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 8) THEN date_trunc('day',current_timestamp) + INTERVAL '4 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN date_trunc('day',current_timestamp) + INTERVAL '8 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 16) THEN date_trunc('day',current_timestamp) + INTERVAL '12 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 20) THEN date_trunc('day',current_timestamp) + INTERVAL '16 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '20 hour' END), 
('MailNSpam12hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN  date_trunc('day',current_timestamp) + INTERVAL '0 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '12 hour' END ), 
('MailNSpam24hr',date_trunc('day',current_timestamp) ), 
('DeniedWeb4hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 4) THEN date_trunc('day',current_timestamp) + INTERVAL '0 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 8) THEN date_trunc('day',current_timestamp) + INTERVAL '4 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN date_trunc('day',current_timestamp) + INTERVAL '8 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 16) THEN date_trunc('day',current_timestamp) + INTERVAL '12 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 20) THEN date_trunc('day',current_timestamp) + INTERVAL '16 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '20 hour' END), 
('DeniedWeb12hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN  date_trunc('day',current_timestamp) + INTERVAL '0 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '12 hour' END ), 
('DeniedWeb24hr',date_trunc('day',current_timestamp) ), 
('IDPAlert4hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 4) THEN date_trunc('day',current_timestamp) + INTERVAL '0 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 8) THEN date_trunc('day',current_timestamp) + INTERVAL '4 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN date_trunc('day',current_timestamp) + INTERVAL '8 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 16) THEN date_trunc('day',current_timestamp) + INTERVAL '12 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 20) THEN date_trunc('day',current_timestamp) + INTERVAL '16 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '20 hour' END), 
('IDPAlert12hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN  date_trunc('day',current_timestamp) + INTERVAL '0 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '12 hour' END ), 
('IDPAlert24hr',date_trunc('day',current_timestamp) ), 
('CleanFTP4hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 4) THEN date_trunc('day',current_timestamp) + INTERVAL '0 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 8) THEN date_trunc('day',current_timestamp) + INTERVAL '4 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN date_trunc('day',current_timestamp) + INTERVAL '8 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 16) THEN date_trunc('day',current_timestamp) + INTERVAL '12 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 20) THEN date_trunc('day',current_timestamp) + INTERVAL '16 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '20 hour' END), 
('CleanFTP12hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN  date_trunc('day',current_timestamp) + INTERVAL '0 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '12 hour' END ), 
('CleanFTP24hr',date_trunc('day',current_timestamp) ), 
('VirusData4hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 4) THEN date_trunc('day',current_timestamp) + INTERVAL '0 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 8) THEN date_trunc('day',current_timestamp) + INTERVAL '4 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN date_trunc('day',current_timestamp) + INTERVAL '8 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 16) THEN date_trunc('day',current_timestamp) + INTERVAL '12 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 20) THEN date_trunc('day',current_timestamp) + INTERVAL '16 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '20 hour' END), 
('VirusData12hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN  date_trunc('day',current_timestamp) + INTERVAL '0 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '12 hour' END ), 
('VirusData24hr',date_trunc('day',current_timestamp) ) , 
('FirewallBlockedTraffic4hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 4) THEN date_trunc('day',current_timestamp) + INTERVAL '0 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 8) THEN date_trunc('day',current_timestamp) + INTERVAL '4 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN date_trunc('day',current_timestamp) + INTERVAL '8 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 16) THEN date_trunc('day',current_timestamp) + INTERVAL '12 hour'  WHEN (EXTRACT(HOUR FROM current_timestamp) < 20) THEN date_trunc('day',current_timestamp) + INTERVAL '16 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '20 hour' END), 
('FirewallBlockedTraffic12hr',CASE WHEN (EXTRACT(HOUR FROM current_timestamp) < 12) THEN  date_trunc('day',current_timestamp) + INTERVAL '0 hour' ELSE  date_trunc('day',current_timestamp) + INTERVAL  '12 hour' END ), 
('FirewallBlockedTraffic24hr',date_trunc('day',current_timestamp) );


DROP TABLE IF EXISTS tbl_proc_log;
Create table tbl_proc_log (proc_name varchar(50),total_records int, start_time timestamp NOT NULL ,merge_time timestamp NOT NULL, end_time timestamp NOT NULL) ;

DROP TABLE IF EXISTS tblalertstatus;
CREATE TABLE tblalertstatus
(
  alertstatusid serial NOT NULL,
  alertdatetime timestamp without time zone,
  message text,
  criteriaid integer,
  CONSTRAINT tblalertstatus_pkey PRIMARY KEY (alertstatusid)
);


DROP TABLE IF EXISTS tblfilelist;
CREATE TABLE tblfilelist
(
  fileid serial NOT NULL,
  filename character(255) DEFAULT NULL::bpchar,
  filecreationtimestamp character(255) DEFAULT NULL::bpchar,
  fileeventtimestamp character(255) DEFAULT NULL::bpchar,
  filesize bigint,
  isloaded integer,
  lastaccesstimestamp character(255) DEFAULT NULL::bpchar,
  appid character varying(64) DEFAULT NULL::character varying,
  CONSTRAINT tblfilelist_pkey PRIMARY KEY (fileid)
);

create index  tblfilelist_idx ON tblfilelist(fileeventtimestamp);

DROP TABLE if exists tblapplication;
CREATE TABLE tblapplication (
    appid serial primary key,
    appname text,
    equalcheck character(1) DEFAULT NULL::bpchar,
    roleid integer
);


COPY tblapplication (appid, appname, equalcheck, roleid) FROM stdin;
1	manageuser.jsp	N	2
2	newuser.jsp	N	3
3	addapplicationname.jsp	N	2
4	addprotocolgroup.jsp	N	2
5	addprotocolidentifier.jsp	N	2
6	protocolgroup.jsp	N	2
7	managedevice.jsp	N	1
8	editdevice.jsp	N	1
9	iviewconfig.jsp	N	2
10	configdatabase.jsp	N	2
11	managedevicegroup.jsp	N	2
12	newdevicegroup.jsp	N	2
\.


ALTER SEQUENCE tblapplication_appid_seq RESTART 100; 

ALTER TABLE ONLY tblapplication
    ADD CONSTRAINT tblapplication_pkey PRIMARY KEY (appid);




DROP TABLE IF EXISTS tblappparameter;
CREATE TABLE tblappparameter (
    appparamid serial NOT NULL,
    appparamname character varying(50) DEFAULT NULL::character varying,
    value character varying(50) DEFAULT NULL::character varying,
    appid integer
);

COPY tblappparameter (appparamid, appparamname, value, appid) FROM stdin;
1	test	test	1
\.

ALTER SEQUENCE tblappparameter_appparamid_seq RESTART 2; 

ALTER TABLE ONLY tblappparameter
    ADD CONSTRAINT tblappparameter_pkey PRIMARY KEY (appparamid);



DROP TABLE IF EXISTS tblappresolver;
CREATE TABLE tblappresolver (
    port integer,
    protocol integer,
    applicationname character varying(50) DEFAULT NULL::character varying
);

COPY tblappresolver (port, protocol, applicationname) FROM stdin;
80	6	HTTP
25	6	SMTP
110	6	POP
\.



DROP TABLE IF EXISTS tbldatalink;
CREATE TABLE tbldatalink (
    datalinkid integer DEFAULT 0 NOT NULL,
    url text,
    openinsamewindow smallint,
    rswparameter character varying(255) DEFAULT NULL::character varying,
    requestparameter character varying(255) DEFAULT NULL::character varying
);

COPY tbldatalink (datalinkid, url, openinsamewindow, rswparameter, requestparameter) FROM stdin;
5	/webpages/reportgroup.jsp?reportgroupid=7	1	srcip	deviceid
8	/webpages/reportgroup.jsp?reportgroupid=10	1	ruleid	deviceid
100001	/webpages/reportgroup.jsp?reportgroupid=100001	1	srcip	deviceid
100002	/webpages/reportgroup.jsp?reportgroupid=100002	1	srcip	deviceid
103000	/webpages/reportgroup.jsp?reportgroupid=103000	1	proto_group	srcip,deviceid
104000	/webpages/reportgroup.jsp?reportgroupid=104000	1	application	proto_group,srcip,deviceid
104100	/webpages/reportgroup.jsp?reportgroupid=104100	1	destip	proto_group,srcip,deviceid
104200	/webpages/reportgroup.jsp?reportgroupid=104200	1	username	proto_group,srcip,deviceid
105000	/webpages/reportgroup.jsp?reportgroupid=105000	1	application	username,proto_group,srcip,deviceid
131000	/webpages/reportgroup.jsp?reportgroupid=131000	1	destip	proto_group,srcip,deviceid
141000	/webpages/reportgroup.jsp?reportgroupid=141000	1	application	destip,proto_group,srcip,deviceid
141100	/webpages/reportgroup.jsp?reportgroupid=142000	1	username	destip,proto_group,srcip,deviceid
132000	/webpages/reportgroup.jsp?reportgroupid=132000	1	username	srcip,deviceid
142000	/webpages/reportgroup.jsp?reportgroupid=142000	1	application	username,srcip,deviceid
142100	/webpages/reportgroup.jsp?reportgroupid=142100	1	destip	username,srcip,deviceid
134000	/webpages/reportgroup.jsp?reportgroupid=134000	1	proto_group	srcip,deviceid
144000	/webpages/reportgroup.jsp?reportgroupid=144000	1	application	proto_group,srcip,deviceid
144100	/webpages/reportgroup.jsp?reportgroupid=144100	1	destip	proto_group,srcip,deviceid
144200	/webpages/reportgroup.jsp?reportgroupid=144200	1	username	proto_group,srcip,deviceid
154000	/webpages/reportgroup.jsp?reportgroupid=154000	1	application	username,proto_group,srcip,deviceid
135000	/webpages/reportgroup.jsp?reportgroupid=135000	1	proto_group	srcip,deviceid
145000	/webpages/reportgroup.jsp?reportgroupid=145000	1	application	proto_group,srcip,deviceid
145100	/webpages/reportgroup.jsp?reportgroupid=145100	1	destip	proto_group,srcip,deviceid
145200	/webpages/reportgroup.jsp?reportgroupid=145200	1	username	proto_group,srcip,deviceid
155000	/webpages/reportgroup.jsp?reportgroupid=155000	1	application	username,proto_group,srcip,deviceid
136000	/webpages/reportgroup.jsp?reportgroupid=136000	1	destip	proto_group,srcip,deviceid
146000	/webpages/reportgroup.jsp?reportgroupid=146000	1	application	destip,proto_group,srcip,deviceid
146100	/webpages/reportgroup.jsp?reportgroupid=146000	1	username	destip,proto_group,srcip,deviceid
137000	/webpages/reportgroup.jsp?reportgroupid=137000	1	destip	proto_group,srcip,deviceid
147000	/webpages/reportgroup.jsp?reportgroupid=147000	1	application	destip,proto_group,srcip,deviceid
147100	/webpages/reportgroup.jsp?reportgroupid=147000	1	username	destip,proto_group,srcip,deviceid
138000	/webpages/reportgroup.jsp?reportgroupid=138000	1	username	srcip,deviceid
148000	/webpages/reportgroup.jsp?reportgroupid=148000	1	application	username,srcip,deviceid
148100	/webpages/reportgroup.jsp?reportgroupid=148100	1	destip	username,srcip,deviceid
139000	/webpages/reportgroup.jsp?reportgroupid=139000	1	username	srcip,deviceid
149000	/webpages/reportgroup.jsp?reportgroupid=149000	1	application	username,srcip,deviceid
149100	/webpages/reportgroup.jsp?reportgroupid=149100	1	destip	username,srcip,deviceid
1420000	/webpages/reportgroup.jsp?reportgroupid=1420000	1	username	deviceid
1430000	/webpages/reportgroup.jsp?reportgroupid=1430000	1	proto_group	username,deviceid
1440000	/webpages/reportgroup.jsp?reportgroupid=1440000	1	application	proto_group,username,deviceid
1440100	/webpages/reportgroup.jsp?reportgroupid=1440100	1	destip	proto_group,username,deviceid
1440200	/webpages/reportgroup.jsp?reportgroupid=1440200	1	srcip	proto_group,username,deviceid
1450000	/webpages/reportgroup.jsp?reportgroupid=1450000	1	application	srcip,proto_group,username,deviceid
1431000	/webpages/reportgroup.jsp?reportgroupid=1431000	1	destip	username,deviceid
1441000	/webpages/reportgroup.jsp?reportgroupid=1441000	1	application	destip,username,deviceid
1441100	/webpages/reportgroup.jsp?reportgroupid=1441100	1	srcip	destip,username,deviceid
1432000	/webpages/reportgroup.jsp?reportgroupid=1432000	1	srcip	username,deviceid
1442000	/webpages/reportgroup.jsp?reportgroupid=1442000	1	application	srcip,username,deviceid
1442100	/webpages/reportgroup.jsp?reportgroupid=1442100	1	destip	srcip,username,deviceid
1434000	/webpages/reportgroup.jsp?reportgroupid=1434000	1	proto_group	username,deviceid
1444000	/webpages/reportgroup.jsp?reportgroupid=1444000	1	application	proto_group,username,deviceid
1444100	/webpages/reportgroup.jsp?reportgroupid=1444100	1	destip	proto_group,username,deviceid
1444200	/webpages/reportgroup.jsp?reportgroupid=1444200	1	srcip	proto_group,username,deviceid
1454000	/webpages/reportgroup.jsp?reportgroupid=1454000	1	application	srcip,proto_group,username,deviceid
1435000	/webpages/reportgroup.jsp?reportgroupid=1435000	1	proto_group	username,deviceid
1445000	/webpages/reportgroup.jsp?reportgroupid=1445000	1	application	proto_group,username,deviceid
1445100	/webpages/reportgroup.jsp?reportgroupid=1445100	1	destip	proto_group,username,deviceid
1445200	/webpages/reportgroup.jsp?reportgroupid=1445200	1	srcip	proto_group,username,deviceid
1455000	/webpages/reportgroup.jsp?reportgroupid=1455000	1	application	srcip,proto_group,username,deviceid
1436000	/webpages/reportgroup.jsp?reportgroupid=1436000	1	destip	username,deviceid
1446000	/webpages/reportgroup.jsp?reportgroupid=1446000	1	application	destip,username,deviceid
1446100	/webpages/reportgroup.jsp?reportgroupid=1446100	1	srcip	destip,username,deviceid
1437000	/webpages/reportgroup.jsp?reportgroupid=1437000	1	destip	username,deviceid
1447000	/webpages/reportgroup.jsp?reportgroupid=1447000	1	application	destip,username,deviceid
1447100	/webpages/reportgroup.jsp?reportgroupid=1447100	1	srcip	destip,username,deviceid
1438000	/webpages/reportgroup.jsp?reportgroupid=1438000	1	srcip	username,deviceid
1448000	/webpages/reportgroup.jsp?reportgroupid=1448000	1	application	srcip,username,deviceid
1448100	/webpages/reportgroup.jsp?reportgroupid=1448100	1	destip	srcip,username,deviceid
1439000	/webpages/reportgroup.jsp?reportgroupid=1439000	1	srcip	username,deviceid
1449000	/webpages/reportgroup.jsp?reportgroupid=1449000	1	application	srcip,username,deviceid
1449100	/webpages/reportgroup.jsp?reportgroupid=1449100	1	destip	srcip,username,deviceid
1520000	/webpages/reportgroup.jsp?reportgroupid=1520000	1	proto_group	deviceid
1520001	/webpages/reportgroup.jsp?reportgroupid=1520001	1	proto_group	deviceid
1520002	/webpages/reportgroup.jsp?reportgroupid=1520002	1	proto_group	deviceid
1420001	/webpages/reportgroup.jsp?reportgroupid=1420001	1	username	deviceid
1420002	/webpages/reportgroup.jsp?reportgroupid=1420002	1	username	deviceid
1530000	/webpages/reportgroup.jsp?reportgroupid=1530000	1	application	proto_group,deviceid
1540000	/webpages/reportgroup.jsp?reportgroupid=1540000	1	username	application,proto_group,deviceid
1540100	/webpages/reportgroup.jsp?reportgroupid=1540100	1	destip	application,proto_group,deviceid
1540200	/webpages/reportgroup.jsp?reportgroupid=1540200	1	srcip	application,proto_group,deviceid
1531000	/webpages/reportgroup.jsp?reportgroupid=1531000	1	username	proto_group,deviceid
1541000	/webpages/reportgroup.jsp?reportgroupid=1541000	1	application	username,proto_group,deviceid
1541100	/webpages/reportgroup.jsp?reportgroupid=1541100	1	destip	username,proto_group,deviceid
1541200	/webpages/reportgroup.jsp?reportgroupid=1541200	1	srcip	username,proto_group,deviceid
1551000	/webpages/reportgroup.jsp?reportgroupid=1551000	1	application	srcip,username,proto_group,deviceid
1551100	/webpages/reportgroup.jsp?reportgroupid=1551100	1	destip	srcip,username,proto_group,deviceid
1532000	/webpages/reportgroup.jsp?reportgroupid=1532000	1	destip	proto_group,deviceid
1542000	/webpages/reportgroup.jsp?reportgroupid=1542000	1	application	proto_group,destip,deviceid
1542100	/webpages/reportgroup.jsp?reportgroupid=1542100	1	username	proto_group,destip,deviceid
1542200	/webpages/reportgroup.jsp?reportgroupid=1542200	1	srcip	proto_group,destip,deviceid
1533000	/webpages/reportgroup.jsp?reportgroupid=1533000	1	srcip	proto_group,deviceid
1543000	/webpages/reportgroup.jsp?reportgroupid=1543000	1	application	proto_group,srcip,deviceid
1543100	/webpages/reportgroup.jsp?reportgroupid=1543100	1	destip	proto_group,srcip,deviceid
1543200	/webpages/reportgroup.jsp?reportgroupid=1543200	1	username	proto_group,srcip,deviceid
1553000	/webpages/reportgroup.jsp?reportgroupid=1553000	1	application	proto_group,srcip,username,deviceid
1553100	/webpages/reportgroup.jsp?reportgroupid=1553100	1	destip	proto_group,srcip,username,deviceid
1534000	/webpages/reportgroup.jsp?reportgroupid=1534000	1	application	proto_group,deviceid
1544000	/webpages/reportgroup.jsp?reportgroupid=1544000	1	username	application,proto_group,deviceid
1544100	/webpages/reportgroup.jsp?reportgroupid=1544100	1	destip	application,proto_group,deviceid
1544200	/webpages/reportgroup.jsp?reportgroupid=1544200	1	srcip	application,proto_group,deviceid
1535000	/webpages/reportgroup.jsp?reportgroupid=1535000	1	application	proto_group,deviceid
1545000	/webpages/reportgroup.jsp?reportgroupid=1545000	1	username	application,proto_group,deviceid
1545100	/webpages/reportgroup.jsp?reportgroupid=1545100	1	destip	application,proto_group,deviceid
1545200	/webpages/reportgroup.jsp?reportgroupid=1545200	1	srcip	application,proto_group,deviceid
1536000	/webpages/reportgroup.jsp?reportgroupid=1536000	1	username	proto_group,deviceid
1546000	/webpages/reportgroup.jsp?reportgroupid=1546000	1	application	username,proto_group,deviceid
1546100	/webpages/reportgroup.jsp?reportgroupid=1546100	1	destip	username,proto_group,deviceid
1546200	/webpages/reportgroup.jsp?reportgroupid=1546200	1	srcip	username,proto_group,deviceid
1556000	/webpages/reportgroup.jsp?reportgroupid=1556000	1	application	srcip,username,proto_group,deviceid
1556100	/webpages/reportgroup.jsp?reportgroupid=1556100	1	destip	srcip,username,proto_group,deviceid
1537000	/webpages/reportgroup.jsp?reportgroupid=1537000	1	username	proto_group,deviceid
1547000	/webpages/reportgroup.jsp?reportgroupid=1547000	1	application	username,proto_group,deviceid
1547100	/webpages/reportgroup.jsp?reportgroupid=1547100	1	destip	username,proto_group,deviceid
1547200	/webpages/reportgroup.jsp?reportgroupid=1547200	1	srcip	username,proto_group,deviceid
1557000	/webpages/reportgroup.jsp?reportgroupid=1557000	1	application	srcip,username,proto_group,deviceid
1557100	/webpages/reportgroup.jsp?reportgroupid=1557100	1	destip	srcip,username,proto_group,deviceid
1538000	/webpages/reportgroup.jsp?reportgroupid=1538000	1	destip	proto_group,deviceid
1548000	/webpages/reportgroup.jsp?reportgroupid=1548000	1	application	proto_group,destip,deviceid
1548100	/webpages/reportgroup.jsp?reportgroupid=1548100	1	username	proto_group,destip,deviceid
1548200	/webpages/reportgroup.jsp?reportgroupid=1548200	1	srcip	proto_group,destip,deviceid
1539000	/webpages/reportgroup.jsp?reportgroupid=1539000	1	destip	proto_group,deviceid
1549000	/webpages/reportgroup.jsp?reportgroupid=1549000	1	application	proto_group,destip,deviceid
1549100	/webpages/reportgroup.jsp?reportgroupid=1549100	1	username	proto_group,destip,deviceid
1549200	/webpages/reportgroup.jsp?reportgroupid=1549200	1	srcip	proto_group,destip,deviceid
15310000	/webpages/reportgroup.jsp?reportgroupid=15310000	1	srcip	proto_group,deviceid
15410000	/webpages/reportgroup.jsp?reportgroupid=15410000	1	application	proto_group,srcip,deviceid
15410100	/webpages/reportgroup.jsp?reportgroupid=15410100	1	destip	proto_group,srcip,deviceid
15410200	/webpages/reportgroup.jsp?reportgroupid=15410200	1	username	proto_group,srcip,deviceid
15510000	/webpages/reportgroup.jsp?reportgroupid=15510000	1	application	proto_group,srcip,username,deviceid
15510100	/webpages/reportgroup.jsp?reportgroupid=15510100	1	destip	proto_group,srcip,username,deviceid
15311000	/webpages/reportgroup.jsp?reportgroupid=15311000	1	srcip	proto_group,deviceid
15411000	/webpages/reportgroup.jsp?reportgroupid=15411000	1	application	proto_group,srcip,deviceid
15411100	/webpages/reportgroup.jsp?reportgroupid=15411100	1	destip	proto_group,srcip,deviceid
15411200	/webpages/reportgroup.jsp?reportgroupid=15411200	1	username	proto_group,srcip,deviceid
15511000	/webpages/reportgroup.jsp?reportgroupid=15511000	1	application	proto_group,srcip,username,deviceid
15511100	/webpages/reportgroup.jsp?reportgroupid=15511100	1	destip	proto_group,srcip,username,deviceid
20101000	/webpages/reportgroup.jsp?reportgroupid=20101000	1	application	deviceid
20201000	/webpages/reportgroup.jsp?reportgroupid=20201000	1	application	deviceid
20301000	/webpages/reportgroup.jsp?reportgroupid=20301000	1	application	deviceid
20401000	/webpages/reportgroup.jsp?reportgroupid=1430000	1	username,proto_group	deviceid
20501000	/webpages/reportgroup.jsp?reportgroupid=1434000	1	username,proto_group	deviceid
20601000	/webpages/reportgroup.jsp?reportgroupid=1435000	1	username,proto_group	deviceid
20701000	/webpages/reportgroup.jsp?reportgroupid=103000	1	srcip,proto_group	deviceid
20801000	/webpages/reportgroup.jsp?reportgroupid=134000	1	srcip,proto_group	deviceid
20901000	/webpages/reportgroup.jsp?reportgroupid=135000	1	srcip,proto_group	deviceid
20101100	/webpages/reportgroup.jsp?reportgroupid=20101100	1	username	application,deviceid
20102100	/webpages/reportgroup.jsp?reportgroupid=20102100	1	destip	application,deviceid
20103100	/webpages/reportgroup.jsp?reportgroupid=20103100	1	srcip	application,deviceid
20201100	/webpages/reportgroup.jsp?reportgroupid=20201100	1	username	application,deviceid
20202100	/webpages/reportgroup.jsp?reportgroupid=20202100	1	destip	application,deviceid
20203100	/webpages/reportgroup.jsp?reportgroupid=20203100	1	srcip	application,deviceid
20301100	/webpages/reportgroup.jsp?reportgroupid=20301100	1	username	application,deviceid
20302100	/webpages/reportgroup.jsp?reportgroupid=20302100	1	destip	application,deviceid
20303100	/webpages/reportgroup.jsp?reportgroupid=20303100	1	srcip	application,deviceid
19	/webpages/reportgroup.jsp?reportgroupid=18	1	ruleid	deviceid
20	/webpages/reportgroup.jsp?reportgroupid=19	1	ruleid	deviceid
21	/webpages/reportgroup.jsp?reportgroupid=20	1	ruleid,proto_group	deviceid
22	/webpages/reportgroup.jsp?reportgroupid=21	1	ruleid,proto_group	deviceid
23	/webpages/reportgroup.jsp?reportgroupid=22	1	ruleid,srcip	deviceid
24	/webpages/reportgroup.jsp?reportgroupid=23	1	ruleid,srcip	deviceid
25	/webpages/reportgroup.jsp?reportgroupid=24	1	ruleid,destip	deviceid
26	/webpages/reportgroup.jsp?reportgroupid=25	1	ruleid,destip	deviceid
10001	/webpages/dashboard.jsp?others=true&reportgroupid=1002	1	deviceid	
4400000	/webpages/reportgroup.jsp?reportgroupid=4400000	1	content	deviceid
4410000	/webpages/reportgroup.jsp?reportgroupid=4410000	1	domain	content,deviceid
4411000	/webpages/reportgroup.jsp?reportgroupid=4411000	1	username	domain,content,deviceid
4420000	/webpages/reportgroup.jsp?reportgroupid=4420000	1	username	content,deviceid
4421000	/webpages/reportgroup.jsp?reportgroupid=4421000	1	domain	content,username,deviceid
4422000	/webpages/reportgroup.jsp?reportgroupid=4422000	1	category	content,username,deviceid
4422100	/webpages/reportgroup.jsp?reportgroupid=4422100	1	domain	content,category,username,deviceid
4430000	/webpages/reportgroup.jsp?reportgroupid=4430000	1	category	content,deviceid
4431000	/webpages/reportgroup.jsp?reportgroupid=4431000	1	username	content,category,deviceid
4432000	/webpages/reportgroup.jsp?reportgroupid=4432000	1	domain	content,category,deviceid
4431100	/webpages/reportgroup.jsp?reportgroupid=4431100	1	domain	content,category,username,deviceid
4500000	/webpages/reportgroup.jsp?reportgroupid=4500000	1	host	deviceid
4510000	/webpages/reportgroup.jsp?reportgroupid=4510000	1	category	host,deviceid
4511000	/webpages/reportgroup.jsp?reportgroupid=4511000	1	domain	category,host,deviceid
4520000	/webpages/reportgroup.jsp?reportgroupid=4520000	1	domain	host,deviceid
4530000	/webpages/reportgroup.jsp?reportgroupid=4530000	1	content	host,deviceid
4531000	/webpages/reportgroup.jsp?reportgroupid=4531000	1	domain	host,content,deviceid
4550000	/webpages/reportgroup.jsp?reportgroupid=4550000	1	username	host,deviceid
4551000	/webpages/reportgroup.jsp?reportgroupid=4551000	1	category	host,username,deviceid
4551100	/webpages/reportgroup.jsp?reportgroupid=4551100	1	domain	host,username,category,deviceid
4552000	/webpages/reportgroup.jsp?reportgroupid=4552000	1	domain	host,username,deviceid
4553000	/webpages/reportgroup.jsp?reportgroupid=4553000	1	content	host,username,deviceid
4553100	/webpages/reportgroup.jsp?reportgroupid=4553100	1	domain	host,username,content,deviceid
4555000	/webpages/reportgroup.jsp?reportgroupid=4555000	1	application	host,username,deviceid
4555100	/webpages/reportgroup.jsp?reportgroupid=4555100	1	category	host,username,application,deviceid
4555110	/webpages/reportgroup.jsp?reportgroupid=4555110	1	domain	host,username,application,category,deviceid
4555200	/webpages/reportgroup.jsp?reportgroupid=4555200	1	content	host,username,application,deviceid
4555210	/webpages/reportgroup.jsp?reportgroupid=4555210	1	domain	host,username,application,content,deviceid
4560000	/webpages/reportgroup.jsp?reportgroupid=4560000	1	application	host,deviceid
4561000	/webpages/reportgroup.jsp?reportgroupid=4561000	1	category	host,application,deviceid
4561100	/webpages/reportgroup.jsp?reportgroupid=4561100	1	domain	host,application,category,deviceid
4562000	/webpages/reportgroup.jsp?reportgroupid=4562000	1	content	host,application,deviceid
4562100	/webpages/reportgroup.jsp?reportgroupid=4562100	1	domain	host,application,content,deviceid
46000000	/webpages/reportgroup.jsp?reportgroupid=46000000	1	application	deviceid
46100000	/webpages/reportgroup.jsp?reportgroupid=46100000	1	category	application,deviceid
46110000	/webpages/reportgroup.jsp?reportgroupid=46110000	1	domain	application,category,deviceid
46111000	/webpages/reportgroup.jsp?reportgroupid=46111000	1	username	application,category,domain,deviceid
46120000	/webpages/reportgroup.jsp?reportgroupid=46120000	1	username	application,category,deviceid
46121000	/webpages/reportgroup.jsp?reportgroupid=46121000	1	domain	application,category,username,deviceid
46122000	/webpages/reportgroup.jsp?reportgroupid=46122000	1	content	application,category,username,deviceid
46122100	/webpages/reportgroup.jsp?reportgroupid=46122100	1	domain	application,category,username,content,deviceid
46130000	/webpages/reportgroup.jsp?reportgroupid=46130000	1	content	application,category,deviceid
46131000	/webpages/reportgroup.jsp?reportgroupid=46131000	1	username	application,category,content,deviceid
46131100	/webpages/reportgroup.jsp?reportgroupid=46131100	1	domain	application,category,content,username,deviceid
46132000	/webpages/reportgroup.jsp?reportgroupid=46132000	1	domain	application,category,content,deviceid
46132100	/webpages/reportgroup.jsp?reportgroupid=46132100	1	username	application,category,content,domain,deviceid
46200000	/webpages/reportgroup.jsp?reportgroupid=46200000	1	domain	application,deviceid
46210000	/webpages/reportgroup.jsp?reportgroupid=46210000	1	username	application,domain,deviceid
46220000	/webpages/reportgroup.jsp?reportgroupid=46220000	1	content	application,domain,deviceid
46221000	/webpages/reportgroup.jsp?reportgroupid=46221000	1	username	application,domain,content,deviceid
46300000	/webpages/reportgroup.jsp?reportgroupid=46300000	1	username	application,deviceid
46310000	/webpages/reportgroup.jsp?reportgroupid=46310000	1	category	application,username,deviceid
46320000	/webpages/reportgroup.jsp?reportgroupid=46320000	1	domain	application,username,deviceid
46330000	/webpages/reportgroup.jsp?reportgroupid=46330000	1	content	application,username,deviceid
46331000	/webpages/reportgroup.jsp?reportgroupid=46331000	1	domain	application,username,content,deviceid
46311000	/webpages/reportgroup.jsp?reportgroupid=46311000	1	domain	application,username,category,deviceid
46400000	/webpages/reportgroup.jsp?reportgroupid=46400000	1	content	application,deviceid
46410000	/webpages/reportgroup.jsp?reportgroupid=46410000	1	domain	application,content,deviceid
46411000	/webpages/reportgroup.jsp?reportgroupid=46411000	1	username	application,content,domain,deviceid
46420000	/webpages/reportgroup.jsp?reportgroupid=46420000	1	username	application,content,deviceid
46421000	/webpages/reportgroup.jsp?reportgroupid=46421000	1	domain	application,content,username,deviceid
46422000	/webpages/reportgroup.jsp?reportgroupid=46422000	1	category	application,content,username,deviceid
46422100	/webpages/reportgroup.jsp?reportgroupid=46422100	1	domain	application,content,username,category,deviceid
46430000	/webpages/reportgroup.jsp?reportgroupid=46430000	1	category	application,content,deviceid
46431000	/webpages/reportgroup.jsp?reportgroupid=46431000	1	username	application,content,category,deviceid
46431100	/webpages/reportgroup.jsp?reportgroupid=46431100	1	domain	application,content,category,username,deviceid
46432000	/webpages/reportgroup.jsp?reportgroupid=46432000	1	domain	application,content,category,deviceid
41000000	/webpages/reportgroup.jsp?reportgroupid=41000000	1	username	
41100000	/webpages/reportgroup.jsp?reportgroupid=41100000	1	category	username
41200000	/webpages/reportgroup.jsp?reportgroupid=41200000	1	domain	username
41300000	/webpages/reportgroup.jsp?reportgroupid=41300000	1	content	username
41500000	/webpages/reportgroup.jsp?reportgroupid=41500000	1	host	username
41600000	/webpages/reportgroup.jsp?reportgroupid=41600000	1	application	username
41110000	/webpages/reportgroup.jsp?reportgroupid=41110000	1	domain	category,username
41310000	/webpages/reportgroup.jsp?reportgroupid=41310000	1	domain	content,username
41510000	/webpages/reportgroup.jsp?reportgroupid=41510000	1	category	host,username
41511000	/webpages/reportgroup.jsp?reportgroupid=41511000	1	domain	category,host,username
41520000	/webpages/reportgroup.jsp?reportgroupid=41520000	1	domain	host,username
41530000	/webpages/reportgroup.jsp?reportgroupid=41530000	1	content	host,username
41531000	/webpages/reportgroup.jsp?reportgroupid=41531000	1	domain	content,host,username
41550000	/webpages/reportgroup.jsp?reportgroupid=41550000	1	application	host,username
41551000	/webpages/reportgroup.jsp?reportgroupid=41551000	1	category	application,host,username
41552000	/webpages/reportgroup.jsp?reportgroupid=41552000	1	content	application,host,username
41551100	/webpages/reportgroup.jsp?reportgroupid=41551100	1	domain	category,application,host,username
41552100	/webpages/reportgroup.jsp?reportgroupid=41552100	1	domain	content,application,host,username
41610000	/webpages/reportgroup.jsp?reportgroupid=41610000	1	category	application,username
41620000	/webpages/reportgroup.jsp?reportgroupid=41620000	1	content	application,username
41611000	/webpages/reportgroup.jsp?reportgroupid=41611000	1	domain	category,application,username
41621000	/webpages/reportgroup.jsp?reportgroupid=41621000	1	domain	content,application,username
42000000	/webpages/reportgroup.jsp?reportgroupid=42000000	1	category	
42100000	/webpages/reportgroup.jsp?reportgroupid=42100000	1	domain	category
42200000	/webpages/reportgroup.jsp?reportgroupid=42200000	1	username	category
42300000	/webpages/reportgroup.jsp?reportgroupid=42300000	1	content	category
42110000	/webpages/reportgroup.jsp?reportgroupid=42110000	1	username	category,domain
42120000	/webpages/reportgroup.jsp?reportgroupid=42120000	1	content	category,domain
42210000	/webpages/reportgroup.jsp?reportgroupid=42210000	1	domain	username,category
42220000	/webpages/reportgroup.jsp?reportgroupid=42220000	1	content	username,category
42221000	/webpages/reportgroup.jsp?reportgroupid=42221000	1	domain	content,username,category
42311000	/webpages/reportgroup.jsp?reportgroupid=42311000	1	domain	username,content,category
42321000	/webpages/reportgroup.jsp?reportgroupid=42321000	1	username	domain,content,category
43000000	/webpages/reportgroup.jsp?reportgroupid=43000000	1	domain	
43100000	/webpages/reportgroup.jsp?reportgroupid=43100000	1	username	domain
43200000	/webpages/reportgroup.jsp?reportgroupid=43200000	1	content	domain
43210000	/webpages/reportgroup.jsp?reportgroupid=43210000	1	username	content,domain
42310000	/webpages/reportgroup.jsp?reportgroupid=42310000	1	username	content,category
42320000	/webpages/reportgroup.jsp?reportgroupid=42320000	1	domain	content,category
42121000	/webpages/reportgroup.jsp?reportgroupid=42121000	1	username	content,category,domain
46112000	/webpages/reportgroup.jsp?reportgroupid=46112000	1	content	application,category,domain,deviceid
46112100	/webpages/reportgroup.jsp?reportgroupid=46112100	1	username	application,category,content,domain,deviceid
7100000	/webpages/reportgroup.jsp?reportgroupid=7100000	1	username	deviceid
7200000	/webpages/reportgroup.jsp?reportgroupid=7200000	1	proto_group	deviceid
7300000	/webpages/reportgroup.jsp?reportgroupid=7300000	1	host	deviceid
7400000	/webpages/reportgroup.jsp?reportgroupid=7400000	1	destination	deviceid
7110000	/webpages/reportgroup.jsp?reportgroupid=7110000	1	proto_group	username,deviceid
7111000	/webpages/reportgroup.jsp?reportgroupid=7111000	1	application	proto_group,username,deviceid
7112000	/webpages/reportgroup.jsp?reportgroupid=7112000	1	destination	proto_group,username,deviceid
7113000	/webpages/reportgroup.jsp?reportgroupid=7113000	1	host	proto_group,username,deviceid
7113100	/webpages/reportgroup.jsp?reportgroupid=7113100	1	application	proto_group,username,host,deviceid
7120000	/webpages/reportgroup.jsp?reportgroupid=7120000	1	destination	username,deviceid
7121000	/webpages/reportgroup.jsp?reportgroupid=7121000	1	application	username,destination,deviceid
7122000	/webpages/reportgroup.jsp?reportgroupid=7122000	1	host	username,destination,deviceid
7130000	/webpages/reportgroup.jsp?reportgroupid=7130000	1	host	username,deviceid
7131000	/webpages/reportgroup.jsp?reportgroupid=7131000	1	application	username,host,deviceid
7132000	/webpages/reportgroup.jsp?reportgroupid=7132000	1	destination	username,host,deviceid
7210000	/webpages/reportgroup.jsp?reportgroupid=7210000	1	application	proto_group,deviceid
7211000	/webpages/reportgroup.jsp?reportgroupid=7211000	1	username	proto_group,application,deviceid
7212000	/webpages/reportgroup.jsp?reportgroupid=7212000	1	destination	proto_group,application,deviceid
7213000	/webpages/reportgroup.jsp?reportgroupid=7213000	1	host	proto_group,application,deviceid
7220000	/webpages/reportgroup.jsp?reportgroupid=7220000	1	username	proto_group,deviceid
7221000	/webpages/reportgroup.jsp?reportgroupid=7221000	1	application	proto_group,username,deviceid
7222000	/webpages/reportgroup.jsp?reportgroupid=7222000	1	destination	proto_group,username,deviceid
7223000	/webpages/reportgroup.jsp?reportgroupid=7223000	1	host	proto_group,username,deviceid
7223100	/webpages/reportgroup.jsp?reportgroupid=7223100	1	application	proto_group,username,host,deviceid
7223200	/webpages/reportgroup.jsp?reportgroupid=7223200	1	destination	proto_group,username,host,deviceid
7230000	/webpages/reportgroup.jsp?reportgroupid=7230000	1	destination	proto_group,deviceid
7231000	/webpages/reportgroup.jsp?reportgroupid=7231000	1	application	proto_group,destination,deviceid
7232000	/webpages/reportgroup.jsp?reportgroupid=7232000	1	username	proto_group,destination,deviceid
7233000	/webpages/reportgroup.jsp?reportgroupid=7233000	1	host	proto_group,destination,deviceid
7240000	/webpages/reportgroup.jsp?reportgroupid=7240000	1	host	proto_group,deviceid
7241000	/webpages/reportgroup.jsp?reportgroupid=7241000	1	application	proto_group,host,deviceid
7242000	/webpages/reportgroup.jsp?reportgroupid=7242000	1	destination	proto_group,host,deviceid
7243000	/webpages/reportgroup.jsp?reportgroupid=7243000	1	username	proto_group,host,deviceid
7243100	/webpages/reportgroup.jsp?reportgroupid=7243100	1	application	proto_group,host,username,deviceid
7243200	/webpages/reportgroup.jsp?reportgroupid=7243200	1	destination	proto_group,host,username,deviceid
7310000	/webpages/reportgroup.jsp?reportgroupid=7310000	1	proto_group	host,deviced
7311000	/webpages/reportgroup.jsp?reportgroupid=7311000	1	application	proto_group,host,deviced
7312000	/webpages/reportgroup.jsp?reportgroupid=7312000	1	destination	proto_group,host,deviced
7313000	/webpages/reportgroup.jsp?reportgroupid=7313000	1	username	host,proto_group,deviced
7313100	/webpages/reportgroup.jsp?reportgroupid=7313100	1	application	host,proto_group,username,deviced
7320000	/webpages/reportgroup.jsp?reportgroupid=7320000	1	destination	host,deviced
7321000	/webpages/reportgroup.jsp?reportgroupid=7321000	1	application	host,destination,deviced
7322000	/webpages/reportgroup.jsp?reportgroupid=7322000	1	username	host,destination,deviced
7330000	/webpages/reportgroup.jsp?reportgroupid=7330000	1	username	host,deviced
7331000	/webpages/reportgroup.jsp?reportgroupid=7331000	1	application	host,username,deviced
7332000	/webpages/reportgroup.jsp?reportgroupid=7332000	1	destination	host,username,deviced
7410000	/webpages/reportgroup.jsp?reportgroupid=7410000	1	proto_group	destination,deviceid
7411000	/webpages/reportgroup.jsp?reportgroupid=7411000	1	application	destination,proto_group,deviceid
7412000	/webpages/reportgroup.jsp?reportgroupid=7412000	1	username	destination,proto_group,deviceid
7413000	/webpages/reportgroup.jsp?reportgroupid=7413000	1	host	destination,proto_group,deviceid
7420000	/webpages/reportgroup.jsp?reportgroupid=7420000	1	username	destination,deviceid
7421000	/webpages/reportgroup.jsp?reportgroupid=7421000	1	application	destination,username,deviceid
7422000	/webpages/reportgroup.jsp?reportgroupid=7422000	1	host	destination,username,deviceid
7430000	/webpages/reportgroup.jsp?reportgroupid=7430000	1	host	destination,deviceid
7431000	/webpages/reportgroup.jsp?reportgroupid=7431000	1	application	destination,host,deviceid
7432000	/webpages/reportgroup.jsp?reportgroupid=7432000	1	username	destination,host,deviceid
81000000	/webpages/reportgroup.jsp?reportgroupid=81000000	1	username	
81100000	/webpages/reportgroup.jsp?reportgroupid=81100000	1	category	username
81200000	/webpages/reportgroup.jsp?reportgroupid=81200000	1	domain	username
81400000	/webpages/reportgroup.jsp?reportgroupid=81400000	1	host	username
81500000	/webpages/reportgroup.jsp?reportgroupid=81500000	1	application	username
81110000	/webpages/reportgroup.jsp?reportgroupid=81110000	1	domain	category,username
81410000	/webpages/reportgroup.jsp?reportgroupid=81410000	1	category	host,username
81420000	/webpages/reportgroup.jsp?reportgroupid=81420000	1	domain	host,username
81440000	/webpages/reportgroup.jsp?reportgroupid=81440000	1	application	host,username
81411000	/webpages/reportgroup.jsp?reportgroupid=81411000	1	domain	category,host,username
81441000	/webpages/reportgroup.jsp?reportgroupid=81441000	1	category	application,host,username
81441100	/webpages/reportgroup.jsp?reportgroupid=81441100	1	domain	category,application,host,username
81510000	/webpages/reportgroup.jsp?reportgroupid=81510000	1	category	application,username
81511000	/webpages/reportgroup.jsp?reportgroupid=81511000	1	domain	category,application,username
82000000	/webpages/reportgroup.jsp?reportgroupid=82000000	1	category	
82100000	/webpages/reportgroup.jsp?reportgroupid=82100000	1	domain	category
82200000	/webpages/reportgroup.jsp?reportgroupid=82200000	1	username	category
82110000	/webpages/reportgroup.jsp?reportgroupid=82110000	1	username	domain,category
82210000	/webpages/reportgroup.jsp?reportgroupid=82210000	1	domain	username,category
83000000	/webpages/reportgroup.jsp?reportgroupid=83000000	1	domain	
83100000	/webpages/reportgroup.jsp?reportgroupid=83100000	1	username	domain
84000000	/webpages/reportgroup.jsp?reportgroupid=84000000	1	host	
84100000	/webpages/reportgroup.jsp?reportgroupid=84100000	1	category	host
84200000	/webpages/reportgroup.jsp?reportgroupid=84200000	1	domain	host
84400000	/webpages/reportgroup.jsp?reportgroupid=84400000	1	username	host
84110000	/webpages/reportgroup.jsp?reportgroupid=84110000	1	domain	category,host
84410000	/webpages/reportgroup.jsp?reportgroupid=84410000	1	category	username,host
84420000	/webpages/reportgroup.jsp?reportgroupid=84420000	1	domain	username,host
84440000	/webpages/reportgroup.jsp?reportgroupid=84440000	1	application	username,host
84411000	/webpages/reportgroup.jsp?reportgroupid=84411000	1	domain	category,username,host
84441000	/webpages/reportgroup.jsp?reportgroupid=84441000	1	category	application,username,host
84441100	/webpages/reportgroup.jsp?reportgroupid=84441100	1	domain	category,application,username,host
84500000	/webpages/reportgroup.jsp?reportgroupid=84500000	1	application	host
84510000	/webpages/reportgroup.jsp?reportgroupid=84510000	1	category	application,host
84511000	/webpages/reportgroup.jsp?reportgroupid=84511000	1	domain	category,application,host
6100000	/webpages/reportgroup.jsp?reportgroupid=6100000	1	file	deviceid
6200000	/webpages/reportgroup.jsp?reportgroupid=6200000	1	file	deviceid
6300000	/webpages/reportgroup.jsp?reportgroupid=6300000	1	username	deviceid
6400000	/webpages/reportgroup.jsp?reportgroupid=6400000	1	username	deviceid
6500000	/webpages/reportgroup.jsp?reportgroupid=6500000	1	host	deviceid
6600000	/webpages/reportgroup.jsp?reportgroupid=6600000	1	host	deviceid
6700000	/webpages/reportgroup.jsp?reportgroupid=6700000	1	server	deviceid
6110000	/webpages/reportgroup.jsp?reportgroupid=6110000	1	server	file,deviceid
6120000	/webpages/reportgroup.jsp?reportgroupid=6120000	1	host	file,deviceid
6130000	/webpages/reportgroup.jsp?reportgroupid=6130000	1	username	file,deviceid
6210000	/webpages/reportgroup.jsp?reportgroupid=6210000	1	server	file,deviceid
6220000	/webpages/reportgroup.jsp?reportgroupid=6220000	1	host	file,deviceid
6230000	/webpages/reportgroup.jsp?reportgroupid=6230000	1	username	file,deviceid
6310000	/webpages/reportgroup.jsp?reportgroupid=6310000	1	file	username,deviceid
6320000	/webpages/reportgroup.jsp?reportgroupid=6320000	1	server	username,deviceid
6330000	/webpages/reportgroup.jsp?reportgroupid=6330000	1	host	username,deviceid
6410000	/webpages/reportgroup.jsp?reportgroupid=6410000	1	file	username,deviceid
6420000	/webpages/reportgroup.jsp?reportgroupid=6420000	1	server	username,deviceid
6430000	/webpages/reportgroup.jsp?reportgroupid=6430000	1	host	username,deviceid
6510000	/webpages/reportgroup.jsp?reportgroupid=6510000	1	file	host,deviceid
6520000	/webpages/reportgroup.jsp?reportgroupid=6520000	1	server	host,deviceid
6530000	/webpages/reportgroup.jsp?reportgroupid=6530000	1	username	host,deviceid
6610000	/webpages/reportgroup.jsp?reportgroupid=6610000	1	file	host,deviceid
6620000	/webpages/reportgroup.jsp?reportgroupid=6620000	1	server	host,deviceid
6630000	/webpages/reportgroup.jsp?reportgroupid=6630000	1	username	host,deviceid
6710000	/webpages/reportgroup.jsp?reportgroupid=6710000	1	file	server,deviceid
6720000	/webpages/reportgroup.jsp?reportgroupid=6720000	1	file	server,deviceid
6730000	/webpages/reportgroup.jsp?reportgroupid=6730000	1	username	server,deviceid
6740000	/webpages/reportgroup.jsp?reportgroupid=6740000	1	host	server,deviceid
510000	/webpages/reportgroup.jsp?reportgroupid=510000	1	sender	deviceid
520000	/webpages/reportgroup.jsp?reportgroupid=520000	1	recipient	deviceid
530000	/webpages/reportgroup.jsp?reportgroupid=530000	1	username	deviceid
540000	/webpages/reportgroup.jsp?reportgroupid=540000	1	host	deviceid
550000	/webpages/reportgroup.jsp?reportgroupid=550000	1	application	deviceid
511000	/webpages/reportgroup.jsp?reportgroupid=511000	1	recipient	sender,deviceid
512000	/webpages/reportgroup.jsp?reportgroupid=512000	1	host	sender,deviceid
513000	/webpages/reportgroup.jsp?reportgroupid=513000	1	destination	sender,deviceid
514000	/webpages/reportgroup.jsp?reportgroupid=514000	1	username	sender,deviceid
515000	/webpages/reportgroup.jsp?reportgroupid=515000	1	application	sender,deviceid
521000	/webpages/reportgroup.jsp?reportgroupid=521000	1	sender	recipient,deviceid
522000	/webpages/reportgroup.jsp?reportgroupid=522000	1	host	recipient,deviceid
523000	/webpages/reportgroup.jsp?reportgroupid=523000	1	destination	recipient,deviceid
524000	/webpages/reportgroup.jsp?reportgroupid=524000	1	username	recipient,deviceid
525000	/webpages/reportgroup.jsp?reportgroupid=525000	1	application	recipient,deviceid
531000	/webpages/reportgroup.jsp?reportgroupid=531000	1	sender	username,deviceid
532000	/webpages/reportgroup.jsp?reportgroupid=532000	1	recipient	username,deviceid
533000	/webpages/reportgroup.jsp?reportgroupid=533000	1	host	username,deviceid
534000	/webpages/reportgroup.jsp?reportgroupid=534000	1	destination	username,deviceid
535000	/webpages/reportgroup.jsp?reportgroupid=535000	1	application	username,deviceid
541000	/webpages/reportgroup.jsp?reportgroupid=541000	1	sender	host,deviceid
542000	/webpages/reportgroup.jsp?reportgroupid=542000	1	recipient	host,deviceid
543000	/webpages/reportgroup.jsp?reportgroupid=543000	1	username	host,deviceid
544000	/webpages/reportgroup.jsp?reportgroupid=544000	1	destination	host,deviceid
545000	/webpages/reportgroup.jsp?reportgroupid=545000	1	application	host,deviceid
551000	/webpages/reportgroup.jsp?reportgroupid=551000	1	sender	application,deviceid
552000	/webpages/reportgroup.jsp?reportgroupid=552000	1	recipient	application,deviceid
553000	/webpages/reportgroup.jsp?reportgroupid=553000	1	username	application,deviceid
554000	/webpages/reportgroup.jsp?reportgroupid=554000	1	host	application,deviceid
555000	/webpages/reportgroup.jsp?reportgroupid=555000	1	destination	application,deviceid
1011000	/webpages/reportgroup.jsp?reportgroupid=1011000	1	sender	recipient,deviceid
1012000	/webpages/reportgroup.jsp?reportgroupid=1012000	1	host	recipient,deviceid
1013000	/webpages/reportgroup.jsp?reportgroupid=1013000	1	destination	recipient,deviceid
1015000	/webpages/reportgroup.jsp?reportgroupid=1015000	1	application	recipient,deviceid
1020000	/webpages/reportgroup.jsp?reportgroupid=1020000	1	sender	deviceid
1021000	/webpages/reportgroup.jsp?reportgroupid=1021000	1	recipient	sender,deviceid
1022000	/webpages/reportgroup.jsp?reportgroupid=1022000	1	host	sender,deviceid
1023000	/webpages/reportgroup.jsp?reportgroupid=1023000	1	destination	sender,deviceid
1025000	/webpages/reportgroup.jsp?reportgroupid=1025000	1	application	sender,deviceid
1030000	/webpages/reportgroup.jsp?reportgroupid=1030000	1	application	deviceid
1031000	/webpages/reportgroup.jsp?reportgroupid=1031000	1	sender	application,deviceid
1032000	/webpages/reportgroup.jsp?reportgroupid=1032000	1	recipient	application,deviceid
1034000	/webpages/reportgroup.jsp?reportgroupid=1034000	1	host	application,deviceid
1035000	/webpages/reportgroup.jsp?reportgroupid=1035000	1	destination	application,deviceid
1010000	/webpages/reportgroup.jsp?reportgroupid=1010000	1	recipient	deviceid
1014000	/webpages/reportgroup.jsp?reportgroupid=1014000	1	username	recipient,deviceid
1024000	/webpages/reportgroup.jsp?reportgroupid=1024000	1	username	sender,deviceid
1033000	/webpages/reportgroup.jsp?reportgroupid=1033000	1	username	application,deviceid
91000000	/webpages/reportgroup.jsp?reportgroupid=91000000	1	severity	
92000000	/webpages/reportgroup.jsp?reportgroupid=92000000	1	attack	
93000000	/webpages/reportgroup.jsp?reportgroupid=93000000	1	attacker	
94000000	/webpages/reportgroup.jsp?reportgroupid=94000000	1	victim	
97000000	/webpages/reportgroup.jsp?reportgroupid=97000000	1	application	
91100000	/webpages/reportgroup.jsp?reportgroupid=91100000	1	attack	severity
91200000	/webpages/reportgroup.jsp?reportgroupid=91200000	1	attacker	severity
91300000	/webpages/reportgroup.jsp?reportgroupid=91300000	1	victim	severity
91400000	/webpages/reportgroup.jsp?reportgroupid=91400000	1	application	severity
91500000	/webpages/reportgroup.jsp?reportgroupid=91500000	1	attack	severity
91600000	/webpages/reportgroup.jsp?reportgroupid=91600000	1	attack	severity
93100000	/webpages/reportgroup.jsp?reportgroupid=93100000	1	attack	attacker
93200000	/webpages/reportgroup.jsp?reportgroupid=93200000	1	victim	attacker
93300000	/webpages/reportgroup.jsp?reportgroupid=93300000	1	application	attacker
94100000	/webpages/reportgroup.jsp?reportgroupid=94100000	1	attack	victim
94200000	/webpages/reportgroup.jsp?reportgroupid=94200000	1	attacker	victim
94300000	/webpages/reportgroup.jsp?reportgroupid=94300000	1	application	victim
97100000	/webpages/reportgroup.jsp?reportgroupid=97100000	1	attack	application
97200000	/webpages/reportgroup.jsp?reportgroupid=97200000	1	attacker	application
97300000	/webpages/reportgroup.jsp?reportgroupid=97300000	1	victim	application
97400000	/webpages/reportgroup.jsp?reportgroupid=97400000	1	attack	application
97500000	/webpages/reportgroup.jsp?reportgroupid=97500000	1	attack	application
11310000	/webpages/reportgroup.jsp?reportgroupid=11310000	1	virus	deviceid
11311000	/webpages/reportgroup.jsp?reportgroupid=11311000	1	domain	virus,deviceid
11312000	/webpages/reportgroup.jsp?reportgroupid=11312000	1	username	virus,deviceid
11313000	/webpages/reportgroup.jsp?reportgroupid=11313000	1	host	virus,deviceid
11320000	/webpages/reportgroup.jsp?reportgroupid=11320000	1	domain	deviceid
11321000	/webpages/reportgroup.jsp?reportgroupid=11321000	1	virus	domain,deviceid
11322000	/webpages/reportgroup.jsp?reportgroupid=11322000	1	username	domain,deviceid
11323000	/webpages/reportgroup.jsp?reportgroupid=11323000	1	host	domain,deviceid
11330000	/webpages/reportgroup.jsp?reportgroupid=11330000	1	username	deviceid
11331000	/webpages/reportgroup.jsp?reportgroupid=11331000	1	virus	username,deviceid
11332000	/webpages/reportgroup.jsp?reportgroupid=11332000	1	domain	username,deviceid
11333000	/webpages/reportgroup.jsp?reportgroupid=11333000	1	host	username,deviceid
11410000	/webpages/reportgroup.jsp?reportgroupid=11410000	1	virus	deviceid
11411000	/webpages/reportgroup.jsp?reportgroupid=11411000	1	sender	virus,deviceid
11411100	/webpages/reportgroup.jsp?reportgroupid=11411100	1	recipient	virus,sender,deviceid
11411200	/webpages/reportgroup.jsp?reportgroupid=11411200	1	host	virus,sender,deviceid
11411300	/webpages/reportgroup.jsp?reportgroupid=11411300	1	destination	virus,sender,deviceid
11411400	/webpages/reportgroup.jsp?reportgroupid=11411400	1	application	virus,sender,deviceid
11411500	/webpages/reportgroup.jsp?reportgroupid=11411500	1	username	virus,sender,deviceid
11412000	/webpages/reportgroup.jsp?reportgroupid=11412000	1	recipient	virus,deviceid
11412100	/webpages/reportgroup.jsp?reportgroupid=11412100	1	sender	virus,recipient,deviceid
11412200	/webpages/reportgroup.jsp?reportgroupid=11412200	1	host	virus,recipient,deviceid
11412300	/webpages/reportgroup.jsp?reportgroupid=11412300	1	destination	virus,recipient,deviceid
11412400	/webpages/reportgroup.jsp?reportgroupid=11412400	1	application	virus,recipient,deviceid
11412500	/webpages/reportgroup.jsp?reportgroupid=11412500	1	username	virus,recipient,deviceid
11413000	/webpages/reportgroup.jsp?reportgroupid=11413000	1	host	virus,deviceid
11413100	/webpages/reportgroup.jsp?reportgroupid=11413100	1	sender	virus,host,deviceid
11413200	/webpages/reportgroup.jsp?reportgroupid=11413200	1	recipient	virus,host,deviceid
11413300	/webpages/reportgroup.jsp?reportgroupid=11413300	1	destination	virus,host,deviceid
11413400	/webpages/reportgroup.jsp?reportgroupid=11413400	1	application	virus,host,deviceid
11413500	/webpages/reportgroup.jsp?reportgroupid=11413500	1	username	virus,host,deviceid
11414000	/webpages/reportgroup.jsp?reportgroupid=11414000	1	destination	virus,deviceid
11414100	/webpages/reportgroup.jsp?reportgroupid=11414100	1	sender	virus,destination,deviceid
11414200	/webpages/reportgroup.jsp?reportgroupid=11414200	1	recipient	virus,destination,deviceid
11414300	/webpages/reportgroup.jsp?reportgroupid=11414300	1	host	virus,destination,deviceid
11414400	/webpages/reportgroup.jsp?reportgroupid=11414400	1	application	virus,destination,deviceid
11414500	/webpages/reportgroup.jsp?reportgroupid=11414500	1	username	virus,destination,deviceid
11415000	/webpages/reportgroup.jsp?reportgroupid=11415000	1	application	virus,deviceid
11415100	/webpages/reportgroup.jsp?reportgroupid=11415100	1	sender	virus,application,deviceid
11415200	/webpages/reportgroup.jsp?reportgroupid=11415200	1	recipient	virus,application,deviceid
11415300	/webpages/reportgroup.jsp?reportgroupid=11415300	1	host	virus,application,deviceid
11415400	/webpages/reportgroup.jsp?reportgroupid=11415400	1	destination	virus,application,deviceid
11415500	/webpages/reportgroup.jsp?reportgroupid=11415500	1	username	virus,application,deviceid
11510000	/webpages/reportgroup.jsp?reportgroupid=11510000	1	virus	deviceid
11511000	/webpages/reportgroup.jsp?reportgroupid=11511000	1	server	virus,deviceid
11511100	/webpages/reportgroup.jsp?reportgroupid=11511100	1	host	virus,server,deviceid
11511200	/webpages/reportgroup.jsp?reportgroupid=11511200	1	file	virus,server,deviceid
11511300	/webpages/reportgroup.jsp?reportgroupid=11511300	1	username	virus,server,deviceid
11512000	/webpages/reportgroup.jsp?reportgroupid=11512000	1	host	virus,deviceid
11512100	/webpages/reportgroup.jsp?reportgroupid=11512100	1	server	virus,host,deviceid
11512200	/webpages/reportgroup.jsp?reportgroupid=11512200	1	file	virus,host,deviceid
11512300	/webpages/reportgroup.jsp?reportgroupid=11512300	1	username	virus,host,deviceid
11513000	/webpages/reportgroup.jsp?reportgroupid=11513000	1	username	virus,deviceid
11513100	/webpages/reportgroup.jsp?reportgroupid=11513100	1	server	virus,username,deviceid
11513200	/webpages/reportgroup.jsp?reportgroupid=11513200	1	file	virus,username,deviceid
11513300	/webpages/reportgroup.jsp?reportgroupid=11513300	1	host	virus,username,deviceid
11514000	/webpages/reportgroup.jsp?reportgroupid=11514000	1	file	virus,deviceid
11514100	/webpages/reportgroup.jsp?reportgroupid=11514100	1	server	virus,file,deviceid
11514200	/webpages/reportgroup.jsp?reportgroupid=11514200	1	host	virus,file,deviceid
11514300	/webpages/reportgroup.jsp?reportgroupid=11514300	1	username	virus,file,deviceid
11520000	/webpages/reportgroup.jsp?reportgroupid=11520000	1	virus	deviceid
11521000	/webpages/reportgroup.jsp?reportgroupid=11521000	1	server	virus,deviceid
11521100	/webpages/reportgroup.jsp?reportgroupid=11521100	1	host	virus,server,deviceid
11521200	/webpages/reportgroup.jsp?reportgroupid=11521200	1	file	virus,server,deviceid
11521300	/webpages/reportgroup.jsp?reportgroupid=11521300	1	username	virus,server,deviceid
11522000	/webpages/reportgroup.jsp?reportgroupid=11522000	1	host	virus,deviceid
11522100	/webpages/reportgroup.jsp?reportgroupid=11522100	1	server	virus,host,deviceid
11522200	/webpages/reportgroup.jsp?reportgroupid=11522200	1	file	virus,host,deviceid
11522300	/webpages/reportgroup.jsp?reportgroupid=11522300	1	username	virus,host,deviceid
11523000	/webpages/reportgroup.jsp?reportgroupid=11523000	1	username	virus,deviceid
11523100	/webpages/reportgroup.jsp?reportgroupid=11523100	1	server	virus,username,deviceid
11523200	/webpages/reportgroup.jsp?reportgroupid=11523200	1	file	virus,username,deviceid
11523300	/webpages/reportgroup.jsp?reportgroupid=11523300	1	host	virus,username,deviceid
11524000	/webpages/reportgroup.jsp?reportgroupid=11524000	1	file	virus,deviceid
11524100	/webpages/reportgroup.jsp?reportgroupid=11524100	1	server	virus,file,deviceid
11524200	/webpages/reportgroup.jsp?reportgroupid=11524200	1	host	virus,file,deviceid
11524300	/webpages/reportgroup.jsp?reportgroupid=11524300	1	username	virus,file,deviceid
92100000	/webpages/reportgroup.jsp?reportgroupid=92100000	1	attacker	attack
92200000	/webpages/reportgroup.jsp?reportgroupid=92200000	1	victim	attack
92300000	/webpages/reportgroup.jsp?reportgroupid=92300000	1	application	attack
20100	/webpages/reportgroup.jsp?reportgroupid=20100	1	usagetype	deviceid
20200	/webpages/reportgroup.jsp?reportgroupid=20200	1	usagetype	deviceid
20300	/webpages/reportgroup.jsp?reportgroupid=20300	1	usagetype	deviceid
\.



ALTER TABLE ONLY tbldatalink
    ADD CONSTRAINT tbldatalink_pkey PRIMARY KEY (datalinkid);



DROP TABLE IF EXISTS tblgraph;
CREATE TABLE tblgraph (
    graphid serial NOT NULL,
    title character varying(255) DEFAULT ''::character varying,
    subtitle character varying(255) DEFAULT ''::character varying,
    description character varying(50) DEFAULT ''::character varying,
    height integer,
    width integer,
    charttype integer,
    xcolumnid integer,
    ycolumnid integer,
    zcolumnid integer DEFAULT (-1),
    graphformatid integer DEFAULT (-1),
    CONSTRAINT tblgraph_width_check CHECK ((width >= 0))
);

COPY tblgraph (graphid, title, subtitle, description, height, width, charttype, xcolumnid, ycolumnid, zcolumnid, graphformatid) FROM stdin;
16	Top Users (Sent + Received)			250	380	41	48	50	-1	2
17	Top Users (Sent)			250	380	41	51	53	-1	2
18	Top Users (Received)			250	380	41	54	56	-1	2
19	Top Application Groups (Sent + Received)			250	380	41	57	59	-1	2
20	Top Application Groups (Sent)			250	380	41	60	62	-1	2
21	Top Application Groups (Received)			250	380	41	63	65	-1	2
22	Top Hosts (Sent + Received)			250	380	41	66	68	-1	2
23	Top Hosts (Sent)			250	380	41	69	71	-1	2
24	Top Hosts (Received)			250	380	41	72	74	-1	2
25	Top Rules			250	380	41	75	77	-1	2
26	Top Protocol Groups (Sent + Received)			250	380	41	78	80	-1	2
27	Top Destinations  (Sent + Received)			250	380	41	81	83	-1	2
28	Top Users (Sent + Received)			250	380	41	84	86	-1	2
29	Top Rules			250	380	41	87	89	-1	2
30	Top Protocol Groups (Sent)			250	380	41	90	92	-1	2
31	Top Protocol Groups (Received)			250	380	41	93	95	-1	2
32	Top Destinations  (Sent)			250	380	41	96	98	-1	2
33	Top Destinations  (Received)			250	380	41	99	101	-1	2
34	Top Users (Sent)			250	380	41	102	104	-1	2
35	Top Users (Received)			250	380	41	105	107	-1	2
130010	Top Application			250	380	41	130011	130013	-1	2
130020	Top Destination			250	380	41	130021	130023	-1	2
130030	Top User			250	380	41	130031	130033	-1	2
140010	Top Destination			250	380	41	140011	140013	-1	2
140110	Top Application			250	380	41	140111	140113	-1	2
140210	Top Application			250	380	41	140211	140213	-1	2
150210	Top Destination			250	380	41	150211	150213	-1	2
131010	Top Application			250	380	41	131011	131013	-1	2
131020	Top User			250	380	41	131021	131023	-1	2
141010	Top User			250	380	41	141011	141013	-1	2
141110	Top Application			250	380	41	141111	141113	-1	2
132010	Top Application			250	380	41	132011	132013	-1	2
132020	Top Destination			250	380	41	132021	132023	-1	2
142010	Top Destination			250	380	41	142011	142013	-1	2
142110	Top Application			250	380	41	142111	142113	-1	2
134010	Top Application			250	380	41	134011	134013	-1	2
134020	Top Destination			250	380	41	134021	134023	-1	2
134030	Top User			250	380	41	134031	134033	-1	2
144010	Top Destination			250	380	41	144011	144013	-1	2
144110	Top Application			250	380	41	144111	144113	-1	2
144210	Top Application			250	380	41	144211	144213	-1	2
154210	Top Destination			250	380	41	154211	154213	-1	2
135010	Top Application			250	380	41	135011	135013	-1	2
135020	Top Destination			250	380	41	135021	135023	-1	2
135030	Top User			250	380	41	135031	135033	-1	2
145010	Top Destination			250	380	41	145011	145013	-1	2
145110	Top Application			250	380	41	145111	145113	-1	2
145210	Top Application			250	380	41	145211	145213	-1	2
155210	Top Destination			250	380	41	155211	155213	-1	2
136010	Top Application			250	380	41	136011	136013	-1	2
136020	Top User			250	380	41	136021	136023	-1	2
146010	Top User			250	380	41	146011	146013	-1	2
146110	Top Application			250	380	41	146111	146113	-1	2
137010	Top Application			250	380	41	137011	137013	-1	2
137020	Top User			250	380	41	137021	137023	-1	2
147010	Top User			250	380	41	147011	147013	-1	2
147110	Top Application			250	380	41	147111	147113	-1	2
138010	Top Application			250	380	41	138011	138013	-1	2
138020	Top Destination			250	380	41	138021	138023	-1	2
148010	Top Destination			250	380	41	148011	148013	-1	2
148110	Top Application			250	380	41	148111	148113	-1	2
139010	Top Application			250	380	41	139011	139013	-1	2
139020	Top Destination			250	380	41	139021	139023	-1	2
149010	Top Destination			250	380	41	149011	149013	-1	2
149110	Top Application			250	380	41	149111	149113	-1	2
1430010	Top Application (Sent + Received)			250	380	41	1430011	1430013	-1	2
1430020	Top Destination (Sent + Received)			250	380	41	1430021	1430023	-1	2
1430030	Top Host (Sent + Received)			250	380	41	1430031	1430033	-1	2
1440010	Top Destination (Sent + Received)			250	380	41	1440011	1440013	-1	2
1440110	Top Application (Sent + Received)			250	380	41	1440111	1440113	-1	2
1440210	Top Application (Sent + Received)			250	380	41	1440211	1440213	-1	2
1450010	Top Destination (Sent + Received)			250	380	41	1450011	1450013	-1	2
1431010	Top Application (Sent + Received)			250	380	41	1431011	1431013	-1	2
1431020	Top Host (Sent + Received)			250	380	41	1431021	1431023	-1	2
1441010	Top Host (Sent + Received)			250	380	41	1441011	1441013	-1	2
1441110	Top Application (Sent + Received)			250	380	41	1441111	1441113	-1	2
1432010	Top Application (Sent + Received)			250	380	41	1432011	1432013	-1	2
1432020	Top Destination (Sent + Received)			250	380	41	1432021	1432023	-1	2
1442010	Top Destination (Sent + Received)			250	380	41	1442011	1442013	-1	2
1442110	Top Application (Sent + Received)			250	380	41	1442111	1442113	-1	2
1434010	Top Application (Sent)			250	380	41	1434011	1434013	-1	2
1434020	Top Destination (Sent)			250	380	41	1434021	1434023	-1	2
1434030	Top Host (Sent)			250	380	41	1434031	1434033	-1	2
1444010	Top Destination (Sent)			250	380	41	1444011	1444013	-1	2
1444110	Top Application (Sent)			250	380	41	1444111	1444113	-1	2
1444210	Top Application (Sent)			250	380	41	1444211	1444213	-1	2
1454010	Top Destination (Sent)			250	380	41	1454011	1454013	-1	2
1435010	Top Application (Received)			250	380	41	1435011	1435013	-1	2
1435020	Top Destination (Received)			250	380	41	1435021	1435023	-1	2
1435030	Top Host (Received)			250	380	41	1435031	1435033	-1	2
1445010	Top Destination (Received)			250	380	41	1445011	1445013	-1	2
1445110	Top Application (Received)			250	380	41	1445111	1445113	-1	2
1445210	Top Application (Received)			250	380	41	1445211	1445213	-1	2
1455010	Top Destination (Received)			250	380	41	1455011	1455013	-1	2
1436010	Top Application (Sent)			250	380	41	1436011	1436013	-1	2
1436020	Top Host (Sent)			250	380	41	1436021	1436023	-1	2
1446010	Top Host (Sent)			250	380	41	1446011	1446013	-1	2
1446110	Top Application (Sent)			250	380	41	1446111	1446113	-1	2
1437010	Top Application (Received)			250	380	41	1437011	1437013	-1	2
1437020	Top Host (Received)			250	380	41	1437021	1437023	-1	2
1447010	Top Host (Received)			250	380	41	1447011	1447013	-1	2
1447110	Top Application (Received)			250	380	41	1447111	1447113	-1	2
1438010	Top Application (Sent)			250	380	41	1438011	1438013	-1	2
1438020	Top Destination (Sent)			250	380	41	1438021	1438023	-1	2
1448010	Top Destination (Sent)			250	380	41	1448011	1448013	-1	2
1448110	Top Application (Sent)			250	380	41	1448111	1448113	-1	2
1439010	Top Application (Received)			250	380	41	1439011	1439013	-1	2
1439020	Top Destination (Received)			250	380	41	1439021	1439023	-1	2
1449010	Top Destination (Received)			250	380	41	1449011	1449013	-1	2
1449110	Top Application (Received)			250	380	41	1449111	1449113	-1	2
1530010	Top User (Sent + Received)			250	380	41	1530011	1530013	-1	2
1530020	Top Destination (Sent + Received)			250	380	41	1530021	1530023	-1	2
1530030	Top Host (Sent + Received)			250	380	41	1530031	1530033	-1	2
1540010	Top Destination (Sent + Received)			250	380	41	1540011	1540013	-1	2
1540020	Top Host (Sent + Received)			250	380	41	1540021	1540023	-1	2
1540110	Top User (Sent + Received)			250	380	41	1540111	1540113	-1	2
1540120	Top Host (Sent + Received)			250	380	41	1540121	1540123	-1	2
1540210	Top Destination (Sent + Received)			250	380	41	1540211	1540213	-1	2
1540220	Top User (Sent + Received)			250	380	41	1540221	1540223	-1	2
1531010	Top Application (Sent + Received)			250	380	41	1531011	1531013	-1	2
1531020	Top Destination (Sent + Received)			250	380	41	1531021	1531023	-1	2
1531030	Top Host (Sent + Received)			250	380	41	1531031	1531033	-1	2
1541010	Top Destination (Sent + Received)			250	380	41	1541011	1541013	-1	2
1541020	Top Host (Sent + Received)			250	380	41	1541021	1541023	-1	2
1541110	Top Application (Sent + Received)			250	380	41	1541111	1541113	-1	2
1541120	Top Host (Sent + Received)			250	380	41	1541121	1541123	-1	2
1541210	Top Application (Sent + Received)			250	380	41	1541211	1541213	-1	2
1541220	Top Destination (Sent + Received)			250	380	41	1541221	1541223	-1	2
1551010	Top Destination (Sent + Received)			250	380	41	1551011	1551013	-1	2
1551110	Top Application (Sent + Received)			250	380	41	1551111	1551113	-1	2
1532010	Top Application (Sent + Received)			250	380	41	1532011	1532013	-1	2
1532020	Top User (Sent + Received)			250	380	41	1532021	1532023	-1	2
1532030	Top Host (Sent + Received)			250	380	41	1532031	1532033	-1	2
1542010	Top User (Sent + Received)			250	380	41	1542011	1542013	-1	2
1542020	Top Host (Sent + Received)			250	380	41	1542021	1542023	-1	2
1542110	Top Application (Sent + Received)			250	380	41	1542111	1542113	-1	2
1542120	Top Host (Sent + Received)			250	380	41	1542121	1542123	-1	2
1542210	Top Application (Sent + Received)			250	380	41	1542211	1542213	-1	2
1542220	Top User (Sent + Received)			250	380	41	1542221	1542223	-1	2
1533010	Top Application (Sent + Received)			250	380	41	1533011	1533013	-1	2
1533020	Top Destination (Sent + Received)			250	380	41	1533021	1533023	-1	2
1533030	Top User (Sent + Received)			250	380	41	1533031	1533033	-1	2
1543010	Top Destination (Sent + Received)			250	380	41	1543011	1543013	-1	2
1543020	Top User (Sent + Received)			250	380	41	1543021	1543023	-1	2
1543110	Top Application (Sent + Received)			250	380	41	1543111	1543113	-1	2
1543120	Top User (Sent + Received)			250	380	41	1543121	1543123	-1	2
1543210	Top Application (Sent + Received)			250	380	41	1543211	1543213	-1	2
1543220	Top Destination (Sent + Received)			250	380	41	1543221	1543223	-1	2
1553010	Top Destination (Sent + Received)			250	380	41	1553011	1553013	-1	2
1553110	Top Application (Sent + Received)			250	380	41	1553111	1553113	-1	2
1534010	Top User (Sent)			250	380	41	1534011	1534013	-1	2
1534020	Top Destination (Sent)			250	380	41	1534021	1534023	-1	2
1534030	Top Host (Sent)			250	380	41	1534031	1534033	-1	2
1544010	Top Destination (Sent)			250	380	41	1544011	1544013	-1	2
1544020	Top Host (Sent)			250	380	41	1544021	1544023	-1	2
1544110	Top User (Sent)			250	380	41	1544111	1544113	-1	2
1544120	Top Host (Sent)			250	380	41	1544121	1544123	-1	2
1544210	Top Destination (Sent)			250	380	41	1544211	1544213	-1	2
1544220	Top User (Sent)			250	380	41	1544221	1544223	-1	2
1535010	Top User (Received)			250	380	41	1535011	1535013	-1	2
1535020	Top Destination (Received)			250	380	41	1535021	1535023	-1	2
1535030	Top Host (Received)			250	380	41	1535031	1535033	-1	2
1545010	Top Destination (Received)			250	380	41	1545011	1545013	-1	2
1545020	Top Host (Received)			250	380	41	1545021	1545023	-1	2
1545110	Top User (Received)			250	380	41	1545111	1545113	-1	2
1545120	Top Host (Received)			250	380	41	1545121	1545123	-1	2
1545210	Top Destination (Received)			250	380	41	1545211	1545213	-1	2
1545220	Top User (Received)			250	380	41	1545221	1545223	-1	2
1536010	Top Application (Sent)			250	380	41	1536011	1536013	-1	2
1536020	Top Destination (Sent)			250	380	41	1536021	1536023	-1	2
1536030	Top Host (Sent)			250	380	41	1536031	1536033	-1	2
1546010	Top Destination (Sent)			250	380	41	1546011	1546013	-1	2
1546020	Top Host (Sent)			250	380	41	1546021	1546023	-1	2
1546110	Top Application (Sent)			250	380	41	1546111	1546113	-1	2
1546120	Top Host (Sent)			250	380	41	1546121	1546123	-1	2
1546210	Top Application (Sent)			250	380	41	1546211	1546213	-1	2
1546220	Top Destination (Sent)			250	380	41	1546221	1546223	-1	2
1556010	Top Destination (Sent)			250	380	41	1556011	1556013	-1	2
1556110	Top Application (Sent)			250	380	41	1556111	1556113	-1	2
1537010	Top Application (Received)			250	380	41	1537011	1537013	-1	2
1537020	Top Destination (Received)			250	380	41	1537021	1537023	-1	2
1537030	Top Host (Received)			250	380	41	1537031	1537033	-1	2
1547010	Top Destination (Received)			250	380	41	1547011	1547013	-1	2
1547020	Top Host (Received)			250	380	41	1547021	1547023	-1	2
1547110	Top Application (Received)			250	380	41	1547111	1547113	-1	2
1547120	Top Host (Received)			250	380	41	1547121	1547123	-1	2
1547210	Top Application (Received)			250	380	41	1547211	1547213	-1	2
1547220	Top Destination (Received)			250	380	41	1547221	1547223	-1	2
1557010	Top Destination (Received)			250	380	41	1557011	1557013	-1	2
1557110	Top Application (Received)			250	380	41	1557111	1557113	-1	2
1538010	Top Application (Sent)			250	380	41	1538011	1538013	-1	2
1538020	Top User (Sent)			250	380	41	1538021	1538023	-1	2
1538030	Top Host (Sent)			250	380	41	1538031	1538033	-1	2
1548010	Top User (Sent)			250	380	41	1548011	1548013	-1	2
1548020	Top Host (Sent)			250	380	41	1548021	1548023	-1	2
1548110	Top Application (Sent)			250	380	41	1548111	1548113	-1	2
1548120	Top Host (Sent)			250	380	41	1548121	1548123	-1	2
1548210	Top Application (Sent)			250	380	41	1548211	1548213	-1	2
1548220	Top User (Sent)			250	380	41	1548221	1548223	-1	2
1539010	Top Application (Received)			250	380	41	1539011	1539013	-1	2
1539020	Top User (Received)			250	380	41	1539021	1539023	-1	2
1539030	Top Host (Received)			250	380	41	1539031	1539033	-1	2
1549010	Top User (Received)			250	380	41	1549011	1549013	-1	2
1549020	Top Host (Received)			250	380	41	1549021	1549023	-1	2
1549110	Top Application (Received)			250	380	41	1549111	1549113	-1	2
1549120	Top Host (Received)			250	380	41	1549121	1549123	-1	2
1549210	Top Application (Received)			250	380	41	1549211	1549213	-1	2
1549220	Top User (Received)			250	380	41	1549221	1549223	-1	2
15310010	Top Application (Sent + Received)			250	380	41	15310011	15310013	-1	2
15310020	Top Destination (Sent + Received)			250	380	41	15310021	15310023	-1	2
15310030	Top User (Sent + Received)			250	380	41	15310031	15310033	-1	2
15410010	Top Destination (Sent + Received)			250	380	41	15410011	15410013	-1	2
15410020	Top User (Sent + Received)			250	380	41	15410021	15410023	-1	2
15410110	Top Application (Sent + Received)			250	380	41	15410111	15410113	-1	2
15410120	Top User (Sent + Received)			250	380	41	15410121	15410123	-1	2
15410210	Top Application (Sent + Received)			250	380	41	15410211	15410213	-1	2
15410220	Top Destination (Sent + Received)			250	380	41	15410221	15410223	-1	2
15510010	Top Destination (Sent + Received)			250	380	41	15510011	15510013	-1	2
15510110	Top Application (Sent + Received)			250	380	41	15510111	15510113	-1	2
15311010	Top Application (Sent + Received)			250	380	41	15311011	15311013	-1	2
15311020	Top Destination (Sent + Received)			250	380	41	15311021	15311023	-1	2
15311030	Top User (Sent + Received)			250	380	41	15311031	15311033	-1	2
15411010	Top Destination (Sent + Received)			250	380	41	15411011	15411013	-1	2
15411020	Top User (Sent + Received)			250	380	41	15411021	15411023	-1	2
15411110	Top Application (Sent + Received)			250	380	41	15411111	15411113	-1	2
15411120	Top User (Sent + Received)			250	380	41	15411121	15411123	-1	2
15411210	Top Application (Sent + Received)			250	380	41	15411211	15411213	-1	2
15411220	Top Destination (Sent + Received)			250	380	41	15411221	15411223	-1	2
15511010	Top Destination (Sent + Received)			250	380	41	15511011	15511013	-1	2
15511110	Top Application (Sent + Received)			250	380	41	15511111	15511113	-1	2
20101100	Top Destinations  (Sent + Received)			250	380	41	20101101	20101103	-1	2
20101200	Top Hosts (Sent + Received)			250	380	41	20101201	20101203	-1	2
20102100	Top Users (Sent + Received)			250	380	41	20102101	20102103	-1	2
20102200	Top Hosts (Sent + Received)			250	380	41	20102201	20102203	-1	2
20103100	Top Destinations  (Sent + Received)			250	380	41	20103101	20103103	-1	2
20103200	Top Users (Sent + Received)			250	380	41	20103201	20103203	-1	2
20201100	Top Destinations  (Sent)			250	380	41	20201101	20201103	-1	2
20201200	Top Hosts (Sent)			250	380	41	20201201	20201203	-1	2
20202100	Top Users (Sent)			250	380	41	20202101	20202103	-1	2
20202200	Top Hosts (Sent)			250	380	41	20202201	20202203	-1	2
20203100	Top Destinations  (Sent)			250	380	41	20203101	20203103	-1	2
20203200	Top Users (Sent)			250	380	41	20203201	20203203	-1	2
20301100	Top Destinations  (Received)			250	380	41	20301101	20301103	-1	2
20301200	Top Hosts (Received)			250	380	41	20301201	20301203	-1	2
20302100	Top Users (Received)			250	380	41	20302101	20302103	-1	2
20302200	Top Hosts (Received)			250	380	41	20302201	20302203	-1	2
20303100	Top Destinations  (Received)			250	380	41	20303101	20303103	-1	2
20303200	Top Users (Received)			250	380	41	20303201	20303203	-1	2
1420000	Top Protocol Groups (Sent + Received)			250	380	41	1420001	1420003	-1	2
1420010	Top Destinations  (Sent + Received)			250	380	41	1420011	1420013	-1	2
1420020	Top Hosts (Sent + Received)			250	380	41	1420021	1420023	-1	2
1420030	Top Rules			250	380	41	1420031	1420033	-1	2
1420040	Top Protocol Groups (Sent)			250	380	41	1420041	1420043	-1	2
1420050	Top Protocol Groups (Received)			250	380	41	1420051	1420053	-1	2
1420060	Top Destinations  (Sent)			250	380	41	1420061	1420063	-1	2
1420070	Top Destinations  (Received)			250	380	41	1420071	1420073	-1	2
1420080	Top Hosts (Sent)			250	380	41	1420081	1420083	-1	2
1420090	Top Hosts (Received)			250	380	41	1420091	1420093	-1	2
1520000	Top Protocol (Sent + Received)			250	380	41	1520001	1520003	-1	2
1520010	Top Users (Sent + Received)			250	380	41	1520011	1520013	-1	2
1520020	Top Destinations  (Sent + Received)			250	380	41	1520021	1520023	-1	2
1520030	Top Hosts (Sent + Received)			250	380	41	1520031	1520033	-1	2
1520040	Top Rules			250	380	41	1520041	1520043	-1	2
1520050	Top Protocol (Sent)			250	380	41	1520051	1520053	-1	2
1520060	Top Protocol (Received)			250	380	41	1520061	1520063	-1	2
1520070	Top Users (Sent)			250	380	41	1520071	1520073	-1	2
1520080	Top Users (Received)			250	380	41	1520081	1520083	-1	2
1520090	Top Destinations  (Sent)			250	380	41	1520091	1520093	-1	2
1520100	Top Destinations  (Received)			250	380	41	1520101	1520103	-1	2
1520110	Top Hosts (Sent)			250	380	41	1520111	1520113	-1	2
1520120	Top Hosts (Received)			250	380	41	1520121	1520123	-1	2
59	 	 		250	380	41	210	215	-1	2
20701000	Top Protocol (Sent + Received)			250	380	41	20701001	20701003	-1	2
20702000	Top Destinations  (Sent + Received)			250	380	41	20702001	20702003	-1	2
20703000	Top Users (Sent + Received)			250	380	41	20703001	20703003	-1	2
20801000	Top Protocol (Sent)			250	380	41	20801001	20801003	-1	2
20802000	Top Destinations  (Sent)			250	380	41	20802001	20802003	-1	2
20803000	Top Users (Sent)			250	380	41	20803001	20803003	-1	2
20901000	Top Protocol (Received)			250	380	41	20901001	20901003	-1	2
20902000	Top Destinations  (Received)			250	380	41	20902001	20902003	-1	2
20903000	Top Users (Received)			250	380	41	20903001	20903003	-1	2
20401000	Top Protocol (Sent + Received)			250	380	41	20401001	20401003	-1	2
20402000	Top Destinations  (Sent + Received)			250	380	41	20402001	20402003	-1	2
20403000	Top Hosts (Sent + Received)			250	380	41	20403001	20403003	-1	2
20501000	Top Protocol (Sent)			250	380	41	20501001	20501003	-1	2
20502000	Top Destinations  (Sent)			250	380	41	20502001	20502003	-1	2
20503000	Top Hosts (Sent)			250	380	41	20503001	20503003	-1	2
20601000	Top Hosts (Received)			250	380	41	20601001	20601003	-1	2
20602000	Top Protocol (Received)			250	380	41	20602001	20602003	-1	2
20603000	Top Destinations  (Received)			250	380	41	20603001	20603003	-1	2
20100000	Top Applications (Sent + Received)			250	380	41	20100001	20100003	-1	2
20200000	Top Applications (Sent)			250	380	41	20200001	20200003	-1	2
20300000	Top Applications (Received)			250	380	41	20300001	20300003	-1	2
20400000	Top Users Per Protocol Group(Sent + Received)			250	380	41	20400001	20400004	-1	2
20500000	Top Users Per Protocol Group (Sent)			250	380	41	20500001	20500004	-1	2
20600000	Top Users Per Protocol Group (Received)			250	380	41	20600001	20600004	-1	2
20700000	Top Hosts Per Protocol Group (Sent + Received)			250	380	41	20700001	20700004	-1	2
20800000	Top Hosts Per Protocol Group (Sent)			250	380	41	20800001	20800004	-1	2
20900000	Top Hosts Per Protocol Group (Received)			250	380	41	20900001	20900004	-1	2
20101000	Top Users (Sent + Received)			250	380	41	20101001	20101003	-1	2
20102000	Top Destinations  (Sent + Received)			250	380	41	20102001	20102003	-1	2
20103000	Top Hosts (Sent + Received)			250	380	41	20103001	20103003	-1	2
20201000	Top Users (Sent)			250	380	41	20201001	20201003	-1	2
20202000	Top Destinations  (Sent)			250	380	41	20202001	20202003	-1	2
20203000	Top Hosts (Sent)			250	380	41	20203001	20203003	-1	2
20301000	Top Users (Received)			250	380	41	20301001	20301003	-1	2
20302000	Top Destinations  (Received)			250	380	41	20302001	20302003	-1	2
20303000	Top Hosts (Received)			250	380	41	20303001	20303003	-1	2
119	Top Accept Rules			250	380	41	369	371	-1	2
120	Top Deny Rules			250	380	41	372	373	-1	2
121	Top Accept Rules - Protocol Group Wise			250	380	41	375	378	-1	2
122	Top Deny Rules - Protocol Group Wise			250	380	41	379	381	-1	2
123	Top Accept Rules - Host Wise			250	380	41	383	386	-1	2
124	Top Deny Rules - Host Wise			250	380	41	387	389	-1	2
125	Top Accept Rules - Destination Wise			250	380	41	391	394	-1	2
126	Top Deny Rules - Destination Wise			250	380	41	395	397	-1	2
127	 			250	380	41	399	403	-1	2
128	 			250	380	41	404	408	-1	2
129				250	380	41	409	413	-1	2
130				250	380	41	414	418	-1	2
131	 			250	380	41	419	422	-1	2
132	 			250	380	41	423	426	-1	2
133	 			250	380	41	427	430	-1	2
134	 			250	380	41	431	434	-1	2
135	Procedure Logs			250	400	3	438	439	-1	6
1001	Allowed Traffic Overview			250	400	121	10011	10012	10013	4
1002	Denied Traffic Overview			250	400	121	10021	10022	10023	5
1003	Allowed Traffic Summary			200	200	21	10031	10032	-1	3
1004	Denied Traffic Summary			200	200	21	10041	10042	-1	3
1005	Web Traffic Summary			200	200	21	10051	10052	-1	3
1006	Mail Traffic Summary			200	200	21	10061	10062	-1	3
1007	FTP Traffic Summary			200	200	21	10071	10072	-1	3
1008	Virus Summary			200	200	21	10081	10082	-1	3
1009	Spam Summary			200	200	21	10091	10092	-1	3
1010	IDP Attacks Summary			200	200	21	10101	10102	-1	3
1011	Firewall Denied Summary			200	200	21	10111	10112	-1	3
1012	Content Filtering Denied Summary			200	200	21	10121	10122	-1	3
801010	 			250	380	41	801011	801014	-1	2
802010	 			250	380	41	802011	802014	-1	2
803010	 			250	380	41	803011	803014	-1	2
804010	 			250	380	41	804011	804014	-1	2
805010	 			250	380	41	805011	805014	-1	2
806010	 			250	380	41	806011	806014	-1	2
901010	 			250	380	41	901011	901017	-1	2
902010	 			250	380	41	902011	902017	-1	2
903010	 			250	380	41	903011	903017	-1	2
904010	 			250	380	41	904011	904016	-1	2
905010	 			250	380	41	905011	905017	-1	2
1201010	Firewall Allowed			250	380	41	435	437	-1	2
1202010	Firewall Denied			250	380	41	1202011	1202012	-1	2
1203010	Web Usage			250	380	41	1203011	1203013	-1	2
1204010	Web Surfing Denied			250	380	41	1204011	1204013	-1	2
1205010	IPS			250	380	41	1205011	1205012	-1	2
1206010	Top Spam			250	380	41	1206011	1206012	-1	2
1207010	Mail Usage			250	380	41	1207011	1207013	-1	2
1208010	FTP Usage			250	380	41	1208011	1208013	-1	2
1209010	Virus			250	380	41	1209011	1209012	-1	2
4400000	Top Content			250	380	41	4400001	4400003	-1	2
4410000	Top Domain			250	380	41	4410001	4410003	-1	2
4420000	Top Users			250	380	41	4420001	4420003	-1	2
4430000	Top Category			250	380	41	4430001	4430003	-1	2
4411000	Top Users			250	380	41	4411001	4411003	-1	2
4411100	Top URLs			250	380	41	4411101	4411103	-1	2
4421000	Top Domain			250	380	41	4421001	4421003	-1	2
4422000	Top Category			250	380	41	4422001	4422003	-1	2
4421100	Top URLs			250	380	41	4421101	4421103	-1	2
4422100	Top Domain			250	380	41	4422101	4422103	-1	2
4422110	Top URLs			250	380	41	4422111	4422113	-1	2
4431000	Top Users			250	380	41	4431001	4431003	-1	2
4432000	Top Domain			250	380	41	4432001	4432003	-1	2
4431100	Top Domain			250	380	41	4431101	4431103	-1	2
4431110	Top URLs			250	380	41	4431111	4431113	-1	2
4432100	Top URLs			250	380	41	4432101	4432103	-1	2
4500000	Top Web Hosts			250	380	41	4500001	4500003	-1	2
4510000	Top Categories			250	380	41	4510001	4510003	-1	2
4511000	Top Domains			250	380	41	4511001	4511003	-1	2
4511100	Top URLs			250	380	41	4511101	4511103	-1	2
4520000	Top Domains			250	380	41	4520001	4520003	-1	2
4530000	Top Contents			250	380	41	4530001	4530003	-1	2
4540000	Top URLs			250	380	41	4540001	4540003	-1	2
4550000	Top Web Users			250	380	41	4550001	4550003	-1	2
4521000	Top URLs			250	380	41	4521001	4521003	-1	2
4531000	Top Domains			250	380	41	4531001	4531003	-1	2
4531100	Top URLs			250	380	41	4531101	4531103	-1	2
4551000	Top Categories			250	380	41	4551001	4551003	-1	2
4552000	Top Domains			250	380	41	4552001	4552003	-1	2
4553000	Top Contents			250	380	41	4553001	4553003	-1	2
4551100	Top Domains			250	380	41	4551101	4551103	-1	2
4551110	Top URLs			250	380	41	4551111	4551113	-1	2
4552100	Top URLs			250	380	41	4552101	4552103	-1	2
4553100	Top Domains			250	380	41	4553101	4553103	-1	2
4553110	Top URLs			250	380	41	4553111	4553113	-1	2
4554000	Top URLs			250	380	41	4554001	4554003	-1	2
4555000	Top Application			250	380	41	4555001	4555003	-1	2
4555100	Top Categories			250	380	41	4555101	4555103	-1	2
4555110	Top Domains			250	380	41	4555111	4555113	-1	2
45551110	Top URLs			250	380	41	45551111	45551113	-1	2
4555200	Top Contents			250	380	41	4555201	4555203	-1	2
4555210	Top Domains			250	380	41	4555211	4555213	-1	2
45552110	Top URLs			250	380	41	45552111	45552113	-1	2
4560000	Top Application			250	380	41	4560001	4560003	-1	2
4561000	Top Categories			250	380	41	4561001	4561003	-1	2
4561100	Top Domains			250	380	41	4561101	4561103	-1	2
4561110	Top URLs			250	380	41	4561111	4561113	-1	2
4562000	Top Contents			250	380	41	4562001	4562003	-1	2
4562100	Top Domains			250	380	41	4562101	4562103	-1	2
4562110	Top URLs			250	380	41	4562111	4562113	-1	2
46000000	Top Applications			250	380	41	46000001	46000003	-1	2
46100000	Top Categories			250	380	41	46100001	46100003	-1	2
46110000	Top Domains			250	380	41	46110001	46110003	-1	2
46111000	Top Users			250	380	41	46111001	46111003	-1	2
46111100	Top URLs			250	380	41	46111101	46111103	-1	2
46112000	Top Contents			250	380	41	46112001	46112003	-1	2
46112100	Top Users			250	380	41	46112101	46112103	-1	2
46112110	Top URLs			250	380	41	46121101	46121103	-1	2
46120000	Top Users			250	380	41	46120001	46120003	-1	2
46121000	Top Domains			250	380	41	46121001	46121003	-1	2
46121100	Top URLs			250	380	41	46121101	46121103	-1	2
46122000	Top Contents			250	380	41	46122001	46122003	-1	2
46122100	Top Domains			250	380	41	46122101	46122103	-1	2
46122110	Top URLs			250	380	41	46122111	46122113	-1	2
46130000	Top Contents			250	380	41	46130001	46130003	-1	2
46131000	Top Users			250	380	41	46131001	46131003	-1	2
46131100	Top Domains			250	380	41	46131101	46131103	-1	2
46131110	Top URLs			250	380	41	46131111	46131113	-1	2
46132000	Top Domains			250	380	41	46132001	46132003	-1	2
46132100	Top Users			250	380	41	46132101	46132103	-1	2
46132110	Top URLs			250	380	41	46132111	46132113	-1	2
46200000	Top Domains			250	380	41	46200001	46200003	-1	2
46210000	Top Users			250	380	41	46210001	46210003	-1	2
46211000	Top URLs			250	380	41	46211001	46211003	-1	2
46220000	Top Contents			250	380	41	46220001	46220003	-1	2
46221000	Top Users			250	380	41	46221001	46221003	-1	2
46221100	Top URLs			250	380	41	46221101	46221103	-1	2
46300000	Top Web Users			250	380	41	46300001	46300003	-1	2
46310000	Top Categories			250	380	41	46310001	46310003	-1	2
46320000	Top Domains			250	380	41	46320001	46320003	-1	2
46330000	Top Contents			250	380	41	46330001	46330003	-1	2
46340000	Top URLs			250	380	41	46340001	46340003	-1	2
46311000	Top Domains			250	380	41	46311001	46311003	-1	2
46311100	Top URLs			250	380	41	46311101	46311103	-1	2
46321000	Top URLs			250	380	41	46321001	46321003	-1	2
46331000	Top Domains			250	380	41	46331001	46331003	-1	2
46331100	Top URLs			250	380	41	46331101	46331103	-1	2
46400000	Top Contents			250	380	41	46400001	46400003	-1	2
46410000	Top Domains			250	380	41	46410001	46410003	-1	2
46411000	Top Users			250	380	41	46411001	46411003	-1	2
46411100	Top URLs			250	380	41	46411101	46411103	-1	2
46420000	Top Users			250	380	41	46420001	46420003	-1	2
46421000	Top Domains			250	380	41	46421001	46421003	-1	2
46421100	Top URLs			250	380	41	46421101	46421103	-1	2
46422000	Top Categories			250	380	41	46422001	46422003	-1	2
46422100	Top Domains			250	380	41	46422101	46422103	-1	2
46422110	Top URLs			250	380	41	46422111	46422113	-1	2
46430000	Top Categories			250	380	41	46430001	46430003	-1	2
46431000	Top Users			250	380	41	46431001	46431003	-1	2
46431100	Top Domains			250	380	41	46431101	46431103	-1	2
46431110	Top URLs			250	380	41	46431111	46431113	-1	2
46432000	Top Domains			250	380	41	46432001	46432003	-1	2
46432100	Top URLs			250	380	41	46432101	46432103	-1	2
4100000	Top Web Users			250	380	41	41000001	41000003	-1	2
4110000	Top Categories			250	380	41	41100001	41100003	-1	2
4120000	Top Domains			250	380	41	41200001	41200003	-1	2
4130000	Top Contents			250	380	41	41300001	41300003	-1	2
4140000	Top URLs			250	380	41	41400001	41400003	-1	2
4150000	Top Hosts			250	380	41	41500001	41500003	-1	2
4160000	Top Applications			250	380	41	41600001	41600003	-1	2
4111000	Top Domains			250	380	41	41110001	41110003	-1	2
4111100	Top URLs			250	380	41	41111001	41111003	-1	2
4121000	Top URLs			250	380	41	41210001	41210003	-1	2
4131000	Top Domains			250	380	41	41310001	41310003	-1	2
4131100	Top URLs			250	380	41	41311001	41311003	-1	2
4151000	Top Categories			250	380	41	41510001	41510003	-1	2
4152000	Top Domains			250	380	41	41520001	41520003	-1	2
4153000	Top Contents			250	380	41	41530001	41530003	-1	2
4154000	Top URLs			250	380	41	41540001	41540003	-1	2
4155000	Top Applications			250	380	41	41550001	41550003	-1	2
4151100	Top Domains			250	380	41	41511001	41511003	-1	2
4151110	Top URLs			250	380	41	41511101	41511103	-1	2
4152100	Top URLs			250	380	41	41521001	41521003	-1	2
4153100	Top Domains			250	380	41	41531001	41531003	-1	2
4153110	Top URLs			250	380	41	41531101	41531103	-1	2
4155100	Top Categories			250	380	41	41551001	41551003	-1	2
4155200	Top Contents			250	380	41	41552001	41552003	-1	2
4155110	Top Domains			250	380	41	41551101	41551103	-1	2
4155111	Top URLs			250	380	41	41551111	41551113	-1	2
4155210	Top Domains			250	380	41	41552101	41552103	-1	2
4155211	Top URLs			250	380	41	41552111	41552113	-1	2
4161000	Top Categories			250	380	41	41610001	41610003	-1	2
4162000	Top Contents			250	380	41	41620001	41620003	-1	2
4161100	Top Domains			250	380	41	41611001	41611003	-1	2
4161110	Top URLs			250	380	41	41611101	41611103	-1	2
4162100	Top Domains			250	380	41	41621001	41621003	-1	2
4162110	Top URLs			250	380	41	41621101	41621103	-1	2
4200000	Top Categories			250	380	41	42000001	42000003	-1	2
4210000	Top Domains			250	380	41	42100001	42100003	-1	2
4220000	Top Users			250	380	41	42200001	42200003	-1	2
4230000	Top Contents			250	380	41	42300001	42300003	-1	2
4211000	Top Users			250	380	41	42110001	42110003	-1	2
4211100	Top URLs			250	380	41	42111001	42111003	-1	2
4212000	Top Contents			250	380	41	42120001	42120003	-1	2
4212100	Top Users			250	380	41	42121001	42121003	-1	2
4212110	Top URLs			250	380	41	42121101	42121103	-1	2
4221000	Top Domains			250	380	41	42210001	42210003	-1	2
4221100	Top URLs			250	380	41	42211001	42211003	-1	2
4222000	Top Contents			250	380	41	42220001	42220003	-1	2
4222100	Top Domains			250	380	41	42221001	42221003	-1	2
4222110	Top URLs			250	380	41	42221101	42221103	-1	2
4231000	Top Users			250	380	41	42310001	42310003	-1	2
4231100	Top Domains			250	380	41	42311001	42311003	-1	2
4231110	Top URLs			250	380	41	42311101	42311103	-1	2
4232000	Top Domains			250	380	41	42320001	42320003	-1	2
4232100	Top Users			250	380	41	42321001	42321003	-1	2
4232110	Top URLs			250	380	41	42321101	42321103	-1	2
4300000	Top Domains			250	380	41	43000001	43000003	-1	2
4310000	Top Users			250	380	41	43100001	43100003	-1	2
4320000	Top Contents			250	380	41	43200001	43200003	-1	2
4311000	Top URLs			250	380	41	43110001	43110003	-1	2
4321000	Top Users			250	380	41	43210001	43210003	-1	2
4321100	Top URLs			250	380	41	43211001	43211003	-1	2
41000000	Top Web Users			250	380	41	41000001	41000003	-1	2
41100000	Top Categories			250	380	41	41100001	41100003	-1	2
41200000	Top Domains			250	380	41	41200001	41200003	-1	2
41300000	Top Contents			250	380	41	41300001	41300003	-1	2
41400000	Top URLs			250	380	41	41400001	41400003	-1	2
41500000	Top Hosts			250	380	41	41500001	41500003	-1	2
41600000	Top Applications			250	380	41	41600001	41600003	-1	2
41110000	Top Domains			250	380	41	41110001	41110003	-1	2
41111000	Top URLs			250	380	41	41111001	41111003	-1	2
41210000	Top URLs			250	380	41	41210001	41210003	-1	2
41310000	Top Domains			250	380	41	41310001	41310003	-1	2
41311000	Top URLs			250	380	41	41311001	41311003	-1	2
41510000	Top Categories			250	380	41	41510001	41510003	-1	2
41520000	Top Domains			250	380	41	41520001	41520003	-1	2
41530000	Top Contents			250	380	41	41530001	41530003	-1	2
41540000	Top URLs			250	380	41	41540001	41540003	-1	2
41550000	Top Applications			250	380	41	41550001	41550003	-1	2
41511000	Top Domains			250	380	41	41511001	41511003	-1	2
41511100	Top URLs			250	380	41	41511101	41511103	-1	2
41521000	Top URLs			250	380	41	41521001	41521003	-1	2
41531000	Top Domains			250	380	41	41531001	41531003	-1	2
41531100	Top URLs			250	380	41	41531101	41531103	-1	2
41551000	Top Categories			250	380	41	41551001	41551003	-1	2
41552000	Top Contents			250	380	41	41552001	41552003	-1	2
41551100	Top Domains			250	380	41	41551101	41551103	-1	2
41551110	Top URLs			250	380	41	41551111	41551113	-1	2
41552100	Top Domains			250	380	41	41552101	41552103	-1	2
41552110	Top URLs			250	380	41	41552111	41552113	-1	2
41610000	Top Categories			250	380	41	41610001	41610003	-1	2
41620000	Top Contents			250	380	41	41620001	41620003	-1	2
41611000	Top Domains			250	380	41	41611001	41611003	-1	2
41611100	Top URLs			250	380	41	41611101	41611103	-1	2
41621000	Top Domains			250	380	41	41621001	41621003	-1	2
41621100	Top URLs			250	380	41	41621101	41621103	-1	2
42000000	Top Categories			250	380	41	42000001	42000003	-1	2
42100000	Top Domains			250	380	41	42100001	42100003	-1	2
42200000	Top Users			250	380	41	42200001	42200003	-1	2
42300000	Top Contents			250	380	41	42300001	42300003	-1	2
42110000	Top Users			250	380	41	42110001	42110003	-1	2
42111000	Top URLs			250	380	41	42111001	42111003	-1	2
42120000	Top Contents			250	380	41	42120001	42120003	-1	2
42121000	Top Users			250	380	41	42121001	42121003	-1	2
42121100	Top URLs			250	380	41	42121101	42121103	-1	2
42210000	Top Domains			250	380	41	42210001	42210003	-1	2
42211000	Top URLs			250	380	41	42211001	42211003	-1	2
42220000	Top Contents			250	380	41	42220001	42220003	-1	2
42221000	Top Domains			250	380	41	42221001	42221003	-1	2
42221100	Top URLs			250	380	41	42221101	42221103	-1	2
42310000	Top Users			250	380	41	42310001	42310003	-1	2
42311000	Top Domains			250	380	41	42311001	42311003	-1	2
42311100	Top URLs			250	380	41	42311101	42311103	-1	2
42320000	Top Domains			250	380	41	42320001	42320003	-1	2
42321000	Top Users			250	380	41	42321001	42321003	-1	2
42321100	Top URLs			250	380	41	42321101	42321103	-1	2
43000000	Top Domains			250	380	41	43000001	43000003	-1	2
43100000	Top Users			250	380	41	43100001	43100003	-1	2
43200000	Top Contents			250	380	41	43200001	43200003	-1	2
43110000	Top URLs			250	380	41	43110001	43110003	-1	2
43210000	Top Users			250	380	41	43210001	43210003	-1	2
43211000	Top URLs			250	380	41	43211001	43211003	-1	2
7100000	Top Denied Users			250	380	41	7100001	7100002	-1	2
7200000	Top Denied Application Groups			250	380	41	7200001	7200002	-1	2
7300000	Top Denied Hosts			250	380	41	7300001	7300002	-1	2
7400000	Top Denied Destinations			250	380	41	7400001	7400002	-1	2
7110000	Top Application Groups			250	380	41	7110001	7110002	-1	2
7111000	Top Applications			250	380	41	7111001	7111002	-1	2
7111100	Top Destinations			250	380	41	7111101	7111102	-1	2
7112000	Top Destinations			250	380	41	7112001	7112002	-1	2
7112100	Top Applications			250	380	41	7112101	7112102	-1	2
7113000	Top Hosts			250	380	41	7113001	7113002	-1	2
7113100	Top Applications			250	380	41	7113101	7113102	-1	2
7113110	Top Destinations			250	380	41	7113111	7113112	-1	2
7120000	Top Destinations			250	380	41	7120001	7120002	-1	2
7121000	Top Applications			250	380	41	7121001	7121002	-1	2
7121100	Top Hosts			250	380	41	7121101	7121102	-1	2
7122000	Top Hosts			250	380	41	7122001	7122002	-1	2
7122100	Top Applications			250	380	41	7122101	7122102	-1	2
7130000	Top Hosts			250	380	41	7130001	7130002	-1	2
7131000	Top Applications			250	380	41	7131001	7131002	-1	2
7131100	Top Destinations			250	380	41	7131101	7131102	-1	2
7132000	Top Destinations			250	380	41	7132001	7132002	-1	2
7132100	Top Applications			250	380	41	7132101	7132102	-1	2
7210000	Top Applications			250	380	41	7210001	7210002	-1	2
7211000	Top Users			250	380	41	7211001	7211002	-1	2
7211100	Top Destinations			250	380	41	7211101	7211102	-1	2
7211200	Top Hosts			250	380	41	7211201	7211202	-1	2
7212000	Top Destinations			250	380	41	7212001	7212002	-1	2
7212100	Top Users			250	380	41	7212101	7212102	-1	2
7212200	Top Hosts			250	380	41	7212201	7212202	-1	2
7213000	Top Hosts			250	380	41	7213001	7213002	-1	2
7213100	Top Destinations			250	380	41	7213101	7213102	-1	2
7213200	Top Users			250	380	41	7213201	7213202	-1	2
7220000	Top Users			250	380	41	7220001	7220002	-1	2
7221000	Top Applications			250	380	41	7221001	7221002	-1	2
7221100	Top Destinations			250	380	41	7221101	7221102	-1	2
7221200	Top Hosts			250	380	41	7221201	7221202	-1	2
7222000	Top Destinations			250	380	41	7222001	7222002	-1	2
7222100	Top Applications			250	380	41	7222101	7222102	-1	2
7222200	Top Hosts			250	380	41	7222201	7222202	-1	2
7223000	Top Hosts			250	380	41	7223001	7223002	-1	2
7223100	Top Applications			250	380	41	7223101	7223102	-1	2
7223110	Top Destinations			250	380	41	7223111	7223112	-1	2
7223200	Top Destinations			250	380	41	7223201	7223202	-1	2
7230000	Top Destinations			250	380	41	7230001	7230002	-1	2
7231000	Top Applications			250	380	41	7231001	7231002	-1	2
7232000	Top Users			250	380	41	7232001	7232002	-1	2
7232100	Top Applications			250	380	41	7232101	7232102	-1	2
7232200	Top Hosts			250	380	41	7232201	7232202	-1	2
7233000	Top Hosts			250	380	41	7233001	7233002	-1	2
7233100	Top Applications			250	380	41	7233101	7233102	-1	2
7233200	Top Users			250	380	41	7233201	7233202	-1	2
7240000	Top Hosts			250	380	41	7240001	7240002	-1	2
7241000	Top Applications			250	380	41	7241001	7241002	-1	2
7241100	Top Destinations			250	380	41	7241101	7241102	-1	2
7241200	Top Users			250	380	41	7241201	7241202	-1	2
7242000	Top Destinations			250	380	41	7242001	7242002	-1	2
7242100	Top Applications			250	380	41	7242101	7242102	-1	2
7242200	Top Users			250	380	41	7242201	7242202	-1	2
7243000	Top Users			250	380	41	7243001	7243002	-1	2
7243100	Top Application			250	380	41	7243101	7243102	-1	2
7243110	Top Destinations			250	380	41	7243111	7243112	-1	2
7243200	Top Destinations			250	380	41	7243201	7243202	-1	2
7243210	Top Applications			250	380	41	7243211	7243212	-1	2
7310000	Top Application Groups			250	380	41	7310001	7310002	-1	2
7311000	Top Application			250	380	41	7311001	7311002	-1	2
7311100	Top Destinations			250	380	41	7311101	7311102	-1	2
7312000	Top Destinations			250	380	41	7312001	7312002	-1	2
7312100	Top Application			250	380	41	7312101	7312102	-1	2
7313000	Top Users			250	380	41	7313001	7313002	-1	2
7313100	Top Applications			250	380	41	7313101	7313102	-1	2
7313110	Top Destinations			250	380	41	7313111	7313112	-1	2
7320000	Top Destinations			250	380	41	7320001	7320002	-1	2
7321000	Top Applications			250	380	41	7321001	7321002	-1	2
7321100	Top Users			250	380	41	7321101	7321102	-1	2
7322000	Top Users			250	380	41	7322001	7322002	-1	2
7322100	Top Applications			250	380	41	7322101	7322102	-1	2
7330000	Top Users			250	380	41	7330001	7330002	-1	2
7331000	Top Application			250	380	41	7331001	7331002	-1	2
7331100	Top Destinations			250	380	41	7331101	7331102	-1	2
7332000	Top Destinations			250	380	41	7332001	7332002	-1	2
7410000	Top Application Groups			250	380	41	7410001	7410002	-1	2
7411000	Top Application			250	380	41	7411001	7411002	-1	2
7411100	Top Users			250	380	41	7411101	7411102	-1	2
7411200	Top Hosts			250	380	41	7411201	7411202	-1	2
7412000	Top Users			250	380	41	7412001	7412002	-1	2
7412100	Top Applications			250	380	41	7412101	7412102	-1	2
7412200	Top Hosts			250	380	41	7412201	7412202	-1	2
7413000	Top Hosts			250	380	41	7413001	7413002	-1	2
7413100	Top Applications			250	380	41	7413101	7413102	-1	2
7413200	Top Users			250	380	41	7413201	7413202	-1	2
7420000	Top Users			250	380	41	7420001	7420002	-1	2
7421000	Top Applications			250	380	41	7421001	7421002	-1	2
7421100	Top Hosts			250	380	41	7421101	7421102	-1	2
7422000	Top Hosts			250	380	41	7422001	7422002	-1	2
7430000	Top Hosts			250	380	41	7430001	7430002	-1	2
7431000	Top Application			250	380	41	7431001	7431002	-1	2
7431100	Top Users			250	380	41	7431101	7431102	-1	2
7432000	Top Users			250	380	41	7432001	7432002	-1	2
7432100	Top Application			250	380	41	7432101	7432102	-1	2
7231100	Top Users			250	380	41	7231101	7231102	-1	2
7231200	Top Hosts			250	380	41	7231201	7231202	-1	2
7223210	Top Applications			250	380	41	7223211	7223212	-1	2
7332100	Top Application			250	380	41	7332101	7332102	-1	2
7422100	Top Applications			250	380	41	7422101	7422102	-1	2
81000001	Top Denied Web Users			250	380	41	81000002	81000003	-1	2
81000002	Top Denied Web Users			250	380	41	81000003	81000004	-1	2
81000003	Top Denied Web Users			250	380	41	81000004	81000005	-1	2
81000004	Top Denied Web Users			250	380	41	81000005	81000006	-1	2
81000005	Top Denied Web Users			250	380	41	81000006	81000007	-1	2
81000006	Top Denied Web Users			250	380	41	81000007	81000008	-1	2
81000007	Top Denied Web Users			250	380	41	81000008	81000009	-1	2
81000008	Top Denied Web Users			250	380	41	81000009	81000010	-1	2
81000009	Top Denied Web Users			250	380	41	81000010	81000011	-1	2
81000010	Top Denied Web Users			250	380	41	81000011	81000012	-1	2
81000011	Top Denied Web Users			250	380	41	81000012	81000013	-1	2
81000012	Top Denied Web Users			250	380	41	81000013	81000014	-1	2
81000013	Top Denied Web Users			250	380	41	81000014	81000015	-1	2
81000014	Top Denied Web Users			250	380	41	81000015	81000016	-1	2
81000015	Top Denied Web Users			250	380	41	81000016	81000017	-1	2
81000016	Top Denied Web Users			250	380	41	81000017	81000018	-1	2
81000017	Top Denied Web Users			250	380	41	81000018	81000019	-1	2
81000018	Top Denied Web Users			250	380	41	81000019	81000020	-1	2
81000019	Top Denied Web Users			250	380	41	81000020	81000021	-1	2
81000020	Top Denied Web Users			250	380	41	81000021	81000022	-1	2
81000021	Top Denied Web Users			250	380	41	81000022	81000023	-1	2
81000000	Top Denied Web Users			250	380	41	81000001	81000002	-1	2
81100000	 Top Categories			250	380	41	81100001	81100002	-1	2
81200000	Top Domains			250	380	41	81200001	81200002	-1	2
81300000	Top URLs			250	380	41	81300001	81300002	-1	2
81400000	Top Hosts			250	380	41	81400001	81400002	-1	2
81500000	Top Applications			250	380	41	81500001	81500002	-1	2
81110000	Top Domains			250	380	41	81110001	81110002	-1	2
81111000	Top URLs			250	380	41	81111001	81111002	-1	2
81210000	Top URLs			250	380	41	81210001	81210002	-1	2
81410000	 Top Categories			250	380	41	81410001	81410002	-1	2
81420000	Top Domains			250	380	41	81420001	81420002	-1	2
81430000	Top URLs			250	380	41	81430001	81430002	-1	2
81440000	Top Applications			250	380	41	81440001	81440002	-1	2
81411000	Top Domains			250	380	41	81411001	81411002	-1	2
81411100	Top URLs			250	380	41	81411101	81411102	-1	2
81421000	Top URLs			250	380	41	81421001	81421002	-1	2
81441000	 Top Categories			250	380	41	81441001	81441002	-1	2
81441100	Top Domains			250	380	41	81441101	81441102	-1	2
81441110	Top URLs			250	380	41	81441111	81441112	-1	2
81510000	 Top Categories			250	380	41	81510001	81510002	-1	2
81511000	Top Domains			250	380	41	81511001	81511002	-1	2
81511100	Top URLs			250	380	41	81511101	81511102	-1	2
82000000	Top Denied Categories			250	380	41	82000001	82000002	-1	2
82100000	Top Domains			250	380	41	82100001	82100002	-1	2
82200000	 Top Users			250	380	41	82200001	82200002	-1	2
82110000	 Top Users			250	380	41	82110001	82110002	-1	2
82111000	Top URLs			250	380	41	82111001	82111002	-1	2
82210000	Top Domains			250	380	41	82210001	82210002	-1	2
82211000	Top URLs			250	380	41	82211001	82211002	-1	2
83000000	Top  Denied Domains 			250	380	41	83000001	83000002	-1	2
83100000	 Top Users			250	380	41	83100001	83100002	-1	2
83110000	Top URLs			250	380	41	83110001	83110002	-1	2
84000000	Top Denied Web Hosts			250	380	41	84000001	84000002	-1	2
84100000	 Top Categories			250	380	41	84100001	84100002	-1	2
84200000	Top Domains			250	380	41	84200001	84200002	-1	2
84300000	Top URLs			250	380	41	84300001	84300002	-1	2
84400000	 Top Users			250	380	41	84400001	84400002	-1	2
84110000	Top Domains			250	380	41	84110001	84110002	-1	2
84111000	Top URLs			250	380	41	84111001	84111002	-1	2
84210000	Top URLs			250	380	41	84210001	84210002	-1	2
84410000	 Top Categories			250	380	41	84410001	84410002	-1	2
84420000	Top Domains			250	380	41	84420001	84420002	-1	2
84430000	Top URLs			250	380	41	84430001	84430002	-1	2
84440000	Top Applications			250	380	41	84440001	84440002	-1	2
84411000	Top Domains			250	380	41	84411001	84411002	-1	2
84411100	Top URLs			250	380	41	84411101	84411102	-1	2
84421000	Top URLs			250	380	41	84421001	84421002	-1	2
84441000	 Top Categories			250	380	41	84441001	84441002	-1	2
84441100	Top Domains			250	380	41	84441101	84441102	-1	2
84441110	Top URLs			250	380	41	84441111	84441112	-1	2
84500000	Top Applications			250	380	41	84500001	84500002	-1	2
84510000	 Top Categories			250	380	41	84510001	84510002	-1	2
84511000	Top Domains			250	380	41	84511001	84511002	-1	2
84511100	Top URLs			250	380	41	84511101	84511102	-1	2
6100000	Top Files Uploaded via FTP			250	380	41	6100001	6100003	-1	2
6200000	Top Files Downloaded via FTP			250	380	41	6200001	6200003	-1	2
6300000	Top FTP Users (Upload)			250	380	41	6300001	6300003	-1	2
6400000	Top FTP Users (Download)			250	380	41	6400001	6400003	-1	2
6500000	Top FTP Hosts (Upload)			250	380	41	6500001	6500003	-1	2
6600000	Top FTP Hosts (Download)			250	380	41	6600001	6600003	-1	2
6700000	Top FTP Servers			250	380	41	6700001	6700003	-1	2
6110000	Top Servers			250	380	41	6110001	6110003	-1	2
6111000	Top Hosts and Users			250	380	41	6111001	6111004	-1	2
6120000	Top FTP Hosts			250	380	41	6120001	6120003	-1	2
6121000	Top Servers and Users			250	380	41	6121001	6121004	-1	2
6130000	Top FTP Users			250	380	41	6130001	6130003	-1	2
6131000	Top Hosts and Servers			250	380	41	6131001	6131004	-1	2
6210000	Top Servers			250	380	41	6210001	6210003	-1	2
6211000	Top Hosts and Users			250	380	41	6211001	6211004	-1	2
6220000	Top FTP Hosts			250	380	41	6220001	6220003	-1	2
6221000	Top Servers and Users			250	380	41	6221001	6221004	-1	2
6230000	Top FTP Users			250	380	41	6230001	6230003	-1	2
6231000	Top Hosts and Servers			250	380	41	6231001	6231004	-1	2
6310000	Top Files			250	380	41	6310001	6310003	-1	2
6311000	Top Servers and Hosts			250	380	41	6311001	6311004	-1	2
6320000	Top Servers			250	380	41	6320001	6320003	-1	2
6321000	Top Hosts and Files			250	380	41	6321001	6321004	-1	2
6330000	Top Hosts			250	380	41	6330001	6330003	-1	2
6331000	Top Files and Servers			250	380	41	6331001	6331004	-1	2
6410000	Top Files			250	380	41	6410001	6410003	-1	2
6411000	Top Servers and Hosts			250	380	41	6411001	6411004	-1	2
6420000	Top Servers			250	380	41	6420001	6420003	-1	2
6421000	Top Hosts and Files			250	380	41	6421001	6421004	-1	2
6430000	Top Hosts			250	380	41	6430001	6430003	-1	2
6431000	Top Files and Servers			250	380	41	6431001	6431004	-1	2
6510000	Top Files			250	380	41	6510001	6510003	-1	2
6511000	Top Servers and Users			250	380	41	6511001	6511004	-1	2
6520000	Top Servers			250	380	41	6520001	6520003	-1	2
6521000	Top Users and Files			250	380	41	6521001	6521004	-1	2
6530000	Top Users			250	380	41	6530001	6530003	-1	2
6531000	Top Files and Servers			250	380	41	6531001	6531004	-1	2
6610000	Top Files			250	380	41	6610001	6610003	-1	2
6611000	Top Servers and Users			250	380	41	6611001	6611004	-1	2
6620000	Top Servers			250	380	41	6620001	6620003	-1	2
6621000	Top Users and Files			250	380	41	6621001	6621004	-1	2
6630000	Top Users			250	380	41	6630001	6630003	-1	2
6631000	Top Files and Servers			250	380	41	6631001	6631004	-1	2
6710000	Top Files Uploaded			250	380	41	6710001	6710003	-1	2
6711000	Top Hosts and Users			250	380	41	6711001	6711004	-1	2
6720000	Top Files Downloaded			250	380	41	6720001	6720003	-1	2
6721000	Top Hosts and Users			250	380	41	6721001	6721004	-1	2
6730000	Top FTP Users			250	380	41	6730001	6730003	-1	2
6731000	Top Files Uploaded			250	380	41	6731001	6731003	-1	2
6732000	Top Files Downloaded			250	380	41	6732001	6732003	-1	2
6740000	Top FTP Hosts			250	380	41	6740001	6740003	-1	2
6741000	Top Files Uploaded			250	380	41	6741001	6741003	-1	2
6742000	Top Files Downloaded			250	380	41	6742001	6742003	-1	2
510000	Top Mail Senders			250	380	41	510001	510003	-1	2
511000	Top Recipients			250	380	41	511001	511003	-1	2
511100	Top Recipients Details			250	380	41	511101	511106	-1	2
512000	Top Source Hosts			250	380	41	512001	512003	-1	2
512100	Top Source Hosts Details			250	380	41	512101	512106	-1	2
513000	Top Destinations			250	380	41	513001	513003	-1	2
513100	Top Destinations Details			250	380	41	513101	513106	-1	2
514000	Top Users			250	380	41	514001	514003	-1	2
514100	Top Users Details			250	380	41	514101	514106	-1	2
515000	Top Applications			250	380	41	515001	515003	-1	2
515100	Top Applications Details			250	380	41	515101	515106	-1	2
520000	Top Mail Recipients			250	380	41	520001	520003	-1	2
521000	Top Senders			250	380	41	521001	521003	-1	2
521100	Top Senders Details			250	380	41	521101	521106	-1	2
522000	Top Source Hosts			250	380	41	522001	522003	-1	2
522100	Top Source Hosts Details			250	380	41	522101	522106	-1	2
523000	Top Destinations			250	380	41	523001	523003	-1	2
523100	Top Destinations Details			250	380	41	523101	523106	-1	2
524000	Top Users			250	380	41	524001	524003	-1	2
524100	Top Users Details			250	380	41	524101	524106	-1	2
525000	Top Applications			250	380	41	525001	525003	-1	2
525100	Top Applications Details			250	380	41	525101	525106	-1	2
530000	Top Mail Users			250	380	41	530001	530003	-1	2
531000	Top Senders			250	380	41	531001	531003	-1	2
531100	Top Senders Details			250	380	41	531101	531106	-1	2
532000	Top Recipients			250	380	41	532001	532003	-1	2
532100	Top Recipients Details			250	380	41	532101	532106	-1	2
533000	Top Source Hosts			250	380	41	533001	533003	-1	2
533100	Top Source Hosts Details			250	380	41	533101	533106	-1	2
534000	Top Destinations			250	380	41	534001	534003	-1	2
534100	Top Destinations Details			250	380	41	534101	534106	-1	2
535000	Top Applications			250	380	41	535001	535003	-1	2
535100	Top Applications Details			250	380	41	535101	535106	-1	2
540000	Top Mail Hosts			250	380	41	540001	540003	-1	2
541000	Top Senders			250	380	41	541001	541003	-1	2
541100	Top Senders Details			250	380	41	541101	541106	-1	2
542000	Top Recipients			250	380	41	542001	542003	-1	2
542100	Top Recipients Details			250	380	41	542101	542106	-1	2
543000	Top Users			250	380	41	543001	543003	-1	2
543100	Top Users Details			250	380	41	543101	543106	-1	2
544000	Top Destinations			250	380	41	544001	544003	-1	2
544100	Top Destinations Details			250	380	41	544101	544106	-1	2
545000	Top Applications			250	380	41	545001	545003	-1	2
545100	Top Applications Details			250	380	41	545101	545106	-1	2
550000	Top Mail Applications			250	380	41	550001	550003	-1	2
551000	Top Senders			250	380	41	551001	551003	-1	2
551100	Top Senders Details			250	380	41	551101	551106	-1	2
552000	Top Recipient			250	380	41	552001	552003	-1	2
552100	Top Recipient Details			250	380	41	552101	552106	-1	2
553000	Top Users			250	380	41	553001	553003	-1	2
553100	Top Users Details			250	380	41	553101	553106	-1	2
554000	Top Hosts			250	380	41	554001	554003	-1	2
554100	Top Hosts Details			250	380	41	554101	554106	-1	2
555000	Top Destinations			250	380	41	555001	555003	-1	2
555100	Top Destinations Details			250	380	41	555101	555106	-1	2
1010000	Top Spam Recipients			250	380	41	1010001	1010002	-1	2
1011000	Top Spam Senders			250	380	41	1011001	1011002	-1	2
1012000	Top Source Hosts			250	380	41	1012001	1012002	-1	2
1013000	Top Destinations			250	380	41	1013001	1013002	-1	2
1014000	Top Users			250	380	41	1014001	1014002	-1	2
1015000	Top Applications			250	380	41	1015001	1015002	-1	2
1011100	Spam Sender Details			250	380	41	1011101	1011106	-1	2
1012100	Source Host Details			250	380	41	1012101	1012106	-1	2
1013100	Destination Details			250	380	41	1013101	1013106	-1	2
1014100	User Details			250	380	41	1014101	1014106	-1	2
1015100	Application Details			250	380	41	1015101	1015106	-1	2
1020000	Top Spam Senders			250	380	41	1020001	1020002	-1	2
1021000	Top Recipients			250	380	41	1021001	1021002	-1	2
1021100	Recipient Details			250	380	41	1021101	1021106	-1	2
1022000	Top Source Hosts			250	380	41	1022001	1022002	-1	2
1023000	Top Destinations			250	380	41	1023001	1023002	-1	2
1023100	Destination Details			250	380	41	1023101	1023106	-1	2
1024000	Top Users			250	380	41	1024001	1024002	-1	2
1024100	User Details			250	380	41	1024101	1024106	-1	2
1025000	Top Applications			250	380	41	1025001	1025002	-1	2
1025100	Application Details			250	380	41	1025101	1025106	-1	2
1030000	Top Applications used for Spam			250	380	41	1030001	1030002	-1	2
1031000	Top Senders			250	380	41	1031001	1031002	-1	2
1032000	Top Recipient			250	380	41	1032001	1032002	-1	2
1033000	Top Users			250	380	41	1033001	1033002	-1	2
1034000	Top Hosts			250	380	41	1034001	1034002	-1	2
1035000	Top Destinations			250	380	41	1035001	1035002	-1	2
1031100	Sender Details			250	380	41	1031101	1031106	-1	2
1032100	Recipient Details			250	380	41	1032101	1032106	-1	2
1033100	User Details			250	380	41	1033101	1033106	-1	2
1034100	Host Details			250	380	41	1034101	1034106	-1	2
1035100	Destination Details			250	380	41	1035101	1035106	-1	2
1022100	Source Host Details			250	380	41	1022101	1022106	-1	2
91000000	Severity wise break-down			250	380	41	91000001	91000002	-1	2
91100000	Top Attacks			250	380	41	91100001	91100002	-1	2
91200000	Top Attackers			250	380	41	91200001	91200002	-1	2
91300000	Top Victims			250	380	41	91300001	91300002	-1	2
91400000	Top Applications			250	380	41	91400001	91400002	-1	2
91500000	Top Detected Attacks			250	380	41	91500001	91500002	-1	2
91600000	Top Dropped Attacks			250	380	41	91600001	91600002	-1	2
91110000	Attacker			250	380	41	91110001	91110006	-1	2
91210000	Attack			250	380	41	91210001	91210005	-1	2
91310000	Attack			250	380	41	91310001	91310005	-1	2
91410000	Attack			250	380	41	91410001	91410006	-1	2
91510000	Attacker			250	380	41	91510001	91510005	-1	2
91610000	Attacker			250	380	41	91610001	91610005	-1	2
94000000	Top Victims			250	380	41	94000001	94000002	-1	2
94100000	Top Attacks			250	380	41	94100001	94100006	-1	2
94200000	Top Attackers			250	380	41	94200001	94200006	-1	2
94300000	Top Applications			250	380	41	94300001	94300006	-1	2
94110000	Attacker			250	380	41	94110001	94110006	-1	2
94210000	Attack			250	380	41	94210001	94210006	-1	2
94310000	Attack			250	380	41	94310001	94310006	-1	2
97000000	Top Applications used by Attacks			250	380	41	97000001	97000002	-1	2
97100000	Top Attacks			250	380	41	97100001	97100006	-1	2
97200000	Top Attackers			250	380	41	97200001	97200005	-1	2
97300000	Top Victims			250	380	41	97300001	97300005	-1	2
97400000	Top Detected Attacks			250	380	41	97400001	97400005	-1	2
97500000	Top Dropped Attacks			250	380	41	97500001	97500005	-1	2
97110000	Attacker			250	380	41	97110001	97110006	-1	2
97210000	Attack			250	380	41	97210001	97210005	-1	2
97310000	Attack			250	380	41	97310001	97310005	-1	2
97410000	Attacker			250	380	41	97410001	97410005	-1	2
97510000	Attacker			250	380	41	97510001	97510005	-1	2
11100000	Top Applications			250	380	41	11100001	11100002	-1	2
11200000	Top Viruses			250	380	41	11200001	11200002	-1	2
11310000	Top Viruses			250	380	41	11310001	11310002	-1	2
11311000	Top Domain			250	380	41	11311001	11311002	-1	2
11311100	Domain Details			250	380	41	11311101	11311104	-1	2
11312000	Top User			250	380	41	11312001	11312002	-1	2
11312100	User Detail			250	380	41	11312101	11312103	-1	2
11313000	Top Host			250	380	41	11313001	11313002	-1	2
11313100	Host Details			250	380	41	11313101	11313103	-1	2
11320000	Top Domains			250	380	41	11320001	11320002	-1	2
11321000	Top Virus			250	380	41	11321001	11321002	-1	2
11321100	Virus Detail			250	380	41	11321101	11321104	-1	2
11322000	Top User			250	380	41	11322001	11322002	-1	2
11322100	User Detail			250	380	41	11322101	11322104	-1	2
11323000	Top Host			250	380	41	11323001	11323002	-1	2
11323100	Host Details			250	380	41	11323101	11323104	-1	2
11330000	Top Users			250	380	41	11330001	11330002	-1	2
11331000	Top Viruses			250	380	41	11331001	11331002	-1	2
11331100	Virus Detail			250	380	41	11331101	11331103	-1	2
11332000	Top Domains			250	380	41	11332001	11332002	-1	2
11332100	Domain Details			250	380	41	11332101	11332104	-1	2
11333000	Top Hosts			250	380	41	11333001	11333002	-1	2
11333100	Host Details			250	380	41	11333101	11333103	-1	2
11410000	Top Viruses			250	380	41	11410001	11410002	-1	2
11411000	Top Sender (Email ids)			250	380	41	11411001	11411002	-1	2
11411100	Top Recipients			250	380	41	11411101	11411102	-1	2
11411110	Recipient Details			250	380	41	11411111	11411116	-1	2
11411200	Top Sender Hosts			250	380	41	11411201	11411202	-1	2
11411210	Sender Host Details			250	380	41	11411211	11411216	-1	2
11411300	Top Receiver Hosts			250	380	41	11411301	11411302	-1	2
11411310	Receiver Host Details			250	380	41	11411311	11411316	-1	2
11411400	Top Applications			250	380	41	11411401	11411402	-1	2
11411410	Application Details			250	380	41	11411411	11411416	-1	2
11411500	Top Users			250	380	41	11411501	11411502	-1	2
11411510	User Detail			250	380	41	11411511	11411516	-1	2
11412000	Top Recipients (Email Ids)			250	380	41	11412001	11412002	-1	2
11412100	Top Senders			250	380	41	11412101	11412102	-1	2
11412110	Sender Details			250	380	41	11412111	11412116	-1	2
11412200	Top Sender Hosts			250	380	41	11412201	11412202	-1	2
11412210	Sender Host Details			250	380	41	11412211	11412216	-1	2
11412300	Top Receiver Hosts			250	380	41	11412301	11412302	-1	2
11412310	Receiver Host Details			250	380	41	11412311	11412316	-1	2
11412400	Top Applications			250	380	41	11412401	11412402	-1	2
11412410	Application Details			250	380	41	11412411	11412416	-1	2
11412500	Top Users			250	380	41	11412501	11412502	-1	2
11412510	User Detail			250	380	41	11412511	11412516	-1	2
11413000	Top Sender Host			250	380	41	11413001	11413002	-1	2
11413100	Top Senders			250	380	41	11413101	11413102	-1	2
11413110	Sender Details			250	380	41	11413111	11413116	-1	2
11413200	Top Recipients			250	380	41	11413201	11413202	-1	2
11413210	Recipient Details			250	380	41	11413211	11413216	-1	2
11413300	Top Receiver Hosts			250	380	41	11413301	11413302	-1	2
11413310	Receiver Host Details			250	380	41	11413311	11413316	-1	2
11413400	Top Applications			250	380	41	11413401	11413402	-1	2
11413410	Application Details			250	380	41	11413411	11413416	-1	2
11413500	Top Users			250	380	41	11413501	11413502	-1	2
11413510	User Detail			250	380	41	11413511	11413516	-1	2
11414000	Top Receiver Host			250	380	41	11414001	11414002	-1	2
11414100	Top Senders			250	380	41	11414101	11414102	-1	2
11414110	Sender Details			250	380	41	11414111	11414116	-1	2
11414200	Top Recipients			250	380	41	11414201	11414202	-1	2
11414210	Recipient Details			250	380	41	11414211	11414216	-1	2
11414300	Top Sender Hosts			250	380	41	11414301	11414302	-1	2
11414310	Sender Host Details			250	380	41	11414311	11414316	-1	2
11414400	Top Applications			250	380	41	11414401	11414402	-1	2
11414410	Application Details			250	380	41	11414411	11414416	-1	2
11414500	Top Users			250	380	41	11414501	11414502	-1	2
11414510	User Detail			250	380	41	11414511	11414516	-1	2
11415000	Top Applications			250	380	41	11415001	11415002	-1	2
11415100	Top Senders			250	380	41	11415101	11415102	-1	2
11415110	Sender Details			250	380	41	11415111	11415116	-1	2
11415200	Top Recipients			250	380	41	11415201	11415202	-1	2
11415210	Recipient Details			250	380	41	11415211	11415216	-1	2
11415300	Top Sender Hosts			250	380	41	11415301	11415302	-1	2
11415310	Sender Host Details			250	380	41	11415311	11415316	-1	2
11415400	Top Receiver Hosts			250	380	41	11415401	11415402	-1	2
11415410	Receiver Host Details			250	380	41	11415411	11415416	-1	2
11415500	Top Users			250	380	41	11415501	11415502	-1	2
11415510	User Detail			250	380	41	11415511	11415516	-1	2
11510000	Top Viruses (Upload)			250	380	41	11510001	11510002	-1	2
11511000	Top Servers			250	380	41	11511001	11511002	-1	2
11511100	Top Hosts			250	380	41	11511101	11511102	-1	2
11511110	Host Details			250	380	41	11511111	11511113	-1	2
11511200	Top Files			250	380	41	11511201	11511202	-1	2
11511210	File Details			250	380	41	11511211	11511213	-1	2
11511300	Top Users			250	380	41	11511301	11511302	-1	2
11511310	User Detail			250	380	41	11511311	11511313	-1	2
11512000	Top Hosts			250	380	41	11512001	11512002	-1	2
11512100	Top Servers			250	380	41	11512101	11512102	-1	2
11512110	Server Details			250	380	41	11512111	11512113	-1	2
11512200	Top Files			250	380	41	11512201	11512202	-1	2
11512210	File Details			250	380	41	11512211	11512213	-1	2
11512300	Top Users			250	380	41	11512301	11512302	-1	2
11512310	User Detail			250	380	41	11512311	11512313	-1	2
11513000	Top Users			250	380	41	11513001	11513002	-1	2
11513100	Top Servers			250	380	41	11513101	11513102	-1	2
11513110	Server Details			250	380	41	11513111	11513113	-1	2
11513200	Top Files			250	380	41	11513201	11513202	-1	2
11513210	File Details			250	380	41	11513211	11513213	-1	2
11513300	Top Hosts			250	380	41	11513301	11513302	-1	2
11513310	Host Details			250	380	41	11513311	11513313	-1	2
11514000	Top File			250	380	41	11514001	11514002	-1	2
11514100	Top Servers			250	380	41	11514101	11514102	-1	2
11514110	Server Details			250	380	41	11514111	11514113	-1	2
11514200	Top Hosts			250	380	41	11514201	11514202	-1	2
11514210	Host Details			250	380	41	11514211	11514213	-1	2
11514300	Top Users			250	380	41	11514301	11514302	-1	2
11514310	User Detail			250	380	41	11514311	11514313	-1	2
11520000	Top Viruses (Download)			250	380	41	11520001	11520002	-1	2
11521000	Top Servers			250	380	41	11521001	11521002	-1	2
11521100	Top Hosts			250	380	41	11521101	11521102	-1	2
11521110	Host Details			250	380	41	11521111	11521113	-1	2
11521200	Top Files			250	380	41	11521201	11521202	-1	2
11521210	File Details			250	380	41	11521211	11521213	-1	2
11521300	Top Users			250	380	41	11521301	11521302	-1	2
11521310	User Detail			250	380	41	11521311	11521313	-1	2
11522000	Top Hosts			250	380	41	11522001	11522002	-1	2
11522100	Top Servers			250	380	41	11522101	11522102	-1	2
11522110	Server Details			250	380	41	11522111	11522113	-1	2
11522200	Top Files			250	380	41	11522201	11522202	-1	2
11522210	File Details			250	380	41	11522211	11522213	-1	2
11522300	Top Users			250	380	41	11522301	11522302	-1	2
11522310	User Detail			250	380	41	11522311	11522313	-1	2
11523000	Top Users			250	380	41	11523001	11523002	-1	2
11523100	Top Servers			250	380	41	11523101	11523102	-1	2
11523110	Server Details			250	380	41	11523111	11523113	-1	2
11523200	Top Files			250	380	41	11523201	11523202	-1	2
11523210	File Details			250	380	41	11523211	11523213	-1	2
11523300	Top Hosts			250	380	41	11523301	11523302	-1	2
11523310	Host Details			250	380	41	11523311	11523313	-1	2
11524000	Top File			250	380	41	11524001	11524002	-1	2
11524100	Top Servers			250	380	41	11524101	11524102	-1	2
11524110	Server Details			250	380	41	11524111	11524113	-1	2
11524200	Top Hosts			250	380	41	11524201	11524202	-1	2
11524210	Host Details			250	380	41	11524211	11524213	-1	2
11524300	Top Users			250	380	41	11524301	11524302	-1	2
11524310	User Detail			250	380	41	11524311	11524313	-1	2
93000000	Top Attackers			250	380	41	93000001	93000002	-1	2
93100000	Top Attacks			250	380	41	93100001	93100002	-1	2
93200000	Top Victims			250	380	41	93200001	93200002	-1	2
93300000	Top Applications			250	380	41	93300001	93300002	-1	2
93110000	Victim			250	380	41	93110001	93110006	-1	2
93210000	Attack			250	380	41	93210001	93210006	-1	2
93310000	Attack			250	380	41	93310001	93310006	-1	2
92000000	Top Attacks			250	380	41	92000001	92000002	-1	2
92110000	Victim			250	380	41	92110001	92110004	-1	2
92210000	Attacker			250	380	41	92210001	92210004	-1	2
92310000	Attacker			250	380	41	92310001	92310005	-1	2
92100000	Top Attackers			250	380	41	92100001	92100002	-1	2
92200000	Top Victims			250	380	41	92200001	92200002	-1	2
92300000	Top Applications			250	380	41	92300001	92300002	-1	2
26010	Top Application Groups 			250	380	41	26011	26013	-1	2
26020	Top Web Categories			250	380	41	26021	26023	-1	2
26030	Top Files Uploaded via FTP			250	380	41	26031	26033	-1	2
26040	Top Files Downloaded via FTP			250	380	41	26041	26043	-1	2
26050	Top Hosts 			250	380	41	26051	26053	-1	2
26060	Top Denied Application Groups			250	380	41	26061	26062	-1	2
26070	Top Denied Categories			250	380	41	26071	26072	-1	2
26080	Top Web Viruses			250	380	41	26081	26082	-1	2
28010	Top Application Groups 			250	380	41	28011	28013	-1	2
28020	Top Web Categories			250	380	41	28021	28023	-1	2
28030	Top Files Uploaded via FTP			250	380	41	28031	28033	-1	2
28040	Top Files Downloaded via FTP			250	380	41	28041	28043	-1	2
28050	Top Users 			250	380	41	28051	28053	-1	2
28060	Top Denied Application Groups			250	380	41	28061	28062	-1	2
28070	Top Denied Categories			250	380	41	28071	28072	-1	2
28080	Top Attacks Received			250	380	41	28081	28082	-1	2
28090	Top Attacks Generated			250	380	41	28091	28092	-1	2
29010	Top Mails Sent to			250	380	41	29011	29013	-1	2
29020	Top Mails Received From			250	380	41	29021	29023	-1	2
29050	Top Destinations			250	380	41	29051	29053	-1	2
29060	Top Destinations			250	380	41	29061	29063	-1	2
29070	Top Users			250	380	41	29071	29073	-1	2
29080	Top Users			250	380	41	29081	29083	-1	2
29090	Top Spam Received			250	380	41	29091	29092	-1	2
29100	Top Spam Sent			250	380	41	29101	29102	-1	2
29030	Top Sender Hosts			250	380	41	29031	29033	-1	2
29040	Top Recipient Hosts			250	380	41	29041	29043	-1	2
20100	CPU Usage			250	380	5	20101	20102	-1	3
20200	Memory Usage			250	380	4	20201	20202	-1	3
20300	Disk Usage			250	380	6	20301	20302	-1	3
20110	CPU Usage			250	380	3	20111	20112	-1	6
20210	Memory Usage			250	380	3	20211	20212	-1	6
20310	Database Usage			250	380	3	20311	20312	-1	6
20320	Archive Usage			250	380	3	20321	20322	-1	6
\.



ALTER SEQUENCE tblgraph_graphid_seq RESTART 100000000; 

ALTER TABLE ONLY tblgraph
    ADD CONSTRAINT tblgraph_pkey PRIMARY KEY (graphid);




DROP TABLE IF EXISTS tblgraphformat;
CREATE TABLE tblgraphformat (
    graphformatid serial NOT NULL,
    graphformat character varying(255) DEFAULT ''::character varying
);

COPY tblgraphformat (graphformatid, graphformat) FROM stdin;
1	labelStep=3,labelDisplay=STAGGER,staggerLines=2,outCnvBaseFontSize=8,outCnvBaseFontColor=000000
3	showBorder=0,showValues=0,showLabels=0,showPercentValues=0,displayLegend=1
4	showValues=0, yAxisValuesStep=6
5	showValues=0, yAxisValuesStep=3, showCanvasBg=0
2	showValues=0
6	showValues=0,yAxisValuesStep=1,labelStep=1
\.

ALTER SEQUENCE tblgraphformat_graphformatid_seq RESTART 10; 

ALTER TABLE ONLY tblgraphformat
    ADD CONSTRAINT tblgraphformat_pkey PRIMARY KEY (graphformatid);




DROP TABLE IF EXISTS tbliviewconfig;
CREATE TABLE tbliviewconfig (
    keyname character varying(25) NOT NULL,
    value character varying(255)
);


COPY tbliviewconfig (keyname, value) FROM stdin;
MailAdminId	admin@iview.com
languageid	1
SMTPAuthenticationFlag	0
MailServerPort	25
MailServer	127.0.0.1
MailAdminName	iViewAdmin
MailServerUsername	\N
MailServerPassword	\N
UsageMonitorSleepTime	300
\.

ALTER TABLE ONLY tbliviewconfig
    ADD CONSTRAINT tbliviewconfig_pkey PRIMARY KEY (keyname);


insert into tbliviewconfig values ('iViewHome','C:/CYGWIN/USR/LOCAL/GARNER/');
insert into tbliviewconfig values ('ArchiveHome','C:/CYGWIN/USR/LOCAL/GARNER/');
insert into tbliviewconfig values ('PostgresHome','C:/CYGWIN/USR/LOCAL/GARNER/');


DROP TABLE if exists tbliviewmenu;
CREATE TABLE tbliviewmenu (
    iviewmenuid serial,
    label character varying(100) DEFAULT NULL::character varying,
    link character varying(255) DEFAULT NULL::character varying,
    target character varying(20) DEFAULT NULL::character varying,
    tooltip character varying(50) DEFAULT NULL::character varying,
    menuorder numeric(10,5) DEFAULT NULL::numeric,
    parentid integer,
    rolelevel integer DEFAULT 1 NOT NULL );


--
-- TOC entry 21327 (class 0 OID 82430)
-- Dependencies: 14689
-- Data for Name: tbliviewmenu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tbliviewmenu (iviewmenuid, label, link, target, tooltip, menuorder, parentid, rolelevel) FROM stdin;
100	SYSTEM	\N	\N	\N	1.00000	-1	2
1001	|Configuration	\N	\N	\N	1.10000	100	2
1002	|Archives	archive.jsp	\N	\N	1.30000	100	2
10020	|Audit Logs	auditlog.jsp			1.20000	1001	2
10014	||Users	manageuser.jsp	\N	\N	1.10010	1001	2
10021	||Device Group	managedevicegroup.jsp			1.10020	1001	1
10016	||Device	managedevice.jsp			1.10030	1001	1
10015	||Application Groups	protocolgroup.jsp	\N		1.10040	1001	2
10011	||Mail Server	iviewconfig.jsp	\N	\N	1.10050	1001	1
10017	||Custom View	reportprofile.jsp	\N	\N	1.10060	1001	2
10018	||Report Notification	mailscheduler.jsp	\N	\N	1.10070	1001	2
10019	||Data Management	configdatabase.jsp	\N	\N	1.10080	1001	1
\.


ALTER SEQUENCE tbliviewmenu_iviewmenuid_seq RESTART 20000; 

ALTER TABLE ONLY tbliviewmenu
    ADD CONSTRAINT tbliviewmenu_pkey PRIMARY KEY (iviewmenuid);


DROP TABLE IF EXISTS tbldashboardmenu;
CREATE TABLE tbldashboardmenu (
    iviewmenuid integer NOT NULL,
    label character varying(100),
    link character varying(255),
    target character varying(20),
    tooltip character varying(50),
    menuorder numeric(10,5),
    parentid integer,
    rolelevel integer NOT NULL
);


COPY tbldashboardmenu (iviewmenuid, label, link, target, tooltip, menuorder, parentid, rolelevel) FROM stdin;
101	|Main Dashboard	maindashboard.jsp			1.10000	100	2
102	|Custom Dashboard	search.jsp			1.20000	100	2
100	DASHBOARDS				1.00000	-1	2
103	|iView Dashboard	reportgroup.jsp?reportgroupid=20000			1.30000	100	2
\.


DROP TABLE IF EXISTS tbllanguage;
CREATE TABLE tbllanguage (
    languageid serial NOT NULL,
    languagename character varying(60) NOT NULL
);

COPY tbllanguage (languageid, languagename) FROM stdin;
1	English
2	Hindi
5	Chinese
\.

ALTER SEQUENCE tbllanguage_languageid_seq RESTART 6; 

ALTER TABLE ONLY tbllanguage
    ADD CONSTRAINT tbllanguage_pkey PRIMARY KEY (languageid);


DROP TABLE IF EXISTS tblprotocolgroup;
CREATE TABLE tblprotocolgroup (
    protocolgroupid serial NOT NULL,
    protocolgroup character varying(23) DEFAULT NULL::character varying,
    description text
);

COPY tblprotocolgroup (protocolgroupid, protocolgroup, description) FROM stdin;
1	Unassigned	Protocols for which Groups are yet to be assigned
2	ICMP	ICMP
3	News	News
4	SNMP	SNMP
5	Name Service	Name Service
6	Printer	Unix Printer
7	Point2Point	Point2Point Protocol
8	Network Security	Network Security
9	Secure Shell	Secure Shell
10	UDP Requests	UDP Requests
11	TCP Requests	TCP Requests
12	Telnet	Telnet
13	Streaming	Streaming
14	Mail	E-Mail
15	FTP	FTP
16	Web	Web Browsing
17	Database Application	Database Applications
18	TL1	TL1
19	Services	This group is customize group.
20	Messaging	This group is customize group.
21	Routing	This group is customize group.
22	Windows Protocols	This group is customize group.
23	Licensing	This group is customize group.
24	Network Management	This group is customize group.
26	Voip	This group is customize group.
25	File Sharing	This group is customize group.
48	Time server	\N
49	testgroup	testgroup description1
\.

ALTER SEQUENCE tblprotocolgroup_protocolgroupid_seq RESTART 50; 

ALTER TABLE ONLY tblprotocolgroup
    ADD CONSTRAINT tblprotocolgroup_pkey PRIMARY KEY (protocolgroupid);

ALTER TABLE ONLY tblprotocolgroup
    ADD CONSTRAINT tblprotocolgroup_protocolgroup_key UNIQUE (protocolgroup);



DROP TABLE IF EXISTS tblprotogroupresolver;
CREATE TABLE tblprotogroupresolver (
    applicationname character varying(50) DEFAULT NULL::character varying,
    protocolgroup character varying(50) DEFAULT NULL::character varying
);

COPY tblprotogroupresolver (applicationname, protocolgroup) FROM stdin;
HTTP	web
SMTP	mail
POP	mail
\.



DROP TABLE IF EXISTS tblprotocolidentifier;
CREATE TABLE tblprotocolidentifier (
    id serial NOT NULL,
    applicationnameid integer,
    protocol integer DEFAULT 0,
    port integer DEFAULT 0,
    type integer DEFAULT 0
);

COPY tblprotocolidentifier (id, applicationnameid, protocol, port, type) FROM stdin;
4	2	6	601	1
7	3	6	5631	1
8	3	6	5632	1
10	4	6	5060	1
12	5	6	1200	1
18	9	6	1778	1
20	10	6	5000	1
23	10	6	5001	1
26	11	6	6969	1
29	12	6	33434	1
30	13	6	1	1
33	14	6	2	1
36	14	6	3	1
41	16	6	7	1
44	17	6	9	1
47	18	6	11	1
50	19	6	19	1
53	20	6	27	1
56	21	6	41	1
59	22	6	51	1
62	23	6	54	1
65	24	6	55	1
68	25	6	62	1
71	26	6	63	1
74	27	6	64	1
77	28	6	67	1
80	29	6	68	1
83	30	6	71	1
86	31	6	72	1
89	32	6	73	1
92	33	6	74	1
95	34	6	84	1
98	35	6	86	1
101	36	6	91	1
104	37	6	93	1
107	38	6	94	1
110	39	6	95	1
113	40	6	96	1
116	41	6	99	1
119	42	6	100	1
121	43	6	101	1
124	44	6	102	1
127	45	6	104	1
130	46	6	106	1
133	47	6	108	1
136	48	6	111	1
139	49	6	112	1
142	50	6	116	1
145	51	6	117	1
148	52	6	120	1
151	53	6	121	1
154	54	6	122	1
157	55	6	130	1
160	56	6	131	1
163	57	6	132	1
166	58	6	145	1
169	59	6	146	1
172	60	6	147	1
175	61	6	148	1
178	62	6	154	1
181	63	6	155	1
184	64	6	166	1
187	65	6	168	1
190	66	6	172	1
194	68	6	173	1
197	69	6	175	1
200	70	6	176	1
203	71	6	177	1
206	72	6	178	1
209	73	6	180	1
212	74	6	181	1
215	75	6	182	1
218	76	6	183	1
221	77	6	184	1
224	78	6	185	1
227	79	6	186	1
230	80	6	187	1
233	81	6	188	1
236	82	6	203	1
239	83	6	204	1
242	84	6	205	1
245	85	6	206	1
248	86	6	207	1
251	87	6	208	1
254	88	6	211	1
257	89	6	212	1
260	90	6	214	1
263	91	6	216	1
266	92	6	219	1
269	93	6	242	1
272	94	6	243	1
275	95	6	244	1
278	96	6	246	1
281	97	6	248	1
284	98	6	257	1
287	99	6	260	1
290	100	6	262	1
293	101	6	266	1
296	102	6	267	1
299	103	6	268	1
302	104	6	281	1
305	105	6	282	1
308	106	6	283	1
311	107	6	284	1
314	108	6	286	1
317	109	6	287	1
320	110	6	308	1
323	111	6	309	1
326	112	6	310	1
329	113	6	313	1
332	114	6	314	1
335	115	6	315	1
338	116	6	316	1
341	117	6	318	1
344	118	6	319	1
347	119	6	320	1
350	120	6	321	1
353	121	6	333	1
356	122	6	344	1
359	123	6	345	1
362	124	6	346	1
365	125	6	347	1
368	126	6	348	1
371	127	6	350	1
374	128	6	351	1
377	129	6	352	1
380	130	6	353	1
383	131	6	354	1
386	132	6	355	1
389	133	6	356	1
392	134	6	357	1
395	135	6	358	1
398	136	6	360	1
401	137	6	361	1
404	138	6	362	1
407	139	6	363	1
410	140	6	364	1
413	141	6	365	1
416	142	6	367	1
419	143	6	368	1
422	144	6	369	1
425	145	6	370	1
428	146	6	371	1
431	147	6	372	1
434	148	6	373	1
437	149	6	374	1
440	150	6	375	1
443	151	6	377	1
446	152	6	378	1
449	153	6	379	1
452	154	6	380	1
455	155	6	385	1
458	156	6	388	1
461	157	6	390	1
464	158	6	392	1
467	159	6	393	1
470	160	6	394	1
473	161	6	395	1
476	162	6	396	1
479	163	6	397	1
482	164	6	398	1
485	165	6	399	1
488	166	6	400	1
491	167	6	402	1
494	168	6	403	1
497	169	6	404	1
500	170	6	405	1
503	171	6	407	1
506	172	6	415	1
509	173	6	416	1
512	174	6	417	1
515	175	6	419	1
518	176	6	421	1
521	177	6	422	1
524	178	6	425	1
527	179	6	426	1
530	180	6	427	1
533	181	6	428	1
536	182	6	429	1
539	183	6	430	1
542	184	6	431	1
545	185	6	432	1
548	186	6	434	1
551	187	6	435	1
554	188	6	436	1
557	189	6	437	1
560	190	6	438	1
563	191	6	439	1
566	192	6	440	1
569	193	6	442	1
572	194	6	446	1
575	195	6	447	1
578	196	6	448	1
581	197	6	449	1
584	198	6	450	1
587	199	6	451	1
590	200	6	452	1
593	201	6	453	1
596	202	6	454	1
599	203	6	455	1
602	204	6	456	1
606	206	6	457	1
609	207	6	459	1
612	208	6	460	1
615	209	6	461	1
618	210	6	462	1
621	211	6	465	1
625	213	6	467	1
628	214	6	470	1
631	215	6	471	1
634	216	6	472	1
637	217	6	474	1
641	219	6	475	1
644	220	6	476	1
647	221	6	477	1
650	222	6	479	1
653	223	6	480	1
656	224	6	481	1
659	225	6	482	1
662	226	6	483	1
665	227	6	484	1
668	228	6	485	1
671	229	6	486	1
674	230	6	490	1
677	231	6	491	1
680	232	6	492	1
683	233	6	493	1
686	234	6	494	1
689	235	6	495	1
692	236	6	496	1
695	237	6	497	1
698	238	6	499	1
701	239	6	502	1
704	240	6	503	1
707	241	6	504	1
710	242	6	506	1
713	243	6	507	1
716	244	6	508	1
719	245	6	514	1
721	246	6	525	1
724	247	6	526	1
727	248	6	527	1
730	249	6	528	1
733	250	6	533	1
736	251	6	534	1
739	252	6	536	1
742	253	6	538	1
745	254	6	539	1
748	255	6	542	1
751	256	6	548	1
754	257	6	549	1
757	258	6	550	1
760	259	6	551	1
763	260	6	552	1
766	261	6	555	1
769	262	6	556	1
772	263	6	557	1
775	264	6	558	1
778	265	6	559	1
781	266	6	560	1
784	267	6	561	1
787	268	6	562	1
790	269	6	564	1
793	270	6	565	1
796	271	6	566	1
799	272	6	567	1
802	273	6	570	1
805	273	6	571	1
807	274	6	572	1
810	275	6	573	1
813	276	6	576	1
816	277	6	577	1
819	278	6	578	1
822	279	6	579	1
825	280	6	580	1
828	281	6	581	1
831	282	6	582	1
834	283	6	587	1
837	284	6	588	1
840	285	6	589	1
843	286	6	590	1
846	287	6	592	1
849	288	6	594	1
852	289	6	595	1
855	290	6	596	1
858	291	6	599	1
861	292	6	606	1
864	293	6	607	1
867	294	6	609	1
870	295	6	610	1
873	296	6	611	1
876	297	6	612	1
879	298	6	613	1
882	299	6	615	1
885	300	6	616	1
888	301	6	617	1
891	302	6	618	1
894	303	6	619	1
897	304	6	620	1
900	305	6	621	1
903	306	6	622	1
906	307	6	623	1
909	308	6	624	1
912	309	6	625	1
915	310	6	626	1
918	311	6	627	1
921	312	6	629	1
924	313	6	633	1
927	314	6	634	1
930	315	6	637	1
933	316	6	638	1
936	317	6	640	1
939	318	6	641	1
942	319	6	643	1
945	320	6	644	1
948	321	6	645	1
951	322	6	649	1
954	323	6	651	1
957	324	6	652	1
960	325	6	653	1
963	326	6	656	1
966	327	6	657	1
969	328	6	658	1
972	329	6	660	1
975	330	6	665	1
978	331	6	667	1
981	332	6	668	1
984	333	6	669	1
987	334	6	670	1
990	335	6	671	1
993	336	6	673	1
996	337	6	674	1
999	338	6	675	1
1002	339	6	678	1
1005	340	6	680	1
1008	341	6	681	1
1011	342	6	685	1
1014	343	6	688	1
1017	344	6	690	1
1020	345	6	692	1
1023	346	6	693	1
1026	347	6	694	1
1029	348	6	696	1
1032	349	6	697	1
1035	350	6	699	1
1038	351	6	706	1
1041	352	6	707	1
1044	353	6	729	1
1047	354	6	730	1
1050	355	6	731	1
1053	356	6	741	1
1056	357	6	742	1
1059	358	6	747	1
1062	359	6	748	1
1065	360	6	750	1
1067	361	6	751	1
1070	362	6	758	1
1073	363	6	759	1
1076	364	6	760	1
1079	365	6	761	1
1082	366	6	762	1
1085	367	6	763	1
1088	368	6	764	1
1091	369	6	769	1
1094	370	6	770	1
1097	371	6	772	1
1100	372	6	773	1
1106	375	6	775	1
1110	377	6	776	1
1113	378	6	780	1
1116	379	6	787	1
1119	380	6	800	1
1122	381	6	801	1
1125	382	6	810	1
1128	383	6	828	1
1131	384	6	829	1
1134	385	6	886	1
1137	386	6	887	1
1140	387	6	888	1
1143	388	6	903	1
1146	389	6	911	1
1149	390	6	912	1
1152	391	6	913	1
1155	392	6	997	1
1158	393	6	998	1
1162	395	6	999	1
1165	396	6	1000	1
1168	397	6	1010	1
1173	399	6	2053	1
1175	400	6	4045	1
1180	401	6	5678	1
1183	402	6	5679	1
1184	403	6	8000	1
1186	403	6	8001	1
1187	403	6	8002	1
1188	403	6	8003	1
1189	404	6	2049	1
1195	406	6	3050	1
1198	407	6	6010	1
1201	408	6	14000	1
1204	409	6	8081	1
1207	410	6	9550	1
1210	411	6	7530	1
1213	412	6	65535	1
1216	413	6	270	1
1221	415	6	2393	1
1223	416	6	6881	1
1233	420	6	6699	1
1235	421	6	1412	1
1238	422	6	2234	1
1240	423	6	1494	1
1250	426	6	119	1
1253	427	6	563	1
1256	428	6	123	1
1258	428	6	2009	1
1259	428	6	98	1
1264	430	6	114	1
1267	431	6	433	1
1270	432	6	532	1
1273	433	6	991	1
1283	434	6	1993	1
1284	434	6	161	1
1285	435	6	162	1
1286	436	6	199	1
1289	437	6	391	1
1292	438	6	705	1
1299	439	6	42	1
1301	439	6	53	1
1305	439	6	5353	1
1307	439	6	5354	1
1309	439	6	1052	1
1311	439	6	2164	1
1316	440	6	1098	1
1317	440	6	1099	1
1318	440	6	10990	1
1321	441	6	3407	1
1323	441	6	389	1
1325	441	6	3269	1
1327	441	6	1760	1
1330	442	6	636	1
1331	443	6	43	1
1339	445	6	33	1
1342	446	6	39	1
1346	450	6	79	1
1349	451	6	81	1
1352	452	6	90	1
1355	453	6	105	1
1358	454	6	136	1
1361	455	6	142	1
1364	456	6	191	1
1367	457	6	195	1
1370	458	6	196	1
1373	459	6	197	1
1376	460	6	198	1
1379	461	6	202	1
1382	462	6	261	1
1385	463	6	263	1
1388	464	6	520	1
1390	465	6	522	1
1393	466	6	535	1
1396	467	6	553	1
1399	468	6	597	1
1402	469	6	648	1
1405	470	6	683	1
1408	471	6	684	1
1411	472	6	900	1
1416	475	6	1512	1
1419	476	6	3075	1
1422	477	6	3076	1
1425	478	6	3396	1
1426	478	6	3800	1
1427	478	6	3910	1
1428	478	6	3911	1
1429	478	6	5309	1
1430	478	6	35	1
1431	478	6	92	1
1434	478	6	515	1
1436	478	6	631	1
1437	478	6	1392	1
1438	478	6	9100	1
1440	480	6	165	1
1443	481	6	170	1
1449	485	6	666	1
1453	486	6	1723	1
1454	487	6	103	1
1457	488	6	524	1
1460	489	6	771	1
1467	491	6	88	1
1469	492	6	4500	1
1472	494	6	113	1
1473	494	6	512	1
1474	494	6	2478	1
1476	495	6	2821	1
1477	495	6	3113	1
1478	495	6	3207	1
1479	495	6	4311	1
1480	495	6	3710	1
1481	495	6	7004	1
1482	495	6	9002	1
1483	495	6	27999	1
1484	495	6	1812	1
1486	495	6	1813	1
1487	495	6	2083	1
1488	495	6	3799	1
1489	495	6	1504	1
1490	495	6	2646	1
1491	496	6	48	1
1494	497	6	49	1
1497	498	6	56	1
1500	499	6	126	1
1503	500	6	129	1
1506	501	6	169	1
1509	502	6	223	1
1512	503	6	265	1
1515	504	6	359	1
1518	505	6	464	1
1521	506	6	500	1
1524	507	6	509	1
1527	508	6	510	1
1530	509	6	584	1
1533	510	6	586	1
1536	511	6	655	1
1539	512	6	663	1
1542	513	6	664	1
1545	514	6	709	1
1548	515	6	710	1
1551	516	6	749	1
1556	518	6	752	1
1559	519	6	753	1
1562	520	6	774	1
1567	523	6	6129	1
1569	524	6	22	1
1571	524	6	614	1
1572	524	6	3897	1
1573	524	6	17235	1
1576	526	6	695	1
1582	529	6	23	1
1583	529	6	89	1
1585	529	6	107	1
1586	529	6	513	1
1589	530	6	992	1
1593	533	6	221	1
1596	534	6	222	1
1602	537	6	1300	1
1603	537	6	1718	1
1604	537	6	1719	1
1605	537	6	1720	1
1606	537	6	11720	1
1608	539	6	466	1
1611	540	6	516	1
1614	541	6	583	1
1617	542	6	600	1
1621	543	6	194	1
1622	543	6	529	1
1625	544	6	994	1
1628	545	6	5050	1
1631	545	6	1168	1
1632	545	6	5010	1
1633	545	6	6667	1
1634	545	6	6670	1
1636	545	6	517	1
1639	545	6	518	1
1642	545	6	12345	1
1644	546	6	258	1
1649	548	6	531	1
1652	549	6	754	1
1655	550	6	902	1
1659	551	6	1411	1
1660	551	6	7070	1
1664	552	6	8554	1
1665	552	6	322	1
1666	552	6	554	1
1669	553	6	458	1
1670	554	6	420	1
1673	555	6	498	1
1676	558	6	537	1
1681	559	6	25	1
1682	559	6	2390	1
1690	562	6	143	1
1693	563	6	993	1
1695	563	6	585	1
1699	564	6	110	1
1704	565	6	995	1
1710	566	6	109	1
1713	567	6	220	1
1715	568	6	50	1
1718	569	6	58	1
1721	570	6	61	1
1724	571	6	158	1
1727	572	6	174	1
1730	573	6	209	1
1733	574	6	210	1
1736	575	6	312	1
1739	576	6	366	1
1742	577	6	406	1
1745	578	6	413	1
1748	579	6	473	1
1751	580	6	505	1
1757	583	6	628	1
1760	584	6	632	1
1763	585	6	642	1
1766	586	6	1109	1
1768	587	6	1352	1
1772	588	6	20	1
1773	588	6	21	1
1774	588	6	47	1
1777	588	6	115	1
1779	588	6	152	1
1781	588	6	349	1
1782	588	6	5402	1
1784	588	6	574	1
1788	589	6	69	1
1790	589	6	1758	1
1792	589	6	1818	1
1796	590	6	989	1
1797	590	6	990	1
1800	591	6	3713	1
1802	592	6	6620	1
1803	592	6	6621	1
1806	595	6	82	1
1809	596	6	97	1
1814	599	6	189	1
1817	600	6	247	1
1820	601	6	317	1
1824	603	6	469	1
1827	604	6	487	1
1830	605	6	540	1
1833	606	6	541	1
1837	608	6	608	1
1840	609	6	662	1
1843	610	6	682	1
1846	611	6	873	1
1852	613	6	80	1
1853	613	6	8080	1
1856	613	6	280	1
1858	613	6	488	1
1859	613	6	591	1
1860	613	6	593	1
1861	613	6	777	1
1862	613	6	1183	1
1864	613	6	2301	1
1865	613	6	2688	1
1866	613	6	2851	1
1867	613	6	3106	1
1868	613	6	4848	1
1869	613	6	4849	1
1870	613	6	8008	1
1871	613	6	8088	1
1872	613	6	8118	1
1873	613	6	8444	1
1874	613	6	8910	1
1877	614	6	443	1
1878	614	6	1184	1
1880	614	6	2381	1
1881	614	6	8443	1
1884	615	6	70	1
1887	616	6	605	1
1888	616	6	7627	1
1889	616	6	16992	1
1890	616	6	16993	1
1892	618	6	311	1
1895	619	6	418	1
1899	621	6	575	1
1906	624	6	598	1
1911	626	6	635	1
1914	627	6	650	1
1919	629	6	3128	1
1921	630	6	7001	1
1924	631	6	9080	1
1927	632	6	2907	1
1931	633	6	3306	1
1933	634	6	1521	1
1936	635	6	1433	1
1937	635	6	1434	1
1939	636	6	4333	1
1941	637	6	2638	1
1942	637	6	7200	1
1945	638	6	65	1
1948	639	6	66	1
1951	640	6	118	1
1954	641	6	134	1
1957	642	6	150	1
1960	643	6	156	1
1963	644	6	217	1
1966	645	6	511	1
1969	646	6	523	1
1972	647	6	630	1
1979	650	6	1524	1
1982	651	6	2361	1
1983	651	6	3081	1
1984	651	6	3082	1
1985	651	6	3083	1
1986	652	6	13	1
1989	653	6	17	1
1992	654	6	37	1
1996	655	6	52	1
1999	656	6	76	1
2002	657	6	78	1
2005	658	6	83	1
2008	658	6	85	1
2010	659	6	124	1
2013	660	6	125	1
2016	661	6	127	1
2019	662	6	133	1
2022	663	6	135	1
2025	664	6	140	1
2028	665	6	141	1
2031	666	6	149	1
2034	667	6	171	1
2037	668	6	259	1
2040	669	6	384	1
2043	670	6	519	1
2046	671	6	546	1
2049	672	6	547	1
2053	674	6	639	1
2056	675	6	647	1
2059	676	6	661	1
2062	677	6	686	1
2065	678	6	687	1
2068	679	6	689	1
2071	680	6	704	1
2074	681	6	765	1
2077	682	6	847	1
2080	683	6	7100	1
2082	684	6	3528	1
2085	685	6	3529	1
2088	686	6	2531	1
2093	688	6	18	1
2099	690	6	29	1
2102	691	6	31	1
2105	692	6	44	1
2108	693	6	45	1
2111	694	6	46	1
2114	695	6	157	1
2117	696	6	218	1
2120	697	6	444	1
2123	698	6	478	1
2126	699	6	1241	1
2129	700	6	9535	1
2131	701	6	6112	1
2133	702	6	1801	1
2136	703	6	4800	1
2139	704	6	38	1
2142	704	6	256	1
2144	705	6	153	1
2147	706	6	159	1
2150	707	6	160	1
2153	708	6	167	1
2156	709	6	179	1
2159	710	6	190	1
2162	711	6	201	1
2165	712	6	224	1
2168	713	6	245	1
2171	714	6	264	1
2174	715	6	386	1
2177	716	6	387	1
2182	718	6	521	1
2185	719	6	646	1
2188	720	6	654	1
2191	721	6	679	1
2194	722	6	691	1
2197	723	6	698	1
2200	724	6	711	1
2203	725	6	137	1
2208	726	6	138	1
2211	727	6	139	1
2214	728	6	215	1
2217	729	6	445	1
2220	730	6	543	1
2223	731	6	544	1
2226	732	6	545	1
2229	733	6	568	1
2232	734	6	569	1
2235	735	6	901	1
2238	736	6	3389	1
2240	737	6	128	1
2243	738	6	744	1
2246	739	6	996	1
2249	740	6	144	1
2252	741	6	151	1
2255	742	6	163	1
2258	743	6	164	1
2261	744	6	192	1
2264	745	6	193	1
2267	746	6	200	1
2270	747	6	213	1
2273	748	6	376	1
2276	749	6	381	1
2279	750	6	382	1
2282	751	6	383	1
2285	752	6	401	1
2288	753	6	408	1
2291	754	6	409	1
2294	755	6	410	1
2297	756	6	411	1
2300	757	6	412	1
2303	758	6	414	1
2306	759	6	423	1
2309	760	6	424	1
2312	761	6	441	1
2315	762	6	463	1
2318	763	6	468	1
2321	764	6	489	1
2324	765	6	501	1
2327	766	6	530	1
2330	767	6	672	1
2333	768	6	676	1
2336	769	6	677	1
2339	770	6	1214	1
2342	771	6	6000	1
2344	771	6	6001	1
2345	771	6	6002	1
2346	771	6	6003	1
2347	771	6	7770	1
2348	771	6	7771	1
2349	771	6	7772	1
2350	771	6	7773	1
2351	771	6	7774	1
2352	771	6	7775	1
2355	772	6	6346	1
2358	773	6	6347	1
2359	774	6	7000	1
2362	775	6	4662	1
2364	776	6	1025	1
2366	777	6	5800	1
2368	777	6	5900	1
2369	778	6	6364	1
2371	779	6	767	1
2408	424	6	9595	1
2412	15	6	5	1
2418	425	6	5813	1
3	2	17	514	1
5	2	17	601	1
15	7	17	2434	1
21	10	17	5000	1
24	10	17	5001	1
27	11	17	6969	1
32	13	17	1	1
35	14	17	2	1
37	14	17	3	1
43	16	17	7	1
46	17	17	9	1
49	18	17	11	1
52	19	17	19	1
55	20	17	27	1
58	21	17	41	1
61	22	17	51	1
64	23	17	54	1
67	24	17	55	1
70	25	17	62	1
73	26	17	63	1
76	27	17	64	1
79	28	17	67	1
82	29	17	68	1
85	30	17	71	1
88	31	17	72	1
91	32	17	73	1
94	33	17	74	1
97	34	17	84	1
100	35	17	86	1
103	36	17	91	1
106	37	17	93	1
109	38	17	94	1
112	39	17	95	1
115	40	17	96	1
118	41	17	99	1
123	43	17	101	1
126	44	17	102	1
129	45	17	104	1
132	46	17	106	1
135	47	17	108	1
138	48	17	111	1
141	49	17	112	1
144	50	17	116	1
147	51	17	117	1
150	52	17	120	1
153	53	17	121	1
156	54	17	122	1
159	55	17	130	1
162	56	17	131	1
165	57	17	132	1
168	58	17	145	1
171	59	17	146	1
174	60	17	147	1
177	61	17	148	1
180	62	17	154	1
183	63	17	155	1
186	64	17	166	1
189	65	17	168	1
192	67	17	172	1
196	68	17	173	1
199	69	17	175	1
202	70	17	176	1
205	71	17	177	1
208	72	17	178	1
211	73	17	180	1
214	74	17	181	1
217	75	17	182	1
220	76	17	183	1
223	77	17	184	1
226	78	17	185	1
229	79	17	186	1
232	80	17	187	1
235	81	17	188	1
238	82	17	203	1
241	83	17	204	1
244	84	17	205	1
247	85	17	206	1
250	86	17	207	1
253	87	17	208	1
256	88	17	211	1
259	89	17	212	1
262	90	17	214	1
265	91	17	216	1
268	92	17	219	1
271	93	17	242	1
274	94	17	243	1
277	95	17	244	1
280	96	17	246	1
283	97	17	248	1
286	98	17	257	1
289	99	17	260	1
292	100	17	262	1
295	101	17	266	1
298	102	17	267	1
301	103	17	268	1
304	104	17	281	1
307	105	17	282	1
310	106	17	283	1
313	107	17	284	1
316	108	17	286	1
319	109	17	287	1
322	110	17	308	1
325	111	17	309	1
328	112	17	310	1
331	113	17	313	1
334	114	17	314	1
337	115	17	315	1
340	116	17	316	1
343	117	17	318	1
346	118	17	319	1
349	119	17	320	1
352	120	17	321	1
355	121	17	333	1
358	122	17	344	1
361	123	17	345	1
364	124	17	346	1
367	125	17	347	1
370	126	17	348	1
373	127	17	350	1
376	128	17	351	1
379	129	17	352	1
382	130	17	353	1
385	131	17	354	1
388	132	17	355	1
391	133	17	356	1
394	134	17	357	1
397	135	17	358	1
400	136	17	360	1
403	137	17	361	1
406	138	17	362	1
409	139	17	363	1
412	140	17	364	1
415	141	17	365	1
418	142	17	367	1
421	143	17	368	1
424	144	17	369	1
427	145	17	370	1
430	146	17	371	1
433	147	17	372	1
436	148	17	373	1
439	149	17	374	1
442	150	17	375	1
445	151	17	377	1
448	152	17	378	1
451	153	17	379	1
454	154	17	380	1
457	155	17	385	1
460	156	17	388	1
463	157	17	390	1
466	158	17	392	1
469	159	17	393	1
472	160	17	394	1
475	161	17	395	1
478	162	17	396	1
481	163	17	397	1
484	164	17	398	1
487	165	17	399	1
490	166	17	400	1
493	167	17	402	1
496	168	17	403	1
499	169	17	404	1
502	170	17	405	1
505	171	17	407	1
508	172	17	415	1
511	173	17	416	1
514	174	17	417	1
517	175	17	419	1
520	176	17	421	1
523	177	17	422	1
526	178	17	425	1
529	179	17	426	1
532	180	17	427	1
535	181	17	428	1
538	182	17	429	1
541	183	17	430	1
544	184	17	431	1
547	185	17	432	1
550	186	17	434	1
553	187	17	435	1
556	188	17	436	1
559	189	17	437	1
562	190	17	438	1
565	191	17	439	1
568	192	17	440	1
571	193	17	442	1
574	194	17	446	1
577	195	17	447	1
580	196	17	448	1
583	197	17	449	1
586	198	17	450	1
589	199	17	451	1
592	200	17	452	1
595	201	17	453	1
598	202	17	454	1
601	203	17	455	1
604	205	17	456	1
608	206	17	457	1
611	207	17	459	1
614	208	17	460	1
617	209	17	461	1
620	210	17	462	1
623	212	17	465	1
627	213	17	467	1
630	214	17	470	1
633	215	17	471	1
636	216	17	472	1
639	218	17	474	1
643	219	17	475	1
646	220	17	476	1
649	221	17	477	1
652	222	17	479	1
655	223	17	480	1
658	224	17	481	1
661	225	17	482	1
664	226	17	483	1
667	227	17	484	1
670	228	17	485	1
673	229	17	486	1
676	230	17	490	1
679	231	17	491	1
682	232	17	492	1
685	233	17	493	1
688	234	17	494	1
691	235	17	495	1
694	236	17	496	1
697	237	17	497	1
700	238	17	499	1
703	239	17	502	1
706	240	17	503	1
709	241	17	504	1
712	242	17	506	1
715	243	17	507	1
718	244	17	508	1
723	246	17	525	1
726	247	17	526	1
729	248	17	527	1
732	249	17	528	1
735	250	17	533	1
738	251	17	534	1
741	252	17	536	1
744	253	17	538	1
747	254	17	539	1
750	255	17	542	1
753	256	17	548	1
756	257	17	549	1
759	258	17	550	1
762	259	17	551	1
765	260	17	552	1
768	261	17	555	1
771	262	17	556	1
774	263	17	557	1
777	264	17	558	1
780	265	17	559	1
783	266	17	560	1
786	267	17	561	1
789	268	17	562	1
792	269	17	564	1
795	270	17	565	1
798	271	17	566	1
801	272	17	567	1
804	273	17	570	1
806	273	17	571	1
809	274	17	572	1
812	275	17	573	1
815	276	17	576	1
818	277	17	577	1
821	278	17	578	1
824	279	17	579	1
827	280	17	580	1
830	281	17	581	1
833	282	17	582	1
836	283	17	587	1
839	284	17	588	1
842	285	17	589	1
845	286	17	590	1
848	287	17	592	1
851	288	17	594	1
854	289	17	595	1
857	290	17	596	1
860	291	17	599	1
863	292	17	606	1
866	293	17	607	1
869	294	17	609	1
872	295	17	610	1
875	296	17	611	1
878	297	17	612	1
881	298	17	613	1
884	299	17	615	1
887	300	17	616	1
890	301	17	617	1
893	302	17	618	1
896	303	17	619	1
899	304	17	620	1
902	305	17	621	1
905	306	17	622	1
908	307	17	623	1
911	308	17	624	1
914	309	17	625	1
917	310	17	626	1
920	311	17	627	1
923	312	17	629	1
926	313	17	633	1
929	314	17	634	1
932	315	17	637	1
935	316	17	638	1
938	317	17	640	1
941	318	17	641	1
944	319	17	643	1
947	320	17	644	1
950	321	17	645	1
953	322	17	649	1
956	323	17	651	1
959	324	17	652	1
962	325	17	653	1
965	326	17	656	1
968	327	17	657	1
971	328	17	658	1
974	329	17	660	1
977	330	17	665	1
980	331	17	667	1
983	332	17	668	1
986	333	17	669	1
989	334	17	670	1
992	335	17	671	1
995	336	17	673	1
998	337	17	674	1
1001	338	17	675	1
1004	339	17	678	1
1007	340	17	680	1
1010	341	17	681	1
1013	342	17	685	1
1016	343	17	688	1
1019	344	17	690	1
1022	345	17	692	1
1025	346	17	693	1
1028	347	17	694	1
1031	348	17	696	1
1034	349	17	697	1
1037	350	17	699	1
1040	351	17	706	1
1043	352	17	707	1
1046	353	17	729	1
1049	354	17	730	1
1052	355	17	731	1
1055	356	17	741	1
1058	357	17	742	1
1061	358	17	747	1
1064	359	17	748	1
1069	361	17	751	1
1072	362	17	758	1
1075	363	17	759	1
1078	364	17	760	1
1081	365	17	761	1
1084	366	17	762	1
1087	367	17	763	1
1090	368	17	764	1
1093	369	17	769	1
1096	370	17	770	1
1099	371	17	772	1
1102	373	17	773	1
1104	374	17	774	1
1108	376	17	775	1
1112	377	17	776	1
1115	378	17	780	1
1118	379	17	787	1
1121	380	17	800	1
1124	381	17	801	1
1127	382	17	810	1
1130	383	17	828	1
1133	384	17	829	1
1136	385	17	886	1
1139	386	17	887	1
1142	387	17	888	1
1145	388	17	903	1
1148	389	17	911	1
1151	390	17	912	1
1154	391	17	913	1
1157	392	17	997	1
1160	394	17	998	1
1164	395	17	999	1
1167	396	17	1000	1
1170	397	17	1010	1
1171	398	17	1167	1
1177	400	17	4045	1
1178	401	17	5678	1
1181	402	17	5679	1
1190	404	17	2049	1
1193	405	17	9996	1
1197	406	17	3050	1
1200	407	17	6010	1
1203	408	17	14000	1
1206	409	17	8081	1
1209	410	17	9550	1
1212	411	17	7530	1
1215	412	17	65535	1
1218	414	17	1645	1
1220	414	17	1646	1
1225	416	17	6881	1
1226	417	17	6112	1
1228	418	17	3823	1
1230	419	17	4672	1
1232	419	17	4660	1
1237	421	17	1412	1
1242	423	17	1604	1
1251	426	17	119	1
1254	427	17	563	1
1260	428	17	123	1
1263	429	17	98	1
1266	430	17	114	1
1269	431	17	433	1
1272	432	17	532	1
1275	433	17	991	1
1277	434	17	161	1
1278	434	17	162	1
1288	436	17	199	1
1291	437	17	391	1
1294	438	17	705	1
1298	439	17	42	1
1300	439	17	53	1
1304	439	17	5353	1
1306	439	17	5354	1
1310	439	17	1052	1
1312	439	17	2164	1
1320	441	17	3407	1
1322	441	17	389	1
1324	441	17	3269	1
1326	441	17	1760	1
1329	442	17	636	1
1332	443	17	43	1
1333	443	17	513	1
1341	445	17	33	1
1344	446	17	39	1
1348	450	17	79	1
1351	451	17	81	1
1354	452	17	90	1
1357	453	17	105	1
1360	454	17	136	1
1363	455	17	142	1
1366	456	17	191	1
1369	457	17	195	1
1372	458	17	196	1
1375	459	17	197	1
1378	460	17	198	1
1381	461	17	202	1
1384	462	17	261	1
1387	463	17	263	1
1392	465	17	522	1
1395	466	17	535	1
1398	467	17	553	1
1401	468	17	597	1
1404	469	17	648	1
1407	470	17	683	1
1410	471	17	684	1
1413	472	17	900	1
1414	473	17	1098	1
1415	474	17	1099	1
1418	475	17	1512	1
1421	476	17	3075	1
1424	477	17	3076	1
1439	479	17	92	1
1442	480	17	165	1
1445	481	17	170	1
1447	483	17	515	1
1448	484	17	631	1
1451	485	17	666	1
1456	487	17	103	1
1459	488	17	524	1
1462	489	17	771	1
1463	490	17	1701	1
1466	491	17	88	1
1475	494	17	113	1
1493	496	17	48	1
1496	497	17	49	1
1499	498	17	56	1
1502	499	17	126	1
1505	500	17	129	1
1508	501	17	169	1
1511	502	17	223	1
1514	503	17	265	1
1517	504	17	359	1
1520	505	17	464	1
1523	506	17	500	1
1526	507	17	509	1
1529	508	17	510	1
1532	509	17	584	1
1535	510	17	586	1
1538	511	17	655	1
1541	512	17	663	1
1544	513	17	664	1
1547	514	17	709	1
1550	515	17	710	1
1553	516	17	749	1
1554	517	17	750	1
1558	518	17	752	1
1561	519	17	753	1
1564	521	17	1812	1
1565	522	17	1813	1
1574	524	17	22	1
1575	525	17	614	1
1578	526	17	695	1
1587	529	17	23	1
1591	531	17	89	1
1592	532	17	107	1
1595	533	17	221	1
1598	534	17	222	1
1600	536	17	992	1
1607	538	17	458	1
1610	539	17	466	1
1613	540	17	516	1
1616	541	17	583	1
1619	542	17	600	1
1623	543	17	194	1
1626	544	17	994	1
1635	545	17	517	1
1638	545	17	518	1
1641	545	17	12345	1
1646	546	17	258	1
1648	547	17	529	1
1651	548	17	531	1
1654	549	17	754	1
1657	550	17	902	1
1662	552	17	554	1
1672	554	17	420	1
1675	555	17	498	1
1678	558	17	537	1
1685	559	17	25	1
1691	562	17	143	1
1697	563	17	993	1
1702	564	17	110	1
1708	565	17	995	1
1711	566	17	109	1
1714	567	17	220	1
1717	568	17	50	1
1720	569	17	58	1
1723	570	17	61	1
1726	571	17	158	1
1729	572	17	174	1
1732	573	17	209	1
1735	574	17	210	1
1738	575	17	312	1
1741	576	17	366	1
1744	577	17	406	1
1747	578	17	413	1
1750	579	17	473	1
1753	580	17	505	1
1754	581	17	512	1
1756	582	17	585	1
1759	583	17	628	1
1762	584	17	632	1
1765	585	17	642	1
1770	587	17	1352	1
1786	588	17	21	1
1794	589	17	69	1
1798	590	17	990	1
1804	593	17	20	1
1805	594	17	47	1
1808	595	17	82	1
1811	596	17	97	1
1812	597	17	115	1
1813	598	17	152	1
1816	599	17	189	1
1819	600	17	247	1
1822	601	17	317	1
1823	602	17	349	1
1826	603	17	469	1
1829	604	17	487	1
1832	605	17	540	1
1835	606	17	541	1
1836	607	17	574	1
1839	608	17	608	1
1842	609	17	662	1
1845	610	17	682	1
1848	611	17	873	1
1850	612	17	989	1
1875	613	17	80	1
1882	614	17	443	1
1885	615	17	70	1
1891	617	17	280	1
1894	618	17	311	1
1897	619	17	418	1
1898	620	17	488	1
1901	621	17	575	1
1903	622	17	591	1
1905	623	17	593	1
1908	624	17	598	1
1910	625	17	605	1
1913	626	17	635	1
1916	627	17	650	1
1918	628	17	777	1
1923	630	17	7001	1
1926	631	17	9080	1
1929	632	17	2907	1
1944	637	17	7200	1
1947	638	17	65	1
1950	639	17	66	1
1953	640	17	118	1
1956	641	17	134	1
1959	642	17	150	1
1962	643	17	156	1
1965	644	17	217	1
1968	645	17	511	1
1971	646	17	523	1
1974	647	17	630	1
1976	648	17	1433	1
1978	649	17	1434	1
1988	652	17	13	1
1991	653	17	17	1
1995	654	17	37	1
1998	655	17	52	1
2001	656	17	76	1
2004	657	17	78	1
2007	658	17	83	1
2009	658	17	85	1
2012	659	17	124	1
2015	660	17	125	1
2018	661	17	127	1
2021	662	17	133	1
2024	663	17	135	1
2027	664	17	140	1
2030	665	17	141	1
2033	666	17	149	1
2036	667	17	171	1
2039	668	17	259	1
2042	669	17	384	1
2045	670	17	519	1
2048	671	17	546	1
2051	672	17	547	1
2055	674	17	639	1
2058	675	17	647	1
2061	676	17	661	1
2064	677	17	686	1
2067	678	17	687	1
2070	679	17	689	1
2073	680	17	704	1
2076	681	17	765	1
2079	682	17	847	1
2084	684	17	3528	1
2087	685	17	3529	1
2090	686	17	2531	1
2091	687	17	2535	1
2095	688	17	18	1
2096	689	17	1025	1
2097	689	17	1026	1
2098	689	17	1027	1
2101	690	17	29	1
2104	691	17	31	1
2107	692	17	44	1
2110	693	17	45	1
2113	694	17	46	1
2116	695	17	157	1
2119	696	17	218	1
2122	697	17	444	1
2125	698	17	478	1
2128	699	17	1241	1
2135	702	17	1801	1
2138	703	17	4800	1
2141	704	17	38	1
2143	704	17	256	1
2146	705	17	153	1
2149	706	17	159	1
2152	707	17	160	1
2155	708	17	167	1
2158	709	17	179	1
2161	710	17	190	1
2164	711	17	201	1
2167	712	17	224	1
2170	713	17	245	1
2173	714	17	264	1
2176	715	17	386	1
2179	716	17	387	1
2180	717	17	520	1
2184	718	17	521	1
2187	719	17	646	1
2190	720	17	654	1
2193	721	17	679	1
2196	722	17	691	1
2199	723	17	698	1
2202	724	17	711	1
2207	725	17	137	1
2210	726	17	138	1
2213	727	17	139	1
2216	728	17	215	1
2219	729	17	445	1
2222	730	17	543	1
2225	731	17	544	1
2228	732	17	545	1
2231	733	17	568	1
2234	734	17	569	1
2237	735	17	901	1
2242	737	17	128	1
2245	738	17	744	1
2248	739	17	996	1
2251	740	17	144	1
2254	741	17	151	1
2257	742	17	163	1
2260	743	17	164	1
2263	744	17	192	1
2266	745	17	193	1
2269	746	17	200	1
2272	747	17	213	1
2275	748	17	376	1
2278	749	17	381	1
2281	750	17	382	1
2284	751	17	383	1
2287	752	17	401	1
2290	753	17	408	1
2293	754	17	409	1
2296	755	17	410	1
2299	756	17	411	1
2302	757	17	412	1
2305	758	17	414	1
2308	759	17	423	1
2311	760	17	424	1
2314	761	17	441	1
2317	762	17	463	1
2320	763	17	468	1
2323	764	17	489	1
2326	765	17	501	1
2329	766	17	530	1
2332	767	17	672	1
2335	768	17	676	1
2338	769	17	677	1
2341	770	17	1214	1
2353	772	17	6346	1
2356	773	17	6347	1
2361	774	17	7000	1
2373	779	17	767	1
2414	15	17	5	1
2419	781	6	6536	2
\.

ALTER SEQUENCE tblprotocolidentifier_id_seq RESTART 3000; 

ALTER TABLE ONLY tblprotocolidentifier
    ADD CONSTRAINT tblprotocolidentifier_pkey PRIMARY KEY (id);

ALTER TABLE ONLY tblprotocolidentifier
    ADD CONSTRAINT tblprotocolidentifier_protocol_key UNIQUE (protocol, port);


DROP TABLE IF EXISTS tblreport;
CREATE TABLE tblreport (
    reportid serial primary key,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    inputparams character varying(255) DEFAULT NULL::character varying,
    query text,
    graphid integer DEFAULT 0 NOT NULL,
    reportformatid integer DEFAULT 0 NOT NULL,
    ispagewisereport integer DEFAULT 0 NOT NULL,
    defaultcolumnforsort character varying(50) DEFAULT NULL::character varying,
    querytype integer DEFAULT 1,
    totalquery text,
    issinglereport integer DEFAULT 0 NOT NULL
);

COPY tblreport (reportid, title, inputparams, query, graphid, reportformatid, ispagewisereport, defaultcolumnforsort, querytype, totalquery, issinglereport) FROM stdin;
41110000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,category	select domain,sum(hits) as hits,sum(bytes) as bytes from web_category_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and category like ''{9}''   and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	41110000	0	0	bytes	1		0
41111000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,category,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_category_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and category like ''{9}'' and domain like ''{10}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41111000	0	0	bytes	1		0
41551100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application,category	select domain,sum(hits) as hits,sum(bytes) as bytes from web_app_category_domain_host_user{4} where  "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and  INET_NTOA(host) like ''{9}'' and application like ''{10}'' and category like ''{11}''  and appid in ({7}) group by domain  order by {5} {6} limit {3} OFFSET {2}	41551100	0	0	bytes	1		0
41551110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application,category,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_app_category_domain_url_host_user{4} where  "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and application like ''{10}'' and  category like ''{11}'' and domain like ''{12}'' and appid in ({7}) group by url  order by {5} {6} limit {3} OFFSET {2}	41551110	0	0	bytes	1		0
42100000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category	select domain,sum(hits) as hits,sum(bytes) as bytes from web_category_domain{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	42100000	0	0	bytes	1		0
1436010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip	select application,sum(hits) as hits,sum(sent) as bytes from user_dest_application{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1436010	0	0	bytes	1		0
1520000	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select application,sum(hits) as hits,sum(total) as bytes from protogroup_application{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	1520000	0	0	bytes	1		0
43000000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select domain,sum(hits) as hits,sum(bytes) as bytes from web_domain{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	43000000	0	0	bytes	1		0
1520010	Top Users 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select username,sum(hits) as hits,sum(total) as bytes from protogroup_user{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1520010	0	0	bytes	1		0
1520020	Top Destinations  	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from protogroup_dest{4} where proto_group like ''{7}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	1520020	0	0	bytes	1		0
1520030	Top Hosts 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from protogroup_hosts{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	1520030	0	0	bytes	1		0
1436020	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from host_dest_user{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1436020	0	0	bytes	1		0
7100000	Top Denied Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username, sum(hits) as hits from blocked_user{4} where  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7100000	0	1	hits	1		0
7110000	Top Application Groups	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select proto_group, sum(hits) as hits from blocked_protogroup_user{4} where username=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY proto_group order by {5} {6} limit {3} OFFSET {2}	7110000	0	1	hits	1		0
7111000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,proto_group	select application, sum(hits) as hits from blocked_app_protogroup_user{4} where username=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7111000	0	1	hits	1		0
7111100	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,proto_group,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where username=''{8}'' and proto_group=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7111100	0	1	hits	1		0
7112000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,proto_group	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_protogroup_user{4} where username=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7112000	0	1	hits	1		0
7112100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,proto_group,destination	select application, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where username=''{8}'' and proto_group=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7112100	0	1	hits	1		0
7113000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,proto_group	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_host_protogroup_user{4} where username=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7113000	0	1	hits	1		0
7113100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,proto_group,host	select application, sum(hits) as hits from blocked_app_host_protogroup_user{4} where username=''{8}'' and proto_group=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7113100	0	1	hits	1		0
7113110	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,proto_group,host,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_protogroup_user{4} where username=''{8}'' and proto_group=''{9}'' and INET_NTOA(srcip)=''{10}'' and application=''{11}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7113110	0	1	hits	1		0
7120000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_user{4} where username=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7120000	0	1	hits	1		0
7121000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,destination	select application, sum(hits) as hits from blocked_app_dest_user{4} where username=''{8}'' and INET_NTOA(destip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7121000	0	1	hits	1		0
7121100	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,destination,application	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_app_dest_host_user{4} where username=''{8}'' and INET_NTOA(destip)=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7121100	0	1	hits	1		0
7122000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,destination	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_dest_host_user{4} where username=''{8}'' and INET_NTOA(destip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7122000	0	1	hits	1		0
7122100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,destination,host	select application, sum(hits) as hits from blocked_app_dest_host_user{4} where username=''{8}'' and INET_NTOA(destip)=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7122100	0	1	hits	1		0
7130000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_host_user{4} where username=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7130000	0	1	hits	1		0
7131000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select application, sum(hits) as hits from blocked_app_host_user{4} where username=''{8}'' and INET_NTOA(srcip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7131000	0	1	hits	1		0
7131100	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_user{4} where username=''{8}'' and INET_NTOA(srcip)=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7131100	0	1	hits	1		0
7132000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_host_user{4} where username=''{8}'' and INET_NTOA(srcip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7132000	0	1	hits	1		0
7132100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,destination	select application, sum(hits) as hits from blocked_app_dest_host_user{4} where username=''{8}'' and INET_NTOA(srcip)=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7132100	0	1	hits	1		0
7200000	Top Denied Application Groups	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select proto_group, sum(hits) as hits from blocked_protogroup{4} where  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY proto_group order by {5} {6} limit {3} OFFSET {2}	7200000	0	1	hits	1		0
7210000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group	select application, sum(hits) as hits from blocked_app_protogroup{4} where proto_group=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7210000	0	1	hits	1		0
7211000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application	select username, sum(hits) as hits from blocked_app_protogroup_user{4} where proto_group=''{8}'' and application=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7211000	0	1	hits	1		0
7211100	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application,username	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where proto_group=''{8}'' and application=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7211100	0	1	hits	1		0
7211200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application,username	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_app_host_protogroup_user{4} where proto_group=''{8}'' and application=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7211200	0	1	hits	1		0
7212000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_protogroup{4} where proto_group=''{8}'' and application=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7212000	0	1	hits	1		0
7212100	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application,destination	select username, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where proto_group=''{8}'' and application=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7212100	0	1	hits	1		0
7212200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application,destination	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where proto_group=''{8}'' and application=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7212200	0	1	hits	1		0
7213000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_app_host_protogroup{4} where proto_group=''{8}'' and application=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7213000	0	1	hits	1		0
7213100	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application,host	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where proto_group=''{8}'' and application=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7213100	0	1	hits	1		0
7213200	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,application,host	select username, sum(hits) as hits from blocked_app_host_protogroup_user{4} where proto_group=''{8}'' and application=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7213200	0	1	hits	1		0
7220000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group	select username, sum(hits) as hits from blocked_protogroup_user{4} where proto_group=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7220000	0	1	hits	1		0
7221000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username	select application, sum(hits) as hits from blocked_app_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7221000	0	1	hits	1		0
7221100	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7221100	0	1	hits	1		0
7221200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username,application	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_app_host_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7221200	0	1	hits	1		0
801010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(host) as host,domain,application,sum(hits) as hits from deniedweb_users_hosts_domains_application{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By host,domain,application order by {5} {6} limit {3} OFFSET {2}	801010	0	0	hits	1		0
802010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(host) as host,domain,application,sum(hits) as hits from deniedweb_users_hosts_domains_application{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By host,domain,application order by {5} {6} limit {3} OFFSET {2}	802010	0	0	hits	1		0
803010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,category,appid	select INET_NTOA(host) as host,domain,application,sum(hits) as hits from deniedweb_categories_hosts_domains_app{4} where category like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By host,domain,application order by {5} {6} limit {3} OFFSET {2}	803010	0	0	hits	1		0
804010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,category,appid	select INET_NTOA(host) as host,domain,application,sum(hits) as hits from deniedweb_categories_hosts_domains_app{4} where category like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By host,domain,application order by {5} {6} limit {3} OFFSET {2}	804010	0	0	hits	1		0
805010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,domain,appid	select username,INET_NTOA(host) as host,application,sum(hits) as hits from deniedweb_users_hosts_domains_app{4} where domain like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By host,username,application order by {5} {6} limit {3} OFFSET {2}	805010	0	0	hits	1		0
7222000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7222000	0	1	hits	1		0
7222100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username,destination	select application, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7222100	0	1	hits	1		0
7222200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username,destination	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_dest_host_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7222200	0	1	hits	1		0
7223000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_host_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7223000	0	1	hits	1		0
7223100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username,host	select application, sum(hits) as hits from blocked_app_host_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7223100	0	1	hits	1		0
7223110	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username,host,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and INET_NTOA(srcip)=''{10}'' and application=''{11}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7223110	0	1	hits	1		0
7223200	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username,host	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_host_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7223200	0	1	hits	1		0
7223210	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,username,host,destination	select application, sum(hits) as hits from blocked_app_dest_host_protogroup_user{4} where proto_group=''{8}'' and username=''{9}'' and INET_NTOA(srcip)=''{10}'' and INET_NTOA(destip)=''{11}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7223210	0	1	hits	1		0
7230000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_protogroup{4} where proto_group=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7230000	0	1	hits	1		0
7231000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination	select application, sum(hits) as hits from blocked_app_dest_protogroup{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7231000	0	1	hits	1		0
7231100	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination,application	select username, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7231100	0	1	hits	1		0
7231200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination,application	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7231200	0	1	hits	1		0
7232000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination	select username, sum(hits) as hits from blocked_dest_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7232000	0	1	hits	1		0
7232100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination,username	select application, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7232100	0	1	hits	1		0
7232200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination,username	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_dest_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7232200	0	1	hits	1		0
7233000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_dest_host_protogroup{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7233000	0	1	hits	1		0
7233100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination,host	select application, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7233100	0	1	hits	1		0
7233200	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,destination,host	select username, sum(hits) as hits from blocked_dest_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(destip)=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7233200	0	1	hits	1		0
7240000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_host_protogroup{4} where proto_group=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7240000	0	1	hits	1		0
7241000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host	select application, sum(hits) as hits from blocked_app_host_protogroup{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7241000	0	1	hits	1		0
7241100	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7241100	0	1	hits	1		0
7241200	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host,application	select username, sum(hits) as hits from blocked_app_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7241200	0	1	hits	1		0
7242000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_host_protogroup{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7242000	0	1	hits	1		0
7242100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host,destination	select application, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7242100	0	1	hits	1		0
7242200	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host,destination	select username, sum(hits) as hits from blocked_dest_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7242200	0	1	hits	1		0
7243000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host	select username, sum(hits) as hits from blocked_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7243000	0	1	hits	1		0
7243100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host,username	select application, sum(hits) as hits from blocked_app_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7243100	0	1	hits	1		0
7243110	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host,username,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and username=''{10}'' and application=''{11}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7243110	0	1	hits	1		0
7243200	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host,username	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7243200	0	1	hits	1		0
7243210	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,proto_group,host,username,destination	select application, sum(hits) as hits from blocked_app_dest_host_protogroup_user{4} where proto_group=''{8}'' and INET_NTOA(srcip)=''{9}'' and username=''{10}'' and INET_NTOA(destip)=''{11}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7243210	0	1	hits	1		0
7300000	Top Denied Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_host{4} where  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7300000	0	1	hits	1		0
7310000	Top Application Groups	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select proto_group, sum(hits) as hits from blocked_host_protogroup{4} where INET_NTOA(srcip)=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY proto_group order by {5} {6} limit {3} OFFSET {2}	7310000	0	1	hits	1		0
7311000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,proto_group	select application, sum(hits) as hits from blocked_app_host_protogroup{4} where INET_NTOA(srcip)=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7311000	0	1	hits	1		0
7311100	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,proto_group,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where INET_NTOA(srcip)=''{8}'' and proto_group=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7311100	0	1	hits	1		0
7312000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,proto_group	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_host_protogroup{4} where INET_NTOA(srcip)=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7312000	0	1	hits	1		0
7312100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,proto_group,destination	select application, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where INET_NTOA(srcip)=''{8}'' and proto_group=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7312100	0	1	hits	1		0
7313000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,proto_group	select username, sum(hits) as hits from blocked_host_protogroup_user{4} where INET_NTOA(srcip)=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7313000	0	1	hits	1		0
7313100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,proto_group,username	select application, sum(hits) as hits from blocked_app_host_protogroup_user{4} where INET_NTOA(srcip)=''{8}'' and proto_group=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7313100	0	1	hits	1		0
7313110	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,proto_group,username,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_protogroup_user{4} where INET_NTOA(srcip)=''{8}'' and proto_group=''{9}'' and username=''{10}'' and application=''{11}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7313110	0	1	hits	1		0
7320000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_host{4} where INET_NTOA(srcip)=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7320000	0	1	hits	1		0
7321000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,destination	select application, sum(hits) as hits from blocked_app_dest_host{4} where INET_NTOA(srcip)=''{8}'' and INET_NTOA(destip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7321000	0	1	hits	1		0
7321100	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,destination,application	select username, sum(hits) as hits from blocked_app_dest_host_user{4} where INET_NTOA(srcip)=''{8}'' and INET_NTOA(destip)=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7321100	0	1	hits	1		0
7322000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,destination	select username, sum(hits) as hits from blocked_dest_host_user{4} where INET_NTOA(srcip)=''{8}'' and INET_NTOA(destip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7322000	0	1	hits	1		0
7322100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,destination,username	select application, sum(hits) as hits from blocked_app_dest_host_user{4} where INET_NTOA(srcip)=''{8}'' and INET_NTOA(destip)=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7322100	0	1	hits	1		0
7330000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select username, sum(hits) as hits from blocked_host_user{4} where INET_NTOA(srcip)=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7330000	0	1	hits	1		0
7331000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select application, sum(hits) as hits from blocked_app_host_user{4} where INET_NTOA(srcip)=''{8}'' and username=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7331000	0	1	hits	1		0
7331100	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_app_dest_host_user{4} where INET_NTOA(srcip)=''{8}'' and username=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7331100	0	1	hits	1		0
7332000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest_host_user{4} where INET_NTOA(srcip)=''{8}'' and username=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7332000	0	1	hits	1		0
7332100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,destination	select application, sum(hits) as hits from blocked_app_dest_host_user{4} where INET_NTOA(srcip)=''{8}'' and username=''{9}'' and INET_NTOA(destip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7332100	0	1	hits	1		0
7400000	Top Denied Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(destip) as destination, sum(hits) as hits from blocked_dest{4} where  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	7400000	0	1	hits	1		0
7410000	Top Application Groups	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination	select proto_group, sum(hits) as hits from blocked_dest_protogroup{4} where INET_NTOA(destip)=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY proto_group order by {5} {6} limit {3} OFFSET {2}	7410000	0	1	hits	1		0
1439010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip	select application,sum(hits) as hits,sum(received) as bytes from host_user_application{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1439010	0	0	bytes	1		0
7411000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group	select application, sum(hits) as hits from blocked_app_dest_protogroup{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7411000	0	1	hits	1		0
7411100	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group,application	select username, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7411100	0	1	hits	1		0
7411200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group,application	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7411200	0	1	hits	1		0
7412000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group	select username, sum(hits) as hits from blocked_dest_protogroup_user{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7412000	0	1	hits	1		0
7412100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group,username	select application, sum(hits) as hits from blocked_app_dest_protogroup_user{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7412100	0	1	hits	1		0
7412200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group,username	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_dest_host_protogroup_user{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7412200	0	1	hits	1		0
7413000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_dest_host_protogroup{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7413000	0	1	hits	1		0
7413100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group,host	select application, sum(hits) as hits from blocked_app_dest_host_protogroup{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7413100	0	1	hits	1		0
7413200	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,proto_group,host	select username, sum(hits) as hits from blocked_dest_host_protogroup_user{4} where INET_NTOA(destip)=''{8}'' and proto_group=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7413200	0	1	hits	1		0
7420000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination	select username, sum(hits) as hits from blocked_dest_user{4} where INET_NTOA(destip)=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7420000	0	1	hits	1		0
7421000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,username	select application, sum(hits) as hits from blocked_app_dest_user{4} where INET_NTOA(destip)=''{8}'' and username=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7421000	0	1	hits	1		0
7421100	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,username,application	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_app_dest_host_user{4} where INET_NTOA(destip)=''{8}'' and username=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7421100	0	1	hits	1		0
7422000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,username	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_dest_host_user{4} where INET_NTOA(destip)=''{8}'' and username=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7422000	0	1	hits	1		0
7422100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,username,host	select application, sum(hits) as hits from blocked_app_dest_host_user{4} where INET_NTOA(destip)=''{8}'' and username=''{9}'' and INET_NTOA(srcip)=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7422100	0	1	hits	1		0
7430000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination	select INET_NTOA(srcip) as host, sum(hits) as hits from blocked_dest_host{4} where INET_NTOA(destip)=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(srcip) order by {5} {6} limit {3} OFFSET {2}	7430000	0	1	hits	1		0
7431000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,host	select application, sum(hits) as hits from blocked_app_dest_host{4} where INET_NTOA(destip)=''{8}'' and INET_NTOA(srcip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7431000	0	1	hits	1		0
7431100	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,host,application	select username, sum(hits) as hits from blocked_app_dest_host_user{4} where INET_NTOA(destip)=''{8}'' and INET_NTOA(srcip)=''{9}'' and application=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7431100	0	1	hits	1		0
7432000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,host	select username, sum(hits) as hits from blocked_dest_host_user{4} where INET_NTOA(destip)=''{8}'' and INET_NTOA(srcip)=''{9}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	7432000	0	1	hits	1		0
7432100	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,destination,host,username	select application, sum(hits) as hits from blocked_app_dest_host_user{4} where INET_NTOA(destip)=''{8}'' and INET_NTOA(srcip)=''{9}'' and username=''{10}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	7432100	0	1	hits	1		0
4555200	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application	select content, sum(hits) as hits, sum(bytes) as bytes from web_app_content_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	4555200	0	1	bytes	1		0
4555210	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and application like ''{10}'' and content like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4555210	0	1	bytes	1		0
4560000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select application, sum(hits) as hits, sum(bytes) as bytes from web_app_host{4} where INET_NTOA(host) = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	4560000	0	1	bytes	1		0
4561000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application	select category, sum(hits) as hits, sum(bytes) as bytes from web_app_category_host{4} where INET_NTOA(host) = ''{8}'' and application like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	4561000	0	1	bytes	1		0
4561100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_host{4} where INET_NTOA(host) = ''{8}'' and application like ''{9}'' and category like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4561100	0	1	bytes	1		0
510000	Top Mail Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select sender,sum(hits) as hits, sum(bytes) as bytes from mail_sender{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	510000	0	1	bytes	1		0
511000	Top Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select recipient,sum(hits) as hits, sum(bytes) as bytes from mail_recipient_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	511000	0	1	bytes	1		0
511100	Top Recipients Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,recipient	select subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where sender=''{8}'' and recipient=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY subject,username,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	511100	0	1	size	1		0
512000	Top Source Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select INET_NTOA(host) as host,sum(hits) as hits, sum(bytes) as bytes from mail_host_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	512000	0	1	bytes	1		0
512100	Top Source Hosts Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,host	select recipient,subject,username,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where sender=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	512100	0	1	size	1		0
513000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select INET_NTOA(destip) as destination,sum(hits) as hits, sum(bytes) as bytes from mail_dest_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	513000	0	1	bytes	1		0
513100	Top Destinations Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,destination	select recipient,subject,username,INET_NTOA(host) as host,application, sum(bytes) as size from mail_detail{4} where sender=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(host),application order by {5} {6} limit {3} OFFSET {2}	513100	0	1	size	1		0
514000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select username,sum(hits) as hits, sum(bytes) as bytes from mail_sender_user{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	514000	0	1	bytes	1		0
514100	Top Users Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,username	select recipient,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where sender=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	514100	0	1	size	1		0
515000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select application,sum(hits) as hits, sum(bytes) as bytes from mail_app_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	515000	0	1	bytes	1		0
515100	Top Applications Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,application	select recipient,subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination, sum(bytes) as size from mail_detail{4} where sender=''{8}'' and application=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	515100	0	1	size	1		0
520000	Top Mail Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select recipient,sum(hits) as hits, sum(bytes) as bytes from mail_recipient{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	520000	0	1	bytes	1		0
521000	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select sender,sum(hits) as hits, sum(bytes) as bytes from mail_recipient_sender{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	521000	0	1	bytes	1		0
521100	Top Senders Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,sender	select subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where recipient=''{8}'' and sender=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY subject,username,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	521100	0	1	size	1		0
522000	Top Source Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select INET_NTOA(host) as host ,sum(hits) as hits, sum(bytes) as bytes from mail_host_recipient{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host)  order by {5} {6} limit {3} OFFSET {2}	522000	0	1	bytes	1		0
522100	Top Source Hosts Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,host	select sender,subject,username,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where recipient=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	522100	0	1	size	1		0
523000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select INET_NTOA(destip) as destination,sum(hits) as hits, sum(bytes) as bytes from mail_dest_recipient{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	523000	0	1	bytes	1		0
523100	Top Destinations Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,destination	select sender,subject,username,INET_NTOA(host) as host,application, sum(bytes) as size from mail_detail{4} where recipient=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(host),application order by {5} {6} limit {3} OFFSET {2}	523100	0	1	size	1		0
524000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select username,sum(hits) as hits, sum(bytes) as bytes from mail_recipient_user{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	524000	0	1	bytes	1		0
524100	Top Users Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,username	select sender,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where recipient=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	524100	0	1	size	1		0
525000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select application,sum(hits) as hits, sum(bytes) as bytes from mail_app_recipient{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	525000	0	1	bytes	1		0
525100	Top Applications Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,application	select sender,subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination, sum(bytes) as size from mail_detail{4} where recipient=''{8}'' and application=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	525100	0	1	size	1		0
530000	Top Mail Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits, sum(bytes) as bytes from mail_user{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	530000	0	1	bytes	1		0
531000	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select sender,sum(hits) as hits, sum(bytes) as bytes from mail_sender_user{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	531000	0	1	bytes	1		0
531100	Top Senders Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,sender	select recipient,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where username=''{8}'' and sender=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	531100	0	1	size	1		0
532000	Top Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select recipient,sum(hits) as hits, sum(bytes) as bytes from mail_recipient_user{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	532000	0	1	bytes	1		0
532100	Top Recipients Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,recipient	select sender,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where username=''{8}'' and recipient=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	532100	0	1	size	1		0
533000	Top Source Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(host) as host,sum(hits) as hits, sum(bytes) as bytes from mail_host_user{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	533000	0	1	bytes	1		0
533100	Top Source Hosts Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select sender,recipient,subject,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where username=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	533100	0	1	size	1		0
534000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(destip) as destination,sum(hits) as hits, sum(bytes) as bytes from mail_dest_user{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	534000	0	1	bytes	1		0
534100	Top Destinations Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,destination	select sender,recipient,subject,INET_NTOA(host) as host,application, sum(bytes) as size from mail_detail{4} where username=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,INET_NTOA(host),application order by {5} {6} limit {3} OFFSET {2}	534100	0	1	size	1		0
535000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select application,sum(hits) as hits, sum(bytes) as bytes from mail_app_user{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	535000	0	1	bytes	1		0
535100	Top Applications Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application	select sender,recipient,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination, sum(bytes) as size from mail_detail{4} where username=''{8}'' and application=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	535100	0	1	size	1		0
540000	Top Mail Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(host) as host,sum(hits) as hits, sum(bytes) as bytes from mail_host{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	540000	0	1	bytes	1		0
541000	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select sender,sum(hits) as hits, sum(bytes) as bytes from mail_host_sender{4} where INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	541000	0	1	bytes	1		0
541100	Top Senders Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,sender	select recipient,subject,username,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where INET_NTOA(host)=''{8}'' and sender=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	541100	0	1	size	1		0
542000	Top Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select recipient,sum(hits) as hits, sum(bytes) as bytes from mail_host_recipient{4} where INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	542000	0	1	bytes	1		0
542100	Top Recipients Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,recipient	select sender,subject,username,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where INET_NTOA(host)=''{8}'' and recipient=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	542100	0	1	size	1		0
543000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select username,sum(hits) as hits, sum(bytes) as bytes from mail_host_user{4} where INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	543000	0	1	bytes	1		0
543100	Top Users Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select sender,recipient,subject,INET_NTOA(destip) as destination,application, sum(bytes) as size from mail_detail{4} where INET_NTOA(host)=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	543100	0	1	size	1		0
544000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select INET_NTOA(destip) as destination,sum(hits) as hits, sum(bytes) as bytes from mail_dest_host{4} where INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	544000	0	1	bytes	1		0
544100	Top Destinations Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,destination	select sender,recipient,subject,username,application, sum(bytes) as size from mail_detail{4} where INET_NTOA(host)=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,application order by {5} {6} limit {3} OFFSET {2}	544100	0	1	size	1		0
545000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select application,sum(hits) as hits, sum(bytes) as bytes from mail_app_host{4} where INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	545000	0	1	bytes	1		0
545100	Top Applications Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application	select sender,recipient,subject,username,INET_NTOA(destip) as destination, sum(bytes) as size from mail_detail{4} where INET_NTOA(host)=''{8}'' and application=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	545100	0	1	size	1		0
550000	Top Mail Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select application,sum(hits) as hits, sum(bytes) as bytes from mail_app{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	550000	0	1	bytes	1		0
551000	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select sender,sum(hits) as hits, sum(bytes) as bytes from mail_app_sender{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	551000	0	1	bytes	1		0
551100	Top Senders Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,sender	select recipient,subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination, sum(bytes) as size from mail_detail{4} where application=''{8}'' and sender=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	551100	0	1	size	1		0
552000	Top Recipient	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select recipient,sum(hits) as hits, sum(bytes) as bytes from mail_app_recipient{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	552000	0	1	bytes	1		0
552100	Top Recipient Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,recipient	select sender,subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination, sum(bytes) as size from mail_detail{4} where application=''{8}'' and recipient=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	552100	0	1	size	1		0
553000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select username,sum(hits) as hits, sum(bytes) as bytes from mail_app_user{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	553000	0	1	bytes	1		0
553100	Top Users Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username	select sender,recipient,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination, sum(bytes) as size from mail_detail{4} where application=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	553100	0	1	size	1		0
554000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select INET_NTOA(host) as host,sum(hits) as hits, sum(bytes) as bytes from mail_app_host{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	554000	0	1	bytes	1		0
554100	Top Hosts Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,host	select sender,recipient,subject,username,INET_NTOA(destip) as destination, sum(bytes) as size from mail_detail{4} where application=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	554100	0	1	size	1		0
555000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select INET_NTOA(destip) as destination,sum(hits) as hits, sum(bytes) as bytes from mail_app_dest{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	555000	0	1	bytes	1		0
555100	Top Destinations Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,destination	select sender,recipient,subject,username,INET_NTOA(host) as host, sum(bytes) as size from mail_detail{4} where application=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	555100	0	1	size	1		0
4562000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application	select content, sum(hits) as hits, sum(bytes) as bytes from web_app_content_host{4} where INET_NTOA(host) = ''{8}'' and application like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	4562000	0	1	bytes	1		0
4562100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_host{4} where INET_NTOA(host) = ''{8}'' and application like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4562100	0	1	bytes	1		0
46000000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select application, sum(hits) as hits, sum(bytes) as bytes from web_app{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	46000000	0	1	bytes	1		0
46100000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select category, sum(hits) as hits, sum(bytes) as bytes from web_app_category{4} where application = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	46100000	0	1	bytes	1		0
46110000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain{4} where application = ''{8}'' and category like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46110000	0	1	bytes	1		0
46111000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,domain	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_user{4} where application = ''{8}'' and category like ''{9}'' and domain like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46111000	0	1	bytes	1		0
46111100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,domain,username	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_url_user{4} where application = ''{8}'' and category like ''{9}'' and domain like ''{10}'' and username like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46111100	0	1	bytes	1		0
1420070	Top Destinations  (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from user_dest{4} where username like ''{7}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	1420070	0	0	bytes	1		0
1420080	Top Hosts (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from srcip_user{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	1420080	0	0	bytes	1		0
46112000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category	select content, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content{4} where application = ''{8}'' and category like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	46112000	0	1	bytes	1		0
46120000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_category_user{4} where application = ''{8}'' and category like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46120000	0	1	bytes	1		0
46121000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,username	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_user{4} where application = ''{8}'' and category like ''{9}'' and username like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46121000	0	1	bytes	1		0
46121100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,username,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_url_user{4} where application = ''{8}'' and category like ''{9}'' and username like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46121100	0	1	bytes	1		0
46122000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,username	select content, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_user{4} where application = ''{8}'' and category like ''{9}'' and username like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	46122000	0	1	bytes	1		0
46122100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,username,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_user{4} where application = ''{8}'' and category like ''{9}'' and username like ''{10}'' and content like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46122100	0	1	bytes	1		0
46122110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,username,content,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_url_user{4} where application = ''{8}'' and category like ''{9}'' and username like ''{10}'' and content like ''{11}'' and domain like ''{12}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46122110	0	1	bytes	1		0
46130000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category	select content, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content{4} where application = ''{8}'' and category like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	46130000	0	1	bytes	1		0
46131000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,content	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_user{4} where application = ''{8}'' and category like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46131000	0	1	bytes	1		0
46131100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,content,username	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_user{4} where application = ''{8}'' and category like ''{9}'' and content like ''{10}'' and username like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46131100	0	1	bytes	1		0
46131110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,content,username,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_url_user{4} where application = ''{8}'' and category like ''{9}'' and content like ''{10}'' and username like ''{11}'' and domain like ''{12}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46131110	0	1	bytes	1		0
1520040	Top Rules	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select ruleid,sum(hits) as hits,sum(total) as bytes from protogroup_rules{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By ruleid order by {5} {6} limit {3} OFFSET {2}	1520040	0	0	bytes	1		0
1520050	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select application,sum(hits) as hits,sum(sent) as bytes from protogroup_application{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	1520050	0	0	bytes	1		0
46132000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain{4} where application = ''{8}'' and category like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46132000	0	1	bytes	1		0
46132100	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,content,domain	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_user{4} where application = ''{8}'' and category like ''{9}'' and content like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46132100	0	1	bytes	1		0
46132110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,content,domain,username	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_url_user{4} where application = ''{8}'' and category like ''{9}'' and content like ''{10}'' and domain like ''{11}'' and username like ''{12}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46132110	0	1	bytes	1		0
46200000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_domain{4} where application = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46200000	0	1	bytes	1		0
46210000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,domain	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_domain_user{4} where application = ''{8}'' and domain like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46210000	0	1	bytes	1		0
46211000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,domain,username	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_domain_url_user{4} where application = ''{8}'' and domain like ''{9}'' and username like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46211000	0	1	bytes	1		0
46220000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,domain	select content, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain{4} where application = ''{8}'' and domain like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	46220000	0	1	bytes	1		0
46221000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,domain,content	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_user{4} where application = ''{8}'' and domain like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46221000	0	1	bytes	1		0
46221100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,domain,content,username	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_url_user{4} where application = ''{8}'' and domain like ''{9}'' and content like ''{10}'' and username like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46221100	0	1	bytes	1		0
46300000	Top Web Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_user{4} where application = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46300000	0	1	bytes	1		0
46310000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username	select category, sum(hits) as hits, sum(bytes) as bytes from web_app_category_user{4} where application = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	46310000	0	1	bytes	1		0
46311000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_user{4} where application = ''{8}'' and username like ''{9}'' and category like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46311000	0	1	bytes	1		0
46311100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_url_user{4} where application = ''{8}'' and username like ''{9}'' and category like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46311100	0	1	bytes	1		0
46320000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_domain_user{4} where application = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46320000	0	1	bytes	1		0
46321000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_domain_url_user{4} where application = ''{8}'' and username like ''{9}'' and domain like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46321000	0	1	bytes	1		0
46330000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username	select content, sum(hits) as hits, sum(bytes) as bytes from web_app_content_user{4} where application = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	46330000	0	1	bytes	1		0
46331000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_user{4} where application = ''{8}'' and username like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46331000	0	1	bytes	1		0
46331100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username,content,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_url_user{4} where application = ''{8}'' and username like ''{9}'' and content like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46331100	0	1	bytes	1		0
46340000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_url_user{4} where application = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46340000	0	1	bytes	1		0
46400000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select content, sum(hits) as hits, sum(bytes) as bytes from web_app_content{4} where application = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	46400000	0	1	bytes	1		0
46410000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain{4} where application = ''{8}'' and content like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46410000	0	1	bytes	1		0
46411000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,domain	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_user{4} where application = ''{8}'' and content like ''{9}'' and domain like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46411000	0	1	bytes	1		0
46411100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,domain,username	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_url_user{4} where application = ''{8}'' and content like ''{9}'' and domain like ''{10}'' and username like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46411100	0	1	bytes	1		0
46420000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_content_user{4} where application = ''{8}'' and content like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46420000	0	1	bytes	1		0
46421000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,username	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_user{4} where application = ''{8}'' and content like ''{9}'' and username like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46421000	0	1	bytes	1		0
46421100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,username,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_url_user{4} where application = ''{8}'' and content like ''{9}'' and username like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46421100	0	1	bytes	1		0
46422000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,username	select category, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_user{4} where application = ''{8}'' and content like ''{9}'' and username like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	46422000	0	1	bytes	1		0
46422100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,username,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_user{4} where application = ''{8}'' and content like ''{9}'' and username like ''{10}'' and category like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46422100	0	1	bytes	1		0
46422110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,username,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_url_user{4} where application = ''{8}'' and content like ''{9}'' and username like ''{10}'' and category like ''{11}'' and domain like ''{12}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46422110	0	1	bytes	1		0
46430000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content	select category, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content{4} where application = ''{8}'' and content like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	46430000	0	1	bytes	1		0
46431000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,category	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_user{4} where application = ''{8}'' and content like ''{9}'' and category like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46431000	0	1	bytes	1		0
46431100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,category,username	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_user{4} where application = ''{8}'' and content like ''{9}'' and category like ''{10}'' and username like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46431100	0	1	bytes	1		0
46431110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,category,username,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_url_user{4} where application = ''{8}'' and content like ''{9}'' and category like ''{10}'' and username like ''{11}'' and domain like ''{12}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46431110	0	1	bytes	1		0
46432000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain{4} where application = ''{8}'' and content like ''{9}'' and category like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	46432000	0	1	bytes	1		0
46432100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,content,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_url{4} where application = ''{8}'' and content like ''{9}'' and category like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46432100	0	1	bytes	1		0
4540000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select url, sum(hits) as hits, sum(bytes) as bytes from web_url_host{4} where INET_NTOA(host) = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4540000	0	1	bytes	1		0
4531100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,content,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_content_domain_url_host{4} where INET_NTOA(host) = ''{8}'' and content like ''{9}'' and domain like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4531100	0	1	bytes	1		0
4552000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select domain, sum(hits) as hits, sum(bytes) as bytes from web_domain_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4552000	0	1	bytes	1		0
4511100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_category_domain_url_host{4} where INET_NTOA(host) = ''{8}'' and category like ''{9}'' and domain like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4511100	0	1	bytes	1		0
4554000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select url, sum(hits) as hits, sum(bytes) as bytes from web_url_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4554000	0	1	bytes	1		0
1446010	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1446010	0	0	bytes	1		0
1446110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip,srcip	select application,sum(hits) as hits,sum(sent) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1446110	0	0	bytes	1		0
1437010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip	select application,sum(hits) as hits,sum(received) as bytes from user_dest_application{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1437010	0	0	bytes	1		0
1437020	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from host_dest_user{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1437020	0	0	bytes	1		0
1447010	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1447010	0	0	bytes	1		0
1447110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip,srcip	select application,sum(hits) as hits,sum(received) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1447110	0	0	bytes	1		0
1438010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip	select application,sum(hits) as hits,sum(sent) as bytes from host_user_application{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1438010	0	0	bytes	1		0
1438020	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_dest_user{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1438020	0	0	bytes	1		0
1448010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1448010	0	0	bytes	1		0
1448110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip,destip	select application,sum(hits) as hits,sum(sent) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1448110	0	0	bytes	1		0
4551110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_category_domain_url_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and category like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4551110	0	1	bytes	1		0
4552100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_domain_url_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and domain like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4552100	0	1	bytes	1		0
4553110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,content,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_content_domain_url_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and content like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4553110	0	1	bytes	1		0
45551110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_url_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and application like ''{10}'' and category like ''{11}'' and domain like ''{12}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	45551110	0	1	bytes	1		0
45552110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application,content,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_url_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and application like ''{10}'' and content like ''{11}'' and domain like ''{12}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	45552110	0	1	bytes	1		0
4561110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_url_host{4} where INET_NTOA(host) = ''{8}'' and application like ''{9}'' and category like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4561110	0	1	bytes	1		0
4521000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_domain_url_host{4} where INET_NTOA(host) = ''{8}'' and domain like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4521000	0	1	bytes	1		0
4562110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application,content,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_content_domain_url_host{4} where INET_NTOA(host) = ''{8}'' and application like ''{9}'' and content like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4562110	0	1	bytes	1		0
46112110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,content,domain,username	select url, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_url_user{4} where application = ''{8}'' and category like ''{9}'' and content like ''{10}'' and domain like ''{11}'' and username like ''{12}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	46112110	0	1	bytes	1		0
46112100	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,category,content,domain	select username, sum(hits) as hits, sum(bytes) as bytes from web_app_category_content_domain_user{4} where application = ''{8}'' and category like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	46112100	0	1	bytes	1		0
16	Top Users 	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits,sum(total) as bytes from top_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	16	1	0	bytes	1		0
17	Top Users (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits,sum(sent) as bytes from top_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	17	1	0	bytes	1		0
18	Top Users (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits,sum(received) as bytes from top_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	18	1	0	bytes	1		0
19	Top Application Groups 	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select proto_group,sum(hits) as hits,sum(total) as bytes from top_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	19	1	0	bytes	1		0
20	Top Application Groups (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select proto_group,sum(hits) as hits,sum(sent) as bytes from top_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	20	1	0	bytes	1		0
21	Top Application Groups (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select proto_group,sum(hits) as hits,sum(received) as bytes from top_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	21	1	0	bytes	1		0
22	Top Hosts 	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from ( select * from top_hosts{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) ) As top_hosts_5min GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	22	1	0	bytes	1		0
23	Top Hosts (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from ( select * from top_hosts{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) ) As top_hosts_5min GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	23	1	0	bytes	1		0
24	Top Hosts (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from ( select * from top_hosts{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) ) As top_hosts_5min GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	24	1	0	bytes	1		0
25	Top Rules	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select ruleid,sum(hits) as hits,sum(total) as bytes from top_rules{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By ruleid order by {5} {6} limit {3} OFFSET {2}	25	1	0	bytes	1		0
26	Top Application Groups 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select proto_group,sum(hits) as hits,sum(total) as bytes from srcip_protogroup{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	26	1	0	bytes	1		0
27	Top Destinations  	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from srcip_dest{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	27	1	0	bytes	1		0
28	Top Users 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select username,sum(hits) as hits,sum(total) as bytes from srcip_user{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	28	1	0	bytes	1		0
29	Top Rules	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select ruleid,sum(hits) as hits,sum(total) as bytes from srcip_ruleid{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By ruleid order by {5} {6} limit {3} OFFSET {2}	29	1	0	bytes	1		0
30	Top Application Groups (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select proto_group,sum(hits) as hits,sum(sent) as bytes from srcip_protogroup{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	30	1	0	bytes	1		0
31	Top Application Groups (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select proto_group,sum(hits) as hits,sum(received) as bytes from srcip_protogroup{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	31	1	0	bytes	1		0
32	Top Destinations  (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from srcip_dest{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	32	1	0	bytes	1		0
33	Top Destinations  (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from srcip_dest{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	33	1	0	bytes	1		0
34	Top Users (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select username,sum(hits) as hits,sum(sent) as bytes from srcip_user{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	34	1	0	bytes	1		0
35	Top Users (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select username,sum(hits) as hits,sum(received) as bytes from srcip_user{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	35	1	0	bytes	1		0
130010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select application,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	130010	0	0	bytes	1		0
130020	Top Destination	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	130020	0	0	bytes	1		0
130030	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select username,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_users{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	130030	0	0	bytes	1		0
140010	Top Destination	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	140010	0	0	bytes	1		0
140110	Top Application  	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,destip	select application,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	140110	0	0	bytes	1		0
140210	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,username	select application,sum(hits) as hits,sum(total) as bytes from user_protogroup_host_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	140210	0	0	bytes	1		0
150210	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_user_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and username like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	150210	0	0	bytes	1		0
131010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip	select application,sum(hits) as hits,sum(total) as bytes from host_dest_application{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}''   and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	131010	0	0	bytes	1		0
131020	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip	select username,sum(hits) as hits,sum(total) as bytes from host_dest_user{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	131020	0	0	bytes	1		0
141010	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip,application	select username,sum(hits) as hits,sum(total) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	141010	0	0	bytes	1		0
141110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip,username	select application,sum(hits) as hits,sum(total) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	141110	0	0	bytes	1		0
132010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username	select application,sum(hits) as hits,sum(total) as bytes from host_user_application{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	132010	0	0	bytes	1		0
132020	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_dest_user{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	132020	0	0	bytes	1		0
142010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	142010	0	0	bytes	1		0
142110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username,destip	select application,sum(hits) as hits,sum(total) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	142110	0	0	bytes	1		0
134010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select application,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	134010	0	0	bytes	1		0
134020	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	134020	0	0	bytes	1		0
134030	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select username,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_users{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	134030	0	0	bytes	1		0
144010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	144010	0	0	bytes	1		0
144110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,destip	select application,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	144110	0	0	bytes	1		0
144210	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,username	select application,sum(hits) as hits,sum(sent) as bytes from user_protogroup_host_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	144210	0	0	bytes	1		0
154210	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_user_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and username like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	154210	0	0	bytes	1		0
135010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select application,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	135010	0	0	bytes	1		0
135020	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	135020	0	0	bytes	1		0
135030	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group	select username,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_users{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	135030	0	0	bytes	1		0
145010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	145010	0	0	bytes	1		0
145110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,destip	select application,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	145110	0	0	bytes	1		0
145210	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,username	select application,sum(hits) as hits,sum(received) as bytes from user_protogroup_host_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	145210	0	0	bytes	1		0
155210	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,proto_group,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_user_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{9}'' and username like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	155210	0	0	bytes	1		0
136010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip	select application,sum(hits) as hits,sum(sent) as bytes from host_dest_application{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}''   and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	136010	0	0	bytes	1		0
136020	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip	select username,sum(hits) as hits,sum(sent) as bytes from host_dest_user{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	136020	0	0	bytes	1		0
146010	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip,application	select username,sum(hits) as hits,sum(sent) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	146010	0	0	bytes	1		0
146110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip,username	select application,sum(hits) as hits,sum(sent) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	146110	0	0	bytes	1		0
137010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip	select application,sum(hits) as hits,sum(received) as bytes from host_dest_application{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}''   and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	137010	0	0	bytes	1		0
137020	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip	select username,sum(hits) as hits,sum(received) as bytes from host_dest_user{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	137020	0	0	bytes	1		0
147010	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip,application	select username,sum(hits) as hits,sum(received) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	147010	0	0	bytes	1		0
147110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,destip,username	select application,sum(hits) as hits,sum(received) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	147110	0	0	bytes	1		0
1420090	Top Hosts (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from srcip_user{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	1420090	0	0	bytes	1		0
138010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username	select application,sum(hits) as hits,sum(sent) as bytes from host_user_application{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	138010	0	0	bytes	1		0
138020	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_dest_user{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	138020	0	0	bytes	1		0
148010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	148010	0	0	bytes	1		0
148110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username,destip	select application,sum(hits) as hits,sum(sent) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	148110	0	0	bytes	1		0
139010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username	select application,sum(hits) as hits,sum(received) as bytes from host_user_application{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	139010	0	0	bytes	1		0
139020	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_dest_user{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	139020	0	0	bytes	1		0
149010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	149010	0	0	bytes	1		0
149110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid,username,destip	select application,sum(hits) as hits,sum(received) as bytes from user_dest_application_host{4} where INET_NTOA(srcip) like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	149110	0	0	bytes	1		0
1430010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select application,sum(hits) as hits,sum(total) as bytes from users_protogroup_application{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1430010	0	0	bytes	1		0
1430020	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from users_protogroup_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1430020	0	0	bytes	1		0
1430030	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_users{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1430030	0	0	bytes	1		0
1440010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1440010	0	0	bytes	1		0
1440110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,destip	select application,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1440110	0	0	bytes	1		0
1440210	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,srcip	select application,sum(hits) as hits,sum(total) as bytes from user_protogroup_host_application{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1440210	0	0	bytes	1		0
1450010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_user_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1450010	0	0	bytes	1		0
1431010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip	select application,sum(hits) as hits,sum(total) as bytes from user_dest_application{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1431010	0	0	bytes	1		0
1431020	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from host_dest_user{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1431020	0	0	bytes	1		0
1441010	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1441010	0	0	bytes	1		0
1441110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,destip,srcip	select application,sum(hits) as hits,sum(total) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1441110	0	0	bytes	1		0
1432010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip	select application,sum(hits) as hits,sum(total) as bytes from host_user_application{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1432010	0	0	bytes	1		0
1432020	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_dest_user{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1432020	0	0	bytes	1		0
1442010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1442010	0	0	bytes	1		0
1442110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip,destip	select application,sum(hits) as hits,sum(total) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1442110	0	0	bytes	1		0
1434010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select application,sum(hits) as hits,sum(sent) as bytes from users_protogroup_application{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1434010	0	0	bytes	1		0
1434020	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from users_protogroup_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1434020	0	0	bytes	1		0
1434030	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_users{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1434030	0	0	bytes	1		0
1444010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1444010	0	0	bytes	1		0
1444110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,destip	select application,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1444110	0	0	bytes	1		0
1444210	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,srcip	select application,sum(hits) as hits,sum(sent) as bytes from user_protogroup_host_application{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1444210	0	0	bytes	1		0
1454010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_user_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1454010	0	0	bytes	1		0
1435010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select application,sum(hits) as hits,sum(received) as bytes from users_protogroup_application{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1435010	0	0	bytes	1		0
1435020	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from users_protogroup_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1435020	0	0	bytes	1		0
1435030	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_users{4} where username like ''{7}'' and proto_group like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1435030	0	0	bytes	1		0
1445010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1445010	0	0	bytes	1		0
1445110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,destip	select application,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1445110	0	0	bytes	1		0
4410000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_content_domain{4} where content like ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4410000	0	1	bytes	1		0
4420000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,content	select username, sum(hits) as hits, sum(bytes) as bytes from web_content_user{4} where content like ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	4420000	0	1	bytes	1		0
4430000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,content	select category, sum(hits) as hits, sum(bytes) as bytes from web_category_content{4} where content like ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	4430000	0	1	bytes	1		0
4411000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,content	select username, sum(hits) as hits, sum(bytes) as bytes from web_content_domain_user{4} where domain like ''{8}'' and content like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	4411000	0	1	bytes	1		0
4411100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,username,content	select url, sum(hits) as hits, sum(bytes) as bytes from web_content_domain_url_user{4} where domain like ''{8}'' and username like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4411100	0	1	bytes	1		0
4421000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_content_domain_user{4} where username like ''{8}'' and content like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4421000	0	1	bytes	1		0
4422000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,content	select category, sum(hits) as hits, sum(bytes) as bytes from web_category_content_user{4} where username like ''{8}'' and content like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	4422000	0	1	bytes	1		0
4421100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,username,content	select url, sum(hits) as hits, sum(bytes) as bytes from web_content_domain_url_user{4} where domain like ''{8}'' and username like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4421100	0	1	bytes	1		0
4422100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,content,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_category_content_domain_user{4} where username like ''{8}'' and content like ''{9}'' and category like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4422100	0	1	bytes	1		0
4422110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,content,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_category_content_domain_url_user{4} where username like ''{8}'' and content like ''{9}'' and category like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4422110	0	1	bytes	1		0
4431000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,content,category	select username, sum(hits) as hits, sum(bytes) as bytes from web_category_content_user{4} where content like ''{8}'' and category like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	4431000	0	1	bytes	1		0
4432000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,content,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_category_content_domain{4} where content like ''{8}'' and category like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4432000	0	1	bytes	1		0
4431100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,content,category,username	select domain, sum(hits) as hits, sum(bytes) as bytes from web_category_content_domain_user{4} where content like ''{8}'' and category like ''{9}'' and username like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4431100	0	1	bytes	1		0
4431110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,content,category,username,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_category_content_domain_url_user{4} where content like ''{8}'' and category like ''{9}'' and username like ''{10}'' and domain like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4431110	0	1	bytes	1		0
4432100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,content,category,domain	select url, sum(hits) as hits, sum(bytes) as bytes from web_category_content_domain_url{4} where content like ''{8}'' and category like ''{9}'' and domain like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By url order by {5} {6} limit {3} OFFSET {2}	4432100	0	1	bytes	1		0
4500000	Top Web Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(host) as host, sum(hits) as hits, sum(bytes) as bytes from web_host{4} where  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By host order by {5} {6} limit {3} OFFSET {2}	4500000	0	1	bytes	1		0
4510000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select category, sum(hits) as hits, sum(bytes) as bytes from web_category_host{4} where INET_NTOA(host) = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	4510000	0	1	bytes	1		0
4511000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_category_domain_host{4} where INET_NTOA(host) = ''{8}'' and category like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4511000	0	1	bytes	1		0
4520000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select domain, sum(hits) as hits, sum(bytes) as bytes from web_domain_host{4} where INET_NTOA(host) = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4520000	0	1	bytes	1		0
4530000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select content, sum(hits) as hits, sum(bytes) as bytes from web_content_host{4} where INET_NTOA(host) = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	4530000	0	1	bytes	1		0
4531000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_content_domain_host{4} where INET_NTOA(host) = ''{8}'' and content like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4531000	0	1	bytes	1		0
4550000	Top Web Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select username, sum(hits) as hits, sum(bytes) as bytes from web_host_user{4} where INET_NTOA(host) = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By username order by {5} {6} limit {3} OFFSET {2}	4550000	0	1	bytes	1		0
4551000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select category, sum(hits) as hits, sum(bytes) as bytes from web_category_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	4551000	0	1	bytes	1		0
4551100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_category_domain_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and category like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4551100	0	1	bytes	1		0
4553000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select content, sum(hits) as hits, sum(bytes) as bytes from web_content_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	4553000	0	1	bytes	1		0
4553100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,content	select domain, sum(hits) as hits, sum(bytes) as bytes from web_content_domain_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and content like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4553100	0	1	bytes	1		0
4555000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select application, sum(hits) as hits, sum(bytes) as bytes from web_app_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	4555000	0	1	bytes	1		0
4555100	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application	select category, sum(hits) as hits, sum(bytes) as bytes from web_app_category_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	4555100	0	1	bytes	1		0
4555110	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application,category	select domain, sum(hits) as hits, sum(bytes) as bytes from web_app_category_domain_host_user{4} where INET_NTOA(host) = ''{8}'' and username like ''{9}'' and application like ''{10}'' and category like ''{11}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	4555110	0	1	bytes	1		0
1445210	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,srcip	select application,sum(hits) as hits,sum(received) as bytes from user_protogroup_host_application{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1445210	0	0	bytes	1		0
1455010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,proto_group,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_user_dest{4} where username like ''{7}'' and proto_group like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1455010	0	0	bytes	1		0
1439020	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_dest_user{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1439020	0	0	bytes	1		0
1449010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1449010	0	0	bytes	1		0
1449110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid,srcip,destip	select application,sum(hits) as hits,sum(received) as bytes from user_dest_application_host{4} where username like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1449110	0	0	bytes	1		0
1530010	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select username,sum(hits) as hits,sum(total) as bytes from users_protogroup_application{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1530010	0	0	bytes	1		0
1530020	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1530020	0	0	bytes	1		0
1530030	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_application{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1530030	0	0	bytes	1		0
1540010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1540010	0	0	bytes	1		0
1540020	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and application like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1540020	0	0	bytes	1		0
1540110	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,destip	select username,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1540110	0	0	bytes	1		0
1540120	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1540120	0	0	bytes	1		0
1540210	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1540210	0	0	bytes	1		0
1540220	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,srcip	select username,sum(hits) as hits,sum(total) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1540220	0	0	bytes	1		0
1531010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select application,sum(hits) as hits,sum(total) as bytes from users_protogroup_application{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1531010	0	0	bytes	1		0
1531020	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from users_protogroup_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1531020	0	0	bytes	1		0
1531030	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_users{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1531030	0	0	bytes	1		0
1541010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1541010	0	0	bytes	1		0
1541020	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1541020	0	0	bytes	1		0
1541110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,destip	select application,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1541110	0	0	bytes	1		0
1541120	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1541120	0	0	bytes	1		0
1541210	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip	select application,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_host{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1541210	0	0	bytes	1		0
1541220	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1541220	0	0	bytes	1		0
1551010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1551010	0	0	bytes	1		0
1551110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip,destip	select application,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and INET_NTOA(destip) like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1551110	0	0	bytes	1		0
1532010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select application,sum(hits) as hits,sum(total) as bytes from protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1532010	0	0	bytes	1		0
1532020	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select username,sum(hits) as hits,sum(total) as bytes from users_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1532020	0	0	bytes	1		0
1532030	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1532030	0	0	bytes	1		0
1542010	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,application	select username,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1542010	0	0	bytes	1		0
1542020	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1542020	0	0	bytes	1		0
1542110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,username	select application,sum(hits) as hits,sum(total) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1542110	0	0	bytes	1		0
1542120	Top Host 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1542120	0	0	bytes	1		0
1542210	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,srcip	select application,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1542210	0	0	bytes	1		0
1542220	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,srcip	select username,sum(hits) as hits,sum(total) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1542220	0	0	bytes	1		0
1533010	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select application,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1533010	0	0	bytes	1		0
1533020	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1533020	0	0	bytes	1		0
1533030	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select username,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_users{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1533030	0	0	bytes	1		0
1543010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1543010	0	0	bytes	1		0
1543020	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,application	select username,sum(hits) as hits,sum(total) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1543020	0	0	bytes	1		0
1543110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,destip	select application,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1543110	0	0	bytes	1		0
1543120	Top User 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,destip	select username,sum(hits) as hits,sum(total) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1543120	0	0	bytes	1		0
1543210	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username	select application,sum(hits) as hits,sum(total) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1543210	0	0	bytes	1		0
1543220	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1543220	0	0	bytes	1		0
1553010	Top Destination 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1553010	0	0	bytes	1		0
1553110	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username,destip	select application,sum(hits) as hits,sum(total) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1553110	0	0	bytes	1		0
1534010	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select username,sum(hits) as hits,sum(sent) as bytes from users_protogroup_application{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1534010	0	0	bytes	1		0
1534020	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1534020	0	0	bytes	1		0
1534030	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_application{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1534030	0	0	bytes	1		0
1544010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1544010	0	0	bytes	1		0
1544020	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and application like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1544020	0	0	bytes	1		0
1544110	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,destip	select username,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1544110	0	0	bytes	1		0
1544120	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1544120	0	0	bytes	1		0
1544210	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1544210	0	0	bytes	1		0
1544220	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,srcip	select username,sum(hits) as hits,sum(sent) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1544220	0	0	bytes	1		0
1535010	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select username,sum(hits) as hits,sum(received) as bytes from users_protogroup_application{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1535010	0	0	bytes	1		0
1535020	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1535020	0	0	bytes	1		0
1535030	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_application{4} where proto_group like ''{7}'' and application like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1535030	0	0	bytes	1		0
1545010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1545010	0	0	bytes	1		0
1545020	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and application like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1545020	0	0	bytes	1		0
1545110	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,destip	select username,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1545110	0	0	bytes	1		0
1545120	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1545120	0	0	bytes	1		0
1545210	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1545210	0	0	bytes	1		0
1545220	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,application,srcip	select username,sum(hits) as hits,sum(received) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and application like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1545220	0	0	bytes	1		0
1536010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select application,sum(hits) as hits,sum(sent) as bytes from users_protogroup_application{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1536010	0	0	bytes	1		0
1536020	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from users_protogroup_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1536020	0	0	bytes	1		0
1536030	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_users{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1536030	0	0	bytes	1		0
1546010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1546010	0	0	bytes	1		0
1546020	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1546020	0	0	bytes	1		0
1546110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,destip	select application,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1546110	0	0	bytes	1		0
1546120	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1546120	0	0	bytes	1		0
1546210	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip	select application,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_host{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1546210	0	0	bytes	1		0
1546220	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1546220	0	0	bytes	1		0
1556010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1556010	0	0	bytes	1		0
1556110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip,destip	select application,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and INET_NTOA(destip) like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1556110	0	0	bytes	1		0
1537010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select application,sum(hits) as hits,sum(received) as bytes from users_protogroup_application{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1537010	0	0	bytes	1		0
1537020	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from users_protogroup_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1537020	0	0	bytes	1		0
1537030	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_users{4} where proto_group like ''{7}'' and username like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1537030	0	0	bytes	1		0
1547010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1547010	0	0	bytes	1		0
1547020	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and username like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1547020	0	0	bytes	1		0
1547110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,destip	select application,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1547110	0	0	bytes	1		0
1547120	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1547120	0	0	bytes	1		0
1547210	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip	select application,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_host{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1547210	0	0	bytes	1		0
1547220	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1547220	0	0	bytes	1		0
1557010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	1557010	0	0	bytes	1		0
1557110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,username,srcip,destip	select application,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and username like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and INET_NTOA(destip) like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1557110	0	0	bytes	1		0
1538010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select application,sum(hits) as hits,sum(sent) as bytes from protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1538010	0	0	bytes	1		0
1538020	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select username,sum(hits) as hits,sum(sent) as bytes from users_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1538020	0	0	bytes	1		0
1538030	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1538030	0	0	bytes	1		0
1548010	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,application	select username,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1548010	0	0	bytes	1		0
1548020	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1548020	0	0	bytes	1		0
1548110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,username	select application,sum(hits) as hits,sum(sent) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1548110	0	0	bytes	1		0
1548120	Top Host (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1548120	0	0	bytes	1		0
1548210	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,srcip	select application,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1548210	0	0	bytes	1		0
1548220	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,srcip	select username,sum(hits) as hits,sum(sent) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1548220	0	0	bytes	1		0
1539010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select application,sum(hits) as hits,sum(received) as bytes from protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1539010	0	0	bytes	1		0
1539020	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select username,sum(hits) as hits,sum(received) as bytes from users_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1539020	0	0	bytes	1		0
1539030	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1539030	0	0	bytes	1		0
1549010	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,application	select username,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1549010	0	0	bytes	1		0
1549020	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,application	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1549020	0	0	bytes	1		0
1549110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,username	select application,sum(hits) as hits,sum(received) as bytes from user_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1549110	0	0	bytes	1		0
1549120	Top Host (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,username	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by srcip order by {5} {6} limit {3} OFFSET {2}	1549120	0	0	bytes	1		0
1549210	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,srcip	select application,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	1549210	0	0	bytes	1		0
1549220	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,destip,srcip	select username,sum(hits) as hits,sum(received) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(destip) like ''{9}'' and INET_NTOA(srcip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1549220	0	0	bytes	1		0
15310010	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select application,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	15310010	0	0	bytes	1		0
15310020	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	15310020	0	0	bytes	1		0
15310030	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select username,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_users{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	15310030	0	0	bytes	1		0
15410010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	15410010	0	0	bytes	1		0
15410020	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,application	select username,sum(hits) as hits,sum(sent) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	15410020	0	0	bytes	1		0
15410110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,destip	select application,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	15410110	0	0	bytes	1		0
15410120	Top User (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,destip	select username,sum(hits) as hits,sum(sent) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	15410120	0	0	bytes	1		0
15410210	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username	select application,sum(hits) as hits,sum(sent) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	15410210	0	0	bytes	1		0
15410220	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	15410220	0	0	bytes	1		0
15510010	Top Destination (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	15510010	0	0	bytes	1		0
15510110	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username,destip	select application,sum(hits) as hits,sum(sent) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	15510110	0	0	bytes	1		0
15311010	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select application,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	15311010	0	0	bytes	1		0
15311020	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	15311020	0	0	bytes	1		0
15311030	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip	select username,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_users{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	15311030	0	0	bytes	1		0
15411010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	15411010	0	0	bytes	1		0
15411020	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,application	select username,sum(hits) as hits,sum(received) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and application like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	15411020	0	0	bytes	1		0
15411110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,destip	select application,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	15411110	0	0	bytes	1		0
15411120	Top User (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,destip	select username,sum(hits) as hits,sum(received) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and INET_NTOA(destip) like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	15411120	0	0	bytes	1		0
15411210	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username	select application,sum(hits) as hits,sum(received) as bytes from user_protogroup_host_application{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	15411210	0	0	bytes	1		0
15411220	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from protogroup_host_dest_user{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	15411220	0	0	bytes	1		0
15511010	Top Destination (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username,application	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and application like ''{11}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by destip order by {5} {6} limit {3} OFFSET {2}	15511010	0	0	bytes	1		0
15511110	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid,srcip,username,destip	select application,sum(hits) as hits,sum(received) as bytes from host_protogroup_application_user_dest{4} where proto_group like ''{7}'' and INET_NTOA(srcip) like ''{9}'' and username like ''{10}'' and INET_NTOA(destip) like ''{9}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by application order by {5} {6} limit {3} OFFSET {2}	15511110	0	0	bytes	1		0
1420000	Top Application Groups 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select proto_group,sum(hits) as hits,sum(total) as bytes from user_protogroup{4} where username = ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	1420000	0	0	bytes	1		0
1420010	Top Destinations  	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from user_dest{4} where username like ''{7}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	1420010	0	0	bytes	1		0
1420020	Top Hosts 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from srcip_user{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	1420020	0	0	bytes	1		0
1420030	Top Rules	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select ruleid,sum(hits) as hits,sum(total) as bytes from user_ruleid{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By ruleid order by {5} {6} limit {3} OFFSET {2}	1420030	0	0	bytes	1		0
1420040	Top Application Groups (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select proto_group,sum(hits) as hits,sum(sent) as bytes from user_protogroup{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	1420040	0	0	bytes	1		0
1420050	Top Application Groups (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select proto_group,sum(hits) as hits,sum(received) as bytes from user_protogroup{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	1420050	0	0	bytes	1		0
1420060	Top Destinations  (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from user_dest{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	1420060	0	0	bytes	1		0
1520060	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select application,sum(hits) as hits,sum(received) as bytes from protogroup_application{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	1520060	0	0	bytes	1		0
1520070	Top Users (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select username,sum(hits) as hits,sum(sent) as bytes from protogroup_user{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1520070	0	0	bytes	1		0
1520080	Top Users (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select username,sum(hits) as hits,sum(received) as bytes from protogroup_user{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	1520080	0	0	bytes	1		0
1520090	Top Destinations  (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from protogroup_dest{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	1520090	0	0	bytes	1		0
1520100	Top Destinations  (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from protogroup_dest{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	1520100	0	0	bytes	1		0
1520110	Top Hosts (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from protogroup_hosts{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	1520110	0	0	bytes	1		0
1520120	Top Hosts (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,proto_group,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from protogroup_hosts{4} where proto_group like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	1520120	0	0	bytes	1		0
59		startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,appid	select INET_NTOA(srcip) as srcip,username,application,INET_NTOA(destip) as destip,action,sum(hits) as hits from rules_detail{4} where ruleid = {7} and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip,username,application,destip,action order by {5} {6} limit {3} OFFSET {2}	59	0	0	hits	1		0
20100000	Top Applications 	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select application,sum(hits) as hits,sum(total) as bytes from top_applications{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20100000	0	0	bytes	1		0
20200000	Top Applications (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select application,sum(hits) as hits,sum(sent) as bytes from top_applications{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20200000	0	0	bytes	1		0
20300000	Top Applications (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select application,sum(hits) as hits,sum(received) as bytes from top_applications{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20300000	0	0	bytes	1		0
20400000	Top Users Per Application Group	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,proto_group,sum(hits) as hits,sum(total) as bytes from top_users_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by username,proto_group order by {5} {6} limit {3} OFFSET {2}	20400000	0	0	bytes	1		0
20500000	Top Users Per Application Group (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,proto_group,sum(hits) as hits,sum(sent) as bytes from top_users_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by username,proto_group order by {5} {6} limit {3} OFFSET {2}	20500000	0	0	bytes	1		0
20600000	Top Users Per Application Group (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,proto_group,sum(hits) as hits,sum(received) as bytes from top_users_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by username,proto_group order by {5} {6} limit {3} OFFSET {2}	20600000	0	0	bytes	1		0
20700000	Top Hosts Per Application Group 	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as srcip,proto_group,sum(hits) as hits,sum(total) as bytes from top_hosts_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By srcip,proto_group order by {5} {6} limit {3} OFFSET {2}	20700000	0	0	bytes	1		0
20800000	Top Hosts Per Application Group (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as srcip,proto_group,sum(hits) as hits,sum(sent) as bytes from top_hosts_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By srcip,proto_group order by {5} {6} limit {3} OFFSET {2}	20800000	0	0	bytes	1		0
20900000	Top Hosts Per Application Group (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as srcip,proto_group,sum(hits) as hits,sum(received) as bytes from top_hosts_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By srcip,proto_group order by {5} {6} limit {3} OFFSET {2}	20900000	0	0	bytes	1		0
20101000	Top Users 	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select username,sum(hits) as hits,sum(total) as bytes from application_user{4} where application like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	20101000	0	0	bytes	1		0
20102000	Top Destinations  	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from application_dest{4} where application like ''{7}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20102000	0	0	bytes	1		0
20103000	Top Hosts 	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from application_hosts{4} where application like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20103000	0	0	bytes	1		0
20201000	Top Users (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select username,sum(hits) as hits,sum(sent) as bytes from application_user{4} where application like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	20201000	0	0	bytes	1		0
20202000	Top Destinations  (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from application_dest{4} where application like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20202000	0	0	bytes	1		0
20203000	Top Hosts (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from application_hosts{4} where application like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20203000	0	0	bytes	1		0
20301000	Top Users (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select username,sum(hits) as hits,sum(received) as bytes from application_user{4} where application like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	20301000	0	0	bytes	1		0
20302000	Top Destinations  (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from application_dest{4} where application like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20302000	0	0	bytes	1		0
20303000	Top Hosts (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from application_hosts{4} where application like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20303000	0	0	bytes	1		0
20401000	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select application,sum(hits) as hits,sum(total) as bytes from users_protogroup_application{4} where username like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20401000	0	0	bytes	1		0
20402000	Top Destinations  	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from users_protogroup_dest{4} where username like ''{7}'' and proto_group like ''{8}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20402000	0	0	bytes	1		0
20403000	Top Hosts 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_users{4} where username like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20403000	0	0	bytes	1		0
20501000	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select application,sum(hits) as hits,sum(sent) as bytes from users_protogroup_application{4} where username like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20501000	0	0	bytes	1		0
20502000	Top Destinations  (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from users_protogroup_dest{4} where username like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20502000	0	0	bytes	1		0
20503000	Top Hosts (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_users{4} where username like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20503000	0	0	bytes	1		0
20601000	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select application,sum(hits) as hits,sum(received) as bytes from users_protogroup_application{4} where username like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20601000	0	0	bytes	1		0
20602000	Top Destinations  (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from users_protogroup_dest{4} where username like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20602000	0	0	bytes	1		0
20603000	Top Hosts (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,proto_group,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_users{4} where username like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20603000	0	0	bytes	1		0
20701000	Top Application 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select application,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20701000	0	0	bytes	1		0
20702000	Top Destinations  	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}''  and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20702000	0	0	bytes	1		0
20703000	Top Users 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select username,sum(hits) as hits,sum(total) as bytes from hosts_protogroup_users{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20703000	0	0	bytes	1		0
20801000	Top Application (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select application,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20801000	0	0	bytes	1		0
20802000	Top Destinations  (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20802000	0	0	bytes	1		0
20803000	Top Users (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select username,sum(hits) as hits,sum(sent) as bytes from hosts_protogroup_users{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20803000	0	0	bytes	1		0
20901000	Top Application (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select application,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_application{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	20901000	0	0	bytes	1		0
20902000	Top Destinations  (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_dest{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20902000	0	0	bytes	1		0
20903000	Top Users (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,proto_group,appid	select username,sum(hits) as hits,sum(received) as bytes from hosts_protogroup_users{4} where INET_NTOA(srcip) like ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20903000	0	0	bytes	1		0
20101100	Top Destinations  	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,username,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from user_dest_application{4} where application like ''{7}'' and username like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20101100	0	0	bytes	1		0
20101200	Top Hosts 	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,username,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from host_user_application{4} where application like ''{7}'' and username like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20101200	0	0	bytes	1		0
20102100	Top Users 	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,destip,appid	select username,sum(hits) as hits,sum(total) as bytes from user_dest_application{4} where application like ''{7}'' and INET_NTOA(destip)  like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20102100	0	0	bytes	1		0
20102200	Top Hosts 	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,destip,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from host_dest_application{4} where application like ''{7}'' and INET_NTOA(destip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20102200	0	0	bytes	1		0
20103100	Top Destinations  	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,srcip,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(total) as bytes from host_dest_application{4} where application like ''{7}'' and INET_NTOA(srcip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20103100	0	0	bytes	1		0
20103200	Top Users 	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,srcip,appid	select username,sum(hits) as hits,sum(total) as bytes from host_user_application{4} where application like ''{7}'' and INET_NTOA(srcip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20103200	0	0	bytes	1		0
20201100	Top Destinations  (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,username,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from user_dest_application{4} where application like ''{7}'' and username like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20201100	0	0	bytes	1		0
20201200	Top Hosts (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,username,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from host_user_application{4} where application like ''{7}'' and username like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20201200	0	0	bytes	1		0
20202100	Top Users (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,destip,appid	select username,sum(hits) as hits,sum(sent) as bytes from user_dest_application{4} where application like ''{7}'' and INET_NTOA(destip)  like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20202100	0	0	bytes	1		0
20202200	Top Hosts (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,destip,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(sent) as bytes from host_dest_application{4} where application like ''{7}'' and INET_NTOA(destip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20202200	0	0	bytes	1		0
20203100	Top Destinations  (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,srcip,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(sent) as bytes from host_dest_application{4} where application like ''{7}'' and INET_NTOA(srcip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20203100	0	0	bytes	1		0
20203200	Top Users (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,srcip,appid	select username,sum(hits) as hits,sum(sent) as bytes from host_user_application{4} where application like ''{7}'' and INET_NTOA(srcip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20203200	0	0	bytes	1		0
20301100	Top Destinations  (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,username,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from user_dest_application{4} where application like ''{7}'' and username like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20301100	0	0	bytes	1		0
20301200	Top Hosts (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,username,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from host_user_application{4} where application like ''{7}'' and username like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20301200	0	0	bytes	1		0
20302100	Top Users (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,destip,appid	select username,sum(hits) as hits,sum(received) as bytes from user_dest_application{4} where application like ''{7}'' and INET_NTOA(destip)  like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20302100	0	0	bytes	1		0
20302200	Top Hosts (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,destip,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(received) as bytes from host_dest_application{4} where application like ''{7}'' and INET_NTOA(destip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	20302200	0	0	bytes	1		0
20303100	Top Destinations  (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,srcip,appid	select INET_NTOA(destip) as destip,sum(hits) as hits,sum(received) as bytes from host_dest_application{4} where application like ''{7}'' and INET_NTOA(srcip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By destip order by {5} {6} limit {3} OFFSET {2}	20303100	0	0	bytes	1		0
20303200	Top Users (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,srcip,appid	select username,sum(hits) as hits,sum(received) as bytes from host_user_application{4} where application like ''{7}'' and INET_NTOA(srcip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) group by username order by {5} {6} limit {3} OFFSET {2}	20303200	0	0	bytes	1		0
119	Top Accept Rules	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select ruleid,sum(hits) as hits,sum(bytes) as bytes from top_acceptrules{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By ruleid order by {5} {6} limit {3} OFFSET {2}	119	0	0	bytes	1		0
120	Top Deny Rules	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select ruleid,sum(hits) as hits,sum(bytes) as bytes from top_denyrules{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By ruleid order by {5} {6} limit {3} OFFSET {2}	120	0	0	hits	1		0
121	Top Accept Rules - Application Group Wise	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select proto_group,ruleid,sum(hits) as hits,sum(bytes) as bytes from top_acceptrules_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By proto_group,ruleid order by {5} {6} limit {3} OFFSET {2}	121	0	0	bytes	1		0
122	Top Deny Rules - Application Group Wise	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select proto_group,ruleid,sum(hits) as hits,sum(bytes) as bytes from top_denyrules_protogroup{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By proto_group,ruleid order by {5} {6} limit {3} OFFSET {2}	122	0	0	hits	1		0
123	Top Accept Rules - Host Wise	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as srcip,ruleid,sum(hits) as hits,sum(bytes) as bytes from top_acceptrules_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By srcip,ruleid order by {5} {6} limit {3} OFFSET {2}	123	0	0	bytes	1		0
124	Top Deny Rules - Host Wise	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(srcip) as srcip,ruleid,sum(hits) as hits,sum(bytes) as bytes from top_denyrules_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By srcip,ruleid order by {5} {6} limit {3} OFFSET {2}	124	0	0	hits	1		0
125	Top Accept Rules - Destination Wise	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(destip) as destip,ruleid,sum(hits) as hits,sum(bytes) as bytes from top_acceptrules_dest{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By destip,ruleid order by {5} {6} limit {3} OFFSET {2}	125	0	0	bytes	1		0
126	Top Deny Rules - Destination Wise	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(destip) as destip,ruleid,sum(hits) as hits,sum(bytes) as bytes from top_denyrules_dest{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By destip,ruleid order by {5} {6} limit {3} OFFSET {2}	126	0	0	hits	1		0
127	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,appid	select INET_NTOA(srcip) as srcip,application,username,INET_NTOA(destip) as destip,sum(hits) as hits,sum(bytes) as bytes from accept_rules_host_application_dest_user{4} where ruleid={7} and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip,application,username,destip order by {5} {6} limit {3} OFFSET {2}	127	0	0	hits	1		0
128		startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,appid	select INET_NTOA(srcip) as srcip,application,username,INET_NTOA(destip) as destip,sum(hits) as hits,sum(bytes) as bytes from deny_rules_host_application_dest_user{4} where ruleid = {7} and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip,application,username,destip order by {5} {6} limit {3} OFFSET {2}	128	0	0	hits	1		0
129		startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,proto_group,appid	select INET_NTOA(srcip) as srcip,application,username,INET_NTOA(destip) as destip,sum(hits) as hits,sum(bytes) as bytes from accept_rules_host_app_protog_dest_user{4} where ruleid = ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip,application,username,destip order by {5} {6} limit {3} OFFSET {2}	129	0	0	hits	1		0
130		startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,proto_group,appid	select INET_NTOA(srcip) as srcip,application,username,INET_NTOA(destip) as destip,sum(hits) as hits,sum(bytes) as bytes from deny_rules_host_app_protogroup_dest_user{4} where ruleid = ''{7}'' and proto_group like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip,application,username,destip order by {5} {6} limit {3} OFFSET {2}	130	0	0	hits	1		0
131	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,srcip,appid	select application,INET_NTOA(destip) as destip,username,sum(hits) as hits,sum(bytes) as bytes from accept_rules_host_application_dest_user{4} where ruleid = ''{7}'' and INET_NTOA(srcip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By application,destip,username order by {5} {6} limit {3} OFFSET {2}	131	0	0	hits	1		0
132	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,srcip,appid	select application,INET_NTOA(destip) as destip,username,sum(hits) as hits,sum(bytes) as bytes from deny_rules_host_application_dest_user{4} where ruleid = ''{7}'' and INET_NTOA(srcip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By application,destip,username order by {5} {6} limit {3} OFFSET {2}	132	0	0	hits	1		0
133	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,destip,appid	select INET_NTOA(srcip) as srcip,application,username,sum(hits) as hits,sum(bytes) as bytes from accept_rules_host_application_dest_user{4} where ruleid = ''{7}'' and INET_NTOA(destip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip,application,username order by {5} {6} limit {3} OFFSET {2}	133	0	0	hits	1		0
134	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,ruleid,destip,appid	select INET_NTOA(srcip) as srcip,application,username,sum(hits) as hits,sum(bytes) as bytes from deny_rules_host_application_dest_user{4} where ruleid = ''{7}'' and INET_NTOA(destip) like ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By srcip,application,username order by {5} {6} limit {3} OFFSET {2}	134	0	0	hits	1		0
806010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,file,appid	select username,domain,INET_NTOA(host) as host,sum(hits) as hits from deniedweb_files_hosts_domains_application{4} file like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username,domain,host order by {5} {6} limit {3} OFFSET {2}	806010	0	0	hits	1		0
1001	Allowed Traffic Overview	startdate,enddate,tbl	select * from getMainDashboardData(''{0}'',''{1}'',''{2}'')	1001	1	0	protocolgroup	1		0
1002	Denied Traffic Overview	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select deviceid, b.name as devicename,sum(a.hits) as total,a.traffic as Traffic from tblmaindeniedtraffic{4} a, tbldevice b where a.appid=b.appid and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and traffic in (select traffic from (select traffic,sum(hits) as total from tblmaindeniedtraffic{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' group by traffic order by total desc limit 5) as p ) GROUP BY a.traffic, b.name,b.deviceid order by traffic ,total desc	1002	1	0	total	1		0
901010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,attackers,appid	select attack,username,INET_NTOA(victims) as victims,application,severity,action,sum(hits) as hits from attackers_victims_attacks_application_users{4} where INET_NTOA(attackers) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By attack,username,victims,application,severity,action order by {5} {6} limit {3} OFFSET {2}	901010	0	0	hits	1		0
902010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,victims,appid	select attack,username,INET_NTOA(attackers) as attackers,application,severity,action,sum(hits) as hits from attackers_victims_attacks_application_users{4} where INET_NTOA(victims) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By attack,username,attackers,application,severity,action order by {5} {6} limit {3} OFFSET {2}	902010	0	0	hits	1		0
903010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,attack,appid	select INET_NTOA(attackers) as attackers,username,INET_NTOA(victims) as victims,application,severity,action,sum(hits) as hits from attackers_victims_attacks_application_users{4} where attack like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By attackers,username,victims,application,severity,action order by {5} {6} limit {3} OFFSET {2}	903010	0	0	hits	1		0
904010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,attack,severity,appid	select INET_NTOA(attackers) as attackers,username,INET_NTOA(victims) as victims,application,action,sum(hits) as hits from attackers_victims_attacks_application_users{4} where attack like ''{7}'' and severity = ''{8}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({9}) GROUP By attackers,username,victims,application,action order by {5} {6} limit {3} OFFSET {2}	904010	0	0	hits	1		0
905010	 	startdate,enddate,offset,limit,tbl,orderby,ordertype,application,appid	select attack,username,INET_NTOA(attackers) as attackers,INET_NTOA(victims) as victims,severity,action,sum(hits) as hits from attackers_victims_attacks_application_users{4} where application =  ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By attack,username,attackers,victims,severity,action order by {5} {6} limit {3} OFFSET {2}	905010	0	0	hits	1		0
1003	Allowed Traffic Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''proto_group'',''bytes'',''tblmainallowedtraffic'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1003	1	0	total	1		0
1201010	Firewall Allowed	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select proto_group,sum(hits) as hits,sum(total) as bytes from user_protogroup{4} where username = ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	1201010	0	0	bytes	1		0
1202010	Firewall Denied	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select application,sum(hits) as hits from hosts_dest_application_user{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	1202010	0	0	hits	1		0
1203010	Web Usage	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select domain,sum(hits) as hits, sum(bytes) as bytes from user_domain{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By domain order by {5} {6} limit {3} OFFSET {2}	1203010	0	0	bytes	1		0
1204010	Web Surfing Denied	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(host) as host,domain,sum(hits) as hits from deniedweb_users_hosts_domains_application{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By domain,host order by {5} {6} limit {3} OFFSET {2}	1204010	0	0	hits	1		0
1205010	IPS	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select attack,sum(hits) as hits from attackers_victims_attacks_application_users{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By attack order by {5} {6} limit {3} OFFSET {2}	1205010	0	0	hits	1		0
1206010	Top Spam	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select spam_sender,sum(hits) as hits from spamsender_application_source_users_dest{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By spam_sender order by {5} {6} limit {3} OFFSET {2}	1206010	0	0	hits	1		0
1207010	Mail Usage	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select application,sum(hits) as hits, sum(bytes) as bytes from user_application{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By application order by {5} {6} limit {3} OFFSET {2}	1207010	0	0	bytes	1		0
1208010	FTP Usage	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(destination) as destination,sum(hits) as hits,sum(upload+download) as bytes from users_dest{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By destination order by {5} {6} limit {3} OFFSET {2}	1208010	0	0	bytes	1		0
1209010	Virus	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select virus,sum(hits) as hits from virus_application_source_users_dest{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By virus order by {5} {6} limit {3} OFFSET {2}	1209010	0	0	hits	1		0
1004	Denied Traffic Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''traffic'',''hits'',''tblmaindeniedtraffic'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1004	1	0	total	1		0
1005	Web Traffic Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''traffic'',''bytes'',''tblwebtrafficsummary'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1005	1	0	totalhits	1		0
42000000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select category,sum(hits) as hits,sum(bytes) as bytes from web_category{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by category order by {5} {6} limit {3} OFFSET {2}	42000000	0	0	bytes	1		0
42200000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category	select username,sum(hits) as hits,sum(bytes) as bytes from web_category_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	42200000	0	0	bytes	1		0
42300000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category	select content,sum(hits) as hits,sum(bytes) as bytes from web_category_content{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and appid in ({7}) group by content order by {5} {6} limit {3} OFFSET {2}	42300000	0	0	bytes	1		0
42110000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,domain	select username,sum(hits) as hits,sum(bytes) as bytes from web_category_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and domain like ''{9}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	42110000	0	0	bytes	1		0
42111000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,domain,username	select url,sum(hits) as hits,sum(bytes) as bytes from web_category_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and domain like ''{9}''  and username like ''{10}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	42111000	0	0	bytes	1		0
42120000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,domain	select content,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and domain like ''{9}'' and appid in ({7}) group by content order by {5} {6} limit {3} OFFSET {2}	42120000	0	0	bytes	1		0
42121000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,domain,content	select username,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and domain like ''{9}''  and content like ''{10}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	42121000	0	0	bytes	1		0
42121100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,domain,content,username	select url,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and domain like ''{9}''  and content like ''{10}'' and username like ''{11}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	42121100	0	0	bytes	1		0
42210000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,username	select domain,sum(hits) as hits,sum(bytes) as bytes from web_category_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and username like ''{9}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	42210000	0	0	bytes	1		0
42211000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,username,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_category_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and username like ''{9}'' and  domain like ''{10}''  and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	42211000	0	0	bytes	1		0
42220000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,username	select content,sum(hits) as hits,sum(bytes) as bytes from web_category_content_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and username like ''{9}'' and appid in ({7}) group by content order by {5} {6} limit {3} OFFSET {2}	42220000	0	0	bytes	1		0
42221000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,username,content	select domain,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and username like ''{9}'' and content like ''{10}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	42221000	0	0	bytes	1		0
42221100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,username,content,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and username like ''{9}'' and content like ''{10}'' and  domain like ''{11}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	42221100	0	0	bytes	1		0
1008	Virus Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''proto_group'',''hits'',''tblvirussummary'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1008	1	0	totalhits	1		0
1009	Spam Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''application'',''hits'',''spam_app'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1009	1	0	totalhits	1		0
1011	Firewall Denied Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''application'',''hits'',''blocked_app_protogroup'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1011	1	0	totalhits	1		0
1006	Mail Traffic Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''traffic'',''bytes'',''tblmailtrafficsummary'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1006	1	0	totalhits	1		0
42310000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,content	select username,sum(hits) as hits,sum(bytes) as bytes from web_category_content_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and content like ''{9}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	42310000	0	0	bytes	1		0
42311000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,content,username	select domain,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and content like ''{9}'' and  username like ''{10}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	42311000	0	0	bytes	1		0
42311100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,content,username,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and content like ''{9}'' and  username like ''{10}'' and  domain like ''{11}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	42311100	0	0	bytes	1		0
42320000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,content	select domain,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and  content like ''{9}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	42320000	0	0	bytes	1		0
42321000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,content,domain	select username,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and  content like ''{9}'' and  domain like ''{10}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	42321000	0	0	bytes	1		0
42321100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,content,domain,username	select url,sum(hits) as hits,sum(bytes) as bytes from web_category_content_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and category like ''{8}''  and  content like ''{9}'' and  domain like ''{10}'' and  username like ''{11}''  and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	42321100	0	0	bytes	1		0
43100000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain	select username,sum(hits) as hits,sum(bytes) as bytes from web_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and  domain like ''{8}'' and appid in ({7})  group by username order by {5} {6} limit {3} OFFSET {2}	43100000	0	0	bytes	1		0
43200000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain	select content,sum(hits) as hits,sum(bytes) as bytes from web_content_domain{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and domain like ''{8}''  and appid  in ({7}) group by content  order by {5} {6} limit {3} OFFSET {2}	43200000	0	0	bytes	1		0
43110000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,username	select url,sum(hits) as hits,sum(bytes) as bytes from web_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and  domain like ''{8}'' and  username like ''{9}'' and appid in ({7})  group by url order by {5} {6} limit {3} OFFSET {2}	43110000	0	0	bytes	1		0
43210000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,content	select username,sum(hits) as hits,sum(bytes) as bytes from web_content_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and domain like ''{8}''  and content like ''{9}'' and appid  in ({7}) group by username  order by {5} {6} limit {3} OFFSET {2}	43210000	0	0	bytes	1		0
43211000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,content,username	select url,sum(hits) as hits,sum(bytes) as bytes from web_content_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and domain like ''{8}''  and content like ''{9}'' and username like ''{10}'' and appid  in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	43211000	0	0	bytes	1		0
81000000	Top Denied Web Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits from deniedweb_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	81000000	0	0	hits	1		0
81100000	 Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select category,sum(hits) as hits from deniedweb_category_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' group by category order by {5} {6} limit {3} OFFSET {2}	81100000	0	0	hits	1		0
81200000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select domain,sum(hits) as hits from deniedweb_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' group by domain order by {5} {6} limit {3} OFFSET {2}	81200000	0	0	hits	1		0
81300000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select url,sum(hits) as hits from deniedweb_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' group by url order by {5} {6} limit {3} OFFSET {2}	81300000	0	0	hits	1		0
81500000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select application,sum(hits) as hits from deniedweb_app_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' group by application order by {5} {6} limit {3} OFFSET {2}	81500000	0	0	hits	1		0
81110000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,category	select domain,sum(hits) as hits from deniedweb_category_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and category like ''{9}'' group by domain order by {5} {6} limit {3} OFFSET {2}	81110000	0	0	hits	1		0
81111000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,category,domain	select url,sum(hits) as hits from deniedweb_category_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and category like ''{9}''  and domain like ''{10}'' group by url order by {5} {6} limit {3} OFFSET {2}	81111000	0	0	hits	1		0
81210000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,domain	select url,sum(hits) as hits from deniedweb_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and domain like ''{9}'' group by url order by {5} {6} limit {3} OFFSET {2}	81210000	0	0	hits	1		0
81410000	 Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select category,sum(hits) as hits from deniedweb_category_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}'' group by category order by {5} {6} limit {3} OFFSET {2}	81410000	0	0	hits	1		0
81420000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select domain,sum(hits) as hits from deniedweb_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}'' group by domain order by {5} {6} limit {3} OFFSET {2}	81420000	0	0	hits	1		0
81430000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select url,sum(hits) as hits from deniedweb_host_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}'' group by url  order by {5} {6} limit {3} OFFSET {2}	81430000	0	0	hits	1		0
81440000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select application,sum(hits) as hits from deniedweb_app_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}'' group by application order by {5} {6} limit {3} OFFSET {2}	81440000	0	0	hits	1		0
81411100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,category,domain	select url,sum(hits) as hits from deniedweb_category_domain_host_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}''  and category like ''{10}'' and domain like ''{11}'' group by url order by {5} {6} limit {3} OFFSET {2}	81411100	0	0	hits	1		0
81421000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,domain	select url,sum(hits) as hits from deniedweb_domain_host_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}''  and domain like ''{10}'' group by url order by {5} {6} limit {3} OFFSET {2}	81421000	0	0	hits	1		0
81441000	 Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application	select category,sum(hits) as hits from deniedweb_app_category_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and application like ''{10}'' group by category order by {5} {6} limit {3} OFFSET {2}	81441000	0	0	hits	1		0
81441110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application,category,domain	select url,sum(hits) as hits from deniedweb_app_category_domain_host_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and application like ''{10}'' and category like ''{11}'' and domain like ''{12}'' group by url order by {5} {6} limit {3} OFFSET {2}	81441110	0	0	hits	1		0
81510000	 Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application	select category,sum(hits) as hits from deniedweb_app_category_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' and application like ''{9}'' group by category order by {5} {6} limit {3} OFFSET {2}	81510000	0	0	hits	1		0
81511000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application,category	select domain,sum(hits) as hits from deniedweb_app_category_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' and application like ''{9}'' and category like ''{10}'' group by domain order by {5} {6} limit {3} OFFSET {2}	81511000	0	0	hits	1		0
81511100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application,category,domain	select url,sum(hits) as hits from deniedweb_app_category_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' and application like ''{9}'' and category like ''{10}'' and domain like ''{11}'' group by url order by {5} {6} limit {3} OFFSET {2}	81511100	0	0	hits	1		0
82000000	Top Denied Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select category,sum(hits) as hits from deniedweb_category{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by category order by {5} {6} limit {3} OFFSET {2}	82000000	0	0	hits	1		0
82100000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category	select domain,sum(hits) as hits from deniedweb_category_domain{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and category like ''{8}'' group by domain order by {5} {6} limit {3} OFFSET {2}	82100000	0	0	hits	1		0
82200000	 Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category	select username,sum(hits) as hits from deniedweb_category_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and category like ''{8}'' group by username order by {5} {6} limit {3} OFFSET {2}	82200000	0	0	hits	1		0
82110000	 Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,domain	select username,sum(hits) as hits from deniedweb_category_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and category like ''{8}'' and domain like ''{9}'' group by username order by {5} {6} limit {3} OFFSET {2}	82110000	0	0	hits	1		0
82111000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,domain,username	select url,sum(hits) as hits from deniedweb_category_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and category like ''{8}'' and domain like ''{9}'' and  username like ''{10}'' group by url order by {5} {6} limit {3} OFFSET {2}	82111000	0	0	hits	1		0
82210000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,username	select domain,sum(hits) as hits from deniedweb_category_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and category like ''{8}'' and username like ''{9}'' group by domain order by {5} {6} limit {3} OFFSET {2}	82210000	0	0	hits	1		0
82211000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,category,username,domain	select url,sum(hits) as hits from deniedweb_category_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and category like ''{8}'' and username like ''{9}'' and domain like ''{10}'' group by url order by {5} {6} limit {3} OFFSET {2}	82211000	0	0	hits	1		0
83000000	Top  Denied Domains 	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select domain,sum(hits) as hits from deniedweb_domain{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	83000000	0	0	hits	1		0
83100000	 Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain	select username,sum(hits) as hits from deniedweb_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and domain like ''{8}'' group by username order by {5} {6} limit {3} OFFSET {2}	83100000	0	0	hits	1		0
83110000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,username	select url,sum(hits) as hits from deniedweb_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and domain like ''{8}'' and username like ''{9}'' group by url order by {5} {6} limit {3} OFFSET {2}	83110000	0	0	hits	1		0
84100000	 Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select category,sum(hits) as hits from deniedweb_category_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' group by category order by {5} {6} limit {3} OFFSET {2}	84100000	0	0	hits	1		0
84200000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select domain,sum(hits) as hits from deniedweb_domain_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' group by domain order by {5} {6} limit {3} OFFSET {2}	84200000	0	0	hits	1		0
84300000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select url,sum(hits) as hits from deniedweb_host_url{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' group by url order by {5} {6} limit {3} OFFSET {2}	84300000	0	0	hits	1		0
84400000	 Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select username,sum(hits) as hits from deniedweb_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' group by username order by {5} {6} limit {3} OFFSET {2}	84400000	0	0	hits	1		0
84210000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,domain	select url,sum(hits) as hits from deniedweb_domain_host_url{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and  domain like ''{9}'' group by url order by {5} {6} limit {3} OFFSET {2}	84210000	0	0	hits	1		0
84410000	 Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select category,sum(hits) as hits from deniedweb_category_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' group by category order by {5} {6} limit {3} OFFSET {2}	84410000	0	0	hits	1		0
84420000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select domain,sum(hits) as hits from deniedweb_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' group by domain order by {5} {6} limit {3} OFFSET {2}	84420000	0	0	hits	1		0
84430000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select url,sum(hits) as hits from deniedweb_host_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' group by url  order by {5} {6} limit {3} OFFSET {2}	84430000	0	0	hits	1		0
84440000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select application,sum(hits) as hits from deniedweb_app_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' group by application order by {5} {6} limit {3} OFFSET {2}	84440000	0	0	hits	1		0
84411000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,category	select domain,sum(hits) as hits from deniedweb_category_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' and category like ''{10}'' group by domain order by {5} {6} limit {3} OFFSET {2}	84411000	0	0	hits	1		0
84411100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,category,domain	select url,sum(hits) as hits from deniedweb_category_domain_host_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' and category like ''{10}'' and domain like ''{11}'' group by url order by {5} {6} limit {3} OFFSET {2}	84411100	0	0	hits	1		0
84421000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,domain	select url,sum(hits) as hits from deniedweb_domain_host_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' and domain like ''{10}'' group by url order by {5} {6} limit {3} OFFSET {2}	84421000	0	0	hits	1		0
84441000	 Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application	select category,sum(hits) as hits from deniedweb_app_category_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' and application like ''{10}'' group by category order by {5} {6} limit {3} OFFSET {2}	84441000	0	0	hits	1		0
84441100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application,category	select domain,sum(hits) as hits from deniedweb_app_category_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' and application like ''{10}'' and category like ''{11}'' group by domain order by {5} {6} limit {3} OFFSET {2}	84441100	0	0	hits	1		0
84441110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username,application,category,domain	select url,sum(hits) as hits from deniedweb_app_category_domain_host_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and username like ''{9}'' and application like ''{10}'' and category like ''{11}''  and domain like ''{12}'' group by url order by {5} {6} limit {3} OFFSET {2}	84441110	0	0	hits	1		0
84500000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select application,sum(hits) as hits from deniedweb_app_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' group by application order by {5} {6} limit {3} OFFSET {2}	84500000	0	0	hits	1		0
84510000	 Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application	select category,sum(hits) as hits from deniedweb_app_category_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and application like ''{9}'' group by category order by {5} {6} limit {3} OFFSET {2}	84510000	0	0	hits	1		0
84511000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application,category	select domain,sum(hits) as hits from deniedweb_app_category_domain_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and application like ''{9}'' and category like ''{10}'' group by domain order by {5} {6} limit {3} OFFSET {2}	84511000	0	0	hits	1		0
84511100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,application,category,domain	select url,sum(hits) as hits from deniedweb_app_category_domain_host_url{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' and application like ''{9}'' and category like ''{10}'' and domain like ''{11}'' group by url order by {5} {6} limit {3} OFFSET {2}	84511100	0	0	hits	1		0
84000000	Top Denied Web Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(host) as host,sum(hits) as hits from deniedweb_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by host order by {5} {6} limit {3} OFFSET {2}	84000000	0	0	hits	1		0
81400000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(host) as host,sum(hits) as hits from deniedweb_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' group by host order by {5} {6} limit {3} OFFSET {2}	81400000	0	0	hits	1		0
84110000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,category	select domain,sum(hits) as hits from deniedweb_category_domain_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}''  and category like  ''{9}''   group by domain order by {5} {6} limit {3} OFFSET {2}	84110000	0	0	hits	1		0
84111000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,category,domain	select url,sum(hits) as hits from deniedweb_category_domain_host_url{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}''  and category like ''{9}''  and domain like ''{10}'' group by url  order by {5} {6} limit {3} OFFSET {2}	84111000	0	0	hits	1		0
81441100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application,category	select domain,sum(hits) as hits from deniedweb_app_category_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and application like ''{10}'' and category like ''{11}'' group by domain order by {5} {6} limit {3} OFFSET {2}	81441100	0	0	hits	1		0
81411000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,category	select domain,sum(hits) as hits from deniedweb_category_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}''  and INET_NTOA(host) like ''{9}''  and category like ''{10}'' group by domain order by {5} {6} limit {3} OFFSET {2}	81411000	0	0	hits	1		0
41000000	Top Web Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits,sum(bytes) as bytes from web_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by username order by {5} {6} limit {3} OFFSET {2}	41000000	0	0	bytes	1		0
41100000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select category,sum(hits) as hits,sum(bytes) as bytes from web_category_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and appid in ({7}) group by category order by {5} {6} limit {3} OFFSET {2}	41100000	0	0	bytes	1		0
41200000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select domain,sum(hits) as hits,sum(bytes) as bytes from web_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	41200000	0	0	bytes	1		0
41300000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select content,sum(hits) as hits,sum(bytes) as bytes from web_content_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and appid in ({7}) group by content order by {5} {6} limit {3} OFFSET {2}	41300000	0	0	bytes	1		0
41500000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(host) as host,sum(hits) as hits,sum(bytes) as bytes from web_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and appid in ({7}) group by INET_NTOA(host)  order by {5} {6} limit {3} OFFSET {2}	41500000	0	0	bytes	1		0
41600000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select application,sum(hits) as hits,sum(bytes) as bytes from web_app_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and appid in ({7}) group by application order by {5} {6} limit {3} OFFSET {2}	41600000	0	0	bytes	1		0
41210000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and domain like ''{9}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41210000	0	0	bytes	1		0
41310000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,content	select domain,sum(hits) as hits,sum(bytes) as bytes from web_content_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and content like ''{9}'' and appid in ({7}) group by domain order by {5} {6} limit {3}  OFFSET {2}	41310000	0	0	bytes	1		0
41311000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,content,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_content_domain_url_user{4} where  "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  content like ''{9}'' and  domain like ''{10}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41311000	0	0	bytes	1		0
41510000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select category,sum(hits) as hits,sum(bytes) as bytes from web_category_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and appid in ({7}) group by category order by {5} {6} limit {3} OFFSET {2}	41510000	0	0	bytes	1		0
41520000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select domain,sum(hits) as hits,sum(bytes) as bytes from web_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  INET_NTOA(host) like ''{9}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	41520000	0	0	bytes	1		0
41530000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select content,sum(hits) as hits,sum(bytes) as bytes from web_content_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and appid in ({7}) group by content order by {5} {6} limit {3} OFFSET {2}	41530000	0	0	bytes	1		0
41540000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select url,sum(hits) as hits,sum(bytes) as bytes from web_url_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41540000	0	0	bytes	1		0
41550000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select application,sum(hits) as hits,sum(bytes) as bytes from web_app_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and appid in ({7}) group by application order by {5} {6} limit {3} OFFSET {2}	41550000	0	0	bytes	1		0
41511000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,category	select domain,sum(hits) as hits,sum(bytes) as bytes from web_category_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}''  and category like ''{10}''  and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	41511000	0	0	bytes	1		0
41511100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,category,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_category_domain_url_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}''  and category like ''{10}''  and domain like ''{11}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41511100	0	0	bytes	1		0
41521000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_domain_url_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  INET_NTOA(host) like ''{9}'' and domain like ''{10}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41521000	0	0	bytes	1		0
41531000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,content	select domain,sum(hits) as hits,sum(bytes) as bytes from web_content_domain_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and content like ''{10}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	41531000	0	0	bytes	1		0
41531100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,content,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_content_domain_url_host_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and content like ''{10}'' and  domain like ''{11}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41531100	0	0	bytes	1		0
41551000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application	select category,sum(hits) as hits,sum(bytes) as bytes from web_app_category_host_user{4} where  "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and application like ''{10}'' and appid in ({7}) group by category  order by {5} {6} limit {3} OFFSET {2}	41551000	0	0	bytes	1		0
41552000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application	select content,sum(hits) as hits,sum(bytes) as bytes from web_app_content_host_user{4} where  "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and application like ''{10}'' and appid in ({7}) group by content order by {5} {6} limit {3} OFFSET {2}	41552000	0	0	bytes	1		0
41552100	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application,content	select domain,sum(hits) as hits,sum(bytes) as bytes from web_app_content_domain_host_user{4} where  "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and application like ''{10}'' and  content like ''{11}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	41552100	0	0	bytes	1		0
41552110	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host,application,content,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_app_content_domain_url_host_user{4} where  "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}''  and INET_NTOA(host) like ''{9}'' and application like ''{10}'' and  content like ''{11}'' and domain like ''{12}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41552110	0	0	bytes	1		0
41610000	Top Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application	select category,sum(hits) as hits,sum(bytes) as bytes from web_app_category_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  application like ''{9}'' and appid in ({7}) group by category order by {5} {6} limit {3} OFFSET {2}	41610000	0	0	bytes	1		0
41620000	Top Contents	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application	select content,sum(hits) as hits,sum(bytes) as bytes from web_app_content_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  application like ''{9}'' and appid in ({7}) group by content order by {5} {6} limit {3} OFFSET {2}	41620000	0	0	bytes	1		0
41611000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application,category	select domain,sum(hits) as hits,sum(bytes) as bytes from web_app_category_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  application like ''{9}''  and category like ''{10}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	41611000	0	0	bytes	1		0
41611100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application,category,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_app_category_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  application like ''{9}''  and category like ''{10}'' and domain like ''{11}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41611100	0	0	bytes	1		0
41621000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application,content	select domain,sum(hits) as hits,sum(bytes) as bytes from web_app_content_domain_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  application like ''{9}'' and  content like ''{10}'' and appid in ({7}) group by domain order by {5} {6} limit {3} OFFSET {2}	41621000	0	0	bytes	1		0
41621100	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,application,content,domain	select url,sum(hits) as hits,sum(bytes) as bytes from web_app_content_domain_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and  application like ''{9}'' and  content like ''{10}'' and domain like ''{11}'' and appid in ({7}) group by url order by {5} {6} limit {3} OFFSET {2}	41621100	0	0	bytes	1		0
1010000	Top Spam Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select recipient,sum(hits) as hits from spam_recipient{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	1010000	0	1	hits	1		0
1011000	Top Spam Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select sender,sum(hits) as hits from spam_recipient_sender{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	1011000	0	1	hits	1		0
1011100	Spam Sender Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,sender	select application,INET_NTOA(destip) as destination,INET_NTOA(host) as host,subject,username,sum(hits) as size from spam_detail{4} where recipient=''{8}'' and sender=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application,INET_NTOA(destip),INET_NTOA(host),subject,username order by {5} {6} limit {3} OFFSET {2}	1011100	0	1	size	1		0
1012000	Top Source Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select INET_NTOA(host) as host,sum(hits) as hits from spam_host_recipient{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	1012000	0	1	hits	1		0
1012100	Source Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,host	select application,INET_NTOA(destip) as destination,sender,subject,username,sum(hits) as size from spam_detail{4} where recipient=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application,INET_NTOA(destip),sender,subject,username order by {5} {6} limit {3} OFFSET {2}	1012100	0	1	size	1		0
1013000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select INET_NTOA(destip) as destination,sum(hits) as hits from spam_dest_recipient{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	1013000	0	1	hits	1		0
1013100	Destination Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,destination	select application,INET_NTOA(host) as host,sender,subject,username,sum(hits) as size from spam_detail{4} where recipient=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application,INET_NTOA(host),sender,subject,username order by {5} {6} limit {3} OFFSET {2}	1013100	0	1	size	1		0
1014000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select username,sum(hits) as hits from spam_recipient_user{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	1014000	0	1	hits	1		0
1014100	User Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,username	select application,INET_NTOA(destip) as destination,INET_NTOA(host) as host,sender,subject,sum(hits) as size from spam_detail{4} where recipient=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application,INET_NTOA(destip),INET_NTOA(host),sender,subject order by {5} {6} limit {3} OFFSET {2}	1014100	0	1	size	1		0
1015000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select application,sum(hits) as hits from spam_app_recipient{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	1015000	0	1	hits	1		0
1015100	Application Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient,application	select INET_NTOA(destip) as destination,INET_NTOA(host) as host,sender,subject,username,sum(hits) as size from spam_detail{4} where recipient=''{8}'' and application=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host),sender,subject,username order by {5} {6} limit {3} OFFSET {2}	1015100	0	1	size	1		0
1020000	Top Spam Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select sender,sum(hits) as hits from spam_sender{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	1020000	0	1	hits	1		0
1021000	Top Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select recipient,sum(hits) as hits from spam_recipient_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	1021000	0	1	hits	1		0
1021100	Recipient Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,recipient	select application,INET_NTOA(destip) as destination,INET_NTOA(host) as host,subject,username,sum(hits) as size from spam_detail{4} where sender=''{8}'' and recipient=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application,INET_NTOA(destip),INET_NTOA(host),subject,username order by {5} {6} limit {3} OFFSET {2}	1021100	0	1	size	1		0
1022000	Top Source Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select INET_NTOA(host) as host,sum(hits) as hits from spam_host_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	1022000	0	1	hits	1		0
1022100	Source Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,host	select application,INET_NTOA(destip) as destination,recipient,subject,username,sum(hits) as size from spam_detail{4} where sender=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application,INET_NTOA(destip),recipient,subject,username order by {5} {6} limit {3} OFFSET {2}	1022100	0	1	size	1		0
1023000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select INET_NTOA(destip) as destination,sum(hits) as hits from spam_dest_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	1023000	0	1	hits	1		0
1023100	Destination Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,destination	select application,INET_NTOA(host) as host,recipient,subject,username,sum(hits) as size from spam_detail{4} where sender=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application,INET_NTOA(host),recipient,subject,username order by {5} {6} limit {3} OFFSET {2}	1023100	0	1	size	1		0
1024000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select username,sum(hits) as hits from spam_sender_user{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	1024000	0	1	hits	1		0
1024100	User Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,username	select application,INET_NTOA(destip) as destination,INET_NTOA(host) as host,recipient,subject,sum(hits) as size from spam_detail{4} where sender=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application,INET_NTOA(destip),INET_NTOA(host),recipient,subject order by {5} {6} limit {3} OFFSET {2}	1024100	0	1	size	1		0
1025000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select application,sum(hits) as hits from spam_app_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	1025000	0	1	hits	1		0
1025100	Application Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender,application	select INET_NTOA(destip) as destination,INET_NTOA(host) as host,recipient,subject,username,sum(hits) as size from spam_detail{4} where sender=''{8}'' and application=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host),recipient,subject,username order by {5} {6} limit {3} OFFSET {2}	1025100	0	1	size	1		0
1030000	Top Applications used for Spam	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select application,sum(hits) as hits from spam_app{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	1030000	0	1	hits	1		0
1031000	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select sender,sum(hits) as hits from spam_app_sender{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	1031000	0	1	hits	1		0
1031100	Sender Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,sender	select INET_NTOA(destip) as destination,INET_NTOA(host) as host,recipient,subject,username,sum(hits) as size from spam_detail{4} where application=''{8}'' and sender=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host),recipient,subject,username order by {5} {6} limit {3} OFFSET {2}	1031100	0	1	size	1		0
1032000	Top Recipient	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select recipient,sum(hits) as hits from spam_app_recipient{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	1032000	0	1	hits	1		0
1032100	Recipient Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,recipient	select INET_NTOA(destip) as destination,INET_NTOA(host) as host,sender,subject,username,sum(hits) as size from spam_detail{4} where application=''{8}'' and recipient=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host),sender,subject,username order by {5} {6} limit {3} OFFSET {2}	1032100	0	1	size	1		0
1033000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select username,sum(hits) as hits from spam_app_user{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	1033000	0	1	hits	1		0
1033100	User Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,username	select INET_NTOA(destip) as destination,INET_NTOA(host) as host,recipient,sender,subject,sum(hits) as size from spam_detail{4} where application=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host),recipient,sender,subject order by {5} {6} limit {3} OFFSET {2}	1033100	0	1	size	1		0
1034000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select INET_NTOA(host) as host,sum(hits) as hits from spam_app_host{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	1034000	0	1	hits	1		0
1035000	Top Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select INET_NTOA(destip) as destination,sum(hits) as hits from spam_app_dest{4} where application=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	1035000	0	1	hits	1		0
1035100	Destination Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,destination	select INET_NTOA(host) as host,recipient,sender,subject,username,sum(hits) as size from spam_detail{4} where application=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),recipient,sender,subject,username order by {5} {6} limit {3} OFFSET {2}	1035100	0	1	size	1		0
1034100	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,host	select INET_NTOA(destip) as destination,recipient,sender,subject,username,sum(hits) as size from spam_detail{4} where application=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),recipient,sender,subject,username order by {5} {6} limit {3} OFFSET {2}	1034100	0	1	size	1		0
91000000	Severity wise break-down	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select severity,sum(hits) as hits from ips_svrt{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by severity order by {5} {6} limit {3} OFFSET {2}	91000000	0	0	hits	1		0
91100000	Top Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity	select  attack,sum(hits) as hits from ips_attack_svrt{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} group by attack order by {5} {6} limit {3} OFFSET {2}	91100000	0	0	hits	1		0
91110000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity,attack	select  INET_NTOA(attacker) as attacker, INET_NTOA(victim) as victim, username, application, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} and attack like ''{9}'' group by attacker, victim, username, application, action order by {5} {6} limit {3} OFFSET {2}	91110000	0	0	hits	1		0
91200000	Top Attackers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity	select INET_NTOA(attacker) as attacker,sum(hits) as hits from ips_attacker_svrt{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} group by attacker order by {5} {6} limit {3} OFFSET {2}	91200000	0	0	hits	1		0
91210000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity,attacker	select attack, INET_NTOA(victim) as victim, application, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} and INET_NTOA(attacker)   like ''{9}'' group by attack, victim, application, action order by {5} {6} limit {3} OFFSET {2}	91210000	0	0	hits	1		0
91300000	Top Victims	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity	select INET_NTOA(victim) as victim,sum(hits) as hits from ips_svrt_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} group by victim order by {5} {6} limit {3} OFFSET {2}	91300000	0	0	hits	1		0
91310000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity,victim	select  attack, INET_NTOA(attacker) as attacker, application, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} and INET_NTOA(victim) like ''{9}'' group by attack, attacker, application, action order by {5} {6} limit {3} OFFSET {2}	91310000	0	0	hits	1		0
91400000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity	select application,sum(hits) as hits from ips_app_svrt{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} group by application order by {5} {6} limit {3} OFFSET {2}	91400000	0	0	hits	1		0
91410000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity,application	select attack, INET_NTOA(attacker) as attacker, INET_NTOA(victim) as victim, username, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} and application like ''{9}'' group by attack, attacker, victim, username, action order by {5} {6} limit {3} OFFSET {2}	91410000	0	0	hits	1		0
92000000	Top Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select attack,sum(hits) as hits from ips_attack{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by attack order by {5} {6} limit {3} OFFSET {2}	92000000	0	0	hits	1		0
92110000	Victim	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attack,attacker	select INET_NTOA(victim) as victim, application, action,sum(hits) as hits from ips_actn_app_attack_attacker_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and attack like ''{8}'' and INET_NTOA(attacker)  like ''{9}'' group by victim, application, action order by {5} {6} limit {3} OFFSET {2}	92110000	0	0	hits	1		0
92200000	Top Victims	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attack	select INET_NTOA(victim) as victim,sum(hits) as hits from ips_attack_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and attack like ''{8}'' group by victim order by {5} {6} limit {3} OFFSET {2}	92200000	0	0	hits	1		0
92210000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attack,victim	select INET_NTOA(attacker) as attacker, application,  action,sum(hits) as hits from ips_actn_app_attack_attacker_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and attack like ''{8}''  and INET_NTOA(victim) like ''{9}'' group by attacker, application,  action order by {5} {6} limit {3} OFFSET {2}	92210000	0	0	hits	1		0
92300000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attack	select application,sum(hits) as hits from ips_app_attack{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and attack like ''{8}'' group by application order by {5} {6} limit {3} OFFSET {2}	92300000	0	0	hits	1		0
92310000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attack,application	select INET_NTOA(attacker) as attacker, INET_NTOA(victim) as victim, username,  action,sum(hits) as hits from ips_actn_app_attack_attacker_user_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and attack like ''{8}'' and application like ''{9}'' group by attacker, victim, username,  action order by {5} {6} limit {3} OFFSET {2}	92310000	0	0	hits	1		0
97000000	Top Applications used by Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select application,sum(hits) as hits from ips_app{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by application order by {5} {6} limit {3} OFFSET {2}	97000000	0	0	hits	1		0
97100000	Top Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select attack,sum(hits) as hits from ips_app_attack{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' group by  attack order by {5} {6} limit {3} OFFSET {2}	97100000	0	0	hits	1		0
97110000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,attack	select INET_NTOA(attacker) as attacker, INET_NTOA(victim) as victim, username, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' and attack like ''{9}'' group by  attacker, victim, username, severity, action order by {5} {6} limit {3} OFFSET {2}	97110000	0	0	hits	1		0
97200000	Top Attackers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select INET_NTOA(attacker) as attacker,sum(hits) as hits from ips_app_attacker{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' group by attacker order by {5} {6} limit {3} OFFSET {2}	97200000	0	0	hits	1		0
97210000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,attacker	select attack, INET_NTOA(victim) as victim, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' and INET_NTOA(attacker) like ''{9}'' group by attack, victim, severity, action order by {5} {6} limit {3} OFFSET {2}	97210000	0	0	hits	1		0
97310000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,victim	select attack, INET_NTOA(attacker) as attacker, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' and INET_NTOA(victim) like ''{9}'' group by attack, attacker, severity, action order by {5} {6} limit {3} OFFSET {2}	97310000	0	0	hits	1		0
4400000	Top Content	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select content, sum(hits) as hits, sum(bytes) as bytes from web_content{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By content order by {5} {6} limit {3} OFFSET {2}	4400000	0	1	 bytes	1		0
93000000	Top Attackers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(attacker) as attacker,sum(hits) as hits from ips_attacker{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by attacker order by {5} {6} limit {3} OFFSET {2}	93000000	0	0	hits	1		0
93100000	Top Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attacker	select attack,sum(hits) as hits from ips_attack_attacker{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(attacker)  like ''{8}'' group by attack order by {5} {6} limit {3} OFFSET {2}	93100000	0	0	hits	1		0
93110000	Victim	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attacker,attack	select INET_NTOA(victim) as victim, username, application, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(attacker)  like ''{8}'' and attack like ''{9}'' group by victim, username, application, severity, action order by {5} {6} limit {3} OFFSET {2}	93110000	0	0	hits	1		0
93200000	Top Victims	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attacker	select INET_NTOA(victim) as victim,sum(hits) as hits from ips_attacker_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(attacker)  like ''{8}'' group by victim order by {5} {6} limit {3} OFFSET {2}	93200000	0	0	hits	1		0
93210000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attacker,victim	select attack, username, application, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(attacker)  like ''{8}'' and INET_NTOA(victim) like ''{9}'' group by attack, username, application, severity, action order by {5} {6} limit {3} OFFSET {2}	93210000	0	0	hits	1		0
93300000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attacker	select application,sum(hits) as hits from ips_app_attacker{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(attacker)  like ''{8}'' group by application order by {5} {6} limit {3} OFFSET {2}	93300000	0	0	hits	1		0
93310000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attacker,application	select attack, INET_NTOA(victim) as victim, username, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(attacker)  like ''{8}'' and application like ''{9}'' group by attack, victim, username, severity, action order by {5} {6} limit {3} OFFSET {2}	93310000	0	0	hits	1		0
97300000	Top Victims	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select INET_NTOA(victim) as victim,sum(hits) as hits from ips_app_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' group by victim order by {5} {6} limit {3} OFFSET {2}	97300000	0	0	hits	1		0
94000000	Top Victims	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(victim) as victim,sum(hits) as hits from ips_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) group by victim order by {5} {6} limit {3} OFFSET {2}	94000000	0	0	hits	1		0
94100000	Top Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,victim	select attack,sum(hits) as hits from ips_attack_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(victim) like ''{8}'' group by attack order by {5} {6} limit {3} OFFSET {2}	94100000	0	0	hits	1		0
94110000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,victim,attack	select INET_NTOA(attacker) as attacker, username, application, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(victim) like ''{8}'' and attack like ''{9}''  group by attacker, username, application, severity, action order by {5} {6} limit {3} OFFSET {2}	94110000	0	0	hits	1		0
94200000	Top Attackers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,victim	select INET_NTOA(attacker) as attacker,sum(hits) as hits from ips_attacker_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(victim) like ''{8}'' group by attacker order by {5} {6} limit {3} OFFSET {2}	94200000	0	0	hits	1		0
94210000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,victim,attacker	select attack, username, application, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(victim) like ''{8}'' and INET_NTOA(attacker)  like ''{9}'' group by attack, username, application, severity, action order by {5} {6} limit {3} OFFSET {2}	94210000	0	0	hits	1		0
94300000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,victim	select application,sum(hits) as hits from ips_app_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(victim) like ''{8}'' group by application order by {5} {6} limit {3} OFFSET {2}	94300000	0	0	hits	1		0
94310000	Attack	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,victim,application	select attack, INET_NTOA(attacker) as attacker, username, severity, action,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(victim) like ''{8}'' and application like ''{9}'' group by attack, attacker, username, severity, action order by {5} {6} limit {3} OFFSET {2}	94310000	0	0	hits	1		0
11300000	Web Viruses	\N	\N	0	0	0	\N	1	\N	1
11400000	Mail Viruses	\N	\N	0	0	0	\N	1	\N	1
11500000	FTP Viruses	\N	\N	0	0	0	\N	1	\N	1
11100000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select application,sum(hits) as hits from virus_app{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	11100000	0	1	hits	1		0
11200000	Top Viruses	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select virus,sum(hits) as hits from virus_virus{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY virus order by {5} {6} limit {3} OFFSET {2}	11200000	0	1	hits	1		0
11310000	Top Viruses	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select virus,sum(hits) as hits from virus_webvirus{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY virus order by {5} {6} limit {3} OFFSET {2}	11310000	0	1	hits	1		0
11311000	Top Domain	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select domain,sum(hits) as hits from virus_domain_webvirus{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY domain order by {5} {6} limit {3} OFFSET {2}	11311000	0	1	hits	1		0
11311100	Domain Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,domain	select url,username,INET_NTOA(host) as host,sum(hits) as hits from virus_domain_host_url_user_webvirus{4} where virus=''{8}'' and domain=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,username,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11311100	0	1	hits	1		0
11312000	Top User	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select username,sum(hits) as hits from virus_user_webvirus{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11312000	0	1	hits	1		0
11312100	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username	select url,INET_NTOA(host) as host,sum(hits) as hits from virus_host_url_user_webvirus{4} where virus=''{8}'' and username=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11312100	0	1	hits	1		0
11313000	Top Host	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select INET_NTOA(host) as host,sum(hits) as hits from virus_host_webvirus{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11313000	0	1	hits	1		0
11313100	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select url,username,sum(hits) as hits from virus_host_url_user_webvirus{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,username order by {5} {6} limit {3} OFFSET {2}	11313100	0	1	hits	1		0
11320000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select domain,sum(hits) as hits from virus_domain{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY domain order by {5} {6} limit {3} OFFSET {2}	11320000	0	1	hits	1		0
11321000	Top Virus	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain	select virus,sum(hits) as hits from virus_domain_webvirus{4} where domain=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY virus order by {5} {6} limit {3} OFFSET {2}	11321000	0	1	hits	1		0
11321100	Virus Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,virus	select url,username,INET_NTOA(host) as host,sum(hits) as hits from virus_domain_host_url_user_webvirus{4} where domain=''{8}'' and virus=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,username,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11321100	0	1	hits	1		0
11322000	Top User	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain	select username,sum(hits) as hits from virus_domain_user{4} where domain=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11322000	0	1	hits	1		0
11322100	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,username	select url,virus,INET_NTOA(host) as host,sum(hits) as hits from virus_domain_host_url_user_webvirus{4} where domain=''{8}'' and username=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,virus,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11322100	0	1	hits	1		0
11323000	Top Host	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain	select INET_NTOA(host) as host,sum(hits) as hits from virus_domain_host{4} where domain=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11323000	0	1	hits	1		0
11323100	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,domain,host	select url,virus,username,sum(hits) as hits from virus_domain_host_url_user_webvirus{4} where domain=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,virus,username order by {5} {6} limit {3} OFFSET {2}	11323100	0	1	hits	1		0
11331000	Top Viruses	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select virus,sum(hits) as hits from virus_user_webvirus{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY virus order by {5} {6} limit {3} OFFSET {2}	11331000	0	1	hits	1		0
11331100	Virus Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,virus	select url,INET_NTOA(host) as host,sum(hits) as hits from virus_host_url_user_webvirus{4} where username=''{8}'' and virus=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11331100	0	1	hits	1		0
11332000	Top Domains	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select domain,sum(hits) as hits from virus_domain_user{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY domain order by {5} {6} limit {3} OFFSET {2}	11332000	0	1	hits	1		0
11332100	Domain Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,domain	select url,INET_NTOA(host) as host,virus,sum(hits) as hits from virus_domain_host_url_user_webvirus{4} where username=''{8}'' and domain=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,INET_NTOA(host),virus order by {5} {6} limit {3} OFFSET {2}	11332100	0	1	hits	1		0
11333000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(host) as host,sum(hits) as hits from virus_host_user{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11333000	0	1	hits	1		0
11333100	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select url,virus,sum(hits) as hits from virus_host_url_user_webvirus{4} where username=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY url,virus order by {5} {6} limit {3} OFFSET {2}	11333100	0	1	hits	1		0
11410000	Top Viruses	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select virus ,sum(hits) as hits from virus_mailvirus{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY virus  order by {5} {6} limit {3} OFFSET {2}	11410000	0	1	hits	1		0
11411000	Top Sender (Email ids)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select sender,sum(hits) as hits from virus_mailvirus_sender{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	11411000	0	1	hits	1		0
11411100	Top Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender	select recipient,sum(hits) as hits from virus_mailvirus_recipient_sender{4} where virus=''{8}'' and sender=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	11411100	0	1	hits	1		0
11411110	Recipient Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender,recipient	select subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and sender=''{9}''  and recipient=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY subject,username,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	11411110	0	1	hits	1		0
11411200	Top Sender Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender	select INET_NTOA(host) as host ,sum(hits) as hits from virus_host_mailvirus_sender{4} where virus=''{8}'' and sender=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host)  order by {5} {6} limit {3} OFFSET {2}	11411200	0	1	hits	1		0
11411300	Top Receiver Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender	select INET_NTOA(destip) as destination,sum(hits) as hits from virus_dest_mailvirus_sender{4} where virus=''{8}'' and sender=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11411300	0	1	hits	1		0
11411310	Receiver Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender,destination	select recipient,subject,username,INET_NTOA(host) as host,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and sender=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(host),application order by {5} {6} limit {3} OFFSET {2}	11411310	0	1	hits	1		0
11411400	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender	select application,sum(hits) as hits from virus_app_mailvirus_sender{4} where virus=''{8}'' and sender=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	11411400	0	1	hits	1		0
11411410	Application Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender,application	select recipient,subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and sender=''{9}''  and application=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11411410	0	1	hits	1		0
11411510	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender,username	select recipient,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and sender=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	11411510	0	1	hits	1		0
11412000	Top Recipients (Email Ids)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select recipient,sum(hits) as hits from virus_mailvirus_recipient{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	11412000	0	1	hits	1		0
11412100	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient	select sender,sum(hits) as hits from virus_mailvirus_recipient_sender{4} where virus=''{8}'' and recipient=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	11412100	0	1	hits	1		0
11412110	Sender Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient,sender	select subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and recipient=''{9}''  and sender=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY subject,username,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	11412110	0	1	hits	1		0
11412200	Top Sender Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient	select INET_NTOA(host) as host ,sum(hits) as hits from virus_host_mailvirus_recipient{4} where virus=''{8}'' and recipient=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host)  order by {5} {6} limit {3} OFFSET {2}	11412200	0	1	hits	1		0
11412210	Sender Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient,host	select sender,subject,username,INET_NTOA(destip) as destination,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and recipient=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	11412210	0	1	hits	1		0
11412300	Top Receiver Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient	select INET_NTOA(destip) as destination,sum(hits) as hits from virus_dest_mailvirus_recipient{4} where virus=''{8}'' and recipient=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11412300	0	1	hits	1		0
11412310	Receiver Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient,destination	select sender,subject,username,INET_NTOA(host) as host,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and recipient=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(host),application order by {5} {6} limit {3} OFFSET {2}	11412310	0	1	hits	1		0
11412400	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient	select application,sum(hits) as hits from virus_app_mailvirus_recipient{4} where virus=''{8}'' and recipient=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	11412400	0	1	hits	1		0
11412410	Application Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient,application	select sender,subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and recipient=''{9}''  and application=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11412410	0	1	hits	1		0
11412510	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient,username	select sender,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and recipient=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,INET_NTOA(host),INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	11412510	0	1	hits	1		0
11413000	Top Sender Host	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select INET_NTOA(host) as host,sum(hits) as hits from virus_host_mailvirus{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11413000	0	1	hits	1		0
11413100	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select sender,sum(hits) as hits from virus_host_mailvirus_sender{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	11413100	0	1	hits	1		0
11413110	Sender Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,sender	select recipient,subject,username,INET_NTOA(destip) as destination,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and sender=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	11413110	0	1	hits	1		0
11413200	Top Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select recipient,sum(hits) as hits from virus_host_mailvirus_recipient{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	11413200	0	1	hits	1		0
11413210	Recipient Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,recipient	select sender,subject,username,INET_NTOA(destip) as destination,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and recipient=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	11413210	0	1	hits	1		0
11413300	Top Receiver Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select INET_NTOA(destip) as destination,sum(hits) as hits from virus_dest_host_mailvirus{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11413300	0	1	hits	1		0
11413310	Receiver Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,destination	select sender,recipient,subject,username,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,application order by {5} {6} limit {3} OFFSET {2}	11413310	0	1	hits	1		0
11413400	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select application,sum(hits) as hits from virus_app_host_mailvirus{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	11413400	0	1	hits	1		0
11413410	Application Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,application	select sender,recipient,subject,username,INET_NTOA(destip) as destination,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and application=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11413410	0	1	hits	1		0
11413510	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,username	select sender,recipient,subject,INET_NTOA(destip) as destination,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,INET_NTOA(destip),application order by {5} {6} limit {3} OFFSET {2}	11413510	0	1	hits	1		0
11414000	Top Receiver Host	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select INET_NTOA(destip) as destination ,sum(hits) as hits from virus_dest_mailvirus{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip)  order by {5} {6} limit {3} OFFSET {2}	11414000	0	1	hits	1		0
11414100	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination	select sender,sum(hits) as hits from virus_dest_mailvirus_sender{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	11414100	0	1	hits	1		0
11414110	Sender Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination,sender	select recipient,subject,username,INET_NTOA(host) as host,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and sender=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(host),application order by {5} {6} limit {3} OFFSET {2}	11414110	0	1	hits	1		0
11414200	Top Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination	select recipient,sum(hits) as hits from virus_dest_mailvirus_recipient{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	11414200	0	1	hits	1		0
11414210	Recipient Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination,recipient	select sender,subject,username,INET_NTOA(host) as host,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and recipient=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(host),application order by {5} {6} limit {3} OFFSET {2}	11414210	0	1	hits	1		0
11414300	Top Sender Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination	select INET_NTOA(host) as host,sum(hits) as hits from virus_dest_host_mailvirus{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11414300	0	1	hits	1		0
11414310	Sender Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination,host	select sender,recipient,subject,username,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,application order by {5} {6} limit {3} OFFSET {2}	11414310	0	1	hits	1		0
11414400	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination	select application,sum(hits) as hits from virus_app_dest_mailvirus{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	11414400	0	1	hits	1		0
11414410	Application Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination,application	select sender,recipient,subject,username,INET_NTOA(host) as host,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and application=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11414410	0	1	hits	1		0
11414510	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination,username	select sender,recipient,subject,INET_NTOA(host) as host,application ,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,INET_NTOA(host),application  order by {5} {6} limit {3} OFFSET {2}	11414510	0	1	hits	1		0
11415000	Top Applications	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select application,sum(hits) as hits from virus_app_mailvirus{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY application order by {5} {6} limit {3} OFFSET {2}	11415000	0	1	hits	1		0
11415100	Top Senders	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application	select sender,sum(hits) as hits from virus_app_mailvirus_sender{4} where virus=''{8}'' and application=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	11415100	0	1	hits	1		0
11415110	Sender Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application,sender	select recipient,subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and application=''{9}''  and sender=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11415110	0	1	hits	1		0
11415200	Top Recipients	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application	select recipient,sum(hits) as hits from virus_app_mailvirus_recipient{4} where virus=''{8}'' and application=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	11415200	0	1	hits	1		0
11415210	Recipient Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application,recipient	select sender,subject,username,INET_NTOA(host) as host,INET_NTOA(destip) as destination,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and application=''{9}''  and recipient=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,subject,username,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11415210	0	1	hits	1		0
11415300	Top Sender Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application	select INET_NTOA(host) as host,sum(hits) as hits from virus_app_host_mailvirus{4} where virus=''{8}'' and application=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11415300	0	1	hits	1		0
11415310	Sender Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application,host	select sender,recipient,subject,username,INET_NTOA(destip) as destination,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and application=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11415310	0	1	hits	1		0
11415400	Top Receiver Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application	select INET_NTOA(destip) as destination,sum(hits) as hits from virus_app_dest_mailvirus{4} where virus=''{8}'' and application=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11415400	0	1	hits	1		0
11415410	Receiver Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application,destination	select sender,recipient,subject,username,INET_NTOA(host) as host,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and application=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,username,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11415410	0	1	hits	1		0
11415510	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application,username	select sender,recipient,subject,INET_NTOA(host) as host,INET_NTOA(destip) as destination,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and application=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender,recipient,subject,INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11415510	0	1	hits	1		0
11510000	Top Viruses (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select virus,sum(hits) as hits from virus_ftpvirus{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY virus order by {5} {6} limit {3} OFFSET {2}	11510000	0	1	hits	1		0
11511000	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select INET_NTOA(destip) as server,sum(hits) as hits from virus_ftpvirus_server{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11511000	0	1	hits	1		0
11511100	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server	select INET_NTOA(host) as host,sum(hits) as hits from virus_ftpvirus_host_server{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11511100	0	1	hits	1		0
11511110	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server,host	select file,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file,username order by {5} {6} limit {3} OFFSET {2}	11511110	0	1	hits	1		0
11511200	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server	select file,sum(hits) as hits from virus_file_ftpvirus_server{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	11511200	0	1	hits	1		0
11511310	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server,username	select INET_NTOA(host) as host,file,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),file order by {5} {6} limit {3} OFFSET {2}	11511310	0	1	hits	1		0
11512000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select INET_NTOA(host) as host,sum(hits) as hits from virus_ftpvirus_host{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11512000	0	1	hits	1		0
11512100	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select INET_NTOA(destip) as server,sum(hits) as hits from virus_ftpvirus_host_server{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11512100	0	1	hits	1		0
11512110	Server Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,server	select file ,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file ,username order by {5} {6} limit {3} OFFSET {2}	11512110	0	1	hits	1		0
11512200	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select file,sum(hits) as hits from virus_file_ftpvirus_host{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	11512200	0	1	hits	1		0
11512310	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,username	select INET_NTOA(destip) as server,file ,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),file  order by {5} {6} limit {3} OFFSET {2}	11512310	0	1	hits	1		0
11513100	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username	select INET_NTOA(destip) as server,sum(hits) as hits from virus_ftpvirus_server_user{4} where virus=''{8}'' and username=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11513100	0	1	hits	1		0
11513110	Server Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username,server	select file,INET_NTOA(host) as host,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and username=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11513110	0	1	hits	1		0
11513200	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username	select file ,sum(hits) as hits from virus_file_ftpvirus_user{4} where virus=''{8}'' and username=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file  order by {5} {6} limit {3} OFFSET {2}	11513200	0	1	hits	1		0
11513210	File Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username,file	select INET_NTOA(destip) as server,INET_NTOA(host) as host,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and username=''{9}''  and file=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11513210	0	1	hits	1		0
11513310	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username,host	select INET_NTOA(destip) as server,file,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and username=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),file order by {5} {6} limit {3} OFFSET {2}	11513310	0	1	hits	1		0
11514200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file	select INET_NTOA(host) as host ,sum(hits) as hits from virus_file_ftpvirus_host{4} where virus=''{8}'' and file=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host)  order by {5} {6} limit {3} OFFSET {2}	11514200	0	1	hits	1		0
11514310	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file,username	select INET_NTOA(destip) as server,INET_NTOA(host) as host,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and file=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11514310	0	1	hits	1		0
11520000	Top Viruses (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select virus,sum(hits) as hits from virus_ftpvirus{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY virus order by {5} {6} limit {3} OFFSET {2}	11520000	0	1	hits	1		0
11521000	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select INET_NTOA(destip) as server,sum(hits) as hits from virus_ftpvirus_server{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11521000	0	1	hits	1		0
11521100	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server	select INET_NTOA(host) as host,sum(hits) as hits from virus_ftpvirus_host_server{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11521100	0	1	hits	1		0
11521110	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server,host	select file,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file,username order by {5} {6} limit {3} OFFSET {2}	11521110	0	1	hits	1		0
11521200	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server	select file,sum(hits) as hits from virus_file_ftpvirus_server{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	11521200	0	1	hits	1		0
11521310	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server,username	select INET_NTOA(host) as host,file,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),file order by {5} {6} limit {3} OFFSET {2}	11521310	0	1	hits	1		0
11522000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select INET_NTOA(host) as host,sum(hits) as hits from virus_ftpvirus_host{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11522000	0	1	hits	1		0
11522100	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select INET_NTOA(destip) as server,sum(hits) as hits from virus_ftpvirus_host_server{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11522100	0	1	hits	1		0
11522110	Server Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,server	select file ,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file ,username order by {5} {6} limit {3} OFFSET {2}	11522110	0	1	hits	1		0
11522200	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select file,sum(hits) as hits from virus_file_ftpvirus_host{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	11522200	0	1	hits	1		0
11522310	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,username	select INET_NTOA(destip) as server,file ,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),file  order by {5} {6} limit {3} OFFSET {2}	11522310	0	1	hits	1		0
11523100	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username	select INET_NTOA(destip) as server,sum(hits) as hits from virus_ftpvirus_server_user{4} where virus=''{8}'' and username=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11523100	0	1	hits	1		0
11523110	Server Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username,server	select file,INET_NTOA(host) as host,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and username=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file,INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11523110	0	1	hits	1		0
11523200	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username	select file ,sum(hits) as hits from virus_file_ftpvirus_user{4} where virus=''{8}'' and username=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file  order by {5} {6} limit {3} OFFSET {2}	11523200	0	1	hits	1		0
11523210	File Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username,file	select INET_NTOA(destip) as server,INET_NTOA(host) as host,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and username=''{9}''  and file=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11523210	0	1	hits	1		0
11523310	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username,host	select INET_NTOA(destip) as server,file,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and username=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),file order by {5} {6} limit {3} OFFSET {2}	11523310	0	1	hits	1		0
11524100	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file	select INET_NTOA(destip) as server,sum(hits) as hits from virus_file_ftpvirus_server{4} where virus=''{8}'' and file=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11524100	0	1	hits	1		0
11524200	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file	select INET_NTOA(host) as host ,sum(hits) as hits from virus_file_ftpvirus_host{4} where virus=''{8}'' and file=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host)  order by {5} {6} limit {3} OFFSET {2}	11524200	0	1	hits	1		0
11524310	User Detail	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file,username	select INET_NTOA(destip) as server,INET_NTOA(host) as host,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and file=''{9}''  and username=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11524310	0	1	hits	1		0
11330000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits from virus_user{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11330000	0	1	hits	1		0
11411500	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender	select username,sum(hits) as hits from virus_mailvirus_sender_user{4} where virus=''{8}'' and sender=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11411500	0	1	hits	1		0
11411210	Sender Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,sender,host	select recipient,subject,username,INET_NTOA(destip) as destination,INET_NTOA(host) as host,application,sum(hits) as hits from virus_app_dst_hst_mailvrs_rcpt_sndr_sbj_usr{4} where virus=''{8}'' and sender=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient,subject,username,INET_NTOA(destip),INET_NTOA(host),application order by {5} {6} limit {3} OFFSET {2}	11411210	0	1	hits	1		0
11412500	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,recipient	select username,sum(hits) as hits from virus_mailvirus_recipient_user{4} where virus=''{8}'' and recipient=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11412500	0	1	hits	1		0
11413500	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select username,sum(hits) as hits from virus_host_mailvirus_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11413500	0	1	hits	1		0
11414500	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,destination	select username,sum(hits) as hits from virus_dest_mailvirus_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11414500	0	1	hits	1		0
11415500	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,application	select username,sum(hits) as hits from virus_app_mailvirus_user{4} where virus=''{8}'' and application=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11415500	0	1	hits	1		0
92100000	Top Attackers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attack	select INET_NTOA(attacker) as attacker,sum(hits) as hits from ips_attack_attacker{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and attack like ''{8}'' group by attacker order by {5} {6} limit {3} OFFSET {2}	92100000	0	0	hits	1		0
6100000	Top Files Uploaded via FTP	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select file,sum(hits) as hits,sum(upload) as bytes from ftp_file{4} where upload>0 and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6100000	0	1	bytes	1		0
6110000	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file	select INET_NTOA(destip) as server,sum(hits) as hits,sum(upload) as bytes from ftp_file_server{4} where upload>0 and  file=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6110000	0	1	bytes	1		0
6111000	Top Hosts and Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file,server	select INET_NTOA(host) as host,username,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and file=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),username order by {5} {6} limit {3} OFFSET {2}	6111000	0	1	bytes	1		0
6120000	Top FTP Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file	select INET_NTOA(host) as host,sum(hits) as hits,sum(upload) as bytes from ftp_file_host{4} where upload>0 and file=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	6120000	0	1	bytes	1		0
6130000	Top FTP Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file	select username,sum(hits) as hits,sum(upload) as bytes from ftp_file_user{4} where upload>0 and file=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	6130000	0	1	bytes	1		0
6131000	Top Hosts and Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file,username	select INET_NTOA(host) as host,INET_NTOA(destip) as server,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and file=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6131000	0	1	bytes	1		0
6200000	Top Files Downloaded via FTP	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select file,sum(hits) as hits,sum(download) as bytes from ftp_file{4} where download>0 and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6200000	0	1	bytes	1		0
6210000	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file	select INET_NTOA(destip) as server,sum(hits) as hits,sum(download) as bytes from ftp_file_server{4} where download>0 and file=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6210000	0	1	bytes	1		0
6211000	Top Hosts and Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file,server	select INET_NTOA(host) as host,username,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and file=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),username order by {5} {6} limit {3} OFFSET {2}	6211000	0	1	bytes	1		0
6220000	Top FTP Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file	select INET_NTOA(host) as host,sum(hits) as hits,sum(download) as bytes from ftp_file_host{4} where download>0 and file=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	6220000	0	1	bytes	1		0
41400000	Top URLs	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select url,sum(hits) as hits,sum(bytes) as bytes from web_url_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and  appid in ({7}) and username like ''{8}'' group by url order by {5} {6} limit {3} OFFSET {2}	41400000	0	0	bytes	1		0
6121000	Top Servers and Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file,host	select INET_NTOA(destip) as server,username,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and file=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),username order by {5} {6} limit {3} OFFSET {2}	6121000	0	1	bytes	1		0
6221000	Top Servers and Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file,host	select INET_NTOA(destip) as server,username,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and file=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),username order by {5} {6} limit {3} OFFSET {2}	6221000	0	1	bytes	1		0
6230000	Top FTP Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file	select username,sum(hits) as hits,sum(download) as bytes from ftp_file_user{4} where download>0 and file=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	6230000	0	1	bytes	1		0
6231000	Top Hosts and Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,file,username	select INET_NTOA(host) as host,INET_NTOA(destip) as server,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and file=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6231000	0	1	bytes	1		0
6300000	Top FTP Users (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits,sum(upload) as bytes from ftp_user{4} where upload>0 and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	6300000	0	1	bytes	1		0
6310000	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select file,sum(hits) as hits,sum(upload) as bytes from ftp_file_user{4} where upload>0 and username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6310000	0	1	bytes	1		0
6311000	Top Servers and Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,file	select INET_NTOA(destip) as server,INET_NTOA(host) as host,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and username=''{8}'' and file=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	6311000	0	1	bytes	1		0
6320000	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(destip) as server,sum(hits) as hits,sum(upload) as bytes from ftp_server_user{4} where upload>0 and username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6320000	0	1	bytes	1		0
6321000	Top Hosts and Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,server	select INET_NTOA(host) as host,file,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and username=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),file order by {5} {6} limit {3} OFFSET {2}	6321000	0	1	bytes	1		0
6330000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(host) as host,sum(hits) as hits,sum(upload) as bytes from ftp_host_user{4} where upload>0 and username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	6330000	0	1	bytes	1		0
6331000	Top Files and Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select file,INET_NTOA(destip) as server,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and username=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file,INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6331000	0	1	bytes	1		0
6400000	Top FTP Users (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select username,sum(hits) as hits,sum(download) as bytes from ftp_user{4} where download>0 and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	6400000	0	1	bytes	1		0
6410000	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select file,sum(hits) as hits,sum(download) as bytes from ftp_file_user{4} where download>0 and username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6410000	0	1	bytes	1		0
6411000	Top Servers and Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,file	select INET_NTOA(destip) as server,INET_NTOA(host) as host,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and username=''{8}'' and file=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	6411000	0	1	bytes	1		0
6420000	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(destip) as server,sum(hits) as hits,sum(download) as bytes from ftp_server_user{4} where download>0 and username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6420000	0	1	bytes	1		0
6421000	Top Hosts and Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,server	select INET_NTOA(host) as host,file,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and username=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),file order by {5} {6} limit {3} OFFSET {2}	6421000	0	1	bytes	1		0
6430000	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select INET_NTOA(host) as host,sum(hits) as hits,sum(download) as bytes from ftp_host_user{4} where download>0 and username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	6430000	0	1	bytes	1		0
6431000	Top Files and Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username,host	select file,INET_NTOA(destip) as server,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and username=''{8}'' and INET_NTOA(host)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file,INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6431000	0	1	bytes	1		0
6500000	Top FTP Hosts (Upload)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(host) as host ,sum(hits) as hits,sum(upload) as bytes from ftp_host{4} where upload>0 and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host)  order by {5} {6} limit {3} OFFSET {2}	6500000	0	1	bytes	1		0
6510000	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select file,sum(hits) as hits,sum(upload) as bytes from ftp_file_host{4} where upload>0 and INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6510000	0	1	bytes	1		0
6511000	Top Servers and Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,file	select INET_NTOA(destip) as server,username,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and INET_NTOA(host)=''{8}'' and file=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),username order by {5} {6} limit {3} OFFSET {2}	6511000	0	1	bytes	1		0
6520000	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select INET_NTOA(destip) as server,sum(hits) as hits,sum(upload) as bytes from ftp_host_server{4} where upload>0 and INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6520000	0	1	bytes	1		0
6521000	Top Users and Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,server	select username,file,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and INET_NTOA(host)=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username,file order by {5} {6} limit {3} OFFSET {2}	6521000	0	1	bytes	1		0
6530000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select username,sum(hits) as hits,sum(upload) as bytes from ftp_host_user{4} where upload>0 and INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	6530000	0	1	bytes	1		0
6531000	Top Files and Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select file,INET_NTOA(destip) as server,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and INET_NTOA(host)=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file,INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6531000	0	1	bytes	1		0
6600000	Top FTP Hosts (Download)	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(host) as host,sum(hits) as hits,sum(download) as bytes from ftp_host{4} where download>0 and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	6600000	0	1	bytes	1		0
6610000	Top Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select file,sum(hits) as hits,sum(download) as bytes from ftp_file_host{4} where download>0 and INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6610000	0	1	bytes	1		0
6611000	Top Servers and Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,file	select INET_NTOA(destip) as server,username,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and INET_NTOA(host)=''{8}'' and file=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),username order by {5} {6} limit {3} OFFSET {2}	6611000	0	1	bytes	1		0
6620000	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select INET_NTOA(destip) as server,sum(hits) as hits,sum(download) as bytes from ftp_host_server{4} where download>0 and INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6620000	0	1	bytes	1		0
6621000	Top Users and Files	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,server	select username,file,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and INET_NTOA(host)=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username,file order by {5} {6} limit {3} OFFSET {2}	6621000	0	1	bytes	1		0
6630000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select username,sum(hits) as hits,sum(download) as bytes from ftp_host_user{4} where download>0 and INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	6630000	0	1	bytes	1		0
6631000	Top Files and Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,username	select file,INET_NTOA(destip) as server,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and INET_NTOA(host)=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file,INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6631000	0	1	bytes	1		0
6700000	Top FTP Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid	select INET_NTOA(destip) as server,sum(hits) as hits,sum(upload+download) as bytes from ftp_server{4} where "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	6700000	0	1	bytes	1		0
6710000	Top Files Uploaded	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,server	select file,sum(hits) as hits,sum(upload) as bytes from ftp_file_server{4} where upload>0 and INET_NTOA(destip)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6710000	0	1	bytes	1		0
6711000	Top Hosts and Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,server,file	select INET_NTOA(host) as host,username,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server_user{4} where upload>0 and INET_NTOA(destip)=''{8}'' and file=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),username order by {5} {6} limit {3} OFFSET {2}	6711000	0	1	bytes	1		0
6720000	Top Files Downloaded	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,server	select file,sum(hits) as hits,sum(download) as bytes from ftp_file_server{4} where download>0 and INET_NTOA(destip)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6720000	0	1	bytes	1		0
6721000	Top Hosts and Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,server,file	select INET_NTOA(host) as host,username,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server_user{4} where download>0 and INET_NTOA(destip)=''{8}'' and file=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),username order by {5} {6} limit {3} OFFSET {2}	6721000	0	1	bytes	1		0
6730000	Top FTP Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,server	select username,sum(hits) as hits,sum(upload+download) as bytes from ftp_server_user{4} where INET_NTOA(destip)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	6730000	0	1	bytes	1		0
6731000	Top Files Uploaded	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,server,username	select file,sum(hits) as hits,sum(upload) as bytes from ftp_file_server_user{4} where upload>0 and INET_NTOA(destip)=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6731000	0	1	bytes	1		0
6732000	Top Files Downloaded	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,server,username	select file,sum(hits) as hits,sum(download) as bytes from ftp_file_server_user{4} where download>0 and INET_NTOA(destip)=''{8}'' and username=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6732000	0	1	bytes	1		0
6740000	Top FTP Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,server	select INET_NTOA(host) as host,sum(hits) as hits,sum(upload+download) as bytes from ftp_host_server{4} where INET_NTOA(destip)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	6740000	0	1	bytes	1		0
6741000	Top Files Uploaded	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,server	select file,sum(hits) as hits,sum(upload) as bytes from ftp_file_host_server{4} where upload>0 and INET_NTOA(host)=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6741000	0	1	bytes	1		0
6742000	Top Files Downloaded	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host,server	select file,sum(hits) as hits,sum(download) as bytes from ftp_file_host_server{4} where download>0 and INET_NTOA(host)=''{8}'' and INET_NTOA(destip)=''{9}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	6742000	0	1	bytes	1		0
91500000	Top Detected Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity	select  attack,sum(hits) as hits from ips_acnt_attack_svrt{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8}  and action = 3 group by attack order by {5} {6} limit {3} OFFSET {2}	91500000	0	0	hits	1		0
91510000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity,attack	select  INET_NTOA(attacker) as attacker, INET_NTOA(victim) as victim, username, application,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} and action=3  and attack like ''{9}'' group by attacker, victim, username, application order by {5} {6} limit {3} OFFSET {2}	91510000	0	0	hits	1		0
91600000	Top Dropped Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity	select  attack,sum(hits) as hits from ips_acnt_attack_svrt{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} and action=4 group by attack order by {5} {6} limit {3} OFFSET {2}	91600000	0	0	hits	1		0
91610000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,severity,attack	select  INET_NTOA(attacker) as attacker, INET_NTOA(victim) as victim, username, application,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7})  and severity = {8} and attack like ''{9}''  and action =4 group by attacker, victim, username, application order by {5} {6} limit {3} OFFSET {2}	91610000	0	0	hits	1		0
97400000	Top Detected Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select attack,sum(hits) as hits from ips_acnt_app_attack{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' and action=3 group by attack order by {5} {6} limit {3} OFFSET {2}	97400000	0	0	hits	1		0
97410000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,attack	select INET_NTOA(attacker) as attacker, INET_NTOA(victim) as victim, username, severity,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' and attack like ''{9}'' and action = 3 group by attacker, victim, username, severity order by {5} {6} limit {3} OFFSET {2}	97410000	0	0	hits	1		0
97500000	Top Dropped Attacks	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application	select attack,sum(hits) as hits from ips_acnt_app_attack{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' and action=4 group by attack order by {5} {6} limit {3} OFFSET {2}	97500000	0	0	hits	1		0
97510000	Attacker	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,application,attack	select INET_NTOA(attacker) as attacker, INET_NTOA(victim) as victim, username, severity,sum(hits) as hits from ips_actn_app_attack_attacker_svrt_user_vctm{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and application like ''{8}'' and attack like ''{9}''  and acttion = 4  group by attacker, victim, username, severity order by {5} {6} limit {3} OFFSET {2}	97510000	0	0	hits	1		0
11513000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select username,sum(hits) as hits from virus_ftpvirus_user{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11513000	0	1	hits	1		0
11514100	Top Servers	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file	select INET_NTOA(destip) as server,sum(hits) as hits from virus_file_ftpvirus_server{4} where virus=''{8}'' and file=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	11514100	0	1	hits	1		0
11523000	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select username,sum(hits) as hits from virus_ftpvirus_user{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11523000	0	1	hits	1		0
11511300	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server	select username,sum(hits) as hits from virus_ftpvirus_server_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11511300	0	1	hits	1		0
11512300	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select username,sum(hits) as hits from virus_ftpvirus_host_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11512300	0	1	hits	1		0
11514300	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file	select username,sum(hits) as hits from virus_file_ftpvirus_user{4} where virus=''{8}'' and file=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11514300	0	1	hits	1		0
11521300	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server	select username,sum(hits) as hits from virus_ftpvirus_server_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11521300	0	1	hits	1		0
11522300	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host	select username,sum(hits) as hits from virus_ftpvirus_host_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11522300	0	1	hits	1		0
11524300	Top Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file	select username,sum(hits) as hits from virus_file_ftpvirus_user{4} where virus=''{8}'' and file=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	11524300	0	1	hits	1		0
11514000	Top File	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select file,sum(hits) as hits from virus_file_ftpvirus{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	11514000	0	1	hits	1		0
11524000	Top File	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus	select file,sum(hits) as hits from virus_file_ftpvirus{4} where virus=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	11524000	0	1	hits	1		0
11511210	File Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server,file	select INET_NTOA(host) as host,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and file=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),username order by {5} {6} limit {3} OFFSET {2}	11511210	0	1	hits	1		0
11521210	File Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,server,file	select INET_NTOA(host) as host,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(destip)=''{9}''  and file=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),username order by {5} {6} limit {3} OFFSET {2}	11521210	0	1	hits	1		0
11512210	File Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,file	select INET_NTOA(destip) as server,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and file=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),username order by {5} {6} limit {3} OFFSET {2}	11512210	0	1	hits	1		0
11522210	File Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,host,file	select INET_NTOA(destip) as server,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and INET_NTOA(host)=''{9}''  and file=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),username order by {5} {6} limit {3} OFFSET {2}	11522210	0	1	hits	1		0
11513300	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username	select INET_NTOA(host) as host,sum(hits) as hits from virus_ftpvirus_host_user{4} where virus=''{8}'' and username=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11513300	0	1	hits	1		0
11523300	Top Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,username	select INET_NTOA(host) as host,sum(hits) as hits from virus_ftpvirus_host_user{4} where virus=''{8}'' and username=''{9}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	11523300	0	1	hits	1		0
11514110	Server Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file,server	select INET_NTOA(host) as host,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and file=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),username order by {5} {6} limit {3} OFFSET {2}	11514110	0	1	hits	1		0
11524110	Server Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file,server	select INET_NTOA(host) as host,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and file=''{9}''  and INET_NTOA(destip)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host),username order by {5} {6} limit {3} OFFSET {2}	11524110	0	1	hits	1		0
11514210	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file,host	select INET_NTOA(destip) as server,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and file=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),username order by {5} {6} limit {3} OFFSET {2}	11514210	0	1	hits	1		0
11524210	Host Details	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,virus,file,host	select INET_NTOA(destip) as server,username,sum(hits) as hits from virus_file_ftpvirus_host_server_user{4} where virus=''{8}'' and file=''{9}''  and INET_NTOA(host)=''{10}''  and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip),username order by {5} {6} limit {3} OFFSET {2}	11524210	0	1	hits	1		0
26010	Top Application Groups 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select proto_group,sum(hits) as hits,sum(total) as bytes from user_protogroup{4} where username = ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	26010	0	0	bytes	1		0
26020	Top Web Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select category,sum(hits) as hits,sum(bytes) as bytes from web_category_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and username like ''{8}'' and appid in ({7}) group by category order by {5} {6} limit {3} OFFSET {2}	26020	0	0	bytes	1		0
26030	Top Files Uploaded via FTP	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select file,sum(hits) as hits,sum(upload) as bytes from ftp_file_user{4} where upload>0 and username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	26030	0	1	bytes	1		0
26040	Top Files Downloaded via FTP	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select file,sum(hits) as hits,sum(download) as bytes from ftp_file_user{4} where download>0 and username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	26040	0	1	bytes	1		0
26050	Top Hosts 	startdate,enddate,offset,limit,tbl,orderby,ordertype,username,appid	select INET_NTOA(srcip) as srcip,sum(hits) as hits,sum(total) as bytes from srcip_user{4} where username like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By srcip order by {5} {6} limit {3} OFFSET {2}	26050	0	0	bytes	1		0
26060	Top Denied Application Groups	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select proto_group, sum(hits) as hits from blocked_protogroup_user{4} where username=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY proto_group order by {5} {6} limit {3} OFFSET {2}	26060	0	1	hits	1		0
26070	Top Denied Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select category,sum(hits) as hits from deniedweb_category_user{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and username like ''{8}'' group by category order by {5} {6} limit {3} OFFSET {2}	26070	0	0	hits	1		0
26080	Top Web Viruses	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,username	select virus,sum(hits) as hits from virus_user_webvirus{4} where username=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY virus order by {5} {6} limit {3} OFFSET {2}	26080	0	1	hits	1		0
28010	Top Application Groups 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select proto_group,sum(hits) as hits,sum(total) as bytes from srcip_protogroup{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) GROUP By proto_group order by {5} {6} limit {3} OFFSET {2}	28010	1	0	bytes	1		0
28020	Top Web Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select category, sum(hits) as hits, sum(bytes) as bytes from web_category_host{4} where INET_NTOA(host) = ''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP By category order by {5} {6} limit {3} OFFSET {2}	28020	0	1	bytes	1		0
28030	Top Files Uploaded via FTP	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select file,sum(hits) as hits,sum(upload) as bytes from ftp_file_host{4} where upload>0 and INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	28030	0	1	bytes	1		0
28040	Top Files Downloaded via FTP	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select file,sum(hits) as hits,sum(download) as bytes from ftp_file_host{4} where download>0 and INET_NTOA(host)=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY file order by {5} {6} limit {3} OFFSET {2}	28040	0	1	bytes	1		0
28050	Top Users 	startdate,enddate,offset,limit,tbl,orderby,ordertype,srcip,appid	select username,sum(hits) as hits,sum(total) as bytes from srcip_user{4} where INET_NTOA(srcip) like ''{7}'' and "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({8}) group by username order by {5} {6} limit {3} OFFSET {2}	28050	1	0	bytes	1		0
28060	Top Denied Application Groups	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select proto_group, sum(hits) as hits from blocked_host_protogroup{4} where INET_NTOA(srcip)=''{8}'' and  "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY proto_group order by {5} {6} limit {3} OFFSET {2}	28060	0	1	hits	1		0
28070	Top Denied Categories	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,host	select category,sum(hits) as hits from deniedweb_category_host{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(host) like ''{8}'' group by category order by {5} {6} limit {3} OFFSET {2}	28070	0	0	hits	1		0
28080	Top Attacks Received	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,victim	select attack,sum(hits) as hits from ips_attack_victim{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(victim) like ''{8}'' group by attack order by {5} {6} limit {3} OFFSET {2}	28080	0	0	hits	1		0
28090	Top Attacks Generated	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,attacker	select attack,sum(hits) as hits from ips_attack_attacker{4} where "5mintime" >=''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) and INET_NTOA(attacker)  like ''{8}'' group by attack order by {5} {6} limit {3} OFFSET {2}	28090	0	0	hits	1		0
29010	Top Mails Sent to	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select recipient,sum(hits) as hits, sum(bytes) as bytes from mail_recipient_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	29010	0	1	bytes	1		0
29020	Top Mails Received From	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select sender,sum(hits) as hits, sum(bytes) as bytes from mail_recipient_sender{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	29020	0	1	bytes	1		0
29090	Top Spam Received	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select sender,sum(hits) as hits from spam_recipient_sender{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY sender order by {5} {6} limit {3} OFFSET {2}	29090	0	1	hits	1		0
29100	Top Spam Sent	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select recipient,sum(hits) as hits from spam_recipient_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY recipient order by {5} {6} limit {3} OFFSET {2}	29100	0	1	hits	1		0
29030	Top Sender Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select INET_NTOA(host) as host,sum(hits) as hits, sum(bytes) as bytes from mail_host_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host) order by {5} {6} limit {3} OFFSET {2}	29030	0	1	bytes	1		0
29040	Top Recipient Hosts	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select INET_NTOA(host) as host ,sum(hits) as hits, sum(bytes) as bytes from mail_host_recipient{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(host)  order by {5} {6} limit {3} OFFSET {2}	29040	0	1	bytes	1		0
29050	Top Sender Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select INET_NTOA(destip) as destination,sum(hits) as hits, sum(bytes) as bytes from mail_dest_sender{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	29050	0	1	bytes	1		0
29060	Top Recipient Destinations	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select INET_NTOA(destip) as destination,sum(hits) as hits, sum(bytes) as bytes from mail_dest_recipient{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY INET_NTOA(destip) order by {5} {6} limit {3} OFFSET {2}	29060	0	1	bytes	1		0
29070	Top Sender Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,sender	select username,sum(hits) as hits, sum(bytes) as bytes from mail_sender_user{4} where sender=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	29070	0	1	bytes	1		0
29080	Top Recipient Users	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,recipient	select username,sum(hits) as hits, sum(bytes) as bytes from mail_recipient_user{4} where recipient=''{8}'' and "5mintime" >= ''{0}'' and "5mintime" <= ''{1}'' and appid in ({7}) GROUP BY username order by {5} {6} limit {3} OFFSET {2}	29080	0	1	bytes	1		0
1007	FTP Traffic Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''traffic'',''bytes'',''tblftptrafficsummary'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1007	1	0	totalbytes	1		0
1010	IDP Attacks Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''attacktype'',''hits'',''tblidpattacksummary'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1010	1	0	totalhits	1		0
20100	CPU Usage		select * from getsystemusage(''cpuusage'')	20100	0	1		1		0
1012	Content Filtering Denied Summary	startdate,enddate,offset,limit,tbl,orderby,ordertype,appid,others	select * from getdashboarddata(''application'',''hits'',''tblcontentfilteringdeniedsummary'',''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',{7},''{8}'')	1012	1	0	totalhits	1		0
20200	Memory Usage		select * from getsystemusage(''memoryusage'')	20200	0	1		1		0
135	Procedure Logs	startdate,enddate,ordertype	SELECT  to_char(date_trunc(''hour'',start_time),''MM:DD  HH24'') as starttime, sum(total_records) as records  FROM tbl_proc_log where start_time  >=''{0}'' and start_time <= ''{1}'' group by starttime order by starttime {2}  limit 24 OFFSET 0	135	0	0	starttime	1		0
20300	Disk Usage		select * from getsystemusage(''diskusage'')	20300	0	1		1		0
20110	CPU Usage	startdate,enddate	select * from getsystemusage(''cpuusage'',''{0}'',''{1}'')	20110	0	1		1		0
20210	Memory Usage	startdate,enddate	select * from getsystemusage(''memoryusage'',''{0}'',''{1}'')	20210	0	1		1		0
20310	Database Usage	startdate,enddate	select * from getsystemusage(''diskusage'',''{0}'',''{1}'')	20310	0	1		1		0
20320	Archive Usage	startdate,enddate	select * from getsystemusage(''archiveusage'',''{0}'',''{1}'')	20320	0	1		1		0
\.

ALTER SEQUENCE tblreport_reportid_seq RESTART 200000000; 

DROP TABLE IF EXISTS tblreportcolumn;
CREATE TABLE tblreportcolumn (
    reportcolumnid serial UNIQUE NOT NULL,
    reportid integer,
    columnname character varying(50) DEFAULT NULL::character varying,
    dbcolumnname character varying(50) DEFAULT NULL::character varying,
    issortable integer DEFAULT 0,
    datalinkid integer DEFAULT (-1),
    columnformat integer DEFAULT 0,
    alignment integer DEFAULT 0,
    tooltip character varying(100) DEFAULT NULL::character varying,
    issearchable integer DEFAULT 0
);


COPY tblreportcolumn (reportcolumnid, reportid, columnname, dbcolumnname, issortable, datalinkid, columnformat, alignment, tooltip, issearchable) FROM stdin;
11100001	11100000	Application	application	0	-1	6	0	application	1
7313101	7313100	Application	application	0	7313100	6	0	application	1
81500001	81500000	Application	application	0	81500000	6	0	application	1
81440001	81440000	Application	application	0	81440000	6	0	application	1
84440001	84440000	Application	application	0	84440000	6	0	application	1
84500001	84500000	Application	application	0	84500000	6	0	application	1
1011105	1011100	Application	application	0	-1	6	0		1
1012105	1012100	Application	application	0	-1	6	0		1
1013105	1013100	Application	application	0	-1	6	0		1
1014105	1014100	Application	application	0	-1	6	0		1
1015001	1015000	Application	application	0	1015000	6	0	application	1
512105	512100	Application	application	0	-1	6	0		1
513105	513100	Application	application	0	-1	6	0		1
514105	514100	Application	application	0	-1	6	0		1
525001	525000	Application	application	0	525000	6	0	application	1
521105	521100	Application	application	0	-1	6	0		1
522105	522100	Application	application	0	-1	6	0		1
523105	523100	Application	application	0	-1	6	0		1
7131001	7131000	Application	application	0	7131000	6	0	application	1
7132101	7132100	Application	application	0	-1	6	0	application	1
7210001	7210000	Application	application	0	7210000	6	0	application	1
7221001	7221000	Application	application	0	7221000	6	0	application	1
7222101	7222100	Application	application	0	-1	6	0	application	1
7223101	7223100	Application	application	0	7223100	6	0	application	1
524105	524100	Application	application	0	-1	6	0		1
15410111	15410110	Application	application	0	-1	6	0	application	1
15410211	15410210	Application	application	0	15510000	6	0	application	1
15510111	15510110	Application	application	0	-1	6	0	application	1
15311011	15311010	Application	application	0	15411000	6	0	application	1
11100002	11100000	Count	hits	0	-1	0	0	application	0
11200002	11200000	Count	hits	0	-1	0	0	virus	0
11310002	11310000	Count	hits	0	-1	0	0	virus	0
11311002	11311000	Count	hits	0	-1	0	0	domain	0
11311104	11311100	Count	hits	0	-1	0	0	url	0
11312002	11312000	Count	hits	0	-1	0	0	username	0
11312103	11312100	Count	hits	0	-1	0	0	url	0
11313002	11313000	Count	hits	0	-1	0	0	host	0
11313103	11313100	Count	hits	0	-1	0	0	url	0
11320002	11320000	Count	hits	0	-1	0	0	domain	0
11321002	11321000	Count	hits	0	-1	0	0	virus	0
11321104	11321100	Count	hits	0	-1	0	0	url	0
11322002	11322000	Count	hits	0	-1	0	0	username	0
11322104	11322100	Count	hits	0	-1	0	0	url	0
11323002	11323000	Count	hits	0	-1	0	0	host	0
11323104	11323100	Count	hits	0	-1	0	0	url	0
11330002	11330000	Count	hits	0	-1	0	0	username	0
11331002	11331000	Count	hits	0	-1	0	0	virus	0
1520001	1520000	Application	application	0	1530000	6	0	application	1
11331103	11331100	Count	hits	0	-1	0	0	url	0
11332002	11332000	Count	hits	0	-1	0	0	domain	0
11332104	11332100	Count	hits	0	-1	0	0	url	0
11333002	11333000	Count	hits	0	-1	0	0	host	0
11333103	11333100	Count	hits	0	-1	0	0	url	0
11410002	11410000	Count	hits	0	-1	0	0	virus	0
11411002	11411000	Count	hits	0	-1	0	0	sender	0
11411102	11411100	Count	hits	0	-1	0	0	recipient	0
11411202	11411200	Count	hits	0	-1	0	0	host	0
11411302	11411300	Count	hits	0	-1	0	0	destination	0
11411402	11411400	Count	hits	0	-1	0	0	application	0
11411502	11411500	Count	hits	0	-1	0	0	username	0
11412002	11412000	Count	hits	0	-1	0	0	recipient	0
1520051	1520050	Application	application	0	1534000	6	0	application	1
1520061	1520060	Application	application	0	1535000	6	0	application	1
20100001	20100000	Application	application	0	20101000	6	0	application	1
20200001	20200000	Application	application	0	20201000	6	0	application	1
20300001	20300000	Application	application	0	20301000	6	0	application	1
20401001	20401000	Application	application	0	-1	6	0	application	1
20501001	20501000	Application	application	0	-1	6	0	application	1
7111001	7111000	Application	application	0	7111000	6	0	application	1
7112101	7112100	Application	application	0	-1	6	0	application	1
7113101	7113100	Application	application	0	7113100	6	0	application	1
7121001	7121000	Application	application	0	7121000	6	0	application	1
7122101	7122100	Application	application	0	-1	6	0	application	1
7223211	7223210	Application	application	0	-1	6	0	application	1
1023105	1023100	Application	application	0	-1	6	0		1
1022105	1022100	Application	application	0	-1	6	0		1
533105	533100	Application	application	0	-1	6	0		1
534105	534100	Application	application	0	-1	6	0		1
541105	541100	Application	application	0	-1	6	0		1
542105	542100	Application	application	0	-1	6	0		1
543105	543100	Application	application	0	-1	6	0		1
544105	544100	Application	application	0	-1	6	0		1
11412401	11412400	Application	application	0	11412400	6	0	application	1
11413401	11413400	Application	application	0	11413400	6	0	application	1
211	59	Application	application	0	-1	6	0	srcip	1
130011	130010	Application	application	0	104000	6	0	application	1
140111	140110	Application	application	0	-1	6	0	application	1
140211	140210	Application	application	0	105000	6	0	application	1
131011	131010	Application	application	0	141000	6	0	application	1
141111	141110	Application	application	0	-1	6	0	application	1
132011	132010	Application	application	0	142000	6	0	application	1
142111	142110	Application	application	0	-1	6	0	application	1
134011	134010	Application	application	0	144000	6	0	application	1
144111	144110	Application	application	0	-1	6	0	application	1
144211	144210	Application	application	0	154000	6	0	application	1
510002	510000	Hits	hits	0	-1	0	0	sender	0
510003	510000	Bytes	bytes	0	-1	2	0	sender	0
520002	520000	Hits	hits	0	-1	0	0	recipient	0
520003	520000	Bytes	bytes	0	-1	2	0	recipient	0
530002	530000	Hits	hits	0	-1	0	0	username	0
530003	530000	Bytes	bytes	0	-1	2	0	username	0
540002	540000	Hits	hits	0	-1	0	0	host	0
540003	540000	Bytes	bytes	0	-1	2	0	host	0
550002	550000	Hits	hits	0	-1	0	0	application	0
550003	550000	Bytes	bytes	0	-1	2	0	application	0
511002	511000	Hits	hits	0	-1	0	0	recipient	0
511003	511000	Bytes	bytes	0	-1	2	0	recipient	0
512002	512000	Hits	hits	0	-1	0	0	host	0
512003	512000	Bytes	bytes	0	-1	2	0	host	0
513002	513000	Hits	hits	0	-1	0	0	destination	0
513003	513000	Bytes	bytes	0	-1	2	0	destination	0
514002	514000	Hits	hits	0	-1	0	0	username	0
514003	514000	Bytes	bytes	0	-1	2	0	username	0
515002	515000	Hits	hits	0	-1	0	0	application	0
515003	515000	Bytes	bytes	0	-1	2	0	application	0
521002	521000	Hits	hits	0	-1	0	0	sender	0
521003	521000	Bytes	bytes	0	-1	2	0	sender	0
522002	522000	Hits	hits	0	-1	0	0	host	0
522003	522000	Bytes	bytes	0	-1	2	0	host	0
523002	523000	Hits	hits	0	-1	0	0	destination	0
523003	523000	Bytes	bytes	0	-1	2	0	destination	0
524002	524000	Hits	hits	0	-1	0	0	username	0
524003	524000	Bytes	bytes	0	-1	2	0	username	0
525002	525000	Hits	hits	0	-1	0	0	application	0
525003	525000	Bytes	bytes	0	-1	2	0	application	0
510001	510000	Sender	sender	0	510000	0	0	sender	1
135011	135010	Application	application	0	145000	6	0	application	1
145111	145110	Application	application	0	-1	6	0	application	1
145211	145210	Application	application	0	155000	6	0	application	1
136011	136010	Application	application	0	146000	6	0	application	1
146111	146110	Application	application	0	-1	6	0	application	1
137011	137010	Application	application	0	147000	6	0	application	1
147111	147110	Application	application	0	-1	6	0	application	1
138011	138010	Application	application	0	148000	6	0	application	1
148111	148110	Application	application	0	-1	6	0	application	1
139011	139010	Application	application	0	149000	6	0	application	1
149111	149110	Application	application	0	-1	6	0	application	1
1430011	1430010	Application	application	0	1440000	6	0	application	1
1440111	1440110	Application	application	0	-1	6	0	application	1
1440211	1440210	Application	application	0	1450000	6	0	application	1
1431011	1431010	Application	application	0	1441000	6	0	application	1
1441111	1441110	Application	application	0	-1	6	0	application	1
1432011	1432010	Application	application	0	1442000	6	0	application	1
1442111	1442110	Application	application	0	-1	6	0	application	1
1434011	1434010	Application	application	0	1444000	6	0	application	1
1444111	1444110	Application	application	0	-1	6	0	application	1
1444211	1444210	Application	application	0	1454000	6	0	application	1
1435011	1435010	Application	application	0	1445000	6	0	application	1
1445111	1445110	Application	application	0	-1	6	0	application	1
1445211	1445210	Application	application	0	1455000	6	0	application	1
1436011	1436010	Application	application	0	1446000	6	0	application	1
1446111	1446110	Application	application	0	-1	6	0	application	1
1437011	1437010	Application	application	0	1447000	6	0	application	1
1447111	1447110	Application	application	0	-1	6	0	application	1
1438011	1438010	Application	application	0	1448000	6	0	application	1
1448111	1448110	Application	application	0	-1	6	0	application	1
1439011	1439010	Application	application	0	1449000	6	0	application	1
1449111	1449110	Application	application	0	-1	6	0	application	1
1531011	1531010	Application	application	0	1541000	6	0	application	1
1541111	1541110	Application	application	0	-1	6	0	application	1
1541211	1541210	Application	application	0	1551000	6	0	application	1
1551111	1551110	Application	application	0	-1	6	0	application	1
1532011	1532010	Application	application	0	1542000	6	0	application	1
1542111	1542110	Application	application	0	-1	6	0	application	1
1542211	1542210	Application	application	0	-1	6	0	application	1
1533011	1533010	Application	application	0	1543000	6	0	application	1
1543111	1543110	Application	application	0	-1	6	0	application	1
1543211	1543210	Application	application	0	1553000	6	0	application	1
1553111	1553110	Application	application	0	-1	6	0	application	1
1536011	1536010	Application	application	0	1546000	6	0	application	1
1546111	1546110	Application	application	0	-1	6	0	application	1
1546211	1546210	Application	application	0	1556000	6	0	application	1
1556111	1556110	Application	application	0	-1	6	0	application	1
1537011	1537010	Application	application	0	1547000	6	0	application	1
1547111	1547110	Application	application	0	-1	6	0	application	1
1547211	1547210	Application	application	0	1557000	6	0	application	1
1557111	1557110	Application	application	0	-1	6	0	application	1
1538011	1538010	Application	application	0	1548000	6	0	application	1
7413101	7413100	Application	application	0	-1	6	0	application	1
7421001	7421000	Application	application	0	7421000	6	0	application	1
7422101	7422100	Application	application	0	-1	6	0	application	1
7431001	7431000	Application	application	0	7431000	6	0	application	1
7432101	7432100	Application	application	0	-1	6	0	application	1
91310003	91310000	Application	application	0	-1	6	0	attack	1
531002	531000	Hits	hits	0	-1	0	0	sender	0
531003	531000	Bytes	bytes	0	-1	2	0	sender	0
532002	532000	Hits	hits	0	-1	0	0	recipient	0
532003	532000	Bytes	bytes	0	-1	2	0	recipient	0
533002	533000	Hits	hits	0	-1	0	0	host	0
533003	533000	Bytes	bytes	0	-1	2	0	host	0
534002	534000	Hits	hits	0	-1	0	0	destination	0
534003	534000	Bytes	bytes	0	-1	2	0	destination	0
535002	535000	Hits	hits	0	-1	0	0	application	0
535003	535000	Bytes	bytes	0	-1	2	0	application	0
541002	541000	Hits	hits	0	-1	0	0	sender	0
541003	541000	Bytes	bytes	0	-1	2	0	sender	0
542002	542000	Hits	hits	0	-1	0	0	recipient	0
542003	542000	Bytes	bytes	0	-1	2	0	recipient	0
543002	543000	Hits	hits	0	-1	0	0	username	0
543003	543000	Bytes	bytes	0	-1	2	0	username	0
544002	544000	Hits	hits	0	-1	0	0	destination	0
544003	544000	Bytes	bytes	0	-1	2	0	destination	0
545002	545000	Hits	hits	0	-1	0	0	application	0
545003	545000	Bytes	bytes	0	-1	2	0	application	0
551002	551000	Hits	hits	0	-1	0	0	sender	0
551003	551000	Bytes	bytes	0	-1	2	0	sender	0
552002	552000	Hits	hits	0	-1	0	0	recipient	0
552003	552000	Bytes	bytes	0	-1	2	0	recipient	0
553002	553000	Hits	hits	0	-1	0	0	username	0
553003	553000	Bytes	bytes	0	-1	2	0	username	0
554002	554000	Hits	hits	0	-1	0	0	host	0
554003	554000	Bytes	bytes	0	-1	2	0	host	0
555002	555000	Hits	hits	0	-1	0	0	destination	0
555003	555000	Bytes	bytes	0	-1	2	0	destination	0
91400001	91400000	Application	application	0	91400000	6	0	application	1
525104	525100	Host	host	0	-1	5	0		1
91510004	91510000	Application	application	0	-1	6	0	attacker	1
91610004	91610000	Application	application	0	-1	6	0	attacker	1
92210002	92210000	Application	application	0	-1	6	0	attacker	1
93300001	93300000	Application	application	0	93300000	6	0	application	1
94110003	94110000	Application	application	0	-1	6	0	attacker	1
94210003	94210000	Application	application	0	-1	6	0	attack	1
94300001	94300000	Application	application	0	94300000	6	0	application	1
97000001	97000000	Application	application	0	97000000	6	0	application	1
92110002	92110000	Application	application	0	-1	6	0	victim	1
11411115	11411110	Application	application	0	-1	6	0	subject	1
11411215	11411210	Application	application	0	-1	6	0	recipient	1
11411315	11411310	Application	application	0	-1	6	0	recipient	1
11411515	11411510	Application	application	0	-1	6	0	recipient	1
11412115	11412110	Application	application	0	-1	6	0	subject	1
11412215	11412210	Application	application	0	-1	6	0	sender	1
11412315	11412310	Application	application	0	-1	6	0	sender	1
11412515	11412510	Application	application	0	-1	6	0	sender	1
11413115	11413110	Application	application	0	-1	6	0	recipient	1
11413215	11413210	Application	application	0	-1	6	0	sender	1
11413315	11413310	Application	application	0	-1	6	0	sender	1
11413515	11413510	Application	application	0	-1	6	0	sender	1
11414115	11414110	Application	application	0	-1	6	0	recipient	1
11414215	11414210	Application	application	0	-1	6	0	sender	1
11414315	11414310	Application	application	0	-1	6	0	sender	1
11414515	11414510	Application	application	0	-1	6	0	sender	1
57	19	Application Group	proto_group	0	1520000	6	1	proto_group	1
60	20	Application Group	proto_group	0	1520001	6	1	proto_group	1
63	21	Application Group	proto_group	0	1520002	6	1	proto_group	1
7410001	7410000	Application Group	proto_group	0	7410000	6	0	proto_group	1
7200001	7200000	Application Group	proto_group	0	7200000	6	0	proto_group	1
7110001	7110000	Application Group	proto_group	0	7110000	6	0	proto_group	1
28011	28010	Application Group	proto_group	0	103000	6	0	proto_group	1
26011	26010	Application Group	proto_group	0	1430000	6	0	proto_group	1
26061	26060	Application Group	proto_group	0	7110000	6	0	proto_group	1
28061	28060	Application Group	proto_group	0	7310000	6	0	proto_group	1
11412102	11412100	Count	hits	0	-1	0	0	sender	0
11412202	11412200	Count	hits	0	-1	0	0	host	0
11412302	11412300	Count	hits	0	-1	0	0	destination	0
11412402	11412400	Count	hits	0	-1	0	0	application	0
11412502	11412500	Count	hits	0	-1	0	0	username	0
11413002	11413000	Count	hits	0	-1	0	0	host	0
11413102	11413100	Count	hits	0	-1	0	0	sender	0
11413202	11413200	Count	hits	0	-1	0	0	recipient	0
11413302	11413300	Count	hits	0	-1	0	0	destination	0
545106	545100	Size	size	0	-1	2	0		0
551106	551100	Size	size	0	-1	2	0		0
545102	545100	Recipient	recipient	0	-1	0	0		1
545103	545100	Subject	subject	0	-1	0	0		1
545104	545100	User	username	0	-1	0	0		1
11412101	11412100	Sender	sender	0	11412100	0	0	sender	1
551101	551100	Recipient	recipient	0	-1	0	0		1
551102	551100	Subject	subject	0	-1	0	0		1
551103	551100	User	username	0	-1	0	0		1
551104	551100	Host	host	0	-1	5	0		1
551105	551100	Destination	destination	0	-1	5	0		1
552101	552100	Sender	sender	0	-1	0	0		1
11414401	11414400	Application	application	0	11414400	6	0	application	1
11415001	11415000	Application	application	0	11415000	6	0	application	1
11413402	11413400	Count	hits	0	-1	0	0	application	0
11413502	11413500	Count	hits	0	-1	0	0	username	0
11414002	11414000	Count	hits	0	-1	0	0	destination	0
11414102	11414100	Count	hits	0	-1	0	0	sender	0
11414202	11414200	Count	hits	0	-1	0	0	recipient	0
11414302	11414300	Count	hits	0	-1	0	0	host	0
11414402	11414400	Count	hits	0	-1	0	0	application	0
11414502	11414500	Count	hits	0	-1	0	0	username	0
11415002	11415000	Count	hits	0	-1	0	0	application	0
11415102	11415100	Count	hits	0	-1	0	0	sender	0
11415202	11415200	Count	hits	0	-1	0	0	recipient	0
11415302	11415300	Count	hits	0	-1	0	0	host	0
11415402	11415400	Count	hits	0	-1	0	0	destination	0
11415502	11415500	Count	hits	0	-1	0	0	username	0
11510002	11510000	Count	hits	0	-1	0	0	virus	0
11511002	11511000	Count	hits	0	-1	0	0	server	0
11413501	11413500	User	username	0	11413500	0	0	username	1
11414001	11414000	Receiver Host	destination	0	11414000	5	0	destination	1
11414101	11414100	Sender	sender	0	11414100	0	0	sender	1
11414201	11414200	Recipient	recipient	0	11414200	0	0	recipient	1
11414301	11414300	Sender Host	host	0	11414300	5	0	host	1
11414501	11414500	User	username	0	11414500	0	0	username	1
11415101	11415100	Sender	sender	0	11415100	0	0	sender	1
11415201	11415200	Recipient	recipient	0	11415200	0	0	recipient	1
11415301	11415300	Sender Host	host	0	11415300	5	0	host	1
11415401	11415400	Receiver Host	destination	0	11415400	5	0	destination	1
11415501	11415500	User	username	0	11415500	0	0	username	1
11510001	11510000	Virus	virus	0	11510000	0	0	virus	1
11511001	11511000	Server	server	0	11511000	5	0	server	1
11511102	11511100	Count	hits	0	-1	0	0	host	0
11511113	11511110	Count	hits	0	-1	0	0	file	0
11511202	11511200	Count	hits	0	-1	0	0	file	0
11511302	11511300	Count	hits	0	-1	0	0	username	0
11511313	11511310	Count	hits	0	-1	0	0	host	0
11512002	11512000	Count	hits	0	-1	0	0	host	0
11512102	11512100	Count	hits	0	-1	0	0	server	0
11512113	11512110	Count	hits	0	-1	0	0	file	0
11512202	11512200	Count	hits	0	-1	0	0	file	0
11512213	11512210	Count	hits	0	-1	0	0	server	0
11512302	11512300	Count	hits	0	-1	0	0	username	0
11512313	11512310	Count	hits	0	-1	0	0	server	0
11513002	11513000	Count	hits	0	-1	0	0	username	0
11513102	11513100	Count	hits	0	-1	0	0	server	0
11513113	11513110	Count	hits	0	-1	0	0	file	0
11513202	11513200	Count	hits	0	-1	0	0	file	0
11513213	11513210	Count	hits	0	-1	0	0	server	0
11513302	11513300	Count	hits	0	-1	0	0	host	0
11513313	11513310	Count	hits	0	-1	0	0	server	0
11514002	11514000	Count	hits	0	-1	0	0	file	0
11514102	11514100	Count	hits	0	-1	0	0	server	0
11514113	11514110	Count	hits	0	-1	0	0	host	0
11514202	11514200	Count	hits	0	-1	0	0	host	0
11514213	11514210	Count	hits	0	-1	0	0	server	0
11514302	11514300	Count	hits	0	-1	0	0	username	0
11514313	11514310	Count	hits	0	-1	0	0	server	0
11520002	11520000	Count	hits	0	-1	0	0	virus	0
11521002	11521000	Count	hits	0	-1	0	0	server	0
11521102	11521100	Count	hits	0	-1	0	0	host	0
11521113	11521110	Count	hits	0	-1	0	0	file	0
11521202	11521200	Count	hits	0	-1	0	0	file	0
11521302	11521300	Count	hits	0	-1	0	0	username	0
11521313	11521310	Count	hits	0	-1	0	0	host	0
11522002	11522000	Count	hits	0	-1	0	0	host	0
11522102	11522100	Count	hits	0	-1	0	0	server	0
11522113	11522110	Count	hits	0	-1	0	0	file	0
11522202	11522200	Count	hits	0	-1	0	0	file	0
11522213	11522210	Count	hits	0	-1	0	0	server	0
11522302	11522300	Count	hits	0	-1	0	0	username	0
11522313	11522310	Count	hits	0	-1	0	0	server	0
11523002	11523000	Count	hits	0	-1	0	0	username	0
11511213	11511210	Count	hits	0	-1	0	0	host	0
11521213	11521210	Count	hits	0	-1	0	0	host	0
11523102	11523100	Count	hits	0	-1	0	0	server	0
11523113	11523110	Count	hits	0	-1	0	0	file	0
11523202	11523200	Count	hits	0	-1	0	0	file	0
11523213	11523210	Count	hits	0	-1	0	0	server	0
11523302	11523300	Count	hits	0	-1	0	0	host	0
11523313	11523310	Count	hits	0	-1	0	0	server	0
11524002	11524000	Count	hits	0	-1	0	0	file	0
11524102	11524100	Count	hits	0	-1	0	0	server	0
11524113	11524110	Count	hits	0	-1	0	0	host	0
11524202	11524200	Count	hits	0	-1	0	0	host	0
11524213	11524210	Count	hits	0	-1	0	0	server	0
11524302	11524300	Count	hits	0	-1	0	0	username	0
11524313	11524310	Count	hits	0	-1	0	0	server	0
11523111	11523110	File	file	0	-1	0	0	file	1
11523112	11523110	Host	host	0	-1	5	0	file	1
11523201	11523200	File	file	0	11523200	0	0	file	1
11523211	11523210	Server	server	0	-1	5	0	server	1
11523212	11523210	Host	host	0	-1	5	0	server	1
11523301	11523300	Host	host	0	11523300	5	0	host	1
11523311	11523310	Server	server	0	-1	5	0	server	1
11523312	11523310	File	file	0	-1	0	0	server	1
11524001	11524000	File	file	0	11524000	0	0	file	1
11524101	11524100	Server	server	0	11524100	5	0	server	1
11524111	11524110	Host	host	0	-1	5	0	host	1
11524112	11524110	User	username	0	-1	0	0	host	1
11524201	11524200	Host	host	0	11524200	5	0	host	1
11524211	11524210	Server	server	0	-1	5	0	server	1
11524212	11524210	User	username	0	-1	0	0	server	1
11524301	11524300	User	username	0	11524300	0	0	username	1
11524311	11524310	Server	server	0	-1	5	0	server	1
11524312	11524310	Host	host	0	-1	5	0	server	1
92300001	92300000	Application	application	0	92300000	6	0	application	1
92300002	92300000	Hits	hits	0	-1	0	0	application	0
92310005	92310000	Hits	hits	0	-1	0	0	attacker	0
92310001	92310000	Attacker	attacker	0	-1	5	0	attacker	1
92310002	92310000	Victim	victim	0	-1	5	0	attacker	1
92310003	92310000	User	username	0	-1	0	0	attacker	1
92310004	92310000	Action	action	0	-1	0	0	attacker	1
93110003	93110000	Application	application	0	-1	6	0	victim	1
93210003	93210000	Application	application	0	-1	6	0	attack	1
93000002	93000000	Hits	hits	0	-1	0	0	attacker	0
93110004	93110000	Severity	severity	0	-1	7	0	victim	1
93210004	93210000	Severity	severity	0	-1	7	0	attack	1
93110006	93110000	Hits	hits	0	-1	0	0	victim	0
93200002	93200000	Hits	hits	0	-1	0	0	victim	0
93210006	93210000	Hits	hits	0	-1	0	0	attack	0
93100002	93100000	Hits	hits	0	-1	0	0	attack	0
93000001	93000000	Attacker	attacker	0	93000000	5	0	attacker	1
93110001	93110000	Victim	victim	0	-1	5	0	victim	1
93110002	93110000	User	username	0	-1	0	0	victim	1
93110005	93110000	Action	action	0	-1	0	0	victim	1
93200001	93200000	Victim	victim	0	93200000	5	0	victim	1
93210001	93210000	Attack	attack	0	-1	0	0	attack	1
93210002	93210000	User	username	0	-1	0	0	attack	1
93210005	93210000	Action	action	0	-1	0	0	attack	1
93100001	93100000	Attack	attack	0	93100000	0	0	attack	1
92000001	92000000	Attack	attack	0	92000000	0	0	attack	1
1207011	1207010	Application	application	0	-1	6	0	application	1
1204013	1204010	Hits	hits	0	-1	0	0		0
1205012	1205010	Hits	hits	0	-1	0	0		0
1206012	1206010	Hits	hits	0	-1	0	0		0
1207012	1207010	Hits	hits	0	-1	0	0	application	0
1207013	1207010	Bytes	bytes	0	-1	2	0	application	0
1208012	1208010	Hits	hits	0	-1	0	0		0
1208013	1208010	Bytes	bytes	0	-1	2	0		0
1209012	1209010	Hits	hits	0	-1	0	0		0
1205011	1205010	Attack	attack	0	-1	0	0		1
1206011	1206010	Spam Senders	spam_sender	0	-1	0	0		1
1208011	1208010	Destination	destination	0	-1	5	0		1
1209011	1209010	Virus	virus	0	-1	0	0		1
1202012	1202010	Hits	hits	0	-1	0	0		0
1203012	1203010	Hits	hits	0	-1	0	0	domain	0
1203013	1203010	Bytes	bytes	0	-1	2	0	domain	0
49	16	Hits	hits	0	-1	0	2	username	0
50	16	Bytes	bytes	0	-1	2	2	username	0
52	17	Hits	hits	0	-1	0	2	username	0
53	17	Bytes	bytes	0	-1	2	2	username	0
55	18	Hits	hits	0	-1	0	2	username	0
56	18	Bytes	bytes	0	-1	2	2	username	0
58	19	Hits	hits	0	-1	0	2	proto_group	0
59	19	Bytes	bytes	0	-1	2	2	proto_group	0
61	20	Hits	hits	0	-1	0	2	proto_group	0
62	20	Bytes	bytes	0	-1	2	2	proto_group	0
64	21	Hits	hits	0	-1	0	2	proto_group	0
1520122	1520120	Hits	hits	0	-1	0	0	srcip	0
1520123	1520120	Bytes	bytes	0	-1	2	0	srcip	0
20201002	20201000	Hits	hits	0	-1	0	0	username	0
20201003	20201000	Bytes	bytes	0	-1	2	0	username	0
20202002	20202000	Hits	hits	0	-1	0	0	destip	0
20202003	20202000	Bytes	bytes	0	-1	2	0	destip	0
20203002	20203000	Hits	hits	0	-1	0	0	srcip	0
20203003	20203000	Bytes	bytes	0	-1	2	0	srcip	0
20301002	20301000	Hits	hits	0	-1	0	0	username	0
20301003	20301000	Bytes	bytes	0	-1	2	0	username	0
20302002	20302000	Hits	hits	0	-1	0	0	destip	0
4530003	4530000	Bytes	bytes	0	-1	2	0	content	0
4531002	4531000	Hits	hits	0	-1	0	0	domain	0
4531003	4531000	Bytes	bytes	0	-1	2	0	domain	0
4531102	4531100	Hits	hits	0	-1	0	0	url	0
4531103	4531100	Bytes	bytes	0	-1	2	0	url	0
4540002	4540000	Hits	hits	0	-1	0	0	url	0
4540003	4540000	Bytes	bytes	0	-1	2	0	url	0
4550002	4550000	Hits	hits	0	-1	0	0	username	0
4550003	4550000	Bytes	bytes	0	-1	2	0	username	0
4551002	4551000	Hits	hits	0	-1	0	0	category	0
4551003	4551000	Bytes	bytes	0	-1	2	0	category	0
4551102	4551100	Hits	hits	0	-1	0	0	domain	0
4551103	4551100	Bytes	bytes	0	-1	2	0	domain	0
4551112	4551110	Hits	hits	0	-1	0	0	url	0
4551113	4551110	Bytes	bytes	0	-1	2	0	url	0
4552002	4552000	Hits	hits	0	-1	0	0	domain	0
4552003	4552000	Bytes	bytes	0	-1	2	0	domain	0
4552102	4552100	Hits	hits	0	-1	0	0	url	0
4552103	4552100	Bytes	bytes	0	-1	2	0	url	0
4553002	4553000	Hits	hits	0	-1	0	0	content	0
4553003	4553000	Bytes	bytes	0	-1	2	0	content	0
4553102	4553100	Hits	hits	0	-1	0	0	domain	0
4553103	4553100	Bytes	bytes	0	-1	2	0	domain	0
4553112	4553110	Hits	hits	0	-1	0	0	url	0
4553113	4553110	Bytes	bytes	0	-1	2	0	url	0
4554002	4554000	Hits	hits	0	-1	0	0	url	0
4554003	4554000	Bytes	bytes	0	-1	2	0	url	0
4555002	4555000	Hits	hits	0	-1	0	0	application	0
4555003	4555000	Bytes	bytes	0	-1	2	0	application	0
4555102	4555100	Hits	hits	0	-1	0	0	category	0
4555103	4555100	Bytes	bytes	0	-1	2	0	category	0
20101002	20101000	Hits	hits	0	-1	0	0	username	0
20101003	20101000	Bytes	bytes	0	-1	2	0	username	0
20102002	20102000	Hits	hits	0	-1	0	0	destip	0
20102003	20102000	Bytes	bytes	0	-1	2	0	destip	0
20103002	20103000	Hits	hits	0	-1	0	0	srcip	0
20103003	20103000	Bytes	bytes	0	-1	2	0	srcip	0
20801003	20801000	Bytes	bytes	0	-1	2	0	application	0
20802002	20802000	Hits	hits	0	-1	0	0	destip	0
20802003	20802000	Bytes	bytes	0	-1	2	0	destip	0
20803002	20803000	Hits	hits	0	-1	0	0	username	0
20803003	20803000	Bytes	bytes	0	-1	2	0	username	0
20901002	20901000	Hits	hits	0	-1	0	0	application	0
20901003	20901000	Bytes	bytes	0	-1	2	0	application	0
20902002	20902000	Hits	hits	0	-1	0	0	destip	0
20902003	20902000	Bytes	bytes	0	-1	2	0	destip	0
20903002	20903000	Hits	hits	0	-1	0	0	username	0
20903003	20903000	Bytes	bytes	0	-1	2	0	username	0
20101102	20101100	Hits	hits	0	-1	0	0	destip	0
20101103	20101100	Bytes	bytes	0	-1	2	0	destip	0
20101202	20101200	Hits	hits	0	-1	0	0	srcip	0
20101203	20101200	Bytes	bytes	0	-1	2	0	srcip	0
20102102	20102100	Hits	hits	0	-1	0	0	username	0
20102103	20102100	Bytes	bytes	0	-1	2	0	username	0
20102202	20102200	Hits	hits	0	-1	0	0	srcip	0
20102203	20102200	Bytes	bytes	0	-1	2	0	srcip	0
20103102	20103100	Hits	hits	0	-1	0	0	destip	0
20103103	20103100	Bytes	bytes	0	-1	2	0	destip	0
20103202	20103200	Hits	hits	0	-1	0	0	username	0
20103203	20103200	Bytes	bytes	0	-1	2	0	username	0
20201102	20201100	Hits	hits	0	-1	0	0	destip	0
20201103	20201100	Bytes	bytes	0	-1	2	0	destip	0
20201202	20201200	Hits	hits	0	-1	0	0	srcip	0
20201203	20201200	Bytes	bytes	0	-1	2	0	srcip	0
20202102	20202100	Hits	hits	0	-1	0	0	username	0
20202103	20202100	Bytes	bytes	0	-1	2	0	username	0
20202202	20202200	Hits	hits	0	-1	0	0	srcip	0
20202203	20202200	Bytes	bytes	0	-1	2	0	srcip	0
10122	1012	Hits	field2	0	-1	0	1	field1	0
4400002	4400000	Hits	hits	0	-1	0	0	content	0
4400003	4400000	Bytes	bytes	0	-1	2	0	content	0
4410002	4410000	Hits	hits	0	-1	0	0	domain	0
4410003	4410000	Bytes	bytes	0	-1	2	0	domain	0
4420002	4420000	Hits	hits	0	-1	0	0	username	0
4420003	4420000	Bytes	bytes	0	-1	2	0	username	0
4430002	4430000	Hits	hits	0	-1	0	0	category	0
4430003	4430000	Bytes	bytes	0	-1	2	0	category	0
4411002	4411000	Hits	hits	0	-1	0	0	username	0
4411003	4411000	Bytes	bytes	0	-1	2	0	username	0
4411102	4411100	Hits	hits	0	-1	0	0	url	0
4411103	4411100	Bytes	bytes	0	-1	2	0	url	0
4421002	4421000	Hits	hits	0	-1	0	0	domain	0
4421003	4421000	Bytes	bytes	0	-1	2	0	domain	0
4422002	4422000	Hits	hits	0	-1	0	0	category	0
4422003	4422000	Bytes	bytes	0	-1	2	0	category	0
4421102	4421100	Hits	hits	0	-1	0	0	url	0
4421103	4421100	Bytes	bytes	0	-1	2	0	url	0
4422102	4422100	Hits	hits	0	-1	0	0	domain	0
4422103	4422100	Bytes	bytes	0	-1	2	0	domain	0
4422112	4422110	Hits	hits	0	-1	0	0	url	0
4422113	4422110	Bytes	bytes	0	-1	2	0	url	0
4431002	4431000	Hits	hits	0	-1	0	0	username	0
42321102	42321100	Hits	hits	0	-1	0	0	url	0
42321103	42321100	Bytes	bytes	0	-1	2	0	url	0
43000002	43000000	Hits	hits	0	-1	0	0	domain	0
43000003	43000000	Bytes	bytes	0	-1	2	0	domain	0
43100002	43100000	Hits	hits	0	-1	0	0	username	0
43100003	43100000	Bytes	bytes	0	-1	2	0	username	0
43200002	43200000	Hits	hits	0	-1	0	0	content	0
43200003	43200000	Bytes	bytes	0	-1	2	0	content	0
43110002	43110000	Hits	hits	0	-1	0	0	url	0
43110003	43110000	Bytes	bytes	0	-1	2	0	url	0
43210002	43210000	Hits	hits	0	-1	0	0	username	0
43210003	43210000	Bytes	bytes	0	-1	2	0	username	0
43211002	43211000	Hits	hits	0	-1	0	0	url	0
43211003	43211000	Bytes	bytes	0	-1	2	0	url	0
41500002	41500000	Hits	hits	0	-1	0	0	host	0
41500003	41500000	Bytes	bytes	0	-1	2	0	host	0
41000002	41000000	Hits	hits	0	-1	0	0	username	0
41000003	41000000	Bytes	bytes	0	-1	2	0	username	0
46221002	46221000	Hits	hits	0	-1	0	0	username	0
46221003	46221000	Bytes	bytes	0	-1	2	0	username	0
10033	1003	Percent	field3	0	-1	3	1	field1	0
10043	1004	Percent	field3	0	-1	3	1	field1	0
10053	1005	Percent	field3	0	-1	3	1	field1	0
10063	1006	Percent	field3	0	-1	3	1	field1	0
10073	1007	Percent	field3	0	-1	3	1	field1	0
10083	1008	Percent	field3	0	-1	3	1	field1	0
10093	1009	Percent	field3	0	-1	3	1	field1	0
10103	1010	Percent	field3	0	-1	3	1	field1	0
10113	1011	Percent	field3	0	-1	3	1	field1	0
10123	1012	Percent	field3	0	-1	3	1	field1	0
10012	1001	Bytes	totalbytes	0	-1	2	2	devicename	0
10022	1002	Hits	total	0	-1	0	1	devicename	0
10041	1004	Traffic	field1	0	-1	0	1	field1	0
10051	1005	Traffic	field1	0	-1	0	1	field1	0
10061	1006	Traffic	field1	0	-1	0	1	field1	0
10071	1007	Traffic	field1	0	-1	0	1	field1	0
10101	1010	Attack Type	field1	0	-1	0	1	field1	0
10091	1009	Application	field1	0	-1	6	1	field1	0
10111	1011	Application	field1	0	-1	6	1	field1	0
10121	1012	Application	field1	0	-1	6	1	field1	0
10081	1008	Application	field1	0	-1	6	1	field1	0
10031	1003	Allowed Traffic	field1	0	-1	6	1	field1	0
20203201	20203200	User	username	0	-1	0	0	username	1
4500001	4500000	Host	host	0	4500000	5	0	host	1
1536031	1536030	Host	srcip	0	1546200	5	0	srcip	1
4400001	4400000	Content	content	0	4400000	0	0	content	1
4410001	4410000	Domain	domain	0	4410000	0	0	domain	1
4420001	4420000	User	username	0	4420000	0	0	username	1
4430001	4430000	Category	category	0	4430000	0	0	category	1
4411001	4411000	User	username	0	4411000	0	0	username	1
4411101	4411100	URL	url	0	-1	0	0	url	1
4421001	4421000	Domain	domain	0	4421000	0	0	domain	1
4422001	4422000	Category	category	0	4422000	0	0	category	1
4421101	4421100	URL	url	0	-1	0	0	url	1
4422101	4422100	Domain	domain	0	4422100	0	0	domain	1
4422111	4422110	URL	url	0	-1	0	0	url	1
46120001	46120000	User	username	0	46120000	0	0	username	1
46311101	46311100	URL	url	0	-1	0	0	url	1
46121001	46121000	Domain	domain	0	46121000	0	0	domain	1
46121101	46121100	URL	url	0	-1	0	0	url	1
46122001	46122000	Content	content	0	46122000	0	0	content	1
46122111	46122110	URL	url	0	-1	0	0	url	1
46422001	46422000	Category	category	0	46422000	0	0	category	1
46422101	46422100	Domain	domain	0	46422100	0	0	domain	1
46422111	46422110	URL	url	0	-1	0	0	url	1
46430001	46430000	Category	category	0	46430000	0	0	category	1
46431001	46431000	User	username	0	46431000	0	0	username	1
41552111	41552110	URL	url	0	-1	0	0	url	1
41610001	41610000	Category	category	0	41610000	0	0	category	1
15411111	15411110	Application	application	0	-1	6	0	application	1
15411211	15411210	Application	application	0	15511000	6	0	application	1
15511111	15511110	Application	application	0	-1	6	0	application	1
15311031	15311030	User	username	0	15411200	0	0	username	1
15411011	15411010	Destination	destip	0	-1	5	0	destip	1
15411021	15411020	User	username	0	-1	0	0	username	1
15411121	15411120	User	username	0	-1	0	0	username	1
15411221	15411220	Destination	destip	0	15511100	5	0	destip	1
15511011	15511010	Destination	destip	0	-1	5	0	destip	1
1420011	1420010	Destination	destip	0	1431000	5	0	destip	1
1420021	1420020	Host	srcip	0	1432000	5	0	srcip	1
1420061	1420060	Destination	destip	0	1436000	5	0	destip	1
405	128	Application	application	0	-1	6	0	application	1
410	129	Application	application	0	-1	6	0	srcip	1
415	130	Application	application	0	-1	6	0	srcip	1
420	131	Application	application	0	-1	6	0	destip	1
424	132	Application	application	0	-1	6	0	destip	1
428	133	Application	application	0	-1	6	0	srcip	1
402	127	Destination	destip	0	-1	5	0	srcip	1
404	128	Host	srcip	0	-1	5	0	srcip	1
406	128	User	username	0	-1	0	0	application	1
407	128	Destination	destip	0	-1	5	0	application	1
409	129	Host	srcip	0	-1	5	0	srcip	1
411	129	User	username	0	-1	0	0	srcip	1
412	129	Destination	destip	0	-1	5	0	srcip	1
414	130	Host	srcip	0	-1	5	0	srcip	1
416	130	User	username	0	-1	0	0	srcip	1
417	130	Destination	destip	0	-1	5	0	srcip	1
419	131	Destination	destip	0	-1	5	0	destip	1
421	131	User	username	0	-1	0	0	destip	1
423	132	Destination	destip	0	-1	5	0	destip	1
425	132	User	username	0	-1	0	0	destip	1
427	133	Host	srcip	0	-1	5	0	srcip	1
429	133	User	username	0	-1	0	0	srcip	1
431	134	Host	srcip	0	-1	5	0	srcip	1
433	134	User	username	0	-1	0	0	srcip	1
438	135	Start Time(MM:DD HH)	starttime	0	-1	0	0		1
439	135	Records	records	0	-1	0	0		1
10011	1001	Device	devicename	0	10001	0	1	devicename	1
10021	1002	Device	devicename	0	10001	0	1	devicename	1
10023	1002	Traffic	traffic	0	-1	0	1	devicename	1
1202011	1202010	Application	application	0	-1	6	0		1
4555001	4555000	Application	application	0	4555000	6	0	application	1
4560001	4560000	Application	application	0	4560000	6	0	application	1
46000001	46000000	Application	application	0	46000000	6	0	application	1
1203011	1203010	Domain	domain	0	-1	0	0	domain	1
1204011	1204010	Domain	domain	0	-1	5	0		1
1204012	1204010	Host	host	0	-1	5	0		1
4531001	4531000	Domain	domain	0	4531000	0	0	domain	1
4531101	4531100	URL	url	0	-1	0	0	url	1
4540001	4540000	URL	url	0	-1	0	0	url	1
4550001	4550000	User	username	0	4550000	0	0	username	1
7100002	7100000	Hits	hits	0	-1	0	0	username	0
7200002	7200000	Hits	hits	0	-1	0	0	proto_group	0
7300002	7300000	Hits	hits	0	-1	0	0	host	0
7400002	7400000	Hits	hits	0	-1	0	0	destination	0
7110002	7110000	Hits	hits	0	-1	0	0	proto_group	0
7111002	7111000	Hits	hits	0	-1	0	0	application	0
7111102	7111100	Hits	hits	0	-1	0	0	destination	0
7112002	7112000	Hits	hits	0	-1	0	0	destination	0
7112102	7112100	Hits	hits	0	-1	0	0	application	0
7113002	7113000	Hits	hits	0	-1	0	0	host	0
7113102	7113100	Hits	hits	0	-1	0	0	application	0
7113112	7113110	Hits	hits	0	-1	0	0	destination	0
7120002	7120000	Hits	hits	0	-1	0	0	destination	0
7121002	7121000	Hits	hits	0	-1	0	0	application	0
7121102	7121100	Hits	hits	0	-1	0	0	host	0
7122002	7122000	Hits	hits	0	-1	0	0	host	0
46321001	46321000	URL	url	0	-1	0	0	url	1
46331001	46331000	Domain	domain	0	46331000	0	0	domain	1
46331101	46331100	URL	url	0	-1	0	0	url	1
46400001	46400000	Content	content	0	46400000	0	0	content	1
46410001	46410000	Domain	domain	0	46410000	0	0	domain	1
46411001	46411000	User	username	0	46411000	0	0	username	1
46411101	46411100	URL	url	0	-1	0	0	url	1
7130001	7130000	Host	host	0	7130000	5	0	host	1
7211001	7211000	User	username	0	7211000	0	0	username	1
7211201	7211200	Host	host	0	-1	5	0	host	1
7212101	7212100	User	username	0	-1	0	0	username	1
7122102	7122100	Hits	hits	0	-1	0	0	application	0
7130002	7130000	Hits	hits	0	-1	0	0	host	0
7131002	7131000	Hits	hits	0	-1	0	0	application	0
7131102	7131100	Hits	hits	0	-1	0	0	destination	0
7132002	7132000	Hits	hits	0	-1	0	0	destination	0
7212201	7212200	Host	host	0	-1	5	0	host	1
7132102	7132100	Hits	hits	0	-1	0	0	application	0
7210002	7210000	Hits	hits	0	-1	0	0	application	0
7211002	7211000	Hits	hits	0	-1	0	0	username	0
7211102	7211100	Hits	hits	0	-1	0	0	destination	0
7211202	7211200	Hits	hits	0	-1	0	0	host	0
7212102	7212100	Hits	hits	0	-1	0	0	username	0
7212202	7212200	Hits	hits	0	-1	0	0	host	0
7213002	7213000	Hits	hits	0	-1	0	0	host	0
7213102	7213100	Hits	hits	0	-1	0	0	destination	0
7213202	7213200	Hits	hits	0	-1	0	0	username	0
7220002	7220000	Hits	hits	0	-1	0	0	username	0
7221002	7221000	Hits	hits	0	-1	0	0	application	0
7221102	7221100	Hits	hits	0	-1	0	0	destination	0
7221202	7221200	Hits	hits	0	-1	0	0	host	0
7222002	7222000	Hits	hits	0	-1	0	0	destination	0
7222102	7222100	Hits	hits	0	-1	0	0	application	0
7222202	7222200	Hits	hits	0	-1	0	0	host	0
7223002	7223000	Hits	hits	0	-1	0	0	host	0
7243211	7243210	Application	application	0	-1	6	0	application	1
7311001	7311000	Application	application	0	7311000	6	0	application	1
7312101	7312100	Application	application	0	-1	6	0	application	1
7310001	7310000	Application Group	proto_group	0	7310000	6	0	proto_group	1
7243212	7243210	Hits	hits	0	-1	0	0	application	0
7310002	7310000	Hits	hits	0	-1	0	0	proto_group	0
7311002	7311000	Hits	hits	0	-1	0	0	application	0
7311102	7311100	Hits	hits	0	-1	0	0	destination	0
7312002	7312000	Hits	hits	0	-1	0	0	destination	0
7312102	7312100	Hits	hits	0	-1	0	0	application	0
7313002	7313000	Hits	hits	0	-1	0	0	username	0
7313102	7313100	Hits	hits	0	-1	0	0	application	0
7313112	7313110	Hits	hits	0	-1	0	0	destination	0
7320002	7320000	Hits	hits	0	-1	0	0	destination	0
7321002	7321000	Hits	hits	0	-1	0	0	application	0
7321102	7321100	Hits	hits	0	-1	0	0	username	0
7322002	7322000	Hits	hits	0	-1	0	0	username	0
7322102	7322100	Hits	hits	0	-1	0	0	application	0
7330002	7330000	Hits	hits	0	-1	0	0	username	0
7331002	7331000	Hits	hits	0	-1	0	0	application	0
7331102	7331100	Hits	hits	0	-1	0	0	destination	0
7332002	7332000	Hits	hits	0	-1	0	0	destination	0
7332102	7332100	Hits	hits	0	-1	0	0	application	0
7410002	7410000	Hits	hits	0	-1	0	0	proto_group	0
7411002	7411000	Hits	hits	0	-1	0	0	application	0
7411102	7411100	Hits	hits	0	-1	0	0	username	0
7411202	7411200	Hits	hits	0	-1	0	0	host	0
7412002	7412000	Hits	hits	0	-1	0	0	username	0
7412102	7412100	Hits	hits	0	-1	0	0	application	0
7412202	7412200	Hits	hits	0	-1	0	0	host	0
7413002	7413000	Hits	hits	0	-1	0	0	host	0
7413102	7413100	Hits	hits	0	-1	0	0	application	0
7413202	7413200	Hits	hits	0	-1	0	0	username	0
7420002	7420000	Hits	hits	0	-1	0	0	username	0
7421002	7421000	Hits	hits	0	-1	0	0	application	0
7421102	7421100	Hits	hits	0	-1	0	0	host	0
7422002	7422000	Hits	hits	0	-1	0	0	host	0
7422102	7422100	Hits	hits	0	-1	0	0	application	0
7430002	7430000	Hits	hits	0	-1	0	0	host	0
7431002	7431000	Hits	hits	0	-1	0	0	application	0
7431102	7431100	Hits	hits	0	-1	0	0	username	0
7432002	7432000	Hits	hits	0	-1	0	0	username	0
7432102	7432100	Hits	hits	0	-1	0	0	application	0
7212002	7212000	Hits	hits	0	-1	0	0	destination	0
46132112	46132110	Hits	hits	0	-1	0	0	url	0
46132113	46132110	Bytes	bytes	0	-1	0	0	url	0
7230001	7230000	Destination	destination	0	7230000	5	0	destination	1
7241101	7241100	Destination	destination	0	-1	5	0	destination	1
7242001	7242000	Destination	destination	0	7242000	5	0	destination	1
7243111	7243110	Destination	destination	0	-1	5	0	destination	1
7243201	7243200	Destination	destination	0	7243200	5	0	destination	1
7311101	7311100	Destination	destination	0	-1	5	0	destination	1
7312001	7312000	Destination	destination	0	7312000	5	0	destination	1
7313111	7313110	Destination	destination	0	-1	5	0	destination	1
7320001	7320000	Destination	destination	0	7320000	5	0	destination	1
7331101	7331100	Destination	destination	0	-1	5	0	destination	1
7332001	7332000	Destination	destination	0	7332000	5	0	destination	1
78	26	Application Group	proto_group	0	103000	6	0	proto_group	1
90	30	Application Group	proto_group	0	134000	6	0	proto_group	1
93	31	Application Group	proto_group	0	135000	6	0	proto_group	1
1420001	1420000	Application Group	proto_group	0	1430000	6	0	proto_group	1
1420041	1420040	Application Group	proto_group	0	1434000	6	0	proto_group	1
1420051	1420050	Application Group	proto_group	0	1435000	6	0	proto_group	1
20400002	20400000	Application Group	proto_group	0	-1	6	0	username	1
20500002	20500000	Application Group	proto_group	0	-1	6	0	username	1
20600002	20600000	Application Group	proto_group	0	-1	6	0	username	1
20700002	20700000	Application Group	proto_group	0	-1	6	0	srcip	1
20800002	20800000	Application Group	proto_group	0	-1	6	0	srcip	1
20900002	20900000	Application Group	proto_group	0	-1	6	0	srcip	1
375	121	Application Group	proto_group	0	21	6	0	proto_group	1
379	122	Application Group	proto_group	0	22	6	0	proto_group	1
435	1201010	Application Group	proto_group	0	1430000	6	0	proto_group	1
10013	1001	Application Group	protocolgroup	0	-1	6	1	devicename	1
81000001	81000000	User	username	0	81000000	0	1	username	1
81100001	81100000	Category	category	0	81100000	0	0	category	1
81000002	81000000	Hits	hits	0	-1	0	0	username	0
81100002	81100000	Hits	hits	0	-1	0	0	category	0
81200002	81200000	Hits	hits	0	-1	0	0	domain	0
81300002	81300000	Hits	hits	0	-1	0	0	url	0
81400002	81400000	Hits	hits	0	-1	0	0	host	0
81500002	81500000	Hits	hits	0	-1	0	0	application	0
83110002	83110000	Hits	hits	0	-1	0	0	url	0
84000002	84000000	Hits	hits	0	-1	0	0	host	0
84100002	84100000	Hits	hits	0	-1	0	0	category	0
84200002	84200000	Hits	hits	0	-1	0	0	domain	0
84300002	84300000	Hits	hits	0	-1	0	0	url	0
84400002	84400000	Hits	hits	0	-1	0	0	username	0
84110002	84110000	Hits	hits	0	-1	0	0	domain	0
84111002	84111000	Hits	hits	0	-1	0	0	url	0
84210002	84210000	Hits	hits	0	-1	0	0	url	0
84410002	84410000	Hits	hits	0	-1	0	0	category	0
84420002	84420000	Hits	hits	0	-1	0	0	domain	0
84430002	84430000	Hits	hits	0	-1	0	0	url	0
84440002	84440000	Hits	hits	0	-1	0	0	application	0
84411002	84411000	Hits	hits	0	-1	0	0	domain	0
84411102	84411100	Hits	hits	0	-1	0	0	url	0
84421002	84421000	Hits	hits	0	-1	0	0	url	0
84441002	84441000	Hits	hits	0	-1	0	0	category	0
84441102	84441100	Hits	hits	0	-1	0	0	domain	0
84441112	84441110	Hits	hits	0	-1	0	0	url	0
84500002	84500000	Hits	hits	0	-1	0	0	application	0
84510002	84510000	Hits	hits	0	-1	0	0	category	0
84511002	84511000	Hits	hits	0	-1	0	0	domain	0
84511102	84511100	Hits	hits	0	-1	0	0	url	0
84000001	84000000	Host	host	0	84000000	5	0	host	1
84100001	84100000	Category	category	0	84100000	0	0	category	1
84200001	84200000	Domain	domain	0	84200000	0	0	domain	1
84300001	84300000	URL	url	0	-1	0	0	url	1
84400001	84400000	User	username	0	84400000	0	1	username	1
84110001	84110000	Domain	domain	0	84110000	0	0	domain	1
84111001	84111000	URL	url	0	-1	0	0	url	1
84210001	84210000	URL	url	0	-1	0	0	url	1
84410001	84410000	Category	category	0	84410000	0	0	category	1
84420001	84420000	Domain	domain	0	84420000	0	0	domain	1
84430001	84430000	URL	url	0	-1	0	0	url	1
84411001	84411000	Domain	domain	0	84411000	0	0	domain	1
6100002	6100000	Hits	hits	0	-1	0	0	file	0
6100003	6100000	Bytes	bytes	0	-1	2	0	file	0
6200002	6200000	Hits	hits	0	-1	0	0	file	0
6200003	6200000	Bytes	bytes	0	-1	2	0	file	0
6300002	6300000	Hits	hits	0	-1	0	0	username	0
6300003	6300000	Bytes	bytes	0	-1	2	0	username	0
6400002	6400000	Hits	hits	0	-1	0	0	username	0
6400003	6400000	Bytes	bytes	0	-1	2	0	username	0
6100001	6100000	File	file	0	6100000	0	0	file	1
6200001	6200000	File	file	0	6200000	0	0	file	1
6300001	6300000	User	username	0	6300000	0	0	username	1
6400001	6400000	User	username	0	6400000	0	0	username	1
6500002	6500000	Hits	hits	0	-1	0	0	host	0
6500003	6500000	Bytes	bytes	0	-1	2	0	host	0
6600002	6600000	Hits	hits	0	-1	0	0	host	0
6600003	6600000	Bytes	bytes	0	-1	2	0	host	0
6700002	6700000	Hits	hits	0	-1	0	0	server	0
6700003	6700000	Bytes	bytes	0	-1	2	0	server	0
6110002	6110000	Hits	hits	0	-1	0	0	server	0
6110003	6110000	Bytes	bytes	0	-1	2	0	server	0
6111003	6111000	Hits	hits	0	-1	0	0	host	0
6111004	6111000	Bytes	bytes	0	-1	2	0	host	0
6120002	6120000	Hits	hits	0	-1	0	0	host	0
6120003	6120000	Bytes	bytes	0	-1	2	0	host	0
6121003	6121000	Hits	hits	0	-1	0	0	server	0
6121004	6121000	Bytes	bytes	0	-1	2	0	server	0
6130002	6130000	Hits	hits	0	-1	0	0	username	0
6130003	6130000	Bytes	bytes	0	-1	2	0	username	0
6131003	6131000	Hits	hits	0	-1	0	0	host	0
6131004	6131000	Bytes	bytes	0	-1	2	0	host	0
6210002	6210000	Hits	hits	0	-1	0	0	server	0
6210003	6210000	Bytes	bytes	0	-1	2	0	server	0
6211003	6211000	Hits	hits	0	-1	0	0	host	0
6211004	6211000	Bytes	bytes	0	-1	2	0	host	0
6220002	6220000	Hits	hits	0	-1	0	0	host	0
6220003	6220000	Bytes	bytes	0	-1	2	0	host	0
6221003	6221000	Hits	hits	0	-1	0	0	server	0
6221004	6221000	Bytes	bytes	0	-1	2	0	server	0
6230002	6230000	Hits	hits	0	-1	0	0	username	0
6230003	6230000	Bytes	bytes	0	-1	2	0	username	0
6231003	6231000	Hits	hits	0	-1	0	0	host	0
6231004	6231000	Bytes	bytes	0	-1	2	0	host	0
6310002	6310000	Hits	hits	0	-1	0	0	file	0
6310003	6310000	Bytes	bytes	0	-1	2	0	file	0
6311003	6311000	Hits	hits	0	-1	0	0	server	0
6311004	6311000	Bytes	bytes	0	-1	2	0	server	0
6320002	6320000	Hits	hits	0	-1	0	0	server	0
6320003	6320000	Bytes	bytes	0	-1	2	0	server	0
6321003	6321000	Hits	hits	0	-1	0	0	host	0
6321004	6321000	Bytes	bytes	0	-1	2	0	host	0
6330002	6330000	Hits	hits	0	-1	0	0	host	0
6330003	6330000	Bytes	bytes	0	-1	2	0	host	0
6331003	6331000	Hits	hits	0	-1	0	0	file	0
6331004	6331000	Bytes	bytes	0	-1	2	0	file	0
6410002	6410000	Hits	hits	0	-1	0	0	file	0
6410003	6410000	Bytes	bytes	0	-1	2	0	file	0
6420002	6420000	Hits	hits	0	-1	0	0	server	0
6420003	6420000	Bytes	bytes	0	-1	2	0	server	0
6430002	6430000	Hits	hits	0	-1	0	0	host	0
6521003	6521000	Hits	hits	0	-1	0	0	username	0
6521004	6521000	Bytes	bytes	0	-1	2	0	username	0
6530002	6530000	Hits	hits	0	-1	0	0	username	0
6530003	6530000	Bytes	bytes	0	-1	2	0	username	0
6531003	6531000	Hits	hits	0	-1	0	0	file	0
6531004	6531000	Bytes	bytes	0	-1	2	0	file	0
6610002	6610000	Hits	hits	0	-1	0	0	file	0
6610003	6610000	Bytes	bytes	0	-1	2	0	file	0
6611003	6611000	Hits	hits	0	-1	0	0	server	0
6611004	6611000	Bytes	bytes	0	-1	2	0	server	0
6620002	6620000	Hits	hits	0	-1	0	0	server	0
6620003	6620000	Bytes	bytes	0	-1	2	0	server	0
6621003	6621000	Hits	hits	0	-1	0	0	username	0
6621004	6621000	Bytes	bytes	0	-1	2	0	username	0
6630002	6630000	Hits	hits	0	-1	0	0	username	0
6630003	6630000	Bytes	bytes	0	-1	2	0	username	0
6631003	6631000	Hits	hits	0	-1	0	0	file	0
6631004	6631000	Bytes	bytes	0	-1	2	0	file	0
6710002	6710000	Hits	hits	0	-1	0	0	file	0
6710003	6710000	Bytes	bytes	0	-1	2	0	file	0
6711003	6711000	Hits	hits	0	-1	0	0	host	0
6711004	6711000	Bytes	bytes	0	-1	2	0	host	0
6720002	6720000	Hits	hits	0	-1	0	0	file	0
6720003	6720000	Bytes	bytes	0	-1	2	0	file	0
6721003	6721000	Hits	hits	0	-1	0	0	host	0
6721004	6721000	Bytes	bytes	0	-1	2	0	host	0
6730002	6730000	Hits	hits	0	-1	0	0	username	0
6730003	6730000	Bytes	bytes	0	-1	2	0	username	0
6731002	6731000	Hits	hits	0	-1	0	0	file	0
6731003	6731000	Bytes	bytes	0	-1	2	0	file	0
6732002	6732000	Hits	hits	0	-1	0	0	file	0
6732003	6732000	Bytes	bytes	0	-1	2	0	file	0
6740002	6740000	Hits	hits	0	-1	0	0	host	0
6740003	6740000	Bytes	bytes	0	-1	2	0	host	0
6741002	6741000	Hits	hits	0	-1	0	0	file	0
6741003	6741000	Bytes	bytes	0	-1	2	0	file	0
6742002	6742000	Hits	hits	0	-1	0	0	file	0
6742003	6742000	Bytes	bytes	0	-1	2	0	file	0
1010001	1010000	Recipient	recipient	0	1010000	0	0	recipient	1
1011001	1011000	Sender	sender	0	1011000	0	0	sender	1
1011101	1011100	Subject	subject	0	-1	0	0		1
1011102	1011100	User	username	0	-1	0	0		1
1011103	1011100	Host	host	0	-1	5	0		1
1010002	1010000	Hits	hits	0	-1	0	0	recipient	0
1011002	1011000	Hits	hits	0	-1	0	0	sender	0
1012002	1012000	Hits	hits	0	-1	0	0	host	0
1013002	1013000	Hits	hits	0	-1	0	0	destination	0
1014002	1014000	Hits	hits	0	-1	0	0	username	0
1015002	1015000	Hits	hits	0	-1	0	0	application	0
1020002	1020000	Hits	hits	0	-1	0	0	sender	0
1021002	1021000	Hits	hits	0	-1	0	0	recipient	0
1022002	1022000	Hits	hits	0	-1	0	0	host	0
1015106	1015100	Count	size	0	-1	0	0		0
1023002	1023000	Hits	hits	0	-1	0	0	destination	0
1024002	1024000	Hits	hits	0	-1	0	0	username	0
1011106	1011100	Count	size	0	-1	0	0		0
1012106	1012100	Count	size	0	-1	0	0		0
1011104	1011100	Destination	destination	0	-1	5	0		1
1024105	1024100	Application	application	0	-1	6	0		1
1025001	1025000	Application	application	0	1025000	6	0	application	1
1030001	1030000	Application	application	0	1030000	6	0	application	1
1025002	1025000	Hits	hits	0	-1	0	0	application	0
1030002	1030000	Hits	hits	0	-1	0	0	application	0
1031002	1031000	Hits	hits	0	-1	0	0	sender	0
1032002	1032000	Hits	hits	0	-1	0	0	recipient	0
1033002	1033000	Hits	hits	0	-1	0	0	username	0
1034002	1034000	Hits	hits	0	-1	0	0	host	0
1035002	1035000	Hits	hits	0	-1	0	0	destination	0
1024106	1024100	Count	size	0	-1	0	0		0
1025106	1025100	Count	size	0	-1	0	0		0
91000001	91000000	Severity	severity	0	91000000	7	0	severity	1
91000002	91000000	Hits	hits	0	-1	0	0	severity	0
91100001	91100000	Attack	attack	0	91100000	0	0	attack	1
91110004	91110000	Application	application	0	-1	6	0	attacker	1
91210003	91210000	Application	application	0	-1	6	0	attack	1
91100002	91100000	Hits	hits	0	-1	0	0	attack	0
91110006	91110000	Hits	hits	0	-1	0	0	attacker	0
91200002	91200000	Hits	hits	0	-1	0	0	attacker	0
91210005	91210000	Hits	hits	0	-1	0	0	attack	0
91300002	91300000	Hits	hits	0	-1	0	0	victim	0
91310005	91310000	Hits	hits	0	-1	0	0	attack	0
91400002	91400000	Hits	hits	0	-1	0	0	application	0
91410006	91410000	Hits	hits	0	-1	0	0	attack	0
91500002	91500000	Hits	hits	0	-1	0	0	attack	0
91510005	91510000	Hits	hits	0	-1	0	0	attacker	0
91600002	91600000	Hits	hits	0	-1	0	0	attack	0
91610005	91610000	Hits	hits	0	-1	0	0	attacker	0
92200002	92200000	Hits	hits	0	-1	0	0	victim	0
92210004	92210000	Hits	hits	0	-1	0	0	attacker	0
93300002	93300000	Hits	hits	0	-1	0	0	application	0
93310006	93310000	Hits	hits	0	-1	0	0	attack	0
94000002	94000000	Hits	hits	0	-1	0	0	victim	0
94100002	94100000	Hits	hits	0	-1	0	0	attack	0
91110001	91110000	Attacker	attacker	0	-1	5	0	attacker	1
91110002	91110000	Victim	victim	0	-1	5	0	attacker	1
91110003	91110000	User	username	0	-1	0	0	attacker	1
91110005	91110000	Action	action	0	-1	0	0	attacker	1
91200001	91200000	Attacker	attacker	0	91200000	5	0	attacker	1
91210001	91210000	Attack	attack	0	-1	0	0	attack	1
91210002	91210000	Victim	victim	0	-1	5	0	attack	1
91210004	91210000	Action	action	0	-1	0	0	attack	1
91300001	91300000	Victim	victim	0	91300000	5	0	victim	1
91310001	91310000	Attack	attack	0	-1	0	0	attack	1
94110006	94110000	Hits	hits	0	-1	0	0	attacker	0
94200002	94200000	Hits	hits	0	-1	0	0	attacker	0
94210006	94210000	Hits	hits	0	-1	0	0	attack	0
94300002	94300000	Hits	hits	0	-1	0	0	application	0
94310006	94310000	Hits	hits	0	-1	0	0	attack	0
97000002	97000000	Hits	hits	0	-1	0	0	application	0
97100002	97100000	Hits	hits	0	-1	0	0	attack	0
97110006	97110000	Hits	hits	0	-1	0	0	attacker	0
97200002	97200000	Hits	hits	0	-1	0	0	attacker	0
97210005	97210000	Hits	hits	0	-1	0	0	attack	0
97300002	97300000	Hits	hits	0	-1	0	0	victim	0
97310005	97310000	Hits	hits	0	-1	0	0	attack	0
97400002	97400000	Hits	hits	0	-1	0	0	attack	0
97410005	97410000	Hits	hits	0	-1	0	0	attacker	0
97500002	97500000	Hits	hits	0	-1	0	0	attack	0
97510005	97510000	Hits	hits	0	-1	0	0	attacker	0
92000002	92000000	Hits	hits	0	-1	0	0	attack	0
92100002	92100000	Hits	hits	0	-1	0	0	attacker	0
92110004	92110000	Hits	hits	0	-1	0	0	victim	0
11411116	11411110	Count	hits	0	-1	0	0	subject	0
11411216	11411210	Count	hits	0	-1	0	0	recipient	0
11411316	11411310	Count	hits	0	-1	0	0	recipient	0
11411416	11411410	Count	hits	0	-1	0	0	recipient	0
11411516	11411510	Count	hits	0	-1	0	0	recipient	0
11412116	11412110	Count	hits	0	-1	0	0	subject	0
11412216	11412210	Count	hits	0	-1	0	0	sender	0
11412316	11412310	Count	hits	0	-1	0	0	sender	0
11412416	11412410	Count	hits	0	-1	0	0	sender	0
11412516	11412510	Count	hits	0	-1	0	0	sender	0
11413116	11413110	Count	hits	0	-1	0	0	recipient	0
11413216	11413210	Count	hits	0	-1	0	0	sender	0
11413316	11413310	Count	hits	0	-1	0	0	sender	0
11413416	11413410	Count	hits	0	-1	0	0	sender	0
11413516	11413510	Count	hits	0	-1	0	0	sender	0
11414116	11414110	Count	hits	0	-1	0	0	recipient	0
11414216	11414210	Count	hits	0	-1	0	0	sender	0
11414316	11414310	Count	hits	0	-1	0	0	sender	0
11414416	11414410	Count	hits	0	-1	0	0	sender	0
11414516	11414510	Count	hits	0	-1	0	0	sender	0
11415116	11415110	Count	hits	0	-1	0	0	recipient	0
11415216	11415210	Count	hits	0	-1	0	0	sender	0
11415316	11415310	Count	hits	0	-1	0	0	sender	0
11415416	11415410	Count	hits	0	-1	0	0	sender	0
525106	525100	Size	size	0	-1	2	0		0
65	21	Bytes	bytes	0	-1	2	2	proto_group	0
67	22	Hits	hits	0	-1	0	2	srcip	0
68	22	Bytes	bytes	0	-1	2	2	srcip	0
70	23	Hits	hits	0	-1	0	2	srcip	0
71	23	Bytes	bytes	0	-1	2	2	srcip	0
73	24	Hits	hits	0	-1	0	2	srcip	0
74	24	Bytes	bytes	0	-1	2	2	srcip	0
75	25	Rule Id	ruleid	0	8	0	1	ruleid	0
76	25	Hits	hits	0	-1	0	2	ruleid	0
77	25	Bytes	bytes	0	-1	2	2	ruleid	0
79	26	Hits	hits	0	-1	0	0	proto_group	0
80	26	Bytes	bytes	0	-1	2	0	proto_group	0
82	27	Hits	hits	0	-1	0	0	destip	0
83	27	Bytes	bytes	0	-1	2	0	destip	0
85	28	Hits	hits	0	-1	0	0	username	0
86	28	Bytes	bytes	0	-1	2	0	username	0
87	29	Rule Id	ruleid	0	-1	0	0	ruleid	0
88	29	Hits	hits	0	-1	0	0	ruleid	0
89	29	Bytes	bytes	0	-1	2	0	ruleid	0
91	30	Hits	hits	0	-1	0	0	proto_group	0
92	30	Bytes	bytes	0	-1	2	0	proto_group	0
94	31	Hits	hits	0	-1	0	0	proto_group	0
95	31	Bytes	bytes	0	-1	2	0	proto_group	0
97	32	Hits	hits	0	-1	0	0	destip	0
98	32	Bytes	bytes	0	-1	2	0	destip	0
100	33	Hits	hits	0	-1	0	0	destip	0
101	33	Bytes	bytes	0	-1	2	0	destip	0
103	34	Hits	hits	0	-1	0	0	username	0
132012	132010	Hits	hits	0	-1	0	0	application	0
132013	132010	Bytes	bytes	0	-1	2	0	application	0
132022	132020	Hits	hits	0	-1	0	0	destip	0
132023	132020	Bytes	bytes	0	-1	2	0	destip	0
142012	142010	Hits	hits	0	-1	0	0	destip	0
142013	142010	Bytes	bytes	0	-1	2	0	destip	0
142112	142110	Hits	hits	0	-1	0	0	application	0
142113	142110	Bytes	bytes	0	-1	2	0	application	0
134012	134010	Hits	hits	0	-1	0	0	application	0
134013	134010	Bytes	bytes	0	-1	2	0	application	0
134022	134020	Hits	hits	0	-1	0	0	destip	0
134023	134020	Bytes	bytes	0	-1	2	0	destip	0
134032	134030	Hits	hits	0	-1	0	0	username	0
134033	134030	Bytes	bytes	0	-1	2	0	username	0
144012	144010	Hits	hits	0	-1	0	0	destip	0
144013	144010	Bytes	bytes	0	-1	2	0	destip	0
144112	144110	Hits	hits	0	-1	0	0	application	0
144113	144110	Bytes	bytes	0	-1	2	0	application	0
144212	144210	Hits	hits	0	-1	0	0	application	0
144213	144210	Bytes	bytes	0	-1	2	0	application	0
154212	154210	Hits	hits	0	-1	0	0	destip	0
154213	154210	Bytes	bytes	0	-1	2	0	destip	0
135012	135010	Hits	hits	0	-1	0	0	application	0
135013	135010	Bytes	bytes	0	-1	2	0	application	0
135022	135020	Hits	hits	0	-1	0	0	destip	0
135023	135020	Bytes	bytes	0	-1	2	0	destip	0
135032	135030	Hits	hits	0	-1	0	0	username	0
135033	135030	Bytes	bytes	0	-1	2	0	username	0
145012	145010	Hits	hits	0	-1	0	0	destip	0
145013	145010	Bytes	bytes	0	-1	2	0	destip	0
145112	145110	Hits	hits	0	-1	0	0	application	0
145113	145110	Bytes	bytes	0	-1	2	0	application	0
145212	145210	Hits	hits	0	-1	0	0	application	0
145213	145210	Bytes	bytes	0	-1	2	0	application	0
155212	155210	Hits	hits	0	-1	0	0	destip	0
155213	155210	Bytes	bytes	0	-1	2	0	destip	0
136012	136010	Hits	hits	0	-1	0	0	application	0
149113	149110	Bytes	bytes	0	-1	2	0	application	0
1430012	1430010	Hits	hits	0	-1	0	0	application	0
1430013	1430010	Bytes	bytes	0	-1	2	0	application	0
1430022	1430020	Hits	hits	0	-1	0	0	destip	0
1430023	1430020	Bytes	bytes	0	-1	2	0	destip	0
1430032	1430030	Hits	hits	0	-1	0	0	srcip	0
1430033	1430030	Bytes	bytes	0	-1	2	0	srcip	0
1440012	1440010	Hits	hits	0	-1	0	0	destip	0
1440013	1440010	Bytes	bytes	0	-1	2	0	destip	0
1440112	1440110	Hits	hits	0	-1	0	0	application	0
1440113	1440110	Bytes	bytes	0	-1	2	0	application	0
1440212	1440210	Hits	hits	0	-1	0	0	application	0
1440213	1440210	Bytes	bytes	0	-1	2	0	application	0
1450012	1450010	Hits	hits	0	-1	0	0	destip	0
1450013	1450010	Bytes	bytes	0	-1	2	0	destip	0
1431012	1431010	Hits	hits	0	-1	0	0	application	0
1431013	1431010	Bytes	bytes	0	-1	2	0	application	0
1431022	1431020	Hits	hits	0	-1	0	0	srcip	0
1431023	1431020	Bytes	bytes	0	-1	2	0	srcip	0
1441012	1441010	Hits	hits	0	-1	0	0	srcip	0
1441013	1441010	Bytes	bytes	0	-1	2	0	srcip	0
1441112	1441110	Hits	hits	0	-1	0	0	application	0
1441113	1441110	Bytes	bytes	0	-1	2	0	application	0
1432012	1432010	Hits	hits	0	-1	0	0	application	0
1432013	1432010	Bytes	bytes	0	-1	2	0	application	0
1432022	1432020	Hits	hits	0	-1	0	0	destip	0
1432023	1432020	Bytes	bytes	0	-1	2	0	destip	0
1442012	1442010	Hits	hits	0	-1	0	0	destip	0
1442013	1442010	Bytes	bytes	0	-1	2	0	destip	0
1442112	1442110	Hits	hits	0	-1	0	0	application	0
1442113	1442110	Bytes	bytes	0	-1	2	0	application	0
1434012	1434010	Hits	hits	0	-1	0	0	application	0
1434013	1434010	Bytes	bytes	0	-1	2	0	application	0
1434022	1434020	Hits	hits	0	-1	0	0	destip	0
1434023	1434020	Bytes	bytes	0	-1	2	0	destip	0
1434032	1434030	Hits	hits	0	-1	0	0	srcip	0
1434033	1434030	Bytes	bytes	0	-1	2	0	srcip	0
1437012	1437010	Hits	hits	0	-1	0	0	application	0
1437013	1437010	Bytes	bytes	0	-1	2	0	application	0
1437022	1437020	Hits	hits	0	-1	0	0	srcip	0
1437023	1437020	Bytes	bytes	0	-1	2	0	srcip	0
1447012	1447010	Hits	hits	0	-1	0	0	srcip	0
1447013	1447010	Bytes	bytes	0	-1	2	0	srcip	0
1447112	1447110	Hits	hits	0	-1	0	0	application	0
1447113	1447110	Bytes	bytes	0	-1	2	0	application	0
1438012	1438010	Hits	hits	0	-1	0	0	application	0
1438013	1438010	Bytes	bytes	0	-1	2	0	application	0
1438022	1438020	Hits	hits	0	-1	0	0	destip	0
1438023	1438020	Bytes	bytes	0	-1	2	0	destip	0
1448012	1448010	Hits	hits	0	-1	0	0	destip	0
1448013	1448010	Bytes	bytes	0	-1	2	0	destip	0
1448112	1448110	Hits	hits	0	-1	0	0	application	0
1448113	1448110	Bytes	bytes	0	-1	2	0	application	0
1439012	1439010	Hits	hits	0	-1	0	0	application	0
1439013	1439010	Bytes	bytes	0	-1	2	0	application	0
1439022	1439020	Hits	hits	0	-1	0	0	destip	0
1439023	1439020	Bytes	bytes	0	-1	2	0	destip	0
1449012	1449010	Hits	hits	0	-1	0	0	destip	0
1449013	1449010	Bytes	bytes	0	-1	2	0	destip	0
1449112	1449110	Hits	hits	0	-1	0	0	application	0
1449113	1449110	Bytes	bytes	0	-1	2	0	application	0
1530012	1530010	Hits	hits	0	-1	0	0	username	0
1530013	1530010	Bytes	bytes	0	-1	2	0	username	0
1530022	1530020	Hits	hits	0	-1	0	0	destip	0
1530023	1530020	Bytes	bytes	0	-1	2	0	destip	0
1530032	1530030	Hits	hits	0	-1	0	0	srcip	0
1530033	1530030	Bytes	bytes	0	-1	2	0	srcip	0
1540012	1540010	Hits	hits	0	-1	0	0	destip	0
1540013	1540010	Bytes	bytes	0	-1	2	0	destip	0
1540022	1540020	Hits	hits	0	-1	0	0	srcip	0
1540023	1540020	Bytes	bytes	0	-1	2	0	srcip	0
1540112	1540110	Hits	hits	0	-1	0	0	username	0
1540113	1540110	Bytes	bytes	0	-1	2	0	username	0
1540122	1540120	Hits	hits	0	-1	0	0	srcip	0
1532032	1532030	Hits	hits	0	-1	0	0	srcip	0
1532033	1532030	Bytes	bytes	0	-1	2	0	srcip	0
1542012	1542010	Hits	hits	0	-1	0	0	username	0
1542013	1542010	Bytes	bytes	0	-1	2	0	username	0
1542022	1542020	Hits	hits	0	-1	0	0	srcip	0
1542023	1542020	Bytes	bytes	0	-1	2	0	srcip	0
1542112	1542110	Hits	hits	0	-1	0	0	application	0
1542113	1542110	Bytes	bytes	0	-1	2	0	application	0
1542122	1542120	Hits	hits	0	-1	0	0	srcip	0
1542123	1542120	Bytes	bytes	0	-1	2	0	srcip	0
1542212	1542210	Hits	hits	0	-1	0	0	application	0
1542213	1542210	Bytes	bytes	0	-1	2	0	application	0
1542222	1542220	Hits	hits	0	-1	0	0	username	0
1542223	1542220	Bytes	bytes	0	-1	2	0	username	0
1533012	1533010	Hits	hits	0	-1	0	0	application	0
1533013	1533010	Bytes	bytes	0	-1	2	0	application	0
1533022	1533020	Hits	hits	0	-1	0	0	destip	0
1533023	1533020	Bytes	bytes	0	-1	2	0	destip	0
1533032	1533030	Hits	hits	0	-1	0	0	username	0
1533033	1533030	Bytes	bytes	0	-1	2	0	username	0
1543012	1543010	Hits	hits	0	-1	0	0	destip	0
1543013	1543010	Bytes	bytes	0	-1	2	0	destip	0
1543022	1543020	Hits	hits	0	-1	0	0	username	0
1543023	1543020	Bytes	bytes	0	-1	2	0	username	0
1543112	1543110	Hits	hits	0	-1	0	0	application	0
1543113	1543110	Bytes	bytes	0	-1	2	0	application	0
1543122	1543120	Hits	hits	0	-1	0	0	username	0
1543123	1543120	Bytes	bytes	0	-1	2	0	username	0
1543212	1543210	Hits	hits	0	-1	0	0	application	0
1543213	1543210	Bytes	bytes	0	-1	2	0	application	0
1543222	1543220	Hits	hits	0	-1	0	0	destip	0
1543223	1543220	Bytes	bytes	0	-1	2	0	destip	0
1553012	1553010	Hits	hits	0	-1	0	0	destip	0
1553013	1553010	Bytes	bytes	0	-1	2	0	destip	0
1553112	1553110	Hits	hits	0	-1	0	0	application	0
1553113	1553110	Bytes	bytes	0	-1	2	0	application	0
1545212	1545210	Hits	hits	0	-1	0	0	destip	0
1545213	1545210	Bytes	bytes	0	-1	2	0	destip	0
1545222	1545220	Hits	hits	0	-1	0	0	username	0
1545223	1545220	Bytes	bytes	0	-1	2	0	username	0
1536012	1536010	Hits	hits	0	-1	0	0	application	0
1536013	1536010	Bytes	bytes	0	-1	2	0	application	0
1536022	1536020	Hits	hits	0	-1	0	0	destip	0
1536023	1536020	Bytes	bytes	0	-1	2	0	destip	0
1536032	1536030	Hits	hits	0	-1	0	0	srcip	0
1536033	1536030	Bytes	bytes	0	-1	2	0	srcip	0
1546012	1546010	Hits	hits	0	-1	0	0	destip	0
1546013	1546010	Bytes	bytes	0	-1	2	0	destip	0
1546022	1546020	Hits	hits	0	-1	0	0	srcip	0
1546023	1546020	Bytes	bytes	0	-1	2	0	srcip	0
1546112	1546110	Hits	hits	0	-1	0	0	application	0
1546113	1546110	Bytes	bytes	0	-1	2	0	application	0
1546122	1546120	Hits	hits	0	-1	0	0	srcip	0
1546123	1546120	Bytes	bytes	0	-1	2	0	srcip	0
1546212	1546210	Hits	hits	0	-1	0	0	application	0
1546213	1546210	Bytes	bytes	0	-1	2	0	application	0
1546222	1546220	Hits	hits	0	-1	0	0	destip	0
1546223	1546220	Bytes	bytes	0	-1	2	0	destip	0
1556012	1556010	Hits	hits	0	-1	0	0	destip	0
1556013	1556010	Bytes	bytes	0	-1	2	0	destip	0
1556112	1556110	Hits	hits	0	-1	0	0	application	0
1556113	1556110	Bytes	bytes	0	-1	2	0	application	0
1537012	1537010	Hits	hits	0	-1	0	0	application	0
1537013	1537010	Bytes	bytes	0	-1	2	0	application	0
1537022	1537020	Hits	hits	0	-1	0	0	destip	0
1537023	1537020	Bytes	bytes	0	-1	2	0	destip	0
1537032	1537030	Hits	hits	0	-1	0	0	srcip	0
1537033	1537030	Bytes	bytes	0	-1	2	0	srcip	0
1547012	1547010	Hits	hits	0	-1	0	0	destip	0
1547013	1547010	Bytes	bytes	0	-1	2	0	destip	0
1539022	1539020	Hits	hits	0	-1	0	0	username	0
1539023	1539020	Bytes	bytes	0	-1	2	0	username	0
1539032	1539030	Hits	hits	0	-1	0	0	srcip	0
1539033	1539030	Bytes	bytes	0	-1	2	0	srcip	0
1549012	1549010	Hits	hits	0	-1	0	0	username	0
1549013	1549010	Bytes	bytes	0	-1	2	0	username	0
1549022	1549020	Hits	hits	0	-1	0	0	srcip	0
1549023	1549020	Bytes	bytes	0	-1	2	0	srcip	0
1549112	1549110	Hits	hits	0	-1	0	0	application	0
1549113	1549110	Bytes	bytes	0	-1	2	0	application	0
1549122	1549120	Hits	hits	0	-1	0	0	srcip	0
1549123	1549120	Bytes	bytes	0	-1	2	0	srcip	0
1549212	1549210	Hits	hits	0	-1	0	0	application	0
1549213	1549210	Bytes	bytes	0	-1	2	0	application	0
1549222	1549220	Hits	hits	0	-1	0	0	username	0
1549223	1549220	Bytes	bytes	0	-1	2	0	username	0
15310012	15310010	Hits	hits	0	-1	0	0	application	0
15310013	15310010	Bytes	bytes	0	-1	2	0	application	0
15310022	15310020	Hits	hits	0	-1	0	0	destip	0
15310023	15310020	Bytes	bytes	0	-1	2	0	destip	0
15310032	15310030	Hits	hits	0	-1	0	0	username	0
15310033	15310030	Bytes	bytes	0	-1	2	0	username	0
15410012	15410010	Hits	hits	0	-1	0	0	destip	0
15410013	15410010	Bytes	bytes	0	-1	2	0	destip	0
15410022	15410020	Hits	hits	0	-1	0	0	username	0
15410023	15410020	Bytes	bytes	0	-1	2	0	username	0
15410112	15410110	Hits	hits	0	-1	0	0	application	0
15410113	15410110	Bytes	bytes	0	-1	2	0	application	0
15410122	15410120	Hits	hits	0	-1	0	0	username	0
15410123	15410120	Bytes	bytes	0	-1	2	0	username	0
15410212	15410210	Hits	hits	0	-1	0	0	application	0
15410213	15410210	Bytes	bytes	0	-1	2	0	application	0
15410222	15410220	Hits	hits	0	-1	0	0	destip	0
15410223	15410220	Bytes	bytes	0	-1	2	0	destip	0
15510012	15510010	Hits	hits	0	-1	0	0	destip	0
15510013	15510010	Bytes	bytes	0	-1	2	0	destip	0
1420033	1420030	Bytes	bytes	0	-1	2	0	ruleid	0
1420042	1420040	Hits	hits	0	-1	0	0	proto_group	0
1420043	1420040	Bytes	bytes	0	-1	2	0	proto_group	0
1420052	1420050	Hits	hits	0	-1	0	0	proto_group	0
1420053	1420050	Bytes	bytes	0	-1	2	0	proto_group	0
1420062	1420060	Hits	hits	0	-1	0	0	destip	0
1420063	1420060	Bytes	bytes	0	-1	2	0	destip	0
1420072	1420070	Hits	hits	0	-1	0	0	destip	0
1420073	1420070	Bytes	bytes	0	-1	2	0	destip	0
1420082	1420080	Hits	hits	0	-1	0	0	srcip	0
1420083	1420080	Bytes	bytes	0	-1	2	0	srcip	0
1420092	1420090	Hits	hits	0	-1	0	0	srcip	0
1420093	1420090	Bytes	bytes	0	-1	2	0	srcip	0
1520002	1520000	Hits	hits	0	-1	0	0	application	0
1520003	1520000	Bytes	bytes	0	-1	2	0	application	0
1520012	1520010	Hits	hits	0	-1	0	0	username	0
1520013	1520010	Bytes	bytes	0	-1	2	0	username	0
1520022	1520020	Hits	hits	0	-1	0	0	destip	0
1520023	1520020	Bytes	bytes	0	-1	2	0	destip	0
1520032	1520030	Hits	hits	0	-1	0	0	srcip	0
1520033	1520030	Bytes	bytes	0	-1	2	0	srcip	0
1520041	1520040	Rule Id	ruleid	0	-1	0	0	ruleid	0
1520042	1520040	Hits	hits	0	-1	0	0	ruleid	0
1520043	1520040	Bytes	bytes	0	-1	2	0	ruleid	0
1520052	1520050	Hits	hits	0	-1	0	0	application	0
1520053	1520050	Bytes	bytes	0	-1	2	0	application	0
1520062	1520060	Hits	hits	0	-1	0	0	application	0
1520063	1520060	Bytes	bytes	0	-1	2	0	application	0
1520072	1520070	Hits	hits	0	-1	0	0	username	0
1520073	1520070	Bytes	bytes	0	-1	2	0	username	0
1520082	1520080	Hits	hits	0	-1	0	0	username	0
1520083	1520080	Bytes	bytes	0	-1	2	0	username	0
1520092	1520090	Hits	hits	0	-1	0	0	destip	0
1520093	1520090	Bytes	bytes	0	-1	2	0	destip	0
1520102	1520100	Hits	hits	0	-1	0	0	destip	0
1520103	1520100	Bytes	bytes	0	-1	2	0	destip	0
1520112	1520110	Hits	hits	0	-1	0	0	srcip	0
1520113	1520110	Bytes	bytes	0	-1	2	0	srcip	0
20302003	20302000	Bytes	bytes	0	-1	2	0	destip	0
20303002	20303000	Hits	hits	0	-1	0	0	srcip	0
20303003	20303000	Bytes	bytes	0	-1	2	0	srcip	0
20401002	20401000	Hits	hits	0	-1	0	0	application	0
20401003	20401000	Bytes	bytes	0	-1	2	0	application	0
20402002	20402000	Hits	hits	0	-1	0	0	destip	0
20402003	20402000	Bytes	bytes	0	-1	2	0	destip	0
20403002	20403000	Hits	hits	0	-1	0	0	srcip	0
20403003	20403000	Bytes	bytes	0	-1	2	0	srcip	0
20501002	20501000	Hits	hits	0	-1	0	0	application	0
20501003	20501000	Bytes	bytes	0	-1	2	0	application	0
20502002	20502000	Hits	hits	0	-1	0	0	destip	0
20502003	20502000	Bytes	bytes	0	-1	2	0	destip	0
20503002	20503000	Hits	hits	0	-1	0	0	srcip	0
20503003	20503000	Bytes	bytes	0	-1	2	0	srcip	0
20601002	20601000	Hits	hits	0	-1	0	0	application	0
20601003	20601000	Bytes	bytes	0	-1	2	0	application	0
20602002	20602000	Hits	hits	0	-1	0	0	destip	0
20602003	20602000	Bytes	bytes	0	-1	2	0	destip	0
20603002	20603000	Hits	hits	0	-1	0	0	srcip	0
20603003	20603000	Bytes	bytes	0	-1	2	0	srcip	0
20701002	20701000	Hits	hits	0	-1	0	0	application	0
20701003	20701000	Bytes	bytes	0	-1	2	0	application	0
20702002	20702000	Hits	hits	0	-1	0	0	destip	0
20702003	20702000	Bytes	bytes	0	-1	2	0	destip	0
20703002	20703000	Hits	hits	0	-1	0	0	username	0
20703003	20703000	Bytes	bytes	0	-1	2	0	username	0
20801002	20801000	Hits	hits	0	-1	0	0	application	0
20203102	20203100	Hits	hits	0	-1	0	0	destip	0
20203103	20203100	Bytes	bytes	0	-1	2	0	destip	0
20203202	20203200	Hits	hits	0	-1	0	0	username	0
20203203	20203200	Bytes	bytes	0	-1	2	0	username	0
20301102	20301100	Hits	hits	0	-1	0	0	destip	0
20301103	20301100	Bytes	bytes	0	-1	2	0	destip	0
20301202	20301200	Hits	hits	0	-1	0	0	srcip	0
20301203	20301200	Bytes	bytes	0	-1	2	0	srcip	0
20302102	20302100	Hits	hits	0	-1	0	0	username	0
20302103	20302100	Bytes	bytes	0	-1	2	0	username	0
20302202	20302200	Hits	hits	0	-1	0	0	srcip	0
20302203	20302200	Bytes	bytes	0	-1	2	0	srcip	0
20303102	20303100	Hits	hits	0	-1	0	0	destip	0
20303103	20303100	Bytes	bytes	0	-1	2	0	destip	0
20303202	20303200	Hits	hits	0	-1	0	0	username	0
20303203	20303200	Bytes	bytes	0	-1	2	0	username	0
369	119	Rule Id	ruleid	0	19	0	0	ruleid	0
370	119	Hits	hits	0	-1	0	0	ruleid	0
371	119	Bytes	bytes	0	-1	2	0	ruleid	0
372	120	Rule Id	ruleid	0	20	0	0	ruleid	0
373	120	Hits	hits	0	-1	0	0	ruleid	0
376	121	Rule Id	ruleid	0	-1	0	0	proto_group	0
377	121	Hits	hits	0	-1	0	0	proto_group	0
378	121	Bytes	bytes	0	-1	2	0	proto_group	0
380	122	Rule Id	ruleid	0	-1	0	0	proto_group	0
381	122	Hits	hits	0	-1	0	0	proto_group	0
384	123	Rule Id	ruleid	0	-1	0	0	srcip	0
385	123	Hits	hits	0	-1	0	0	srcip	0
386	123	Bytes	bytes	0	-1	2	0	srcip	0
388	124	Rule Id	ruleid	0	-1	0	0	srcip	0
389	124	Hits	hits	0	-1	0	0	srcip	0
392	125	Rule Id	ruleid	0	-1	0	0	destip	0
393	125	Hits	hits	0	-1	0	0	destip	0
394	125	Bytes	bytes	0	-1	2	0	destip	0
396	126	Rule Id	ruleid	0	-1	0	0	destip	0
397	126	Hits	hits	0	-1	0	0	destip	0
403	127	Hits	hits	0	-1	0	0	srcip	0
408	128	Hits	hits	0	-1	0	0	application	0
413	129	Hits	hits	0	-1	0	0	srcip	0
418	130	Hits	hits	0	-1	0	0	srcip	0
422	131	Hits	hits	0	-1	0	0	destip	0
426	132	Hits	hits	0	-1	0	0	destip	0
430	133	Hits	hits	0	-1	0	0	srcip	0
434	134	Hits	hits	0	-1	0	0	srcip	0
436	1201010	Hits	hits	0	-1	0	0	proto_group	0
437	1201010	Bytes	bytes	0	-1	2	0	proto_group	0
10032	1003	Bytes	field2	0	-1	2	1	field1	0
10042	1004	Hits	field2	0	-1	0	1	field1	0
10072	1007	Bytes	field2	0	-1	2	1	field1	0
10082	1008	Hits	field2	0	-1	0	1	field1	0
10092	1009	Hits	field2	0	-1	0	1	field1	0
10102	1010	Hits	field2	0	-1	0	1	field1	0
10112	1011	Hits	field2	0	-1	0	1	field1	0
4555112	4555110	Hits	hits	0	-1	0	0	domain	0
4555113	4555110	Bytes	bytes	0	-1	2	0	domain	0
45551112	45551110	Hits	hits	0	-1	0	0	url	0
45551113	45551110	Bytes	bytes	0	-1	2	0	url	0
4555202	4555200	Hits	hits	0	-1	0	0	content	0
4555203	4555200	Bytes	bytes	0	-1	2	0	content	0
46120002	46120000	Hits	hits	0	-1	0	0	username	0
46120003	46120000	Bytes	bytes	0	-1	2	0	username	0
46121002	46121000	Hits	hits	0	-1	0	0	domain	0
46121003	46121000	Bytes	bytes	0	-1	2	0	domain	0
46121102	46121100	Hits	hits	0	-1	0	0	url	0
46121103	46121100	Bytes	bytes	0	-1	2	0	url	0
46122002	46122000	Hits	hits	0	-1	0	0	content	0
46122003	46122000	Bytes	bytes	0	-1	2	0	content	0
46122102	46122100	Hits	hits	0	-1	0	0	domain	0
46122103	46122100	Bytes	bytes	0	-1	2	0	domain	0
46122112	46122110	Hits	hits	0	-1	0	0	url	0
46122113	46122110	Bytes	bytes	0	-1	2	0	url	0
46130002	46130000	Hits	hits	0	-1	0	0	content	0
46130003	46130000	Bytes	bytes	0	-1	2	0	content	0
46131002	46131000	Hits	hits	0	-1	0	0	username	0
46131003	46131000	Bytes	bytes	0	-1	2	0	username	0
46131102	46131100	Hits	hits	0	-1	0	0	domain	0
46131103	46131100	Bytes	bytes	0	-1	2	0	domain	0
46131112	46131110	Hits	hits	0	-1	0	0	url	0
46131113	46131110	Bytes	bytes	0	-1	2	0	url	0
46132002	46132000	Hits	hits	0	-1	0	0	domain	0
46132003	46132000	Bytes	bytes	0	-1	2	0	domain	0
46132102	46132100	Hits	hits	0	-1	0	0	username	0
46132103	46132100	Bytes	bytes	0	-1	2	0	username	0
46200002	46200000	Hits	hits	0	-1	0	0	domain	0
46421103	46421100	Bytes	bytes	0	-1	2	0	url	0
46422002	46422000	Hits	hits	0	-1	0	0	category	0
46422003	46422000	Bytes	bytes	0	-1	2	0	category	0
46422102	46422100	Hits	hits	0	-1	0	0	domain	0
46422103	46422100	Bytes	bytes	0	-1	2	0	domain	0
46422112	46422110	Hits	hits	0	-1	0	0	url	0
46422113	46422110	Bytes	bytes	0	-1	2	0	url	0
46430002	46430000	Hits	hits	0	-1	0	0	category	0
46430003	46430000	Bytes	bytes	0	-1	2	0	category	0
46431002	46431000	Hits	hits	0	-1	0	0	username	0
46431003	46431000	Bytes	bytes	0	-1	2	0	username	0
46431102	46431100	Hits	hits	0	-1	0	0	domain	0
46431103	46431100	Bytes	bytes	0	-1	2	0	domain	0
46431112	46431110	Hits	hits	0	-1	0	0	url	0
46431113	46431110	Bytes	bytes	0	-1	2	0	url	0
46432002	46432000	Hits	hits	0	-1	0	0	domain	0
46432003	46432000	Bytes	bytes	0	-1	2	0	domain	0
46432102	46432100	Hits	hits	0	-1	0	0	url	0
46432103	46432100	Bytes	bytes	0	-1	2	0	url	0
41100002	41100000	Hits	hits	0	-1	0	0	category	0
41100003	41100000	Bytes	bytes	0	-1	2	0	category	0
41200002	41200000	Hits	hits	0	-1	0	0	domain	0
41200003	41200000	Bytes	bytes	0	-1	2	0	domain	0
41300002	41300000	Hits	hits	0	-1	0	0	content	0
41552102	41552100	Hits	hits	0	-1	0	0	domain	0
41552103	41552100	Bytes	bytes	0	-1	2	0	domain	0
41552112	41552110	Hits	hits	0	-1	0	0	url	0
41552113	41552110	Bytes	bytes	0	-1	2	0	url	0
41610002	41610000	Hits	hits	0	-1	0	0	category	0
41610003	41610000	Bytes	bytes	0	-1	2	0	category	0
41620002	41620000	Hits	hits	0	-1	0	0	content	0
41620003	41620000	Bytes	bytes	0	-1	2	0	content	0
41611002	41611000	Hits	hits	0	-1	0	0	domain	0
41611003	41611000	Bytes	bytes	0	-1	2	0	domain	0
41611102	41611100	Hits	hits	0	-1	0	0	url	0
41611103	41611100	Bytes	bytes	0	-1	2	0	url	0
41621002	41621000	Hits	hits	0	-1	0	0	domain	0
41621003	41621000	Bytes	bytes	0	-1	2	0	domain	0
41621102	41621100	Hits	hits	0	-1	0	0	url	0
41621103	41621100	Bytes	bytes	0	-1	2	0	url	0
42000002	42000000	Hits	hits	0	-1	0	0	category	0
42000003	42000000	Bytes	bytes	0	-1	2	0	category	0
42100002	42100000	Hits	hits	0	-1	0	0	domain	0
42100003	42100000	Bytes	bytes	0	-1	2	0	domain	0
42200002	42200000	Hits	hits	0	-1	0	0	username	0
42200003	42200000	Bytes	bytes	0	-1	2	0	username	0
42300002	42300000	Hits	hits	0	-1	0	0	content	0
42300003	42300000	Bytes	bytes	0	-1	2	0	content	0
42110002	42110000	Hits	hits	0	-1	0	0	username	0
42110003	42110000	Bytes	bytes	0	-1	2	0	username	0
104	34	Bytes	bytes	0	-1	2	0	username	0
106	35	Hits	hits	0	-1	0	0	username	0
107	35	Bytes	bytes	0	-1	2	0	username	0
215	59	Count	hits	0	-1	0	0	srcip	0
130012	130010	Hits	hits	0	-1	0	0	application	0
130013	130010	Bytes	bytes	0	-1	2	0	application	0
130022	130020	Hits	hits	0	-1	0	0	destip	0
130023	130020	Bytes	bytes	0	-1	2	0	destip	0
130032	130030	Hits	hits	0	-1	0	0	username	0
130033	130030	Bytes	bytes	0	-1	2	0	username	0
140012	140010	Hits	hits	0	-1	0	0	destip	0
140013	140010	Bytes	bytes	0	-1	2	0	destip	0
140112	140110	Hits	hits	0	-1	0	0	application	0
140113	140110	Bytes	bytes	0	-1	2	0	application	0
140212	140210	Hits	hits	0	-1	0	0	application	0
140213	140210	Bytes	bytes	0	-1	2	0	application	0
150212	150210	Hits	hits	0	-1	0	0	destip	0
150213	150210	Bytes	bytes	0	-1	2	0	destip	0
131012	131010	Hits	hits	0	-1	0	0	application	0
131013	131010	Bytes	bytes	0	-1	2	0	application	0
131022	131020	Hits	hits	0	-1	0	0	username	0
131023	131020	Bytes	bytes	0	-1	2	0	username	0
141012	141010	Hits	hits	0	-1	0	0	username	0
141013	141010	Bytes	bytes	0	-1	2	0	username	0
141112	141110	Hits	hits	0	-1	0	0	application	0
141113	141110	Bytes	bytes	0	-1	2	0	application	0
136013	136010	Bytes	bytes	0	-1	2	0	application	0
136022	136020	Hits	hits	0	-1	0	0	username	0
136023	136020	Bytes	bytes	0	-1	2	0	username	0
146012	146010	Hits	hits	0	-1	0	0	username	0
146013	146010	Bytes	bytes	0	-1	2	0	username	0
146112	146110	Hits	hits	0	-1	0	0	application	0
146113	146110	Bytes	bytes	0	-1	2	0	application	0
137012	137010	Hits	hits	0	-1	0	0	application	0
137013	137010	Bytes	bytes	0	-1	2	0	application	0
137022	137020	Hits	hits	0	-1	0	0	username	0
137023	137020	Bytes	bytes	0	-1	2	0	username	0
147012	147010	Hits	hits	0	-1	0	0	username	0
147013	147010	Bytes	bytes	0	-1	2	0	username	0
147112	147110	Hits	hits	0	-1	0	0	application	0
147113	147110	Bytes	bytes	0	-1	2	0	application	0
138012	138010	Hits	hits	0	-1	0	0	application	0
138013	138010	Bytes	bytes	0	-1	2	0	application	0
138022	138020	Hits	hits	0	-1	0	0	destip	0
138023	138020	Bytes	bytes	0	-1	2	0	destip	0
148012	148010	Hits	hits	0	-1	0	0	destip	0
148013	148010	Bytes	bytes	0	-1	2	0	destip	0
148112	148110	Hits	hits	0	-1	0	0	application	0
148113	148110	Bytes	bytes	0	-1	2	0	application	0
139012	139010	Hits	hits	0	-1	0	0	application	0
139013	139010	Bytes	bytes	0	-1	2	0	application	0
139022	139020	Hits	hits	0	-1	0	0	destip	0
139023	139020	Bytes	bytes	0	-1	2	0	destip	0
149012	149010	Hits	hits	0	-1	0	0	destip	0
149013	149010	Bytes	bytes	0	-1	2	0	destip	0
149112	149110	Hits	hits	0	-1	0	0	application	0
1444012	1444010	Hits	hits	0	-1	0	0	destip	0
1444013	1444010	Bytes	bytes	0	-1	2	0	destip	0
1444112	1444110	Hits	hits	0	-1	0	0	application	0
1444113	1444110	Bytes	bytes	0	-1	2	0	application	0
1444212	1444210	Hits	hits	0	-1	0	0	application	0
1444213	1444210	Bytes	bytes	0	-1	2	0	application	0
1454012	1454010	Hits	hits	0	-1	0	0	destip	0
1454013	1454010	Bytes	bytes	0	-1	2	0	destip	0
1435012	1435010	Hits	hits	0	-1	0	0	application	0
1435013	1435010	Bytes	bytes	0	-1	2	0	application	0
1435022	1435020	Hits	hits	0	-1	0	0	destip	0
1435023	1435020	Bytes	bytes	0	-1	2	0	destip	0
1435032	1435030	Hits	hits	0	-1	0	0	srcip	0
1435033	1435030	Bytes	bytes	0	-1	2	0	srcip	0
1445012	1445010	Hits	hits	0	-1	0	0	destip	0
1445013	1445010	Bytes	bytes	0	-1	2	0	destip	0
1445112	1445110	Hits	hits	0	-1	0	0	application	0
1445113	1445110	Bytes	bytes	0	-1	2	0	application	0
1445212	1445210	Hits	hits	0	-1	0	0	application	0
1445213	1445210	Bytes	bytes	0	-1	2	0	application	0
1455012	1455010	Hits	hits	0	-1	0	0	destip	0
1455013	1455010	Bytes	bytes	0	-1	2	0	destip	0
1436012	1436010	Hits	hits	0	-1	0	0	application	0
1436013	1436010	Bytes	bytes	0	-1	2	0	application	0
1436022	1436020	Hits	hits	0	-1	0	0	srcip	0
1436023	1436020	Bytes	bytes	0	-1	2	0	srcip	0
1446012	1446010	Hits	hits	0	-1	0	0	srcip	0
1446013	1446010	Bytes	bytes	0	-1	2	0	srcip	0
1446112	1446110	Hits	hits	0	-1	0	0	application	0
1446113	1446110	Bytes	bytes	0	-1	2	0	application	0
1540123	1540120	Bytes	bytes	0	-1	2	0	srcip	0
1540212	1540210	Hits	hits	0	-1	0	0	destip	0
1540213	1540210	Bytes	bytes	0	-1	2	0	destip	0
1540222	1540220	Hits	hits	0	-1	0	0	username	0
1540223	1540220	Bytes	bytes	0	-1	2	0	username	0
1531012	1531010	Hits	hits	0	-1	0	0	application	0
1531013	1531010	Bytes	bytes	0	-1	2	0	application	0
1531022	1531020	Hits	hits	0	-1	0	0	destip	0
1531023	1531020	Bytes	bytes	0	-1	2	0	destip	0
1531032	1531030	Hits	hits	0	-1	0	0	srcip	0
1531033	1531030	Bytes	bytes	0	-1	2	0	srcip	0
1541012	1541010	Hits	hits	0	-1	0	0	destip	0
1541013	1541010	Bytes	bytes	0	-1	2	0	destip	0
1541022	1541020	Hits	hits	0	-1	0	0	srcip	0
1541023	1541020	Bytes	bytes	0	-1	2	0	srcip	0
1541112	1541110	Hits	hits	0	-1	0	0	application	0
1541113	1541110	Bytes	bytes	0	-1	2	0	application	0
1541122	1541120	Hits	hits	0	-1	0	0	srcip	0
1541123	1541120	Bytes	bytes	0	-1	2	0	srcip	0
1541212	1541210	Hits	hits	0	-1	0	0	application	0
1541213	1541210	Bytes	bytes	0	-1	2	0	application	0
1541222	1541220	Hits	hits	0	-1	0	0	destip	0
1541223	1541220	Bytes	bytes	0	-1	2	0	destip	0
1551012	1551010	Hits	hits	0	-1	0	0	destip	0
1551013	1551010	Bytes	bytes	0	-1	2	0	destip	0
1551112	1551110	Hits	hits	0	-1	0	0	application	0
1551113	1551110	Bytes	bytes	0	-1	2	0	application	0
1532012	1532010	Hits	hits	0	-1	0	0	application	0
1532013	1532010	Bytes	bytes	0	-1	2	0	application	0
1532022	1532020	Hits	hits	0	-1	0	0	username	0
1532023	1532020	Bytes	bytes	0	-1	2	0	username	0
1534012	1534010	Hits	hits	0	-1	0	0	username	0
1534013	1534010	Bytes	bytes	0	-1	2	0	username	0
1534022	1534020	Hits	hits	0	-1	0	0	destip	0
1534023	1534020	Bytes	bytes	0	-1	2	0	destip	0
1534032	1534030	Hits	hits	0	-1	0	0	srcip	0
1534033	1534030	Bytes	bytes	0	-1	2	0	srcip	0
1544012	1544010	Hits	hits	0	-1	0	0	destip	0
1544013	1544010	Bytes	bytes	0	-1	2	0	destip	0
1544022	1544020	Hits	hits	0	-1	0	0	srcip	0
1544023	1544020	Bytes	bytes	0	-1	2	0	srcip	0
1544112	1544110	Hits	hits	0	-1	0	0	username	0
1544113	1544110	Bytes	bytes	0	-1	2	0	username	0
1544122	1544120	Hits	hits	0	-1	0	0	srcip	0
1544123	1544120	Bytes	bytes	0	-1	2	0	srcip	0
1544212	1544210	Hits	hits	0	-1	0	0	destip	0
1544213	1544210	Bytes	bytes	0	-1	2	0	destip	0
1544222	1544220	Hits	hits	0	-1	0	0	username	0
1544223	1544220	Bytes	bytes	0	-1	2	0	username	0
1535012	1535010	Hits	hits	0	-1	0	0	username	0
1535013	1535010	Bytes	bytes	0	-1	2	0	username	0
1535022	1535020	Hits	hits	0	-1	0	0	destip	0
1535023	1535020	Bytes	bytes	0	-1	2	0	destip	0
1535032	1535030	Hits	hits	0	-1	0	0	srcip	0
1535033	1535030	Bytes	bytes	0	-1	2	0	srcip	0
1545012	1545010	Hits	hits	0	-1	0	0	destip	0
1545013	1545010	Bytes	bytes	0	-1	2	0	destip	0
1545022	1545020	Hits	hits	0	-1	0	0	srcip	0
1545023	1545020	Bytes	bytes	0	-1	2	0	srcip	0
1545112	1545110	Hits	hits	0	-1	0	0	username	0
1545113	1545110	Bytes	bytes	0	-1	2	0	username	0
1545122	1545120	Hits	hits	0	-1	0	0	srcip	0
1545123	1545120	Bytes	bytes	0	-1	2	0	srcip	0
1547022	1547020	Hits	hits	0	-1	0	0	srcip	0
1547023	1547020	Bytes	bytes	0	-1	2	0	srcip	0
1547112	1547110	Hits	hits	0	-1	0	0	application	0
1547113	1547110	Bytes	bytes	0	-1	2	0	application	0
1547122	1547120	Hits	hits	0	-1	0	0	srcip	0
1547123	1547120	Bytes	bytes	0	-1	2	0	srcip	0
1547212	1547210	Hits	hits	0	-1	0	0	application	0
1547213	1547210	Bytes	bytes	0	-1	2	0	application	0
1547222	1547220	Hits	hits	0	-1	0	0	destip	0
1547223	1547220	Bytes	bytes	0	-1	2	0	destip	0
1557012	1557010	Hits	hits	0	-1	0	0	destip	0
1557013	1557010	Bytes	bytes	0	-1	2	0	destip	0
1557112	1557110	Hits	hits	0	-1	0	0	application	0
1557113	1557110	Bytes	bytes	0	-1	2	0	application	0
1538012	1538010	Hits	hits	0	-1	0	0	application	0
1538013	1538010	Bytes	bytes	0	-1	2	0	application	0
1538022	1538020	Hits	hits	0	-1	0	0	username	0
1538023	1538020	Bytes	bytes	0	-1	2	0	username	0
1538032	1538030	Hits	hits	0	-1	0	0	srcip	0
1538033	1538030	Bytes	bytes	0	-1	2	0	srcip	0
1548012	1548010	Hits	hits	0	-1	0	0	username	0
1548013	1548010	Bytes	bytes	0	-1	2	0	username	0
1548022	1548020	Hits	hits	0	-1	0	0	srcip	0
1548023	1548020	Bytes	bytes	0	-1	2	0	srcip	0
1548112	1548110	Hits	hits	0	-1	0	0	application	0
1548113	1548110	Bytes	bytes	0	-1	2	0	application	0
1548122	1548120	Hits	hits	0	-1	0	0	srcip	0
1548123	1548120	Bytes	bytes	0	-1	2	0	srcip	0
1548212	1548210	Hits	hits	0	-1	0	0	application	0
1548213	1548210	Bytes	bytes	0	-1	2	0	application	0
1548222	1548220	Hits	hits	0	-1	0	0	username	0
1548223	1548220	Bytes	bytes	0	-1	2	0	username	0
1539012	1539010	Hits	hits	0	-1	0	0	application	0
1539013	1539010	Bytes	bytes	0	-1	2	0	application	0
15510112	15510110	Hits	hits	0	-1	0	0	application	0
15510113	15510110	Bytes	bytes	0	-1	2	0	application	0
15311012	15311010	Hits	hits	0	-1	0	0	application	0
15311013	15311010	Bytes	bytes	0	-1	2	0	application	0
15311022	15311020	Hits	hits	0	-1	0	0	destip	0
15311023	15311020	Bytes	bytes	0	-1	2	0	destip	0
15311032	15311030	Hits	hits	0	-1	0	0	username	0
15311033	15311030	Bytes	bytes	0	-1	2	0	username	0
15411012	15411010	Hits	hits	0	-1	0	0	destip	0
15411013	15411010	Bytes	bytes	0	-1	2	0	destip	0
15411022	15411020	Hits	hits	0	-1	0	0	username	0
15411023	15411020	Bytes	bytes	0	-1	2	0	username	0
15411112	15411110	Hits	hits	0	-1	0	0	application	0
15411113	15411110	Bytes	bytes	0	-1	2	0	application	0
15411122	15411120	Hits	hits	0	-1	0	0	username	0
15411123	15411120	Bytes	bytes	0	-1	2	0	username	0
15411212	15411210	Hits	hits	0	-1	0	0	application	0
15411213	15411210	Bytes	bytes	0	-1	2	0	application	0
15411222	15411220	Hits	hits	0	-1	0	0	destip	0
15411223	15411220	Bytes	bytes	0	-1	2	0	destip	0
15511012	15511010	Hits	hits	0	-1	0	0	destip	0
15511013	15511010	Bytes	bytes	0	-1	2	0	destip	0
15511112	15511110	Hits	hits	0	-1	0	0	application	0
15511113	15511110	Bytes	bytes	0	-1	2	0	application	0
1420002	1420000	Hits	hits	0	-1	0	0	proto_group	0
1420003	1420000	Bytes	bytes	0	-1	2	0	proto_group	0
1420012	1420010	Hits	hits	0	-1	0	0	destip	0
1420013	1420010	Bytes	bytes	0	-1	2	0	destip	0
1420022	1420020	Hits	hits	0	-1	0	0	srcip	0
1420023	1420020	Bytes	bytes	0	-1	2	0	srcip	0
1420031	1420030	Rule Id	ruleid	0	-1	0	0	ruleid	0
1420032	1420030	Hits	hits	0	-1	0	0	ruleid	0
20100002	20100000	Hits	hits	0	-1	0	0	application	0
20100003	20100000	Bytes	bytes	0	-1	2	0	application	0
20200002	20200000	Hits	hits	0	-1	0	0	application	0
20200003	20200000	Bytes	bytes	0	-1	2	0	application	0
20300002	20300000	Hits	hits	0	-1	0	0	application	0
20300003	20300000	Bytes	bytes	0	-1	2	0	application	0
20400003	20400000	Hits	hits	0	-1	0	0	username	0
20400004	20400000	Bytes	bytes	0	-1	2	0	username	0
20500003	20500000	Hits	hits	0	-1	0	0	username	0
20500004	20500000	Bytes	bytes	0	-1	2	0	username	0
20600003	20600000	Hits	hits	0	-1	0	0	username	0
20600004	20600000	Bytes	bytes	0	-1	2	0	username	0
20700003	20700000	Hits	hits	0	-1	0	0	srcip	0
20700004	20700000	Bytes	bytes	0	-1	2	0	srcip	0
20800003	20800000	Hits	hits	0	-1	0	0	srcip	0
20800004	20800000	Bytes	bytes	0	-1	2	0	srcip	0
20900003	20900000	Hits	hits	0	-1	0	0	srcip	0
20900004	20900000	Bytes	bytes	0	-1	2	0	srcip	0
4431003	4431000	Bytes	bytes	0	-1	2	0	username	0
4432002	4432000	Hits	hits	0	-1	0	0	domain	0
4432003	4432000	Bytes	bytes	0	-1	2	0	domain	0
4431102	4431100	Hits	hits	0	-1	0	0	domain	0
4431103	4431100	Bytes	bytes	0	-1	2	0	domain	0
4431112	4431110	Hits	hits	0	-1	0	0	url	0
4431113	4431110	Bytes	bytes	0	-1	2	0	url	0
4432102	4432100	Hits	hits	0	-1	0	0	url	0
4432103	4432100	Bytes	bytes	0	-1	2	0	url	0
4500002	4500000	Hits	hits	0	-1	0	0	host	0
4500003	4500000	Bytes	bytes	0	-1	2	0	host	0
4510002	4510000	Hits	hits	0	-1	0	0	category	0
4510003	4510000	Bytes	bytes	0	-1	2	0	category	0
4511002	4511000	Hits	hits	0	-1	0	0	domain	0
4511003	4511000	Bytes	bytes	0	-1	2	0	domain	0
4511102	4511100	Hits	hits	0	-1	0	0	url	0
4511103	4511100	Bytes	bytes	0	-1	2	0	url	0
4520002	4520000	Hits	hits	0	-1	0	0	domain	0
4520003	4520000	Bytes	bytes	0	-1	2	0	domain	0
4521002	4521000	Hits	hits	0	-1	0	0	url	0
4521003	4521000	Bytes	bytes	0	-1	2	0	url	0
4530002	4530000	Hits	hits	0	-1	0	0	content	0
4555212	4555210	Hits	hits	0	-1	0	0	domain	0
4555213	4555210	Bytes	bytes	0	-1	2	0	domain	0
45552112	45552110	Hits	hits	0	-1	0	0	url	0
45552113	45552110	Bytes	bytes	0	-1	2	0	url	0
4560002	4560000	Hits	hits	0	-1	0	0	application	0
4560003	4560000	Bytes	bytes	0	-1	2	0	application	0
4561002	4561000	Hits	hits	0	-1	0	0	category	0
4561003	4561000	Bytes	bytes	0	-1	2	0	category	0
4561102	4561100	Hits	hits	0	-1	0	0	domain	0
4561103	4561100	Bytes	bytes	0	-1	2	0	domain	0
4561112	4561110	Hits	hits	0	-1	0	0	url	0
4561113	4561110	Bytes	bytes	0	-1	2	0	url	0
4562002	4562000	Hits	hits	0	-1	0	0	content	0
4562003	4562000	Bytes	bytes	0	-1	2	0	content	0
4562102	4562100	Hits	hits	0	-1	0	0	domain	0
4562103	4562100	Bytes	bytes	0	-1	2	0	domain	0
4562112	4562110	Hits	hits	0	-1	0	0	url	0
4562113	4562110	Bytes	bytes	0	-1	2	0	url	0
46000002	46000000	Hits	hits	0	-1	0	0	application	0
46000003	46000000	Bytes	bytes	0	-1	2	0	application	0
46100002	46100000	Hits	hits	0	-1	0	0	category	0
46100003	46100000	Bytes	bytes	0	-1	2	0	category	0
46110002	46110000	Hits	hits	0	-1	0	0	domain	0
46110003	46110000	Bytes	bytes	0	-1	2	0	domain	0
46111002	46111000	Hits	hits	0	-1	0	0	username	0
46111003	46111000	Bytes	bytes	0	-1	2	0	username	0
46111102	46111100	Hits	hits	0	-1	0	0	url	0
46111103	46111100	Bytes	bytes	0	-1	2	0	url	0
46112002	46112000	Hits	hits	0	-1	0	0	content	0
46112003	46112000	Bytes	bytes	0	-1	2	0	content	0
46112102	46112100	Hits	hits	0	-1	0	0	username	0
46112103	46112100	Bytes	bytes	0	-1	2	0	username	0
46112112	46112110	Hits	hits	0	-1	0	0	url	0
46112113	46112110	Bytes	bytes	0	-1	2	0	url	0
46200003	46200000	Bytes	bytes	0	-1	2	0	domain	0
46210002	46210000	Hits	hits	0	-1	0	0	username	0
46210003	46210000	Bytes	bytes	0	-1	2	0	username	0
46211002	46211000	Hits	hits	0	-1	0	0	url	0
46211003	46211000	Bytes	bytes	0	-1	2	0	url	0
46220002	46220000	Hits	hits	0	-1	0	0	content	0
46220003	46220000	Bytes	bytes	0	-1	2	0	content	0
46221102	46221100	Hits	hits	0	-1	0	0	url	0
46221103	46221100	Bytes	bytes	0	-1	2	0	url	0
46300002	46300000	Hits	hits	0	-1	0	0	username	0
46300003	46300000	Bytes	bytes	0	-1	2	0	username	0
46310002	46310000	Hits	hits	0	-1	0	0	category	0
46310003	46310000	Bytes	bytes	0	-1	2	0	category	0
46320002	46320000	Hits	hits	0	-1	0	0	domain	0
46320003	46320000	Bytes	bytes	0	-1	2	0	domain	0
46330002	46330000	Hits	hits	0	-1	0	0	content	0
46330003	46330000	Bytes	bytes	0	-1	2	0	content	0
46340002	46340000	Hits	hits	0	-1	0	0	url	0
46340003	46340000	Bytes	bytes	0	-1	2	0	url	0
46311002	46311000	Hits	hits	0	-1	0	0	domain	0
46311003	46311000	Bytes	bytes	0	-1	2	0	domain	0
46311102	46311100	Hits	hits	0	-1	0	0	url	0
46311103	46311100	Bytes	bytes	0	-1	2	0	url	0
46321002	46321000	Hits	hits	0	-1	0	0	url	0
46321003	46321000	Bytes	bytes	0	-1	2	0	url	0
46331002	46331000	Hits	hits	0	-1	0	0	domain	0
46331003	46331000	Bytes	bytes	0	-1	2	0	domain	0
46331102	46331100	Hits	hits	0	-1	0	0	url	0
46331103	46331100	Bytes	bytes	0	-1	2	0	url	0
46400002	46400000	Hits	hits	0	-1	0	0	content	0
46400003	46400000	Bytes	bytes	0	-1	2	0	content	0
46410002	46410000	Hits	hits	0	-1	0	0	domain	0
46410003	46410000	Bytes	bytes	0	-1	2	0	domain	0
46411002	46411000	Hits	hits	0	-1	0	0	username	0
46411003	46411000	Bytes	bytes	0	-1	2	0	username	0
46411102	46411100	Hits	hits	0	-1	0	0	url	0
46411103	46411100	Bytes	bytes	0	-1	2	0	url	0
46420002	46420000	Hits	hits	0	-1	0	0	username	0
46420003	46420000	Bytes	bytes	0	-1	2	0	username	0
46421002	46421000	Hits	hits	0	-1	0	0	domain	0
46421003	46421000	Bytes	bytes	0	-1	2	0	domain	0
46421102	46421100	Hits	hits	0	-1	0	0	url	0
41300003	41300000	Bytes	bytes	0	-1	2	0	content	0
41400002	41400000	Hits	hits	0	-1	0	0	url	0
41400003	41400000	Bytes	bytes	0	-1	2	0	url	0
41600002	41600000	Hits	hits	0	-1	0	0	application	0
41600003	41600000	Bytes	bytes	0	-1	2	0	application	0
41110002	41110000	Hits	hits	0	-1	0	0	domain	0
41110003	41110000	Bytes	bytes	0	-1	2	0	domain	0
41111002	41111000	Hits	hits	0	-1	0	0	url	0
41111003	41111000	Bytes	bytes	0	-1	2	0	url	0
41210002	41210000	Hits	hits	0	-1	0	0	url	0
41210003	41210000	Bytes	bytes	0	-1	2	0	url	0
41310002	41310000	Hits	hits	0	-1	0	0	domain	0
41310003	41310000	Bytes	bytes	0	-1	2	0	domain	0
41311002	41311000	Hits	hits	0	-1	0	0	url	0
41311003	41311000	Bytes	bytes	0	-1	2	0	url	0
41510002	41510000	Hits	hits	0	-1	0	0	category	0
41510003	41510000	Bytes	bytes	0	-1	2	0	category	0
41520002	41520000	Hits	hits	0	-1	0	0	domain	0
41520003	41520000	Bytes	bytes	0	-1	2	0	domain	0
41530002	41530000	Hits	hits	0	-1	0	0	content	0
41530003	41530000	Bytes	bytes	0	-1	2	0	content	0
41540002	41540000	Hits	hits	0	-1	0	0	url	0
41540003	41540000	Bytes	bytes	0	-1	2	0	url	0
41550002	41550000	Hits	hits	0	-1	0	0	application	0
41550003	41550000	Bytes	bytes	0	-1	2	0	application	0
41511002	41511000	Hits	hits	0	-1	0	0	domain	0
41511003	41511000	Bytes	bytes	0	-1	2	0	domain	0
41511102	41511100	Hits	hits	0	-1	0	0	url	0
41511103	41511100	Bytes	bytes	0	-1	2	0	url	0
41521002	41521000	Hits	hits	0	-1	0	0	url	0
41521003	41521000	Bytes	bytes	0	-1	2	0	url	0
41531002	41531000	Hits	hits	0	-1	0	0	domain	0
41531003	41531000	Bytes	bytes	0	-1	2	0	domain	0
41531102	41531100	Hits	hits	0	-1	0	0	url	0
41531103	41531100	Bytes	bytes	0	-1	2	0	url	0
41551002	41551000	Hits	hits	0	-1	0	0	category	0
41551003	41551000	Bytes	bytes	0	-1	2	0	category	0
41552002	41552000	Hits	hits	0	-1	0	0	content	0
41552003	41552000	Bytes	bytes	0	-1	2	0	content	0
41551102	41551100	Hits	hits	0	-1	0	0	domain	0
41551103	41551100	Bytes	bytes	0	-1	2	0	domain	0
41551112	41551110	Hits	hits	0	-1	0	0	url	0
41551113	41551110	Bytes	bytes	0	-1	2	0	url	0
42111002	42111000	Hits	hits	0	-1	0	0	url	0
42111003	42111000	Bytes	bytes	0	-1	2	0	url	0
42120002	42120000	Hits	hits	0	-1	0	0	content	0
42120003	42120000	Bytes	bytes	0	-1	2	0	content	0
42121002	42121000	Hits	hits	0	-1	0	0	username	0
42121003	42121000	Bytes	bytes	0	-1	2	0	username	0
42121102	42121100	Hits	hits	0	-1	0	0	url	0
42121103	42121100	Bytes	bytes	0	-1	2	0	url	0
42210002	42210000	Hits	hits	0	-1	0	0	domain	0
42210003	42210000	Bytes	bytes	0	-1	2	0	domain	0
42211002	42211000	Hits	hits	0	-1	0	0	url	0
42211003	42211000	Bytes	bytes	0	-1	2	0	url	0
42220002	42220000	Hits	hits	0	-1	0	0	content	0
42220003	42220000	Bytes	bytes	0	-1	2	0	content	0
42221002	42221000	Hits	hits	0	-1	0	0	domain	0
42221003	42221000	Bytes	bytes	0	-1	2	0	domain	0
42221102	42221100	Hits	hits	0	-1	0	0	url	0
42221103	42221100	Bytes	bytes	0	-1	2	0	url	0
42310002	42310000	Hits	hits	0	-1	0	0	username	0
42310003	42310000	Bytes	bytes	0	-1	2	0	username	0
42311002	42311000	Hits	hits	0	-1	0	0	domain	0
42311003	42311000	Bytes	bytes	0	-1	2	0	domain	0
42311102	42311100	Hits	hits	0	-1	0	0	url	0
42311103	42311100	Bytes	bytes	0	-1	2	0	url	0
42320002	42320000	Hits	hits	0	-1	0	0	domain	0
42320003	42320000	Bytes	bytes	0	-1	2	0	domain	0
42321002	42321000	Hits	hits	0	-1	0	0	username	0
42321003	42321000	Bytes	bytes	0	-1	2	0	username	0
7223102	7223100	Hits	hits	0	-1	0	0	application	0
7223112	7223110	Hits	hits	0	-1	0	0	destination	0
7223212	7223210	Hits	hits	0	-1	0	0	application	0
7230002	7230000	Hits	hits	0	-1	0	0	destination	0
7231002	7231000	Hits	hits	0	-1	0	0	application	0
7231102	7231100	Hits	hits	0	-1	0	0	username	0
7231202	7231200	Hits	hits	0	-1	0	0	host	0
7232002	7232000	Hits	hits	0	-1	0	0	username	0
7232102	7232100	Hits	hits	0	-1	0	0	application	0
7232202	7232200	Hits	hits	0	-1	0	0	host	0
7233002	7233000	Hits	hits	0	-1	0	0	host	0
7223202	7223200	Hits	hits	0	-1	0	0	destination	0
7233102	7233100	Hits	hits	0	-1	0	0	application	0
7233202	7233200	Hits	hits	0	-1	0	0	username	0
7240002	7240000	Hits	hits	0	-1	0	0	host	0
7241002	7241000	Hits	hits	0	-1	0	0	application	0
7241102	7241100	Hits	hits	0	-1	0	0	destination	0
7241202	7241200	Hits	hits	0	-1	0	0	username	0
7242002	7242000	Hits	hits	0	-1	0	0	destination	0
7242102	7242100	Hits	hits	0	-1	0	0	application	0
7242202	7242200	Hits	hits	0	-1	0	0	username	0
7243002	7243000	Hits	hits	0	-1	0	0	username	0
7243102	7243100	Hits	hits	0	-1	0	0	application	0
7243112	7243110	Hits	hits	0	-1	0	0	destination	0
7243202	7243200	Hits	hits	0	-1	0	0	destination	0
81110002	81110000	Hits	hits	0	-1	0	0	domain	0
81111002	81111000	Hits	hits	0	-1	0	0	url	0
81210002	81210000	Hits	hits	0	-1	0	0	url	0
81410002	81410000	Hits	hits	0	-1	0	0	category	0
81420002	81420000	Hits	hits	0	-1	0	0	domain	0
81430002	81430000	Hits	hits	0	-1	0	0	url	0
81440002	81440000	Hits	hits	0	-1	0	0	application	0
81411002	81411000	Hits	hits	0	-1	0	0	domain	0
81411102	81411100	Hits	hits	0	-1	0	0	url	0
81421002	81421000	Hits	hits	0	-1	0	0	url	0
81441002	81441000	Hits	hits	0	-1	0	0	category	0
81441102	81441100	Hits	hits	0	-1	0	0	domain	0
81441112	81441110	Hits	hits	0	-1	0	0	url	0
81510002	81510000	Hits	hits	0	-1	0	0	category	0
81511002	81511000	Hits	hits	0	-1	0	0	domain	0
81511102	81511100	Hits	hits	0	-1	0	0	url	0
82000002	82000000	Hits	hits	0	-1	0	0	category	0
82100002	82100000	Hits	hits	0	-1	0	0	domain	0
82200002	82200000	Hits	hits	0	-1	0	0	username	0
82110002	82110000	Hits	hits	0	-1	0	0	username	0
82111002	82111000	Hits	hits	0	-1	0	0	url	0
82210002	82210000	Hits	hits	0	-1	0	0	domain	0
82211002	82211000	Hits	hits	0	-1	0	0	url	0
83000002	83000000	Hits	hits	0	-1	0	0	domain	0
83100002	83100000	Hits	hits	0	-1	0	0	username	0
6430003	6430000	Bytes	bytes	0	-1	2	0	host	0
6411003	6411000	Hits	hits	0	-1	0	0	server	0
6411004	6411000	Bytes	bytes	0	-1	2	0	server	0
6421003	6421000	Hits	hits	0	-1	0	0	host	0
6421004	6421000	Bytes	bytes	0	-1	2	0	host	0
6431003	6431000	Hits	hits	0	-1	0	0	file	0
6431004	6431000	Bytes	bytes	0	-1	2	0	file	0
6510002	6510000	Hits	hits	0	-1	0	0	file	0
6510003	6510000	Bytes	bytes	0	-1	2	0	file	0
6511003	6511000	Hits	hits	0	-1	0	0	server	0
6511004	6511000	Bytes	bytes	0	-1	2	0	server	0
6520002	6520000	Hits	hits	0	-1	0	0	server	0
6520003	6520000	Bytes	bytes	0	-1	2	0	server	0
1013106	1013100	Count	size	0	-1	0	0		0
1014106	1014100	Count	size	0	-1	0	0		0
1031106	1031100	Count	size	0	-1	0	0		0
1032106	1032100	Count	size	0	-1	0	0		0
1033106	1033100	Count	size	0	-1	0	0		0
1034106	1034100	Count	size	0	-1	0	0		0
11415516	11415510	Count	hits	0	-1	0	0	sender	0
511106	511100	Size	size	0	-1	2	0		0
512106	512100	Size	size	0	-1	2	0		0
513106	513100	Size	size	0	-1	2	0		0
514106	514100	Size	size	0	-1	2	0		0
515106	515100	Size	size	0	-1	2	0		0
521106	521100	Size	size	0	-1	2	0		0
522106	522100	Size	size	0	-1	2	0		0
523106	523100	Size	size	0	-1	2	0		0
524106	524100	Size	size	0	-1	2	0		0
531106	531100	Size	size	0	-1	2	0		0
532106	532100	Size	size	0	-1	2	0		0
533106	533100	Size	size	0	-1	2	0		0
534106	534100	Size	size	0	-1	2	0		0
535106	535100	Size	size	0	-1	2	0		0
541106	541100	Size	size	0	-1	2	0		0
542106	542100	Size	size	0	-1	2	0		0
543106	543100	Size	size	0	-1	2	0		0
544106	544100	Size	size	0	-1	2	0		0
552106	552100	Size	size	0	-1	2	0		0
553106	553100	Size	size	0	-1	2	0		0
554106	554100	Size	size	0	-1	2	0		0
555106	555100	Size	size	0	-1	2	0		0
42321101	42321100	URL	url	0	-1	0	0	url	1
20201201	20201200	Host	srcip	0	-1	5	0	srcip	1
1021106	1021100	Count	size	0	-1	0	0		0
1023106	1023100	Count	size	0	-1	0	0		0
1035106	1035100	Count	size	0	-1	0	0		0
1022106	1022100	Count	size	0	-1	0	0		0
28012	28010	Hits	hits	0	-1	0	0	proto_group	0
28013	28010	Bytes	bytes	0	-1	2	0	proto_group	0
28052	28050	Hits	hits	0	-1	0	0	username	0
28053	28050	Bytes	bytes	0	-1	2	0	username	0
29012	29010	Hits	hits	0	-1	0	0	recipient	0
29013	29010	Bytes	bytes	0	-1	2	0	recipient	0
29032	29030	Hits	hits	0	-1	0	0	host	0
29033	29030	Bytes	bytes	0	-1	2	0	host	0
29052	29050	Hits	hits	0	-1	0	0	destination	0
29053	29050	Bytes	bytes	0	-1	2	0	destination	0
29072	29070	Hits	hits	0	-1	0	0	username	0
29073	29070	Bytes	bytes	0	-1	2	0	username	0
29022	29020	Hits	hits	0	-1	0	0	sender	0
29023	29020	Bytes	bytes	0	-1	2	0	sender	0
29042	29040	Hits	hits	0	-1	0	0	host	0
29043	29040	Bytes	bytes	0	-1	2	0	host	0
29062	29060	Hits	hits	0	-1	0	0	destination	0
29063	29060	Bytes	bytes	0	-1	2	0	destination	0
29082	29080	Hits	hits	0	-1	0	0	username	0
29083	29080	Bytes	bytes	0	-1	2	0	username	0
29092	29090	Hits	hits	0	-1	0	0	sender	0
29102	29100	Hits	hits	0	-1	0	0	recipient	0
26012	26010	Hits	hits	0	-1	0	0	proto_group	0
26013	26010	Bytes	bytes	0	-1	2	0	proto_group	0
26052	26050	Hits	hits	0	-1	0	0	srcip	0
26053	26050	Bytes	bytes	0	-1	2	0	srcip	0
28022	28020	Hits	hits	0	-1	0	0	category	0
28023	28020	Bytes	bytes	0	-1	2	0	category	0
26032	26030	Hits	hits	0	-1	0	0	file	0
26033	26030	Bytes	bytes	0	-1	2	0	file	0
26042	26040	Hits	hits	0	-1	0	0	file	0
26043	26040	Bytes	bytes	0	-1	2	0	file	0
28032	28030	Hits	hits	0	-1	0	0	file	0
28033	28030	Bytes	bytes	0	-1	2	0	file	0
28042	28040	Hits	hits	0	-1	0	0	file	0
28043	28040	Bytes	bytes	0	-1	2	0	file	0
26062	26060	Hits	hits	0	-1	0	0	proto_group	0
28062	28060	Hits	hits	0	-1	0	0	proto_group	0
26082	26080	Count	hits	0	-1	0	0	virus	0
26022	26020	Hits	hits	0	-1	0	0	category	0
26023	26020	Bytes	bytes	0	-1	2	0	category	0
26072	26070	Hits	hits	0	-1	0	0	category	0
28072	28070	Hits	hits	0	-1	0	0	category	0
28092	28090	Hits	hits	0	-1	0	0	attack	0
28082	28080	Hits	hits	0	-1	0	0	attack	0
432	134	Application	application	0	-1	6	0	srcip	1
11200001	11200000	Virus Name	virus	0	-1	0	0	virus	1
11310001	11310000	Virus	virus	0	11310000	0	0	virus	1
11311001	11311000	Domain	domain	0	11311000	0	0	domain	1
11311101	11311100	URL	url	0	-1	0	0	url	1
11311102	11311100	User	username	0	-1	0	0	url	1
11311103	11311100	Host	host	0	-1	5	0	url	1
11312001	11312000	User	username	0	11312000	0	0	username	1
11312101	11312100	URL	url	0	-1	0	0	url	1
11312102	11312100	Host	host	0	-1	5	0	url	1
11313001	11313000	Host	host	0	11313000	0	0	host	1
11313101	11313100	URL	url	0	-1	0	0	url	1
11313102	11313100	User	username	0	-1	0	0	url	1
11321101	11321100	URL	url	0	-1	0	0	url	1
4551001	4551000	Category	category	0	4551000	0	0	category	1
4551101	4551100	Domain	domain	0	4551100	0	0	domain	1
4551111	4551110	URL	url	0	-1	0	0	url	1
4552001	4552000	Domain	domain	0	4552000	0	0	domain	1
4552101	4552100	URL	url	0	-1	0	0	url	1
4553001	4553000	Content	content	0	4553000	0	0	content	1
4553101	4553100	Domain	domain	0	4553100	0	0	domain	1
4553111	4553110	URL	url	0	-1	0	0	url	1
4554001	4554000	URL	url	0	-1	0	0	url	1
4555101	4555100	Category	category	0	4555100	0	0	category	1
4555111	4555110	Domain	domain	0	4555110	0	0	domain	1
45551111	45551110	URL	url	0	-1	0	0	url	1
4555201	4555200	Content	content	0	4555200	0	0	content	1
4555211	4555210	Domain	domain	0	4555210	0	0	domain	1
45552111	45552110	URL	url	0	-1	0	0	url	1
4561001	4561000	Category	category	0	4561000	0	0	category	1
4561101	4561100	Domain	domain	0	4561100	0	0	domain	1
4561111	4561110	URL	url	0	-1	0	0	url	1
4562001	4562000	Content	content	0	4562000	0	0	content	1
4562101	4562100	Domain	domain	0	4562100	0	0	domain	1
4562111	4562110	URL	url	0	-1	0	0	url	1
46100001	46100000	Category	category	0	46100000	0	0	category	1
46110001	46110000	Domain	domain	0	46110000	0	0	domain	1
46111001	46111000	User	username	0	46111000	0	0	username	1
46111101	46111100	URL	url	0	-1	0	0	url	1
46112001	46112000	Content	content	0	46112000	0	0	content	1
46112101	46112100	User	username	0	46112100	0	0	username	1
46112111	46112110	URL	url	0	-1	0	0	url	1
46122101	46122100	Domain	domain	0	46122100	0	0	domain	1
46130001	46130000	Content	content	0	46130000	0	0	content	1
46131001	46131000	User	username	0	46131000	0	0	username	1
46131101	46131100	Domain	domain	0	46131100	0	0	domain	1
46131111	46131110	URL	url	0	-1	0	0	url	1
46132001	46132000	Domain	domain	0	46132000	0	0	domain	1
7313001	7313000	User	username	0	7313000	0	0	username	1
81200001	81200000	Domain	domain	0	81200000	0	0	domain	1
81300001	81300000	URL	url	0	-1	0	0	url	1
81400001	81400000	Host	host	0	81400000	5	0	host	1
81110001	81110000	Domain	domain	0	81110000	0	0	domain	1
81111001	81111000	URL	url	0	-1	0	0	url	1
81210001	81210000	URL	url	0	-1	0	0	url	1
81410001	81410000	Category	category	0	81410000	0	0	category	1
81420001	81420000	Domain	domain	0	81420000	0	0	domain	1
81430001	81430000	URL	url	0	-1	0	0	url	1
81411001	81411000	Domain	domain	0	81411000	0	0	domain	1
81411101	81411100	URL	url	0	-1	0	0	url	1
81421001	81421000	URL	url	0	-1	0	0	url	1
81441001	81441000	Category	category	0	81441000	0	0	category	1
81441101	81441100	Domain	domain	0	81441100	0	0	domain	1
81441111	81441110	URL	url	0	-1	0	0	url	1
81510001	81510000	Category	category	0	81510000	0	0	category	1
81511001	81511000	Domain	domain	0	81511000	0	0	domain	1
81511101	81511100	URL	url	0	-1	0	0	url	1
82000001	82000000	Category	category	0	82000000	0	0	category	1
82100001	82100000	Domain	domain	0	82100000	0	0	domain	1
82200001	82200000	User	username	0	82200000	0	1	username	1
82110001	82110000	User	username	0	82110000	0	1	username	1
82111001	82111000	URL	url	0	-1	0	0	url	1
82210001	82210000	Domain	domain	0	82210000	0	0	domain	1
82211001	82211000	URL	url	0	-1	0	0	url	1
83000001	83000000	Domain	domain	0	83000000	0	0	domain	1
83100001	83100000	User	username	0	83100000	0	1	username	1
83110001	83110000	URL	url	0	-1	0	0	url	1
84411101	84411100	URL	url	0	-1	0	0	url	1
84421001	84421000	URL	url	0	-1	0	0	url	1
84441001	84441000	Category	category	0	84441000	0	0	category	1
84441101	84441100	Domain	domain	0	84441100	0	0	domain	1
84441111	84441110	URL	url	0	-1	0	0	url	1
84510001	84510000	Category	category	0	84510000	0	0	category	1
84511001	84511000	Domain	domain	0	84511000	0	0	domain	1
84511110	84511100	URL	url	0	-1	0	0	url	1
6530001	6530000	User	username	0	6530000	0	0	username	1
6531001	6531000	File	file	0	-1	0	0	file	1
6531002	6531000	Server	server	0	-1	0	0	file	1
6610001	6610000	File	file	0	6610000	0	0	file	1
1012001	1012000	Host	host	0	1012000	5	0	host	1
1012101	1012100	Sender	sender	0	-1	0	0		1
1012102	1012100	Subject	subject	0	-1	0	0		1
1012103	1012100	User	username	0	-1	0	0		1
1012104	1012100	Destination	destination	0	-1	5	0		1
1013001	1013000	Destination	destination	0	1013000	5	0	destination	1
1013101	1013100	Sender	sender	0	-1	0	0		1
1013102	1013100	Subject	subject	0	-1	0	0		1
1013103	1013100	User	username	0	-1	0	0		1
1013104	1013100	Host	host	0	-1	5	0		1
1014001	1014000	User	username	0	1014000	0	0	username	1
1014101	1014100	Sender	sender	0	-1	0	0		1
1014102	1014100	Subject	subject	0	-1	0	0		1
1014103	1014100	Host	host	0	-1	5	0		1
1014104	1014100	Destination	destination	0	-1	5	0		1
1015101	1015100	Sender	sender	0	-1	0	0		1
1015102	1015100	Subject	subject	0	-1	0	0		1
1015103	1015100	User	username	0	-1	0	0		1
1015104	1015100	Host	host	0	-1	5	0		1
1015105	1015100	Destination	destination	0	-1	5	0		1
1020001	1020000	Sender	sender	0	1020000	0	0	sender	1
1021101	1021100	Subject	subject	0	-1	0	0		1
1024103	1024100	Host	host	0	-1	5	0		1
1024104	1024100	Destination	destination	0	-1	5	0		1
1025101	1025100	Recipient	recipient	0	-1	0	0		1
1025102	1025100	Subject	subject	0	-1	0	0		1
1025103	1025100	User	username	0	-1	0	0		1
1025104	1025100	Host	host	0	-1	5	0		1
1025105	1025100	Destination	destination	0	-1	5	0		1
1031001	1031000	Sender	sender	0	1031000	0	0	sender	1
1032001	1032000	Recipient	recipient	0	1032000	0	0	recipient	1
1033001	1033000	User	username	0	1033000	0	0	username	1
1034001	1034000	Host	host	0	1034000	5	0	host	1
1035001	1035000	Destination	destination	0	1035000	5	0	destination	1
1031101	1031100	Recipient	recipient	0	-1	0	0		1
1031102	1031100	Subject	subject	0	-1	0	0		1
1031103	1031100	User	username	0	-1	0	0		1
1031104	1031100	Host	host	0	-1	5	0		1
1031105	1031100	Destination	destination	0	-1	5	0		1
1032101	1032100	Sender	sender	0	-1	0	0		1
1032102	1032100	Subject	subject	0	-1	0	0		1
1032103	1032100	User	username	0	-1	0	0		1
1032104	1032100	Host	host	0	-1	5	0		1
1032105	1032100	Destination	destination	0	-1	5	0		1
1033101	1033100	Sender	sender	0	-1	0	0		1
1033102	1033100	Recipient	recipient	0	-1	0	0		1
1033103	1033100	Subject	subject	0	-1	0	0		1
1033104	1033100	Host	host	0	-1	5	0		1
1033105	1033100	Destination	destination	0	-1	5	0		1
1034101	1034100	Sender	sender	0	-1	0	0		1
1034102	1034100	Recipient	recipient	0	-1	0	0		1
1034103	1034100	Subject	subject	0	-1	0	0		1
1034104	1034100	User	username	0	-1	0	0		1
1034105	1034100	Destination	destination	0	-1	5	0		1
1035101	1035100	Sender	sender	0	-1	0	0		1
1035102	1035100	Recipient	recipient	0	-1	0	0		1
1035103	1035100	Subject	subject	0	-1	0	0		1
525102	525100	Subject	subject	0	-1	0	0		1
525103	525100	User	username	0	-1	0	0		1
525105	525100	Destination	destination	0	-1	5	0		1
531001	531000	Sender	sender	0	531000	0	0	sender	1
532001	532000	Recipient	recipient	0	532000	0	0	recipient	1
533001	533000	Source Host	host	0	533000	5	0	host	1
534001	534000	Destination	destination	0	534000	5	0	destination	1
541001	541000	Sender	sender	0	541000	0	0	sender	1
542001	542000	Recipient	recipient	0	542000	0	0	recipient	1
543001	543000	User	username	0	543000	0	0	username	1
11413101	11413100	Sender	sender	0	11413100	0	0	sender	1
11413201	11413200	Recipient	recipient	0	11413200	0	0	recipient	1
11413301	11413300	Receiver Host	destination	0	11413300	5	0	destination	1
4431111	4431110	URL	url	0	-1	0	0	url	1
130031	130030	User	username	0	104200	0	0	username	1
140011	140010	Destination	destip	0	-1	5	0	destip	1
150211	150210	Destination	destip	0	-1	5	0	destip	1
131021	131020	User	username	0	141100	0	0	username	1
141011	141010	User	username	0	-1	0	0	username	1
11411401	11411400	Application	application	0	11411400	6	0	application	1
550001	550000	Application	application	0	550000	6	0	application	1
515001	515000	Application	application	0	515000	6	0	application	1
132021	132020	Destination	destip	0	142100	5	0	destip	1
142011	142010	Destination	destip	0	-1	5	0	destip	1
134021	134020	Destination	destip	0	144100	5	0	destip	1
134031	134030	User	username	0	144200	0	0	username	1
144011	144010	Destination	destip	0	-1	5	0	destip	1
154211	154210	Destination	destip	0	-1	5	0	destip	1
135021	135020	Destination	destip	0	145100	5	0	destip	1
135031	135030	User	username	0	145200	0	0	username	1
145011	145010	Destination	destip	0	-1	5	0	destip	1
155211	155210	Destination	destip	0	-1	5	0	destip	1
136021	136020	User	username	0	146100	0	0	username	1
146011	146010	User	username	0	-1	0	0	username	1
137021	137020	User	username	0	147100	0	0	username	1
147011	147010	User	username	0	-1	0	0	username	1
138021	138020	Destination	destip	0	148100	5	0	destip	1
148011	148010	Destination	destip	0	-1	5	0	destip	1
139021	139020	Destination	destip	0	149100	5	0	destip	1
149011	149010	Destination	destip	0	-1	5	0	destip	1
1430021	1430020	Destination	destip	0	1440100	5	0	destip	1
1430031	1430030	Host	srcip	0	1440200	5	0	srcip	1
1440011	1440010	Destination	destip	0	-1	5	0	destip	1
1450011	1450010	Destination	destip	0	-1	5	0	destip	1
1431021	1431020	Host	srcip	0	1441100	5	0	srcip	1
1441011	1441010	Host	srcip	0	-1	5	0	srcip	1
42220001	42220000	Content	content	0	42220000	0	0	content	1
1432021	1432020	Destination	destip	0	1442100	5	0	destip	1
1442011	1442010	Destination	destip	0	-1	5	0	destip	1
1434021	1434020	Destination	destip	0	1444100	5	0	destip	1
1434031	1434030	Host	srcip	0	1444200	5	0	srcip	1
1444011	1444010	Destination	destip	0	-1	5	0	destip	1
1454011	1454010	Destination	destip	0	-1	5	0	destip	1
1435021	1435020	Destination	destip	0	1445100	5	0	destip	1
1435031	1435030	Host	srcip	0	1445200	5	0	srcip	1
1445011	1445010	Destination	destip	0	-1	5	0	destip	1
1455011	1455010	Destination	destip	0	-1	5	0	destip	1
1530021	1530020	Destination	destip	0	1540100	5	0	destip	1
1530031	1530030	Host	srcip	0	1540200	5	0	srcip	1
1540011	1540010	Destination	destip	0	-1	5	0	destip	1
1540021	1540020	Host	srcip	0	-1	5	0	srcip	1
1540111	1540110	User	username	0	-1	0	0	username	1
1540121	1540120	Host	srcip	0	-1	5	0	srcip	1
1540211	1540210	Destination	destip	0	-1	5	0	destip	1
1540221	1540220	User	username	0	-1	0	0	username	1
1531021	1531020	Destination	destip	0	1541100	5	0	destip	1
1531031	1531030	Host	srcip	0	1541200	5	0	srcip	1
1541011	1541010	Destination	destip	0	-1	5	0	destip	1
1541021	1541020	Host	srcip	0	-1	5	0	srcip	1
1541121	1541120	Host	srcip	0	-1	5	0	srcip	1
511105	511100	Application	application	0	-1	6	0		1
1541221	1541220	Destination	destip	0	1551100	5	0	destip	1
1551011	1551010	Destination	destip	0	-1	5	0	destip	1
1532021	1532020	User	username	0	1542100	0	0	username	1
1532031	1532030	Host	srcip	0	1542200	5	0	srcip	1
1542011	1542010	User	username	0	-1	0	0	username	1
1542021	1542020	Host	srcip	0	-1	5	0	srcip	1
1542121	1542120	Host	srcip	0	-1	5	0	srcip	1
1542221	1542220	User	username	0	-1	0	0	username	1
1533021	1533020	Destination	destip	0	1543100	5	0	destip	1
1533031	1533030	User	username	0	1543200	0	0	username	1
1543011	1543010	Destination	destip	0	-1	5	0	destip	1
1543021	1543020	User	username	0	-1	0	0	username	1
1543121	1543120	User	username	0	-1	0	0	username	1
1543221	1543220	Destination	destip	0	1553100	5	0	destip	1
1553011	1553010	Destination	destip	0	-1	5	0	destip	1
15310031	15310030	User	username	0	15410200	0	0	username	1
15410011	15410010	Destination	destip	0	-1	5	0	destip	1
15410021	15410020	User	username	0	-1	0	0	username	1
15410121	15410120	User	username	0	-1	0	0	username	1
15410221	15410220	Destination	destip	0	15510100	5	0	destip	1
15510011	15510010	Destination	destip	0	-1	5	0	destip	1
15311021	15311020	Destination	destip	0	15411100	5	0	destip	1
1420071	1420070	Destination	destip	0	1437000	5	0	destip	1
1420081	1420080	Host	srcip	0	1438000	5	0	srcip	1
1420091	1420090	Host	srcip	0	1439000	5	0	srcip	1
1520011	1520010	User	username	0	1531000	0	0	username	1
1520021	1520020	Destination	destip	0	1532000	5	0	destip	1
1520031	1520030	Host	srcip	0	1533000	5	0	srcip	1
1520071	1520070	User	username	0	1536000	0	0	username	1
1520081	1520080	User	username	0	1537000	0	0	username	1
1520091	1520090	Destination	destip	0	1538000	5	0	destip	1
1520101	1520100	Destination	destip	0	1539000	5	0	destip	1
1520111	1520110	Host	srcip	0	15310000	5	0	srcip	1
46132101	46132100	User	username	0	46132100	0	0	username	1
46200001	46200000	Domain	domain	0	46200000	0	0	domain	1
46210001	46210000	User	username	0	46210000	0	0	username	1
46211001	46211000	URL	url	0	-1	0	0	url	1
46220001	46220000	Content	content	0	46220000	0	0	content	1
46221101	46221100	URL	url	0	-1	0	0	url	1
46300001	46300000	User	username	0	46300000	0	0	username	1
46310001	46310000	Category	category	0	46310000	0	0	category	1
46320001	46320000	Domain	domain	0	46320000	0	0	domain	1
46330001	46330000	Content	content	0	46330000	0	0	content	1
46340001	46340000	URL	url	0	-1	0	0	url	1
7233201	7233200	User	username	0	-1	0	0	username	1
7240001	7240000	Host	host	0	7240000	5	0	host	1
7241201	7241200	User	username	0	-1	0	0	username	1
7242201	7242200	User	username	0	-1	0	0	username	1
7243001	7243000	User	username	0	7243000	0	0	username	1
7321101	7321100	User	username	0	-1	0	0	username	1
7322001	7322000	User	username	0	7322000	0	0	username	1
7330001	7330000	User	username	0	7330000	0	0	username	1
1021105	1021100	Application	application	0	-1	6	0		1
7411101	7411100	User	username	0	-1	0	0	username	1
7411201	7411200	Host	host	0	-1	5	0	host	1
7412001	7412000	User	username	0	7412000	0	0	username	1
7412201	7412200	Host	host	0	-1	5	0	host	1
7413001	7413000	Host	host	0	7413000	5	0	host	1
7413201	7413200	User	username	0	-1	0	0	username	1
7420001	7420000	User	username	0	7420000	0	0	username	1
1021103	1021100	Host	host	0	-1	5	0		1
1021104	1021100	Destination	destination	0	-1	5	0		1
1022001	1022000	Host	host	0	1022000	5	0	host	1
1023001	1023000	Destination	destination	0	1023000	5	0	destination	1
1023101	1023100	Recipient	recipient	0	-1	0	0		1
1023102	1023100	Subject	subject	0	-1	0	0		1
1023103	1023100	User	username	0	-1	0	0		1
1023104	1023100	Host	host	0	-1	5	0		1
1024001	1024000	User	username	0	1024000	0	0	username	1
1024101	1024100	Recipient	recipient	0	-1	0	0		1
1024102	1024100	Subject	subject	0	-1	0	0		1
1035104	1035100	User	username	0	-1	0	0		1
1035105	1035100	Host	host	0	-1	5	0		1
92100001	92100000	Attacker	attacker	0	92100000	5	0	attacker	1
92110001	92110000	Victim	victim	0	-1	5	0	victim	1
92110003	92110000	Action	action	0	-1	0	0	victim	1
11411111	11411110	Subject	subject	0	-1	0	0	subject	1
11411112	11411110	User	username	0	-1	0	0	subject	1
11411113	11411110	Sender Host	host	0	-1	5	0	subject	1
11411114	11411110	Receiver Host	destination	0	-1	5	0	subject	1
11411211	11411210	Recipient	recipient	0	-1	0	0	recipient	1
11411212	11411210	Subject	subject	0	-1	0	0	recipient	1
11411213	11411210	User	username	0	-1	0	0	recipient	1
11411214	11411210	Receiver Host	host	0	-1	5	0	recipient	1
11411311	11411310	Recipient	recipient	0	-1	0	0	recipient	1
11411312	11411310	Subject	subject	0	-1	0	0	recipient	1
11411313	11411310	User	username	0	-1	0	0	recipient	1
11411314	11411310	Sender Host	host	0	-1	5	0	recipient	1
11414412	11414410	Recipient	recipient	0	-1	0	0	sender	1
11320001	11320000	Domain	domain	0	11320000	0	0	domain	1
11321001	11321000	Virus	virus	0	11321000	0	0	virus	1
11321102	11321100	User	username	0	-1	0	0	url	1
11321103	11321100	Host	host	0	-1	5	0	url	1
11322001	11322000	User	username	0	11322000	0	0	username	1
11322101	11322100	URL	url	0	-1	0	0	url	1
11322102	11322100	Virus	virus	0	-1	0	0	url	1
11322103	11322100	Host	host	0	-1	5	0	url	1
11323001	11323000	Host	host	0	11323000	5	0	host	1
97510004	97510000	Severity	severity	0	-1	7	0	attacker	1
11323101	11323100	URL	url	0	-1	0	0	url	1
11323102	11323100	Virus	virus	0	-1	0	0	url	1
11323103	11323100	User	username	0	-1	0	0	url	1
11330001	11330000	User	username	0	11330000	0	0	username	1
11331001	11331000	Virus	virus	0	11331000	0	0	virus	1
11331101	11331100	URL	url	0	-1	0	0	url	1
7213001	7213000	Host	host	0	7213000	5	0	host	1
7213201	7213200	User	username	0	-1	0	0	username	1
7220001	7220000	User	username	0	7220000	0	0	username	1
7221201	7221200	Host	host	0	-1	5	0	host	1
7222201	7222200	Host	host	0	-1	5	0	host	1
7223001	7223000	Host	host	0	7223000	5	0	host	1
7231201	7231200	Host	host	0	-1	5	0	host	1
6611001	6611000	Server	server	0	-1	5	0	server	1
6611002	6611000	User	username	0	-1	0	0	server	1
6620001	6620000	Server	server	0	6620000	5	0	server	1
6621001	6621000	User	username	0	-1	0	0	username	1
6621002	6621000	File	file	0	-1	0	0	username	1
6630001	6630000	User	username	0	6630000	0	0	username	1
6631001	6631000	File	file	0	-1	0	0	file	1
6631002	6631000	Server	server	0	-1	0	0	file	1
6710001	6710000	File	file	0	6710000	0	0	file	1
6711001	6711000	Host	host	0	-1	5	0	host	1
6711002	6711000	User	username	0	-1	0	0	host	1
6720001	6720000	File	file	0	6720000	0	0	file	1
6721001	6721000	Host	host	0	-1	5	0	host	1
6721002	6721000	User	username	0	-1	0	0	host	1
6730001	6730000	User	username	0	6730000	0	0	username	1
6731001	6731000	File	file	0	-1	0	0	file	1
6732001	6732000	File	file	0	-1	0	0	file	1
6740001	6740000	Host	host	0	6740000	5	0	host	1
6741001	6741000	File	file	0	-1	0	0	file	1
6742001	6742000	File	file	0	-1	0	0	file	1
11331102	11331100	Host	host	0	-1	5	0	url	1
11332001	11332000	Domain	domain	0	11332000	0	0	domain	1
11332101	11332100	URL	url	0	-1	0	0	url	1
11332102	11332100	Host	host	0	-1	5	0	url	1
11332103	11332100	Virus	virus	0	-1	0	0	url	1
11333001	11333000	Host	host	0	11333000	5	0	host	1
11333101	11333100	URL	url	0	-1	0	0	url	1
11333102	11333100	Virus	virus	0	-1	0	0	url	1
11410001	11410000	Virus	virus	0	11410000	0	0	virus	1
11411001	11411000	Sender	sender	0	11411000	0	0	sender	1
11411101	11411100	Recipient	recipient	0	11411100	0	0	recipient	1
11411201	11411200	Sender Host	host	0	11411200	5	0	host	1
11411301	11411300	Receiver Host	destination	0	11411300	5	0	destination	1
11411501	11411500	User	username	0	11411500	0	0	username	1
11412001	11412000	Recipient	recipient	0	11412000	0	0	recipient	1
520001	520000	Recipient	recipient	0	520000	0	0	recipient	1
530001	530000	User	username	0	530000	0	0	username	1
540001	540000	Host	host	0	540000	5	0	host	1
511001	511000	Recipient	recipient	0	511000	0	0	recipient	1
512001	512000	Source Host	host	0	512000	5	0	host	1
513001	513000	Destination	destination	0	513000	5	0	destination	1
514001	514000	User	username	0	514000	0	0	username	1
511101	511100	Subject	subject	0	-1	0	0		1
511102	511100	User	username	0	-1	0	0		1
511103	511100	Host	host	0	-1	5	0		1
511104	511100	Destination	destination	0	-1	0	0		1
512101	512100	Recipient	recipient	0	-1	0	0		1
512102	512100	Subject	subject	0	-1	0	0		1
512103	512100	User	username	0	-1	0	0		1
512104	512100	Destination	destination	0	-1	5	0		1
513101	513100	Recipient	recipient	0	-1	0	0		1
513102	513100	Subject	subject	0	-1	0	0		1
513103	513100	User	username	0	-1	0	0		1
513104	513100	Host	host	0	-1	5	0		1
514101	514100	Recipient	recipient	0	-1	0	0		1
514102	514100	Subject	subject	0	-1	0	0		1
514103	514100	Host	host	0	-1	5	0		1
514104	514100	Destination	destination	0	-1	5	0		1
515101	515100	Recipient	recipient	0	-1	0	0		1
515102	515100	Subject	subject	0	-1	0	0		1
515103	515100	User	username	0	-1	0	0		1
515104	515100	Host	host	0	-1	5	0		1
515105	515100	Destination	destination	0	-1	5	0		1
521001	521000	Sender	sender	0	521000	0	0	sender	1
522001	522000	Source Host	host	0	522000	5	0	host	1
523001	523000	Destination	destination	0	523000	5	0	destination	1
524001	524000	User	username	0	524000	0	0	username	1
521101	521100	Subject	subject	0	-1	0	0		1
521102	521100	User	username	0	-1	0	0		1
521103	521100	Host	host	0	-1	5	0		1
521104	521100	Destination	destination	0	-1	5	0		1
522101	522100	Sender	sender	0	-1	0	0		1
522102	522100	Subject	subject	0	-1	0	0		1
522103	522100	User	username	0	-1	0	0		1
522104	522100	Destination	destination	0	-1	5	0		1
523101	523100	Sender	sender	0	-1	0	0		1
523102	523100	Subject	subject	0	-1	0	0		1
523103	523100	User	username	0	-1	0	0		1
523104	523100	Host	host	0	-1	5	0		1
524101	524100	Sender	sender	0	-1	0	0		1
524102	524100	Subject	subject	0	-1	0	0		1
524103	524100	Host	host	0	-1	5	0		1
524104	524100	Destination	destination	0	-1	5	0		1
525101	525100	Sender	sender	0	-1	0	0		1
544001	544000	Destination	destination	0	544000	5	0	destination	1
551001	551000	Sender	sender	0	551000	0	0	sender	1
552001	552000	Recipient	recipient	0	552000	0	0	recipient	1
553001	553000	User	username	0	553000	0	0	username	1
554001	554000	Host	host	0	554000	5	0	host	1
555001	555000	Destination	destination	0	555000	5	0	destination	1
531101	531100	Recipient	recipient	0	-1	0	0		1
531102	531100	Subject	subject	0	-1	0	0		1
531103	531100	Host	host	0	-1	5	0		1
531104	531100	Destination	destination	0	-1	5	0		1
532101	532100	Sender	sender	0	-1	0	0		1
532102	532100	Subject	subject	0	-1	0	0		1
532103	532100	Host	host	0	-1	5	0		1
532104	532100	Destination	destination	0	-1	5	0		1
533101	533100	Sender	sender	0	-1	0	0		1
533102	533100	Recipient	recipient	0	-1	0	0		1
533103	533100	Subject	subject	0	-1	0	0		1
533104	533100	Destination	destination	0	-1	5	0		1
534101	534100	Sender	sender	0	-1	0	0		1
534102	534100	Recipient	recipient	0	-1	0	0		1
534103	534100	Subject	subject	0	-1	0	0		1
534104	534100	Host	host	0	-1	5	0		1
535101	535100	Sender	sender	0	-1	0	0		1
535102	535100	Recipient	recipient	0	-1	0	0		1
535103	535100	Subject	subject	0	-1	0	0		1
535104	535100	Host	host	0	-1	5	0		1
535105	535100	Destination	destination	0	-1	5	0		1
541101	541100	Recipient	recipient	0	-1	0	0		1
541102	541100	Subject	subject	0	-1	0	0		1
541103	541100	User	username	0	-1	0	0		1
541104	541100	Destination	destination	0	-1	5	0		1
542101	542100	Sender	sender	0	-1	0	0		1
542102	542100	Subject	subject	0	-1	0	0		1
542103	542100	User	username	0	-1	0	0		1
542104	542100	Destination	destination	0	-1	5	0		1
543101	543100	Sender	sender	0	-1	0	0		1
543102	543100	Recipient	recipient	0	-1	0	0		1
543103	543100	Subject	subject	0	-1	0	0		1
543104	543100	Destination	destination	0	-1	5	0		1
544101	544100	Sender	sender	0	-1	0	0		1
544102	544100	Recipient	recipient	0	-1	0	0		1
544103	544100	Subject	subject	0	-1	0	0		1
544104	544100	User	username	0	-1	0	0		1
545101	545100	Sender	sender	0	-1	0	0		1
552102	552100	Subject	subject	0	-1	0	0		1
552103	552100	User	username	0	-1	0	0		1
552104	552100	Host	host	0	-1	5	0		1
552105	552100	Destination	destination	0	-1	5	0		1
553101	553100	Sender	sender	0	-1	0	0		1
553102	553100	Recipient	recipient	0	-1	0	0		1
553103	553100	Subject	subject	0	-1	0	0		1
553104	553100	Host	host	0	-1	5	0		1
553105	553100	Destination	destination	0	-1	5	0		1
554101	554100	Sender	sender	0	-1	0	0		1
554102	554100	Recipient	recipient	0	-1	0	0		1
554103	554100	Subject	subject	0	-1	0	0		1
554104	554100	User	username	0	-1	0	0		1
554105	554100	Destination	destination	0	-1	5	0		1
555101	555100	Sender	sender	0	-1	0	0		1
555102	555100	Recipient	recipient	0	-1	0	0		1
555103	555100	Subject	subject	0	-1	0	0		1
555104	555100	User	username	0	-1	0	0		1
555105	555100	Host	host	0	-1	5	0		1
545105	545100	Destination	destination	0	-1	0	0		1
11412201	11412200	Sender Host	host	0	11412200	5	0	host	1
11412301	11412300	Receiver Host	destination	0	11412300	5	0	destination	1
11412501	11412500	User	username	0	11412500	0	0	username	1
11413001	11413000	Sender Host	host	0	11413000	5	0	host	1
11511101	11511100	Host	host	0	11511100	5	0	host	1
11511111	11511110	File	file	0	-1	0	0	file	1
11511112	11511110	User	username	0	-1	0	0	file	1
11511201	11511200	File	file	0	11511200	0	0	file	1
11511211	11511210	Host	host	0	-1	5	0	host	1
11511212	11511210	User	username	0	-1	0	0	host	1
11511301	11511300	User	username	0	11511300	0	0	username	1
11511311	11511310	Host	host	0	-1	5	0	host	1
11511312	11511310	File	file	0	-1	0	0	host	1
11512001	11512000	Host	host	0	11512000	5	0	host	1
11512101	11512100	Server	server	0	11512100	5	0	server	1
11512111	11512110	File	file	0	-1	0	0	file	1
11512112	11512110	User	username	0	-1	0	0	file	1
11512201	11512200	File	file	0	11512200	0	0	file	1
11512211	11512210	Server	server	0	-1	5	0	server	1
11512212	11512210	User	username	0	-1	0	0	server	1
11512301	11512300	User	username	0	11512300	0	0	username	1
11512311	11512310	Server	server	0	-1	5	0	server	1
11512312	11512310	File	file	0	-1	0	0	server	1
11513001	11513000	User	username	0	11513000	0	0	username	1
11513101	11513100	Server	server	0	11513100	5	0	server	1
11513111	11513110	File	file	0	-1	0	0	file	1
11513112	11513110	Host	host	0	-1	5	0	file	1
11513201	11513200	File	file	0	11513200	0	0	file	1
11513211	11513210	Server	server	0	-1	5	0	server	1
11513212	11513210	Host	host	0	-1	5	0	server	1
11513301	11513300	Host	host	0	11513300	5	0	host	1
11513311	11513310	Server	server	0	-1	5	0	server	1
11513312	11513310	File	file	0	-1	0	0	server	1
11514001	11514000	File	file	0	11514000	0	0	file	1
11514101	11514100	Server	server	0	11514100	5	0	server	1
11514111	11514110	Host	host	0	-1	5	0	host	1
11514112	11514110	User	username	0	-1	0	0	host	1
11514201	11514200	Host	host	0	11514200	5	0	host	1
11514211	11514210	Server	server	0	-1	5	0	server	1
11514212	11514210	User	username	0	-1	0	0	server	1
11514301	11514300	User	username	0	11514300	0	0	username	1
11514311	11514310	Server	server	0	-1	5	0	server	1
11514312	11514310	Host	host	0	-1	5	0	server	1
11520001	11520000	Virus	virus	0	11520000	0	0	virus	1
11521001	11521000	Server	server	0	11521000	5	0	server	1
11521101	11521100	Host	host	0	11521100	5	0	host	1
11521111	11521110	File	file	0	-1	0	0	file	1
11521112	11521110	User	username	0	-1	0	0	file	1
11521201	11521200	File	file	0	11521200	0	0	file	1
11521211	11521210	Host	host	0	-1	5	0	host	1
11521212	11521210	User	username	0	-1	0	0	host	1
11521301	11521300	User	username	0	11521300	0	0	username	1
11521311	11521310	Host	host	0	-1	5	0	host	1
11521312	11521310	File	file	0	-1	0	0	host	1
11522001	11522000	Host	host	0	11522000	5	0	host	1
11522101	11522100	Server	server	0	11522100	5	0	server	1
11522111	11522110	File	file	0	-1	0	0	file	1
11522112	11522110	User	username	0	-1	0	0	file	1
11522201	11522200	File	file	0	11522200	0	0	file	1
11522211	11522210	Server	server	0	-1	5	0	server	1
11522212	11522210	User	username	0	-1	0	0	server	1
11522301	11522300	User	username	0	11522300	0	0	username	1
11522311	11522310	Server	server	0	-1	5	0	server	1
11522312	11522310	File	file	0	-1	0	0	server	1
11523001	11523000	User	username	0	11523000	0	0	username	1
11523101	11523100	Server	server	0	11523100	5	0	server	1
41620001	41620000	Content	content	0	41620000	0	0	content	1
41611001	41611000	Domain	domain	0	41611000	0	0	domain	1
20203001	20203000	Host	srcip	0	20203100	5	0	srcip	1
4431001	4431000	User	username	0	4431000	0	0	username	1
4432001	4432000	Domain	domain	0	4432000	0	0	domain	1
4431101	4431100	Domain	domain	0	4431100	0	0	domain	1
4432101	4432100	URL	url	0	-1	0	0	url	1
4510001	4510000	Category	category	0	4510000	0	0	category	1
4511001	4511000	Domain	domain	0	4511000	0	0	domain	1
4511101	4511100	URL	url	0	-1	0	0	url	1
4520001	4520000	Domain	domain	0	4520000	0	0	domain	1
4521001	4521000	URL	url	0	-1	0	0	url	1
4530001	4530000	Content	content	0	4530000	0	0	content	1
48	16	User	username	0	1420000	0	1	username	1
51	17	User	username	0	1420001	0	1	username	1
1537031	1537030	Host	srcip	0	1547200	5	0	srcip	1
20402001	20402000	Destination	destip	0	-1	5	0	destip	1
54	18	User	username	0	1420002	0	1	username	1
66	22	Host	srcip	0	5	5	1	srcip	1
69	23	Host	srcip	0	100001	5	1	srcip	1
72	24	Host	srcip	0	100002	5	1	srcip	1
81	27	Destination	destip	0	131000	5	0	destip	1
84	28	User	username	0	132000	0	0	username	1
96	32	Destination	destip	0	136000	5	0	destip	1
99	33	Destination	destip	0	137000	5	0	destip	1
102	34	User	username	0	138000	0	0	username	1
105	35	User	username	0	139000	0	0	username	1
210	59	Host	srcip	0	-1	5	0	srcip	1
212	59	User	username	0	-1	0	0	srcip	1
213	59	Destination	destip	0	-1	5	0	srcip	1
214	59	Action	action	0	-1	0	0	srcip	1
130021	130020	Destination	destip	0	104100	5	0	destip	1
1436021	1436020	Host	srcip	0	1446100	5	0	srcip	1
1446011	1446010	Host	srcip	0	-1	5	0	srcip	1
1437021	1437020	Host	srcip	0	1447100	5	0	srcip	1
1447011	1447010	Host	srcip	0	-1	5	0	srcip	1
1438021	1438020	Destination	destip	0	1448100	5	0	destip	1
1448011	1448010	Destination	destip	0	-1	5	0	destip	1
1439021	1439020	Destination	destip	0	1449100	5	0	destip	1
1449011	1449010	Destination	destip	0	-1	5	0	destip	1
1530011	1530010	User	username	0	1540000	0	0	username	1
1534011	1534010	User	username	0	1544000	0	0	username	1
1534021	1534020	Destination	destip	0	1544100	5	0	destip	1
1534031	1534030	Host	srcip	0	1544200	5	0	srcip	1
1544011	1544010	Destination	destip	0	-1	5	0	destip	1
1544021	1544020	Host	srcip	0	-1	5	0	srcip	1
1544111	1544110	User	username	0	-1	0	0	username	1
1544121	1544120	Host	srcip	0	-1	5	0	srcip	1
1544211	1544210	Destination	destip	0	-1	5	0	destip	1
1544221	1544220	User	username	0	-1	0	0	username	1
1535011	1535010	User	username	0	1545000	0	0	username	1
1535021	1535020	Destination	destip	0	1545100	5	0	destip	1
1535031	1535030	Host	srcip	0	1545200	5	0	srcip	1
1545011	1545010	Destination	destip	0	-1	5	0	destip	1
1545021	1545020	Host	srcip	0	-1	5	0	srcip	1
1545111	1545110	User	username	0	-1	0	0	username	1
1545121	1545120	Host	srcip	0	-1	5	0	srcip	1
1545211	1545210	Destination	destip	0	-1	5	0	destip	1
1545221	1545220	User	username	0	-1	0	0	username	1
1536021	1536020	Destination	destip	0	1546100	5	0	destip	1
1546011	1546010	Destination	destip	0	-1	5	0	destip	1
1546021	1546020	Host	srcip	0	-1	5	0	srcip	1
1546121	1546120	Host	srcip	0	-1	5	0	srcip	1
1546221	1546220	Destination	destip	0	1556100	5	0	destip	1
1556011	1556010	Destination	destip	0	-1	5	0	destip	1
1537021	1537020	Destination	destip	0	1547100	5	0	destip	1
1547011	1547010	Destination	destip	0	-1	5	0	destip	1
1547021	1547020	Host	srcip	0	-1	5	0	srcip	1
1547121	1547120	Host	srcip	0	-1	5	0	srcip	1
1547221	1547220	Destination	destip	0	1557100	5	0	destip	1
1557011	1557010	Destination	destip	0	-1	5	0	destip	1
1538021	1538020	User	username	0	1548100	0	0	username	1
1538031	1538030	Host	srcip	0	1548200	5	0	srcip	1
1548011	1548010	User	username	0	-1	0	0	username	1
1548021	1548020	Host	srcip	0	-1	5	0	srcip	1
1548121	1548120	Host	srcip	0	-1	5	0	srcip	1
1548221	1548220	User	username	0	-1	0	0	username	1
1539021	1539020	User	username	0	1549100	0	0	username	1
1539031	1539030	Host	srcip	0	1549200	5	0	srcip	1
1549011	1549010	User	username	0	-1	0	0	username	1
1549021	1549020	Host	srcip	0	-1	5	0	srcip	1
1549121	1549120	Host	srcip	0	-1	5	0	srcip	1
1549221	1549220	User	username	0	-1	0	0	username	1
15310021	15310020	Destination	destip	0	15410100	5	0	destip	1
1520121	1520120	Host	srcip	0	15311000	5	0	srcip	1
20400001	20400000	User	username	0	20401000	0	0	username	1
20500001	20500000	User	username	0	20501000	0	0	username	1
20600001	20600000	User	username	0	20601000	0	0	username	1
20700001	20700000	Host	srcip	0	20701000	5	0	srcip	1
20800001	20800000	Host	srcip	0	20801000	5	0	srcip	1
20900001	20900000	Host	srcip	0	20901000	5	0	srcip	1
20101001	20101000	User	username	0	20101100	0	0	username	1
20102001	20102000	Destination	destip	0	20102100	5	0	destip	1
20103001	20103000	Host	srcip	0	20103100	5	0	srcip	1
20201001	20201000	User	username	0	20201100	0	0	username	1
20202001	20202000	Destination	destip	0	20202100	5	0	destip	1
20301001	20301000	User	username	0	20301100	0	0	username	1
20302001	20302000	Destination	destip	0	20302100	5	0	destip	1
20303001	20303000	Host	srcip	0	20303100	5	0	srcip	1
20403001	20403000	Host	srcip	0	-1	5	0	srcip	1
20502001	20502000	Destination	destip	0	-1	5	0	destip	1
20503001	20503000	Host	srcip	0	-1	5	0	srcip	1
20602001	20602000	Destination	destip	0	-1	5	0	destip	1
20603001	20603000	Host	srcip	0	-1	5	0	srcip	1
20702001	20702000	Destination	destip	0	-1	5	0	destip	1
20703001	20703000	User	username	0	-1	0	0	username	1
20802001	20802000	Destination	destip	0	-1	5	0	destip	1
20803001	20803000	User	username	0	-1	0	0	username	1
20902001	20902000	Destination	destip	0	-1	5	0	destip	1
20903001	20903000	User	username	0	-1	0	0	username	1
20101101	20101100	Destination	destip	0	-1	5	0	destip	1
20101201	20101200	Host	srcip	0	-1	5	0	srcip	1
20102101	20102100	User	username	0	-1	0	0	username	1
20102201	20102200	Host	srcip	0	-1	5	0	srcip	1
20103101	20103100	Destination	destip	0	-1	5	0	destip	1
20103201	20103200	User	username	0	-1	0	0	username	1
20201101	20201100	Destination	destip	0	-1	5	0	destip	1
20202101	20202100	User	username	0	-1	0	0	username	1
20202201	20202200	Host	srcip	0	-1	5	0	srcip	1
20203101	20203100	Destination	destip	0	-1	5	0	destip	1
20301101	20301100	Destination	destip	0	-1	5	0	destip	1
20301201	20301200	Host	srcip	0	-1	5	0	srcip	1
20302101	20302100	User	username	0	-1	0	0	username	1
20302201	20302200	Host	srcip	0	-1	5	0	srcip	1
20303101	20303100	Destination	destip	0	-1	5	0	destip	1
20303201	20303200	User	username	0	-1	0	0	username	1
383	123	Host	srcip	0	23	5	0	srcip	1
387	124	Host	srcip	0	24	5	0	srcip	1
391	125	Destination	destip	0	25	5	0	destip	1
395	126	Destination	destip	0	26	5	0	destip	1
399	127	Host	srcip	0	-1	5	0	srcip	1
401	127	User	username	0	-1	0	0	srcip	1
46311001	46311000	Domain	domain	0	46311000	0	0	domain	1
46420001	46420000	User	username	0	46420000	0	0	username	1
46421001	46421000	Domain	domain	0	46421000	0	0	domain	1
46421101	46421100	URL	url	0	-1	0	0	url	1
46431101	46431100	Domain	domain	0	46431100	0	0	domain	1
46431111	46431110	URL	url	0	-1	0	0	url	1
46432001	46432000	Domain	domain	0	46432000	0	0	domain	1
46432101	46432100	URL	url	0	-1	0	0	url	1
41100001	41100000	Category	category	0	41100000	0	0	category	1
41200001	41200000	Domain	domain	0	41200000	0	0	domain	1
41300001	41300000	Content	content	0	41300000	0	0	content	1
41400001	41400000	URL	url	0	-1	0	0	url	1
41110001	41110000	Domain	domain	0	41110000	0	0	domain	1
41111001	41111000	URL	url	0	-1	0	0	url	1
41210001	41210000	URL	url	0	-1	0	0	url	1
41310001	41310000	Domain	domain	0	41310000	0	0	domain	1
41311001	41311000	URL	url	0	-1	0	0	url	1
41510001	41510000	Category	category	0	41510000	0	0	category	1
41520001	41520000	Domain	domain	0	41520000	0	0	domain	1
41530001	41530000	Content	content	0	41530000	0	0	content	1
41540001	41540000	URL	url	0	-1	0	0	url	1
41511001	41511000	Domain	domain	0	41511000	0	0	domain	1
41511101	41511100	URL	url	0	-1	0	0	url	1
41521001	41521000	URL	url	0	-1	0	0	url	1
41531001	41531000	Domain	domain	0	41531000	0	0	domain	1
41531101	41531100	URL	url	0	-1	0	0	url	1
41551001	41551000	Category	category	0	41551000	0	0	category	1
41552001	41552000	Content	content	0	41552000	0	0	content	1
41551101	41551100	Domain	domain	0	41551100	0	0	domain	1
41551111	41551110	URL	url	0	-1	0	0	url	1
41552101	41552100	Domain	domain	0	41552100	0	0	domain	1
41611101	41611100	URL	url	0	-1	0	0	url	1
41621001	41621000	Domain	domain	0	41621000	0	0	domain	1
41621101	41621100	URL	url	0	-1	0	0	url	1
42000001	42000000	Category	category	0	42000000	0	0	category	1
42100001	42100000	Domain	domain	0	42100000	0	0	domain	1
42200001	42200000	User	username	0	42200000	0	1	username	1
42300001	42300000	Content	content	0	42300000	0	0	content	1
42110001	42110000	User	username	0	42110000	0	1	username	1
42111001	42111000	URL	url	0	-1	0	0	url	1
42120001	42120000	Content	content	0	42120000	0	0	content	1
42121001	42121000	User	username	0	42121000	0	1	username	1
42121101	42121100	URL	url	0	-1	0	0	url	1
42210001	42210000	Domain	domain	0	42210000	0	0	domain	1
42211001	42211000	URL	url	0	-1	0	0	url	1
42221001	42221000	Domain	domain	0	42221000	0	0	domain	1
42221101	42221100	URL	url	0	-1	0	0	url	1
42310001	42310000	User	username	0	42310000	0	1	username	1
42311001	42311000	Domain	domain	0	42311000	0	0	domain	1
42311101	42311100	URL	url	0	-1	0	0	url	1
42320001	42320000	Domain	domain	0	42320000	0	0	domain	1
42321001	42321000	User	username	0	42321000	0	1	username	1
43000001	43000000	Domain	domain	0	43000000	0	0	domain	1
43100001	43100000	User	username	0	43100000	0	1	username	1
43200001	43200000	Content	content	0	43200000	0	0	content	1
43110001	43110000	URL	url	0	-1	0	0	url	1
43210001	43210000	User	username	0	43210000	0	1	username	1
43211001	43211000	URL	url	0	-1	0	0	url	1
41500001	41500000	Host	host	0	41500000	5	0	host	1
41000001	41000000	User	username	0	41000000	0	0	username	1
46221001	46221000	User	username	0	46221000	0	0	username	1
7100001	7100000	User	username	0	7100000	0	0	username	1
41600001	41600000	Application	application	0	41600000	6	0	application	1
7300001	7300000	Host	host	0	7300000	5	0	host	1
41550001	41550000	Application	application	0	41550000	6	0	application	1
7113001	7113000	Host	host	0	7113000	0	0	host	1
7121101	7121100	Host	host	0	-1	5	0	host	1
7122001	7122000	Host	host	0	7122000	5	0	host	1
7231101	7231100	User	username	0	-1	0	0	username	1
7232001	7232000	User	username	0	7232000	0	0	username	1
7232201	7232200	Host	host	0	-1	5	0	host	1
7233001	7233000	Host	host	0	7233000	5	0	host	1
7421101	7421100	Host	host	0	-1	5	0	host	1
7422001	7422000	Host	host	0	7422000	5	0	host	1
7430001	7430000	Host	host	0	7430000	5	0	host	1
7431101	7431100	User	username	0	-1	0	0	username	1
7432001	7432000	User	username	0	7432000	0	0	username	1
46132111	46132110	URL	url	0	-1	0	0	url	1
7400001	7400000	Destination	destination	0	7400000	5	0	destination	1
7111101	7111100	Destination	destination	0	-1	5	0	destination	1
7112001	7112000	Destination	destination	0	7112000	5	0	destination	1
7113111	7113110	Destination	destination	0	-1	5	0	destination	1
7120001	7120000	Destination	destination	0	7120000	5	0	destination	1
7131101	7131100	Destination	destination	0	-1	5	0	destination	1
7132001	7132000	Destination	destination	0	7132000	5	0	destination	1
7211101	7211100	Destination	destination	0	-1	5	0	destination	1
7212001	7212000	Destination	destination	0	7212000	5	0	destination	1
7213101	7213100	Destination	destination	0	-1	5	0	destination	1
7221101	7221100	Destination	destination	0	-1	5	0	destination	1
7222001	7222000	Destination	destination	0	7222000	5	0	destination	1
7223111	7223110	Destination	destination	0	-1	5	0	destination	1
7223201	7223200	Destination	destination	0	7223200	5	0	destination	1
6500001	6500000	Host	host	0	6500000	5	0	host	1
6600001	6600000	Host	host	0	6600000	5	0	host	1
6700001	6700000	Server	server	0	6700000	5	0	server	1
6110001	6110000	Server	server	0	6110000	5	0	server	1
6111001	6111000	Host	host	0	-1	0	0	host	1
6111002	6111000	User	username	0	-1	0	0	host	1
6120001	6120000	Host	host	0	6120000	5	0	host	1
6121001	6121000	Server	server	0	-1	5	0	server	1
6121002	6121000	User	username	0	-1	0	0	server	1
6130001	6130000	User	username	0	6130000	0	0	username	1
6131001	6131000	Host	host	0	-1	5	0	host	1
6131002	6131000	Server	server	0	-1	0	0	host	1
6210001	6210000	Server	server	0	6210000	5	0	server	1
6211001	6211000	Host	host	0	-1	5	0	host	1
6211002	6211000	User	username	0	-1	0	0	host	1
6220001	6220000	Host	host	0	6220000	5	0	host	1
6221001	6221000	Server	server	0	-1	5	0	server	1
6221002	6221000	User	username	0	-1	0	0	server	1
6230001	6230000	User	username	0	6230000	0	0	username	1
6231001	6231000	Host	host	0	-1	5	0	host	1
6231002	6231000	Server	server	0	-1	0	0	host	1
6310001	6310000	File	file	0	6310000	0	0	file	1
6311001	6311000	Server	server	0	-1	5	0	server	1
6311002	6311000	Host	host	0	-1	5	0	server	1
6320001	6320000	Server	server	0	6320000	0	0	server	1
6321001	6321000	Host	host	0	-1	5	0	host	1
6321002	6321000	File	file	0	-1	0	0	host	1
6330001	6330000	Host	host	0	6330000	5	0	host	1
6331001	6331000	File	file	0	-1	0	0	file	1
6331002	6331000	Server	server	0	-1	0	0	file	1
6410001	6410000	File	file	0	6410000	0	0	file	1
6420001	6420000	Server	server	0	6420000	5	0	server	1
6430001	6430000	Host	host	0	6430000	5	0	host	1
6411001	6411000	Server	server	0	-1	5	0	server	1
6411002	6411000	Host	host	0	-1	5	0	server	1
6421001	6421000	Host	host	0	-1	5	0	host	1
6421002	6421000	File	file	0	-1	0	0	host	1
6431001	6431000	File	file	0	-1	0	0	file	1
6431002	6431000	Server	server	0	-1	0	0	file	1
6510001	6510000	File	file	0	6510000	0	0	file	1
6511001	6511000	Server	server	0	-1	5	0	server	1
6511002	6511000	User	username	0	-1	0	0	server	1
6520001	6520000	Server	server	0	6520000	5	0	server	1
6521001	6521000	User	username	0	-1	0	0	username	1
6521002	6521000	File	file	0	-1	0	0	username	1
1021001	1021000	Recipient	recipient	0	1021000	0	0	recipient	1
1021102	1021100	User	username	0	-1	0	0		1
1022101	1022100	Recipient	recipient	0	-1	0	0		1
1022102	1022100	Subject	subject	0	-1	0	0		1
1022103	1022100	User	username	0	-1	0	0		1
1022104	1022100	Destination	destination	0	-1	5	0		1
91310002	91310000	Attacker	attacker	0	-1	5	0	attack	1
91310004	91310000	Action	action	0	-1	0	0	attack	1
91410001	91410000	Attack	attack	0	-1	0	0	attack	1
91410002	91410000	Attacker	attacker	0	-1	5	0	attack	1
91410003	91410000	Victim	victim	0	-1	5	0	attack	1
91410004	91410000	User	username	0	-1	0	0	attack	1
91410005	91410000	Action	action	0	-1	0	0	attack	1
91500001	91500000	Attack	attack	0	91500000	0	0	attack	1
91510001	91510000	Attacker	attacker	0	-1	5	0	attacker	1
91510002	91510000	Victim	victim	0	-1	5	0	attacker	1
91510003	91510000	User	username	0	-1	0	0	attacker	1
91600001	91600000	Attack	attack	0	91600000	0	0	attack	1
91610001	91610000	Attacker	attacker	0	-1	5	0	attacker	1
91610002	91610000	Victim	victim	0	-1	5	0	attacker	1
91610003	91610000	User	username	0	-1	0	0	attacker	1
92200001	92200000	Victim	victim	0	92200000	5	0	victim	1
92210001	92210000	Attacker	attacker	0	-1	5	0	attacker	1
92210003	92210000	Action	action	0	-1	0	0	attacker	1
93310001	93310000	Attack	attack	0	-1	0	0	attack	1
93310002	93310000	Victim	victim	0	-1	5	0	attack	1
93310003	93310000	User	username	0	-1	0	0	attack	1
93310005	93310000	Action	action	0	-1	0	0	attack	1
94000001	94000000	Victim	victim	0	94000000	5	0	victim	1
94100001	94100000	Attack	attack	0	94100000	0	0	attack	1
94110001	94110000	Attacker	attacker	0	-1	5	0	attacker	1
94110002	94110000	User	username	0	-1	0	0	attacker	1
94110005	94110000	Action	action	0	-1	0	0	attacker	1
94200001	94200000	Attacker	attacker	0	94200000	5	0	attacker	1
94210001	94210000	Attack	attack	0	-1	0	0	attack	1
94210002	94210000	User	username	0	-1	0	0	attack	1
94210005	94210000	Action	action	0	-1	0	0	attack	1
94310001	94310000	Attack	attack	0	-1	0	0	attack	1
94310002	94310000	Attacker	attacker	0	-1	5	0	attack	1
94310003	94310000	User	username	0	-1	0	0	attack	1
94310005	94310000	Action	action	0	-1	0	0	attack	1
97100001	97100000	Attack	attack	0	97100000	0	0	attack	1
97110001	97110000	Attacker	attacker	0	-1	5	0	attacker	1
97110002	97110000	Victim	victim	0	-1	5	0	attacker	1
97110003	97110000	User	username	0	-1	0	0	attacker	1
97110005	97110000	Action	action	0	-1	0	0	attacker	1
97200001	97200000	Attacker	attacker	0	97200000	5	0	attacker	1
97210001	97210000	Attack	attack	0	-1	0	0	attack	1
97210002	97210000	Victim	victim	0	-1	5	0	attack	1
97210004	97210000	Action	action	0	-1	0	0	attack	1
97300001	97300000	Victim	victim	0	97300000	5	0	victim	1
97310001	97310000	Attack	attack	0	-1	0	0	attack	1
97310002	97310000	Attacker	attacker	0	-1	5	0	attack	1
97310004	97310000	Action	action	0	-1	0	0	attack	1
97400001	97400000	Attack	attack	0	97400000	0	0	attack	1
97410001	97410000	Attacker	attacker	0	-1	5	0	attacker	1
97410002	97410000	Victim	victim	0	-1	5	0	attacker	1
97410003	97410000	User	username	0	-1	0	0	attacker	1
97500001	97500000	Attack	attack	0	97500000	0	0	attack	1
97510001	97510000	Attacker	attacker	0	-1	5	0	attacker	1
97510002	97510000	Victim	victim	0	-1	5	0	attacker	1
97510003	97510000	User	username	0	-1	0	0	attacker	1
11411411	11411410	Recipient	recipient	0	-1	0	0	recipient	1
11411412	11411410	Subject	subject	0	-1	0	0	recipient	1
11411413	11411410	User	username	0	-1	0	0	recipient	1
11411414	11411410	Sender Host	host	0	-1	5	0	recipient	1
11411415	11411410	Receiver Host	destination	0	-1	5	0	recipient	1
11411511	11411510	Recipient	recipient	0	-1	0	0	recipient	1
11411512	11411510	Subject	subject	0	-1	0	0	recipient	1
11411513	11411510	Sender Host	host	0	-1	5	0	recipient	1
11411514	11411510	Receiver Host	destination	0	-1	5	0	recipient	1
11412111	11412110	Subject	subject	0	-1	0	0	subject	1
11412112	11412110	User	username	0	-1	0	0	subject	1
93310004	93310000	Severity	severity	0	-1	7	0	attack	1
94110004	94110000	Severity	severity	0	-1	7	0	attacker	1
11412113	11412110	Sender Host	host	0	-1	5	0	subject	1
11412114	11412110	Receiver Host	destination	0	-1	5	0	subject	1
11412211	11412210	Sender	sender	0	-1	0	0	sender	1
11412212	11412210	Subject	subject	0	-1	0	0	sender	1
11412213	11412210	User	username	0	-1	0	0	sender	1
11412214	11412210	Receiver Host	destination	0	-1	5	0	sender	1
11412311	11412310	Sender	sender	0	-1	0	0	sender	1
11412312	11412310	Subject	subject	0	-1	0	0	sender	1
11412313	11412310	User	username	0	-1	0	0	sender	1
11412314	11412310	Sender Host	host	0	-1	5	0	sender	1
11412411	11412410	Sender	sender	0	-1	0	0	sender	1
11412412	11412410	Subject	subject	0	-1	0	0	sender	1
11412413	11412410	User	username	0	-1	0	0	sender	1
11412414	11412410	Sender Host	host	0	-1	5	0	sender	1
11412415	11412410	Receiver Host	destination	0	-1	5	0	sender	1
11412511	11412510	Sender	sender	0	-1	0	0	sender	1
11412512	11412510	Subject	subject	0	-1	0	0	sender	1
11412513	11412510	Sender Host	host	0	-1	5	0	sender	1
11412514	11412510	Receiver Host	destination	0	-1	5	0	sender	1
11413111	11413110	Recipient	recipient	0	-1	0	0	recipient	1
11413112	11413110	Subject	subject	0	-1	0	0	recipient	1
11413113	11413110	User	username	0	-1	0	0	recipient	1
11413114	11413110	Receiver Host	destination	0	-1	5	0	recipient	1
11413211	11413210	Sender	sender	0	-1	0	0	sender	1
11413212	11413210	Subject	subject	0	-1	0	0	sender	1
11413213	11413210	User	username	0	-1	0	0	sender	1
11413214	11413210	Receiver Host	destination	0	-1	5	0	sender	1
11413311	11413310	Sender	sender	0	-1	0	0	sender	1
11413312	11413310	Recipient	recipient	0	-1	0	0	sender	1
11413313	11413310	Subject	subject	0	-1	0	0	sender	1
11413314	11413310	User	username	0	-1	0	0	sender	1
11413411	11413410	Sender	sender	0	-1	0	0	sender	1
11413412	11413410	Recipient	recipient	0	-1	0	0	sender	1
11413413	11413410	Subject	subject	0	-1	0	0	sender	1
11413414	11413410	User	username	0	-1	0	0	sender	1
11413415	11413410	Receiver Host	destination	0	-1	5	0	sender	1
11413511	11413510	Sender	sender	0	-1	0	0	sender	1
11413512	11413510	Recipient	recipient	0	-1	0	0	sender	1
11413513	11413510	Subject	subject	0	-1	0	0	sender	1
11413514	11413510	Receiver Host	destination	0	-1	5	0	sender	1
11414111	11414110	Recipient	recipient	0	-1	0	0	recipient	1
11414112	11414110	Subject	subject	0	-1	0	0	recipient	1
11414113	11414110	User	username	0	-1	0	0	recipient	1
11414114	11414110	Sender Host	host	0	-1	5	0	recipient	1
11414211	11414210	Sender	sender	0	-1	0	0	sender	1
11414212	11414210	Subject	subject	0	-1	0	0	sender	1
11414213	11414210	User	username	0	-1	0	0	sender	1
11414214	11414210	Sender Host	host	0	-1	5	0	sender	1
11414311	11414310	Sender	sender	0	-1	0	0	sender	1
11414312	11414310	Recipient	recipient	0	-1	0	0	sender	1
11414313	11414310	Subject	subject	0	-1	0	0	sender	1
11414314	11414310	User	username	0	-1	0	0	sender	1
11414411	11414410	Sender	sender	0	-1	0	0	sender	1
11414413	11414410	Subject	subject	0	-1	0	0	sender	1
11414414	11414410	User	username	0	-1	0	0	sender	1
11414415	11414410	Sender Host	host	0	-1	5	0	sender	1
11414511	11414510	Sender	sender	0	-1	0	0	sender	1
11414512	11414510	Recipient	recipient	0	-1	0	0	sender	1
11414513	11414510	Subject	subject	0	-1	0	0	sender	1
11414514	11414510	Sender Host	host	0	-1	5	0	sender	1
11415111	11415110	Recipient	recipient	0	-1	0	0	recipient	1
11415112	11415110	Subject	subject	0	-1	0	0	recipient	1
11415113	11415110	User	username	0	-1	0	0	recipient	1
11415114	11415110	Sender Host	host	0	-1	5	0	recipient	1
11415115	11415110	Receiver Host	destination	0	-1	5	0	recipient	1
11415211	11415210	Sender	sender	0	-1	0	0	sender	1
11415212	11415210	Subject	subject	0	-1	0	0	sender	1
11415213	11415210	User	username	0	-1	0	0	sender	1
11415214	11415210	Sender Host	host	0	-1	5	0	sender	1
11415215	11415210	Receiver Host	destination	0	-1	5	0	sender	1
11415311	11415310	Sender	sender	0	-1	0	0	sender	1
11415312	11415310	Recipient	recipient	0	-1	0	0	sender	1
11415313	11415310	Subject	subject	0	-1	0	0	sender	1
11415314	11415310	User	username	0	-1	0	0	sender	1
11415315	11415310	Receiver Host	destination	0	-1	5	0	sender	1
11415411	11415410	Sender	sender	0	-1	0	0	sender	1
11415412	11415410	Recipient	recipient	0	-1	0	0	sender	1
11415413	11415410	Subject	subject	0	-1	0	0	sender	1
11415414	11415410	User	username	0	-1	0	0	sender	1
11415415	11415410	Sender Host	host	0	-1	5	0	sender	1
11415511	11415510	Sender	sender	0	-1	0	0	sender	1
11415512	11415510	Recipient	recipient	0	-1	0	0	sender	1
11415513	11415510	Subject	subject	0	-1	0	0	sender	1
11415514	11415510	Sender Host	host	0	-1	5	0	sender	1
11415515	11415510	Receiver Host	destination	0	-1	5	0	sender	1
28051	28050	User	username	0	132000	0	0	username	1
29011	29010	Recipient	recipient	0	511000	0	0	recipient	1
29031	29030	Source Host	host	0	512000	5	0	host	1
29051	29050	Destination	destination	0	513000	5	0	destination	1
29071	29070	User	username	0	514000	0	0	username	1
29021	29020	Sender	sender	0	521000	0	0	sender	1
29041	29040	Source Host	host	0	522000	5	0	host	1
29061	29060	Destination	destination	0	523000	5	0	destination	1
29081	29080	User	username	0	524000	0	0	username	1
29091	29090	Sender	sender	0	1011000	0	0	sender	1
29101	29100	Recipient	recipient	0	1021000	0	0	recipient	1
535001	535000	Application	application	0	535000	6	0	application	1
26051	26050	Host	srcip	0	1432000	5	0	srcip	1
28021	28020	Category	category	0	4510000	0	0	category	1
26031	26030	File	file	0	6310000	0	0	file	1
26041	26040	File	file	0	6410000	0	0	file	1
28031	28030	File	file	0	6510000	0	0	file	1
28041	28040	File	file	0	6610000	0	0	file	1
545001	545000	Application	application	0	545000	6	0	application	1
531105	531100	Application	application	0	-1	6	0		1
26081	26080	Virus	virus	0	11331000	0	0	virus	1
26021	26020	Category	category	0	41100000	0	0	category	1
26071	26070	Category	category	0	81100000	0	0	category	1
28071	28070	Category	category	0	84100000	0	0	category	1
28091	28090	Attack	attack	0	93100000	0	0	attack	1
28081	28080	Attack	attack	0	94100000	0	0	attack	1
532105	532100	Application	application	0	-1	6	0		1
1548111	1548110	Application	application	0	-1	6	0	application	1
1548211	1548210	Application	application	0	-1	6	0	application	1
1539011	1539010	Application	application	0	1549000	6	0	application	1
1549111	1549110	Application	application	0	-1	6	0	application	1
1549211	1549210	Application	application	0	-1	6	0	application	1
15310011	15310010	Application	application	0	15410000	6	0	application	1
20601001	20601000	Application	application	0	-1	6	0	application	1
20701001	20701000	Application	application	0	-1	6	0	application	1
20801001	20801000	Application	application	0	-1	6	0	application	1
20901001	20901000	Application	application	0	-1	6	0	application	1
400	127	Application	application	0	-1	6	0	srcip	1
7231001	7231000	Application	application	0	7231000	6	0	application	1
7232101	7232100	Application	application	0	-1	6	0	application	1
7233101	7233100	Application	application	0	-1	6	0	application	1
7241001	7241000	Application	application	0	7241000	6	0	application	1
7242101	7242100	Application	application	0	-1	6	0	application	1
7243101	7243100	Application	application	0	7243100	6	0	application	1
7321001	7321000	Application	application	0	7321000	6	0	application	1
7322101	7322100	Application	application	0	-1	6	0	application	1
7331001	7331000	Application	application	0	7331000	6	0	application	1
7332101	7332100	Application	application	0	-1	6	0	application	1
7411001	7411000	Application	application	0	7411000	6	0	application	1
7412101	7412100	Application	application	0	-1	6	0	application	1
94210004	94210000	Severity	severity	0	-1	7	0	attack	1
94310004	94310000	Severity	severity	0	-1	7	0	attack	1
97110004	97110000	Severity	severity	0	-1	7	0	attacker	1
97210003	97210000	Severity	severity	0	-1	7	0	attack	1
97310003	97310000	Severity	severity	0	-1	7	0	attack	1
97410004	97410000	Severity	severity	0	-1	7	0	attacker	1
20101	20100	CPU	usagetype	0	20100	0	0		0
20102	20100	Percent	usage	0	-1	3	0		0
10062	1006	Bytes	field2	0	-1	2	1	field1	0
10052	1005	Bytes	field2	0	-1	2	1	field1	0
20201	20200	Memory	usagetype	0	20200	0	0		0
20202	20200	Usage	usage	0	-1	2	0		0
20301	20300	Disk	usagetype	0	20300	0	0		0
20302	20300	Usage	usage	0	-1	2	0		0
20111	20110	Time (YYYY-MM-DD HH:MM:SS)	usagetype	0	-1	0	0		0
20112	20110	Usage	usage	0	-1	0	0		0
20211	20210	Time (YYYY-MM-DD HH:MM:SS)	usagetype	0	-1	0	0		0
20212	20210	Usage	usage	0	-1	0	0		0
20311	20310	Time (YYYY-MM-DD HH:MM:SS)	usagetype	0	-1	0	0		0
20312	20310	Usage	usage	0	-1	0	0		0
20321	20320	Time (YYYY-MM-DD HH:MM:SS)	usagetype	0	-1	0	0		0
20322	20320	Usage	usage	0	-1	0	0		0
\.


ALTER SEQUENCE tblreportcolumn_reportcolumnid_seq RESTART 200000000; 

ALTER TABLE ONLY tblreportcolumn
    ADD CONSTRAINT tblreportcolumn_pkey PRIMARY KEY (reportcolumnid);



DROP TABLE IF EXISTS tblreportgroup cascade;
CREATE TABLE tblreportgroup (
    reportgroupid serial UNIQUE NOT NULL,
    title character varying(255) DEFAULT NULL::character varying,
    description character varying(255) DEFAULT NULL::character varying,
    inputparams character varying(255) DEFAULT NULL::character varying,
    grouptype integer DEFAULT 0,
    menuorder integer DEFAULT 100
);

COPY tblreportgroup (reportgroupid, title, description, inputparams, grouptype, menuorder) FROM stdin;
7	Host {0} Reports	\N	srcip,deviceid	0	100
8	User {0} Reports	\N	username,deviceid	0	100
9	Protocol Goup {0} Reports	\N	proto_group,deviceid	0	100
10	Rule id {0} Reports	\N	ruleid,deviceid	0	100
16	Application {0} Reports	\N	application,deviceid	0	100
18	Rule Id {0} Accept Report	\N	ruleid,deviceid	0	100
11	Host {0} and Protocol Group {1} Reports	\N	srcip,proto_group,deviceid	0	100
12	User {0} and Protocol Group {1} Reports	\N	username,proto_group,deviceid	0	100
13	Protocol Group {0} Protocol {1} Reports	\N	proto_group,application,deviceid	0	100
14	Protocol Group {0} Destination {1} Reports	\N	proto_group,destip,deviceid	0	100
19	Rule Id {0} Deny Report	\N	ruleid,deviceid	0	100
20	Rule Id {0} and Protocol Group {1} Accept Report	\N	ruleid,proto_group,deviceid	0	100
21	Rule Id {0} and Protocol Group {1} Deny Report	\N	ruleid,proto_group,deviceid	0	100
22	Rule Id {0} and Host {1} Accept Report	\N	ruleid,srcip,deviceid	0	100
23	Rule Id {0} and Host {1} Deny Report	\N	ruleid,srcip,deviceid	0	100
24	Rule Id {0} and Destination {1} Accept Report	\N	ruleid,destip,deviceid	0	100
25	Rule Id {0} and Destination {1} Deny Report	\N	ruleid,destip,deviceid	0	100
27	Procedure Logs	\N		0	100
6	Source Host Based Usage	\N	deviceid	1	100
15	Application Based Usage	\N	deviceid	1	100
17	Firewall Rule Based Usage	\N	deviceid	1	100
500000	Mail Usage	\N	deviceid	1	100
600000	FTP Usage	\N	deviceid	1	100
103000	Host {0} and Protocol Group {1} 		srcip,proto_group,deviceid	0	100
104000	Host {0}, Protocol Group {1} and Application {2}		srcip,proto_group,application	0	100
104100	Host {0}, Protocol Group {1} and Destination {2}		srcip,proto_group,destip	0	100
104200	Host {0}, Protocol Group {1} and User {2}		srcip,proto_group,username	0	100
105000	Host {0},Protocol Group {1},User {2} and Application{3}		srcip,proto_group,username,application	0	100
131000	Host {0} and Destination {1} 		srcip,destip	0	100
141000	Host {0}, Destination {1} and Application {2}		srcip,destip,appliction	0	100
700000	Blocked Attempts	\N	deviceid	1	100
141100	Host {0}, Destination {1} and User {2}		srcip,destip,username	0	100
132000	Host {0} and User {1} 		srcip,username	0	100
142000	Host {0}, User {1} and Application {2}		srcip,username,application	0	100
142100	Host {0}, User {1} and Destination {2}		srcip,username,destip	0	100
135000	Host {0} and Protocol Group {1} 		srcip,proto_group,deviceid	0	100
800000	Blocked Web Attempts	\N	deviceid	1	100
900000	Attacks	\N	deviceid	1	100
1100000	Virus	\N	deviceid	1	100
1002	Dashboard	Dashboard		0	100
1001	Main Dashboard	Main Dashboard		0	100
1430000	User {0} Reports and Application Group {1}		username,proto_group	0	100
134000	Host {0} and Protocol Group {1} 		srcip,proto_group,deviceid	0	100
144000	Host {0}, Protocol Group {1} and Application {2}		srcip,proto_group,application	0	100
144100	Host {0}, Protocol Group {1} and Destination {2}		srcip,proto_group,destip	0	100
144200	Host {0}, Protocol Group {1} and User {2}		srcip,proto_group,username	0	100
154000	Host {0},Protocol Group {1},User {2} and Application{3}		srcip,proto_group,username,application	0	100
1440000	User {0} Reports , Application Group {1} and Application {2}		username,proto_group,application	0	100
100001	Host {0} Reports		srcip,deviceid	0	100
100002	Host {0} Reports		srcip,deviceid	0	100
1440100	User {0} Reports,Application Group {1} and Destination {2}		username,proto_group,destip	0	100
1440200	User {0} Reports,Application Group {1} and Host {2}		username,proto_group,srcip	0	100
1450000	User {0} Reports,Application Group {1}, Host {2} and Destination {3}		username,proto_group,srcip,application	0	100
1431000	User {0} Reports and Destination {1}		username,destip	0	100
1441000	User {0} Reports, Destination {1} and Application {2}		username,destip,application	0	100
1441100	User {0} Reports, Destination {1} and Host {2}		username,destip,srcip	0	100
1432000	User {0} Reports and Host {1}		username,srcip	0	100
1442000	User {0} Reports, Host {1} and Application {2}		username,srcip,application	0	100
1442100	User {0} Reports, Host {1} and Destination {2}		username,srcip,destip	0	100
1434000	User {0} Reports and Application Group {1}		username,proto_group	0	100
1444000	User {0} Reports , Application Group {1} and Application {2}		username,proto_group,application	0	100
1444100	User {0} Reports,Application Group {1} and Destination {2}		username,proto_group,destip	0	100
1444200	User {0} Reports,Application Group {1} and Host {2}		username,proto_group,srcip	0	100
1454000	User {0} Reports,Application Group {1}, Host {2} and Destination {3}		username,proto_group,srcip,application	0	100
1435000	User {0} Reports and Application Group {1}		username,proto_group	0	100
1445000	User {0} Reports , Application Group {1} and Application {2}		username,proto_group,application	0	100
1445100	User {0} Reports,Application Group {1} and Destination {2}		username,proto_group,destip	0	100
1445200	User {0} Reports,Application Group {1} and Host {2}		username,proto_group,srcip	0	100
1455000	User {0} Reports,Application Group {1}, Host {2} and Destination {3}		username,proto_group,srcip,application	0	100
1436000	User {0} Reports and Destination {1}		username,destip	0	100
1446000	User {0} Reports, Destination {1} and Application {2}		username,destip,application	0	100
1446100	User {0} Reports, Destination {1} and Host {2}		username,destip,srcip	0	100
1437000	User {0} Reports and Destination {1}		username,destip	0	100
1447000	User {0} Reports, Destination {1} and Application {2}		username,destip,application	0	100
1447100	User {0} Reports, Destination {1} and Host {2}		username,destip,srcip	0	100
1438000	User {0} Reports and Host {1}		username,srcip	0	100
1448000	User {0} Reports, Host {1} and Application {2}		username,srcip,application	0	100
1448100	User {0} Reports, Host {1} and Destination {2}		username,srcip,destip	0	100
1439000	User {0} Reports and Host {1}		username,srcip	0	100
1449000	User {0} Reports, Host {1} and Application {2}		username,srcip,application	0	100
1449100	User {0} Reports, Host {1} and Destination {2}		username,srcip,destip	0	100
1530000	Application Group {0} and Application {1}		proto_group,application,deviceid	0	100
1540000	Application Group {0}, Application {1} and Username {2}		proto_group,application,username,deviceid	0	100
1540100	Application Group {0}, Application {1} and Destination {2}		proto_group,application,destip,deviceid	0	100
1540200	Application Group {0}, Application {1} and Host {2}		proto_group,application,srcip,deviceid	0	100
1531000	Application Group {0} and User {1}		proto_group,usename,deviceid	0	100
1541000	Application Group {0}, User {1} and Application {2}		proto_group,usename,application,deviceid	0	100
1541100	Application Group {0}, User {1} and Destination {2}		proto_group,usename,destination,deviceid	0	100
1541200	Application Group {0}, User {1} and Host {2}		proto_group,usename,srcip,deviceid	0	100
1551000	Application Group {0}, User {1}, Host {2} And Application {3}		proto_group,usename,application,deviceid	0	100
1551100	Application Group {0}, User {1}, Host {2} And Destination {3}		proto_group,usename,destination,deviceid	0	100
1532000	Application Group {0} and Destination {1}		proto_group,destip,deviceid	0	100
1542000	Application Group {0}, Destination {1} and Application {2}		proto_group,destip,application,deviceid	0	100
1542100	Application Group {0}, Destination {1} and User {2}		proto_group,destip,username,deviceid	0	100
1542200	Application Group {0}, Destination {1} and Host {2}		proto_group,destip,srcip,deviceid	0	100
1533000	Application Group {0} and Host {1}		proto_group,srcip,deviceid	0	100
1543000	Application Group {0}, Host {1} and Application {2}		proto_group,srcip,application,deviceid	0	100
1543100	Application Group {0}, Host {1} and Destination {2}		proto_group,srcip,destip,deviceid	0	100
1543200	Application Group {0}, Host {1} and User {2}		proto_group,srcip,username,deviceid	0	100
1553000	Application Group {0}, Host {1}, User {2} and Application {3}		proto_group,srcip,username,application,deviceid	0	100
1553100	Application Group {0}, Host {1}, User {2} and Destination {3}		proto_group,srcip,username,destip,deviceid	0	100
1534000	Application Group {0} and Application {1}		proto_group,application,deviceid	0	100
1544000	Application Group {0}, Application {1} and Username {2}		proto_group,application,username,deviceid	0	100
1544100	Application Group {0}, Application {1} and Destination {2}		proto_group,application,destip,deviceid	0	100
1544200	Application Group {0}, Application {1} and Host {2}		proto_group,application,srcip,deviceid	0	100
1535000	Application Group {0} and Application {1}		proto_group,application,deviceid	0	100
145000	Host {0}, Protocol Group {1} and Application {2}		srcip,proto_group,application	0	100
145100	Host {0}, Protocol Group {1} and Destination {2}		srcip,proto_group,destip	0	100
145200	Host {0}, Protocol Group {1} and User {2}		srcip,proto_group,username	0	100
155000	Host {0},Protocol Group {1},User {2} and Application{3}		srcip,proto_group,username,application	0	100
136000	Host {0} and Destination {1} 		srcip,destip	0	100
146000	Host {0}, Destination {1} and Application {2}		srcip,destip,appliction	0	100
146100	Host {0}, Destination {1} and User {2}		srcip,destip,username	0	100
137000	Host {0} and Destination {1} 		srcip,destip	0	100
147000	Host {0}, Destination {1} and Application {2}		srcip,destip,appliction	0	100
147100	Host {0}, Destination {1} and User {2}		srcip,destip,username	0	100
138000	Host {0} and User {1} 		srcip,username	0	100
148000	Host {0}, User {1} and Application {2}		srcip,username,application	0	100
148100	Host {0}, User {1} and Destination {2}		srcip,username,destip	0	100
139000	Host {0} and User {1} 		srcip,username	0	100
149000	Host {0}, User {1} and Application {2}		srcip,username,application	0	100
149100	Host {0}, User {1} and Destination {2}		srcip,username,destip	0	100
1545000	Application Group {0}, Application {1} and Username {2}		proto_group,application,username,deviceid	0	100
1545100	Application Group {0}, Application {1} and Destination {2}		proto_group,application,destip,deviceid	0	100
1545200	Application Group {0}, Application {1} and Host {2}		proto_group,application,srcip,deviceid	0	100
1536000	Application Group {0} and User {1}		proto_group,usename,deviceid	0	100
1546000	Application Group {0}, User {1} and Application {2}		proto_group,usename,application,deviceid	0	100
1546100	Application Group {0}, User {1} and Destination {2}		proto_group,usename,destination,deviceid	0	100
1546200	Application Group {0}, User {1} and Host {2}		proto_group,usename,srcip,deviceid	0	100
1556000	Application Group {0}, User {1}, Host {2} And Application {3}		proto_group,usename,application,deviceid	0	100
1556100	Application Group {0}, User {1}, Host {2} And Destination {3}		proto_group,usename,destination,deviceid	0	100
1537000	Application Group {0} and User {1}		proto_group,usename,deviceid	0	100
1547000	Application Group {0}, User {1} and Application {2}		proto_group,usename,application,deviceid	0	100
1547100	Application Group {0}, User {1} and Destination {2}		proto_group,usename,destination,deviceid	0	100
1547200	Application Group {0}, User {1} and Host {2}		proto_group,usename,srcip,deviceid	0	100
1557000	Application Group {0}, User {1}, Host {2} And Application {3}		proto_group,usename,application,deviceid	0	100
1557100	Application Group {0}, User {1}, Host {2} And Destination {3}		proto_group,usename,destination,deviceid	0	100
1538000	Application Group {0} and Destination {1}		proto_group,destip,deviceid	0	100
1548000	Application Group {0}, Destination {1} and Application {2}		proto_group,destip,application,deviceid	0	100
1548100	Application Group {0}, Destination {1} and User {2}		proto_group,destip,username,deviceid	0	100
1548200	Application Group {0}, Destination {1} and Host {2}		proto_group,destip,srcip,deviceid	0	100
1539000	Application Group {0} and Destination {1}		proto_group,destip,deviceid	0	100
1549000	Application Group {0}, Destination {1} and Application {2}		proto_group,destip,application,deviceid	0	100
1549100	Application Group {0}, Destination {1} and User {2}		proto_group,destip,username,deviceid	0	100
1549200	Application Group {0}, Destination {1} and Host {2}		proto_group,destip,srcip,deviceid	0	100
15310000	Application Group {0} and Host {1}		proto_group,srcip,deviceid	0	100
15410000	Application Group {0}, Host {1} and Application {2}		proto_group,srcip,application,deviceid	0	100
15410100	Application Group {0}, Host {1} and Destination {2}		proto_group,srcip,destip,deviceid	0	100
15410200	Application Group {0}, Host {1} and User {2}		proto_group,srcip,username,deviceid	0	100
15510000	Application Group {0}, Host {1}, User {2} and Application {3}		proto_group,srcip,username,application,deviceid	0	100
15510100	Application Group {0}, Host {1}, User {2} and Destination {3}		proto_group,srcip,username,destip,deviceid	0	100
15311000	Application Group {0} and Host {1}		proto_group,srcip,deviceid	0	100
15411000	Application Group {0}, Host {1} and Application {2}		proto_group,srcip,application,deviceid	0	100
15411100	Application Group {0}, Host {1} and Destination {2}		proto_group,srcip,destip,deviceid	0	100
15411200	Application Group {0}, Host {1} and User {2}		proto_group,srcip,username,deviceid	0	100
15511000	Application Group {0}, Host {1}, User {2} and Application {3}		proto_group,srcip,username,application,deviceid	0	100
15511100	Application Group {0}, Host {1}, User {2} and Destination {3}		proto_group,srcip,username,destip,deviceid	0	100
1420000	User {0} Reports		username,deviceid	0	100
1420001	User {0} Reports		username,deviceid	0	100
1420002	User {0} Reports		username,deviceid	0	100
1520000	Application Goup {0} Reports		proto_group,deviceid	0	100
1520001	Application Goup {0} Reports		proto_group,deviceid	0	100
1520002	Application Goup {0} Reports		proto_group,deviceid	0	100
20101000	Application {0} Reports		application,deviceid	0	100
20201000	Application {0} Reports		application,deviceid	0	100
20301000	Application {0} Reports		application,deviceid	0	100
20401000	User {0} and Protocol Group {1} Reports		username,proto_group,deviceid	0	100
20501000	User {0} and Protocol Group {1} Reports		username,proto_group,deviceid	0	100
20601000	User {0} and Protocol Group {1} Reports		username,proto_group,deviceid	0	100
20701000	Host {0} and Protocol Group {1} Reports		srcip,proto_group,deviceid	0	100
20801000	Host {0} and Protocol Group {1} Reports		srcip,proto_group,deviceid	0	100
20901000	Host {0} and Protocol Group {1} Reports		srcip,proto_group,deviceid	0	100
20101100	User {0} and Application {1}		username,application,deviceid	0	100
20102100	Destination {0} and Application {1}		destip,application,deviceid	0	100
20103100	Host {0} and Application {1}		srcip,application,deviceid	0	100
20201100	User {0} and Application {1}		username,application,deviceid	0	100
20202100	Destination {0} and Application {1}		destip,application,deviceid	0	100
20203100	Host {0} and Application {1}		srcip,application,deviceid	0	100
20301100	User {0} and Application {1}		username,application,deviceid	0	100
20302100	Destination {0} and Application {1}		destip,application,deviceid	0	100
20303100	Host {0} and Application {1}		srcip,application,deviceid	0	100
4400000	Content {0} Reports		content,deviceid	0	100
4410000	Content {0} and Domain {1} Reports		content,domain,deviceid	0	100
4411000	Content {0}, Domain {1} and User {2}		content,domain,username,deviceid	0	100
4420000	Content {0} and User {1} reports		content,username,deviceid	0	100
4421000	Content {0}, Domain {1} and User {2}		content,domain,username,deviceid	0	100
4422000	Content {0}, Category {1} and User {2}		content,category,username,deviceid	0	100
4422100	Content {0}, Category {1}, User {2} and Domain {3}		content,category,username,domain,deviceid	0	100
4430000	Content {0} and Category {1} Reports		content,category,deviceid	0	100
4431000	Content {0}, Category {1} and User {2}		content,category,username,deviceid	0	100
4431100	Content {0}, Category {1}, User {2} and Domain {3}		content,category,username,domain,deviceid	0	100
4432000	Content {0}, Category {1} and Domain {2}		content,category,domain,deviceid	0	100
4500000	Web Host {0} Reports		host,deviceid	0	100
4510000	Web Host {0} and Category {1} Reports		host,category,deviceid	0	100
4511000	Web Host {0}, Category {1} and Domain {2}		host,category,domain,deviceid	0	100
4520000	Web Host {0} and Domain {1} Reports		host,domain,deviceid	0	100
4530000	Web Host {0} and Content {1} Reports		host,content,deviceid	0	100
4531000	Web Host {0}, Content {1} and Domain {2}		host,content,domain,deviceid	0	100
4550000	Web Host {0} and User {1} Reports		host,username,deviceid	0	100
4551000	Web Host {0}, User {1} and Category {2}		host,username,category,deviceid	0	100
4551100	Web Host {0}, User {1}, Category {2} and Domain {3}		host,username,category,domain,deviceid	0	100
4552000	Web Host {0}, User {1} and Domain {2}		host,username,domain,deviceid	0	100
4553000	Web Host {0}, User {1} and Content {2}		host,username,content,deviceid	0	100
4553100	Web Host {0}, User {1}, Content {2} and Domain {3}		host,username,content,domain,deviceid	0	100
4555000	Web Host {0}, User {1} and Application {2}		host,username,application,deviceid	0	100
4555100	Web Host {0}, User {1} Application {2} and Category {3}		host,username,application,category,deviceid	0	100
4555110	Web Host {0}, User {1} Application {2}, Category {3} and Domain {4}		host,username,application,category,domain,deviceid	0	100
4555200	Web Host {0}, User {1} Application {2} and Content {3}		host,username,application,content,deviceid	0	100
4555210	Web Host {0}, User {1} Application {2}, Content {3} and Domain {4}		host,username,application,content,domain,deviceid	0	100
4560000	Web Host {0} and Application {1} Reports		host,application,deviceid	0	100
4561000	Web Host {0}, Application {1} and Category {2}		host,application,category,deviceid	0	100
4561100	Web Host {0}, Application {1}, Category {2} and Domain {3}		host,application,category,domain,deviceid	0	100
4562000	Web Host {0}, Application {1} and Content {2}		host,application,content,deviceid	0	100
4562100	Web Host {0}, Application {1}, Content {2} and Domain {3}		host,application,content,domain,deviceid	0	100
46000000	Application {0} reports		application,deviceid	0	100
46100000	Application {0} and Category {1} reports		application,category,deviceid	0	100
46110000	Application {0}, Category {1} and Domain {2}		application,category,domain,deviceid	0	100
46111000	Application {0}, Category {1}, Domain {2} and User {3}		application,category,domain,username,deviceid	0	100
46120000	Application {0}, Category {1} and User {2}		application,category,username,deviceid	0	100
46121000	Application {0}, Category {1}, User {2} and Domain {3}		application,category,username,domain,deviceid	0	100
46122000	Application {0}, Category {1}, User {2} and Content {3}		application,category,username,content,deviceid	0	100
46122100	Application {0}, Category {1}, User {2}, Content {3} and Domain {4}		application,category,username,content,domain,deviceid	0	100
46130000	Application {0}, Category {1} and Content {2}		application,category,content,deviceid	0	100
46131000	Application {0}, Category {1}, Content {2} and User {3}		application,category,content,username,deviceid	0	100
46131100	Application {0}, Category {1}, Content {2}, User {3} and Domain {4}		application,category,content,username,domain,deviceid	0	100
46132000	Application {0}, Category {1}, Content {2} and Domain {3}		application,category,content,domain,deviceid	0	100
46132100	Application {0}, Category {1}, Content {2}, Domain {3} and User {4}		application,category,content,domain,username,deviceid	0	100
46200000	Application {0} and Domain {1}		application,domain,deviceid	0	100
46210000	Application {0}, Domain {1} and User {2}		application,domain,username,deviceid	0	100
46220000	Application {0}, Domain {1} and Content {2}		application,domain,content,deviceid	0	100
46221000	Application {0}, Domain {1}, Content {2} and User {3}		application,domain,content,username,deviceid	0	100
46300000	Application {0} and Web User {1} Reports		application,username,deviceid	0	100
46310000	Application {0}, Web User {1} and Category {2}		application,username,category,deviceid	0	100
46311000	Application {0}, Web User {1}, Category {2} and Domain {3}		application,username,category,domain,deviceid	0	100
46320000	Application {0}, Web User {1} and Domain {2}		application,username,domain,deviceid	0	100
46330000	Application {0}, Web User {1} and Content {2}		application,username,content,deviceid	0	100
46331000	Application {0}, Web User {1}, Content {2} and Domain {3}		application,username,content,domain,deviceid	0	100
46400000	Application {0} and Content {1} Reports		application,content,deviceid	0	100
46410000	Application {0}, Content {1} and Domain {2}		application,content,domain,deviceid	0	100
46411000	Application {0}, Content {1}, Domain {2} and User {3}		application,content,domain,username,deviceid	0	100
46420000	Application {0}, Content {1} and User {2}		application,content,username,deviceid	0	100
46421000	Application {0}, Content {1}, User {2} and Domain {3}		application,content,username,domain,deviceid	0	100
46422000	Application {0}, Content {1}, User {2} and Category {3}		application,content,username,category,deviceid	0	100
46422100	Application {0}, Content {1}, User {2}, Category {3} and Domain {4}		application,content,username,category,domain,deviceid	0	100
46430000	Application {0}, Content {1} and Category {2}		application,content,category,deviceid	0	100
46431000	Application {0}, Content {1}, Category {2} and User {3}		application,content,category,username,deviceid	0	100
46431100	Application {0}, Content {1}, Category {2}, User {3} and Domain {4}		application,content,category,username,domain,deviceid	0	100
46432000	Application {0}, Content {1}, Category {2} and Domain {3}		application,content,category,domain,deviceid	0	100
41000000	Web user {0}		username	0	100
41100000	Web user {0} and Category {1}		username,category	0	100
41200000	Web user {0} and Domain {1}		username,domain	0	100
41300000	Web user {0} and Content {1}		username,content	0	100
41500000	Web user {0} and Host {1}		username,host	0	100
41600000	Web user {0} and Application {1}		username,application	0	100
41110000	Web user {0}, Category {1} and Domain {2}		username,category,domain	0	100
41310000	Web user {0}, Content {1} and Domain {2}		username,content,domain	0	100
41510000	Web user {0}, Host {1}  and Category {2}		username,host,category	0	100
41511000	Web user {0}, Host {1}, Category {2} and Domain {3}		username,host,category,domain	0	100
41520000	Web user {0}, Host {1}  and Domain {2}		username,host,domain	0	100
41530000	Web user {0}, Host {1}  and Content {2}		username,host,content	0	100
41531000	Web user {0}, Host {1}, Content {2} and Domain {3}		username,host,content,domain	0	100
41550000	Web user {0}, Host {1}  and Application {2}		username,host,application	0	100
41551000	Web user {0}, Host {1}, Application {2} and Category {3}		username,host,application,category	0	100
41552000	Web user {0}, Host {1}, Application {2} and Content {3}		username,host,application,content	0	100
41551100	Web user {0}, Host {1}, Application {2}, Category {3} and Domain {4}		username,host,application,category,domain	0	100
41552100	Web user {0}, Host {1}, Application {2}, Content {3} and Domain {4}		username,host,application,content,domain	0	100
41610000	Web user {0}, Application {1} and Category {2}		username,application,category	0	100
41620000	Web user {0}, Application {1} and Content {2}		username,application,content	0	100
41611000	Web user {0}, Application {1}, Category {2} and  Domain {3}		username,application,category,domain	0	100
41621000	Web user {0}, Application {1}, Content {2} and Domain {3}		username,application,content,domain	0	100
46112100	Application {0}, Category {1}, Content {2}, Domain {3} and User {4}		application,category,content,domain,username,deviceid	0	100
46112000	Application {0}, Category {1}, Domain {2} and Content {3}		application,category,domain,content,deviceid	0	100
400000	Web Usage		deviceid	1	100
42000000	Category {0}		category	0	100
42100000	Category {0} and Domain {1}		category,domain	0	100
42200000	Category {0} and User {1}		category,username	0	100
42300000	Category {0} and Content {1}		category,content	0	100
42110000	Category {0}, Domain {1} and User {2}		category,domain,username	0	100
42120000	Category {0}, Domain {1} and Content {2}		category,domain,content	0	100
42121000	Category {0}, Domain {1}, Content {2} and User {3}		category,domain,content,username	0	100
42210000	Category {0}, User {1} and Domain {2}		category,username,domain	0	100
42220000	Category {0}, User {1} and Content {2}		category,username,content	0	100
42221000	Category {0}, User {1}, Content {2} and URL {3}		category,username,content,url	0	100
42310000	Category {0}, Content {1} and User{2}		category,content,username	0	100
42320000	Category {0}, Content {1} and Domain{2}		category,content,domain	0	100
42311000	Category {0}, Content {1}, User{2} and Domain{3}		category,content,username,domain	0	100
42321000	Category {0}, Content {1} , Domain{2} and User{3}		category,content,domain,username	0	100
43000000	Domain {0}		domain	0	100
43100000	Domain {0} and User {1}		domain,username	0	100
43200000	Domain {0} and Content {1}		domain,content	0	100
43210000	Domain {0}, Content {1} and User {2}		domain,content,username	0	100
7100000	Denied User {0} Reports		username,deviceid	0	100
7110000	User {0} and Application Group {1} Reports		username,proto_group,deviceid	0	100
7111000	User {0}, Application Group {1} and Application {2}		username,proto_group,application,deviceid	0	100
7112000	User {0}, Application Group {1} and Destination {2}		username,proto_group,destination,deviceid	0	100
7113000	User {0}, Application Group {1} and Host {2}		username,proto_group,host,deviceid	0	100
7113100	User {0}, Application Group {1}, Host {2} and Application {3}		username,proto_group,host,application,deviceid	0	100
7120000	User {0} and Destination {1} Reports		username,destination,deviceid	0	100
7121000	User {0}, Destination {1} and Application {2}		username,destination,application,deviceid	0	100
7122000	User {0}, Destination {1} and Host {2}		username,destination,host,deviceid	0	100
7130000	User {0} and Host {1} Reports		username,host,deviceid	0	100
7131000	User {0}, Host {1} and Application {2}		username,host,application,deviceid	0	100
7132000	User {0}, Host {1} and Destination {2}		username,host,destination,deviceid	0	100
7200000	Denied Application Group {0} Reports		proto_group,deviceid	0	100
7210000	Application Group {0} and Application {1} Reports		proto_group,application,deviceid	0	100
7211000	Application Group {0}, Application {1} and User {2}		proto_group,application,username,deviceid	0	100
7212000	Application Group {0}, Application {1} and Destination {2}		proto_group,application,destination,deviceid	0	100
7213000	Application Group {0}, Application {1} and Host {2}		proto_group,application,host,deviceid	0	100
7220000	Application Group {0} and User {1} Reports		proto_group,username,deviceid	0	100
7221000	Application Group {0}, User {1} and Application {2}		proto_group,username,application,deviceid	0	100
7222000	Application Group {0}, User {1} and Destination {2}		proto_group,username,destination,deviceid	0	100
7223000	Application Group {0}, User {1} and Host {2}		proto_group,username,host,deviceid	0	100
7223100	Application Group {0}, User {1}, Host {2} and Application {3}		proto_group,username,host,application,deviceid	0	100
7223200	Application Group {0}, User {1}, Host {2} and Destination {3}		proto_group,username,host,destination,deviceid	0	100
7230000	Application Group {0} and Destination {1} Reports		proto_group,destination,deviceid	0	100
7231000	Application Group {0}, Destination {1} and Application {2}		proto_group,destination,application,deviceid	0	100
7232000	Application Group {0}, Destination {1} and User {2}		proto_group,destination,username,deviceid	0	100
7233000	Application Group {0}, Destination {1} and Host {2}		proto_group,destination,host,deviceid	0	100
7240000	Application Group {0} and Host {1} Reports		proto_group,host,deviceid	0	100
7241000	Application Group {0}, Host {1} and Application {2}		proto_group,host,application,deviceid	0	100
7242000	Application Group {0}, Host {1} and Destination {2}		proto_group,host,destination,deviceid	0	100
7243000	Application Group {0}, Host {1} and User {2}		proto_group,host,username,deviceid	0	100
7243100	Application Group {0}, Host {1}, User {2} and Application {3}		proto_group,host,username,application,deviceid	0	100
7243200	Application Group {0}, Host {1}, User {2} and Destination {3}		proto_group,host,username,destination,deviceid	0	100
7300000	Denied Host {0} Reports		host,deviceid	0	100
7310000	Denied Host {0} and Application Group {1} Reports		proto_group,host,deviceid	0	100
7311000	Denied Host {0},Application Group {1} and Application {2}		application,proto_group,host,deviceid	0	100
7312000	Denied Host {0},Application Group {1} and Destination {2}		destination,proto_group,host,deviceid	0	100
7313000	Denied Host {0},Application Group {1} and User {2}		host,proto_group,username,deviceid	0	100
7313100	Denied Host {0},Application Group {1}, User {2} and Application {3}		host,proto_group,username,application,deviceid	0	100
7320000	Denied Host {0} and Destination {1} Reports		host,destination,deviceid	0	100
7321000	Denied Host {0}, Destination {1} and Application {2}		host,destination,application,deviceid	0	100
7322000	Denied Host {0}, Destination {1} and User {2}		host,destination,username,deviceid	0	100
7330000	Denied Host {0} and User {1} Reports		host,username,deviceid	0	100
7331000	Denied Host {0}, User {1} and Application {2}		host,username,application,deviceid	0	100
7332000	Denied Host {0}, User {1} and Destination {2}		host,username,destination,deviceid	0	100
7400000	Denied Destination {0} Reports		destination,deviceid	0	100
7410000	Denied Destination {0} and Application Group {1} Reports		destination,proto_group,deviceid	0	100
7411000	Denied Destination {0}, Application Group {1} and Application {2}		destination,proto_group,application,deviceid	0	100
7412000	Denied Destination {0}, Application Group {1} and User {2}		destination,proto_group,username,deviceid	0	100
7413000	Denied Destination {0}, Application Group {1} and Host {2}		destination,proto_group,host,deviceid	0	100
7420000	Denied Destination {0} and User {1} Reports		destination,username,deviceid	0	100
7421000	Denied Destination {0}, User {1} and Application {2}		destination,username,application,deviceid	0	100
7422000	Denied Destination {0}, User {1} and Host {2}		destination,username,host,deviceid	0	100
7430000	Denied Destination {0} and Host {1} Reports		destination,host,deviceid	0	100
7431000	Denied Destination {0}, Host {1} and Application {2}		destination,host,application,deviceid	0	100
7432000	Denied Destination {0}, Host {1} and User {2}		destination,host,username,deviceid	0	100
81000000	Top Denied Web Users {0}		username	0	100
81100000	Top Denied Web Users {0} and Category {1}		username,category	0	100
81200000	Top Denied Web Users {0} and Domain {1}		username,domain	0	100
81400000	Top Denied Web Users {0} and Host {1}		username,host	0	100
81500000	Top Denied Web Users {0} and Application {1}		username,application	0	100
81110000	Top Denied Web Users {0}, Category {1} and Domain {2}		username,category,domain	0	100
81410000	Top Denied Web Users {0}, Host {1} and Category {2}		username,host,category	0	100
81420000	Top Denied Web Users {0}, Host {1} and Domain {2}		username,host,domain	0	100
81440000	Top Denied Web Users {0}, Host {1} and Application {2}		username,host,application	0	100
81411000	Top Denied Web Users {0}, Host {1}, Category {2} and Domain {3}		username,host,category,domain	0	100
81441000	Top Denied Web Users {0}, Host {1}, Application {2} and Category {3}		username,host,application,category	0	100
81441100	Top Denied Web Users {0}, Host {1}, Application {2}, Category {3} and Domain {4}		username,host,application,category,domain	0	100
81510000	Top Denied Web Users {0}, Application {1} and Category {2}		username,application,category	0	100
81511000	Top Denied Web Users {0}, Application {1}, Category {2} and Domain {3}		username,application,category,domain	0	100
82000000	Top Denied Categories {0}		category	0	100
82100000	Top Denied Categories {0} and  Domain {1}		category,domain	0	100
82200000	Top Denied Categories {0} and  User {1}		category,username	0	100
82110000	Top Denied Categories {0}, Domain {1} and User {2}		category,domain,username	0	100
82210000	Top Denied Categories {0}, User {1} and Domain {2}		category,username,domain	0	100
83000000	Top  Denied Domains {0}		domain	0	100
83100000	Top  Denied Domains {0} and User {1}		domain,username	0	100
84000000	Top Denied Web Hosts {0}		host	0	100
84100000	Top Denied Web Hosts {0} and Category {1}		host,category	0	100
84200000	Top Denied Web Hosts {0} and Domain {1}		host,domain	0	100
84400000	Top Denied Web Hosts {0} and User {1}		host,username	0	100
84110000	Top Denied Web Hosts {0}, Category {1} and Domain {2}		host,category,domain	0	100
84410000	Top Denied Web Hosts {0}, User {1} and Category {2}		host,username,category	0	100
84420000	Top Denied Web Hosts {0}, User {1} and Domain {2}		host,username,domain	0	100
84440000	Top Denied Web Hosts {0}, User {1} and Application {2}		host,username,application	0	100
84411000	Top Denied Web Hosts {0}, User {1}, Category {2} and Domain {3}		host,username,category,domain	0	100
84441000	Top Denied Web Hosts {0}, User {1}, Application {2} and Category {3}		host,username,application,category	0	100
84441100	Top Denied Web Hosts {0}, User {1}, Application {2}, Category {3} and Domain {4}		host,username,application,category,domain	0	100
84500000	Top Denied Web Hosts {0} and Top Applications {1}		host,application	0	100
84510000	Top Denied Web Hosts {0}, Top Applications {1} and Category {2}		host,application,category	0	100
84511000	Top Denied Web Hosts {0}, Top Applications {1}, Category {2} and Domain {3}		host,application,category,domain	0	100
6100000	Uploaded {0} File Reports		file,deviceid	0	100
6110000	Uploaded {0} File and Server {1} Reports		file,server,deviceid	0	100
6120000	Uploaded {0} File and Host {1} Reports		file,host,deviceid	0	100
6130000	Uploaded {0} File and User {1} Reports		file,username,deviceid	0	100
6200000	Downloaded {0} File Reports		file,deviceid	0	100
6210000	Downloaded {0} File and Server {1} Reports		file,server,deviceid	0	100
6220000	Downloaded {0} File and Host {1} Reports		file,host,deviceid	0	100
6230000	Downloaded {0} File and User {1} Reports		file,username,deviceid	0	100
6300000	User {0} Reports (Upload)		username,deviceid	0	100
6310000	User {0} and File {1} Reports		username,file,deviceid	0	100
6320000	User {0} and Server {1} Reports		username,server,deviceid	0	100
6330000	User {0} and Host {1} Reports		username,host,deviceid	0	100
6400000	User {0} Reports (Download)		username,deviceid	0	100
6410000	User {0} and File {1} Reports		username,file,deviceid	0	100
6420000	User {0} and Server {1} Reports		username,server,deviceid	0	100
6430000	User {0} and Host {1} Reports		username,host,deviceid	0	100
6500000	Host {0} Reports		host,deviceid	0	100
6510000	Host {0} and File {1} Reports		host,file,deviceid	0	100
6520000	Host {0} and Server {1} Reports		host,server,deviceid	0	100
6530000	Host {0} and User {1} Reports		host,username,deviceid	0	100
6600000	Host {0} Reports		host,deviceid	0	100
6610000	Host {0} and File {1} Reports		host,file,deviceid	0	100
6620000	Host {0} and Server {1} Reports		host,server,deviceid	0	100
6630000	Host {0} and User {1} Reports		host,username,deviceid	0	100
6700000	Server {0} Reports		server,deviceid	0	100
6710000	Server {0} and Uploaded {1} File Reports		server,file,deviceid	0	100
6720000	Server {0} and Downloaded {1} File Reports		server,file,deviceid	0	100
6730000	Server {0} and FTP User {1} Reports		server,username,deviceid	0	100
6740000	Server {0} and FTP Host {1} Reports		server,host,deviceid	0	100
1000000	Spam		deviceid	1	100
510000	Mail Sender {0} Reports		sender,deviceid	0	100
511000	Mail Sender {0} Recipient {1} Reports		sender,recipient,deviceid	0	100
512000	Mail Sender {0} Source Host {1} Reports		sender,host,deviceid	0	100
513000	Mail Sender {0} Destination {1} Reports		sender,destination,deviceid	0	100
514000	Mail Sender {0} User {1} Reports		sender,username,deviceid	0	100
515000	Mail Sender {0} Application {1} Reports		sender,application,deviceid	0	100
520000	Mail Recipient {0} Reports		recipient,deviceid	0	100
521000	Mail Recipient {0} Sender {1} Reports		recipient,sender,deviceid	0	100
522000	Mail Recipient {0} Source Host {1} Reports		recipient,host,deviceid	0	100
523000	Mail Recipient {0} Destination {1} Reports		recipient,destination,deviceid	0	100
524000	Mail Recipient {0} User {1} Reports		recipient,username,deviceid	0	100
525000	Mail Recipient {0} Application {1} Reports		recipient,application,deviceid	0	100
530000	Mail User {0} Reports		username,deviceid	0	100
531000	Mail User {0} Sender {1} Reports		username,sender,deviceid	0	100
532000	Mail User {0} Recipient {1} Reports		username,recipient,deviceid	0	100
533000	Mail User {0} Source Host {1} Reports		username,host,deviceid	0	100
534000	Mail User {0} Destination {1} Reports		username,destination,deviceid	0	100
535000	Mail User {0} Application {1} Reports		username,application,deviceid	0	100
540000	Mail Host {0} Reports		host,deviceid	0	100
541000	Mail Host {0} Sender {1} Reports		host,sender,deviceid	0	100
542000	Mail Host {0} Recipient {1} Reports		host,recipient,deviceid	0	100
543000	Mail Host {0} User {1} Reports		host,username,deviceid	0	100
544000	Mail Host {0} Destination {1} Reports		host,destination,deviceid	0	100
545000	Mail Host {0} Application {1} Reports		host,application,deviceid	0	100
550000	Mail Application {0} Reports		application,deviceid	0	100
551000	Mail Application {0} Sender {1} Reports		application,sender,deviceid	0	100
552000	Mail Application {0} Recipient {1} Reports		application,recipient,deviceid	0	100
553000	Mail Application {0} User {1} Reports		application,username,deviceid	0	100
554000	Mail Application {0} Host {1} Reports		application,host,deviceid	0	100
555000	Mail Application {0} Destination {1} Reports		application,destination,deviceid	0	100
1010000	Spam Recipient {0} Reports		recipient,deviceid	0	100
1011000	Spam Recipient {0} and Sender {1} Reports		recipient,sender,deviceid	0	100
1012000	Spam Recipient {0} and Source Host {1} Reports		recipient,host,deviceid	0	100
1013000	Spam Recipient {0} and Destination {1} Reports		recipient,destination,deviceid	0	100
1015000	Spam Recipient {0} and Application {1} Reports		recipient,application,deviceid	0	100
1020000	Spam Sender {0} Reports		sender,deviceid	0	100
1021000	Spam Sender {0} and Recipient {1} Reports		sender,recipient,deviceid	0	100
1022000	Spam Sender {0} and Source Host {1} Reports		sender,host,deviceid	0	100
1023000	Spam Sender {0} and Destination {1} Reports		sender,destination,deviceid	0	100
1024000	Spam Sender {0} and User {1} Reports		sender,username,deviceid	0	100
1025000	Spam Sender {0} and Application {1} Reports		sender,application,deviceid	0	100
1030000	Application {0} Reports		application,deviceid	0	100
1031000	Application {0} and Sender {1} Reports		application,sender,deviceid	0	100
1032000	Application {0} and Recipient {1} Reports		application,recipient,deviceid	0	100
1033000	Application {0} and User {1} Reports		application,username,deviceid	0	100
1034000	Application {0} and Host {1} Reports		application,host,deviceid	0	100
1035000	Application {0} and Destination {1} Reports		application,destination,deviceid	0	100
1014000	Spam Recipient {0} and User {1} Reports		recipient,username,deviceid	0	100
91000000	Severity wise break-down {0}		severity	0	100
92000000	Top Attacks  {0}		attack	0	100
93000000	Top Attackers {0}		attacker	0	100
94000000	Top Victims {0}		victim	0	100
97000000	Top Applications used by Attacks {0}		application	0	100
91100000	Severity wise break-down {0} and Top Attacks {1}		severity,attack	0	100
91200000	Severity wise break-down {0} and Top Attackers {1}		severity,attacker	0	100
91300000	Severity wise break-down {0} and Top Victims {1}		severity,victim	0	100
91500000	Severity wise break-down {0} and Top Detected Attacks {1}		severity,attack	0	100
91600000	Severity wise break-down {0} and Top Dropped Attacks {1}		severity,attack	0	100
93100000	Top Attackers {0} and Attack {1}		attacker,attack	0	100
93200000	Top Attackers {0} and Victim {1}		attacker,victim	0	100
93300000	Top Attackers {0} and Application {1}		attacker,application	0	100
94100000	Top Victims {0} and Attack {1}		victim,attack	0	100
94200000	Top Victims {0} and Attacker {1}		victim,attacker	0	100
94300000	Top Victims {0} and Application {1}		victim,application	0	100
97100000	Top Applications used by Attacks {0} and Attack {1}		application,attack	0	100
97200000	Top Applications used by Attacks {0} and Attacker {1}		application,attacker	0	100
97300000	Top Applications used by Attacks {0} and Victim {2}		application,victim	0	100
97400000	Top Applications used by Attacks {0} and Detected Attack {1}		application,attack	0	100
97500000	Top Applications used by Attacks {0} and Dropped Attack {1}		application,attack	0	100
11300000	Web Virus Reports			0	100
11310000	Virus {0} Reports		virus,deviceid	0	100
11311000	Virus {0} and Domain {1} Reports		virus,domain,deviceid	0	100
11312000	Virus {0} and User {1} Reports		virus,username,deviceid	0	100
11313000	Virus {0} and Host {1} Reports		virus,host,deviceid	0	100
11320000	Domain {0} Reports		domain,deviceid	0	100
11321000	Domain {0} and Virus {1} Reports		domain,virus,deviceid	0	100
11322000	Domain {0} and User {1} Reports		domain,username,deviceid	0	100
11323000	Domain {0} and Host {1} Reports		domain,host,deviceid	0	100
11330000	User {0} Reports		username,deviceid	0	100
11331000	User {0} and Viruse {1} Reports		username,virus,deviceid	0	100
11332000	User {0} and Domain {1} Reports		username,domain,deviceid	0	100
11333000	User {0} and Host {1} Reports		username,host,deviceid	0	100
11400000	Mail Virus Reports			0	100
11410000	Virus {0} Reports		virus,deviceid	0	100
11411000	Virus {0} and Sender {1} Reports		virus,sender,deviceid	0	100
11411100	Virus {0}, Sender {1} and Recipient {2}		virus,sender,recipient,deviceid	0	100
11411200	Virus {0}, Sender {1} and Sender Host {2}		virus,sender,host,deviceid	0	100
11411300	Virus {0}, Sender {1} and Receiver Host {2}		virus,sender,destination,deviceid	0	100
11411400	Virus {0}, Sender {1} and Application {2}		virus,sender,application,deviceid	0	100
11411500	Virus {0}, Sender {1} and User {2}		virus,sender,username,deviceid	0	100
11412000	Virus {0} and Recipient {1} Reports		virus,recipient,deviceid	0	100
11412100	Virus {0}, Recipient {1} and Sender {2}		virus,recipient,sender,deviceid	0	100
11412200	Virus {0}, Recipient {1} and Sender Host {2}		virus,recipient,host,deviceid	0	100
11412300	Virus {0}, Recipient {1} and Receiver Host {2}		virus,recipient,destination,deviceid	0	100
11412400	Virus {0}, Recipient {1} and Application {2}		virus,recipient,application,deviceid	0	100
11412500	Virus {0}, Recipient {1} and User {2}		virus,recipient,username,deviceid	0	100
11413000	Virus {0} and Sender Host {1} Reports		virus,host,deviceid	0	100
11413100	Virus {0}, Sender Host {1} and Sender {2}		virus,host,sender,deviceid	0	100
11413200	Virus {0}, Sender Host {1} and Recipient {2}		virus,host,recipient,deviceid	0	100
11413300	Virus {0}, Sender Host {1} and Receiver Host {2}		virus,host,destination,deviceid	0	100
11413400	Virus {0}, Sender Host {1} and Application {2}		virus,host,application,deviceid	0	100
11413500	Virus {0}, Sender Host {1} and User {2}		virus,host,username,deviceid	0	100
11414000	Virus {0} and Receiver Host {1} Reports		virus,destination,deviceid	0	100
11414100	Virus {0}, Receiver Host {1} and Sender {2}		virus,destination,sender,deviceid	0	100
11414200	Virus {0}, Receiver Host {1} and Recipient {2}		virus,destination,recipient,deviceid	0	100
11414300	Virus {0}, Receiver Host {1} and Sender Host {2}		virus,destination,host,deviceid	0	100
11414400	Virus {0}, Receiver Host {1} and Application {2}		virus,destination,application,deviceid	0	100
11414500	Virus {0}, Receiver Host {1} and User {2}		virus,destination,username,deviceid	0	100
11415000	Virus {0} and Application {1} Reports		virus,application,deviceid	0	100
11415100	Virus {0}, Application {1} and Sender {2}		virus,application,sender,deviceid	0	100
11415200	Virus {0}, Application {1} and Recipient {2}		virus,application,recipient,deviceid	0	100
11415300	Virus {0}, Application {1} and Sender Host {2}		virus,application,host,deviceid	0	100
11415400	Virus {0}, Application {1} and Receiver Host {2}		virus,application,destination,deviceid	0	100
11415500	Virus {0}, Application {1} and User {2}		virus,application,username,deviceid	0	100
11500000	FTP Virus Reports			0	100
11510000	FTP Virus {0} Reports		virus,deviceid	0	100
11511000	FTP Virus {0} and Server {1} Reports		virus,server,deviceid	0	100
11511100	FTP Virus {0},Server {1} and Host {2}		virus,server,host,deviceid	0	100
11511200	FTP Virus {0},Server {1} and File {2}		virus,server,file,deviceid	0	100
11511300	FTP Virus {0},Server {1} and User {2}		virus,server,username,deviceid	0	100
11512000	FTP Virus {0} and Host {1} Reports		virus,host,deviceid	0	100
11512100	FTP Virus {0}, Host {1} and Server {2}		virus,host,server,deviceid	0	100
11512200	FTP Virus {0}, Host {1} and File {2}		virus,host,file,deviceid	0	100
11512300	FTP Virus {0}, Host {1} and User {2}		virus,host,username,deviceid	0	100
11513000	FTP Virus {0} and User {1} Reports		virus,username,deviceid	0	100
11513100	FTP Virus {0}, User {1} and Server {2}		virus,username,server,deviceid	0	100
11513200	FTP Virus {0}, User {1} and File {2}		virus,username,file,deviceid	0	100
11513300	FTP Virus {0}, User {1} and Host {2}		virus,username,host,deviceid	0	100
11514000	FTP Virus {0} and File {1} Reports		virus,file,deviceid	0	100
11514100	FTP Virus {0}, File {1} and Server {2}		virus,file,server,deviceid	0	100
11514200	FTP Virus {0}, File {1} and Host {2}		virus,file,host,deviceid	0	100
11514300	FTP Virus {0}, File {1} and User {2}		virus,file,username,deviceid	0	100
11520000	FTP Virus {0} Reports		virus,deviceid	0	100
11521000	FTP Virus {0} and Server {1} Reports		virus,server,deviceid	0	100
11521100	FTP Virus {0},Server {1} and Host {2}		virus,server,host,deviceid	0	100
11521200	FTP Virus {0},Server {1} and File {2}		virus,server,file,deviceid	0	100
11521300	FTP Virus {0},Server {1} and User {2}		virus,server,username,deviceid	0	100
11522000	FTP Virus {0} and Host {1} Reports		virus,host,deviceid	0	100
11522100	FTP Virus {0}, Host {1} and Server {2}		virus,host,server,deviceid	0	100
11522200	FTP Virus {0}, Host {1} and File {2}		virus,host,file,deviceid	0	100
11522300	FTP Virus {0}, Host {1} and User {2}		virus,host,username,deviceid	0	100
11523000	FTP Virus {0} and User {1} Reports		virus,username,deviceid	0	100
11523100	FTP Virus {0}, User {1} and Server {2}		virus,username,server,deviceid	0	100
11523200	FTP Virus {0}, User {1} and File {2}		virus,username,file,deviceid	0	100
11523300	FTP Virus {0}, User {1} and Host {2}		virus,username,host,deviceid	0	100
11524000	FTP Virus {0} and File {1} Reports		virus,file,deviceid	0	100
11524100	FTP Virus {0}, File {1} and Server {2}		virus,file,server,deviceid	0	100
11524200	FTP Virus {0}, File {1} and Host {2}		virus,file,host,deviceid	0	100
11524300	FTP Virus {0}, File {1} and User {2}		virus,file,username,deviceid	0	100
92100000	Top Attacks {0} and Attacker {1}		attack,attacker	0	100
92200000	Top Attacks {0} and Victim {1}		attack,victim	0	100
92300000	Top Attacks {0} and Application {1}		attack,application	0	100
26	Search By User {0}		username	0	100
28	Search By Source {0}		srcip,host,victim,attacker	0	100
29	Search By Email Address {0}		sender,recipient	0	100
91400000	Severity wise break-down {0} and Top Applications {1}		severity,application	0	100
20000	System Information			0	100
20100	CPU Usage		deviceid	0	100
20200	Memory Usage		deviceid	0	100
20300	Disk Usage		deviceid	0	100
\.


ALTER SEQUENCE tblreportgroup_reportgroupid_seq RESTART  200000000; 

ALTER TABLE ONLY tblreportgroup
    ADD CONSTRAINT tblreportgroup_pkey PRIMARY KEY (reportgroupid);



DROP TABLE IF EXISTS tblreportgrouprel cascade;
CREATE TABLE tblreportgrouprel (
    reportgroupid integer DEFAULT 0,
    reportid integer DEFAULT 0,
    roworder integer DEFAULT 0
);

COPY tblreportgrouprel (reportgroupid, reportid, roworder) FROM stdin;
6	16	11
6	17	12
6	18	21
6	19	22
6	20	31
6	21	32
6	22	41
6	23	42
6	24	51
6	25	52
7	26	11
7	27	12
7	28	21
7	29	22
7	30	31
7	31	32
7	32	41
7	33	42
7	34	51
7	35	52
1420000	1420000	11
1420000	1420010	12
1420000	1420020	21
1420000	1420030	22
1420000	1420040	31
1420000	1420050	32
1420000	1420060	41
1420000	1420070	42
1420000	1420080	51
1420000	1420090	52
1520000	1520000	11
1520000	1520010	12
1520000	1520020	21
1520000	1520030	22
1520000	1520040	31
1520000	1520050	32
1520000	1520060	41
1520000	1520070	42
1520000	1520080	51
1520000	1520090	52
1520000	1520100	61
1520000	1520110	62
1520000	1520120	71
10	59	11
20701000	20701000	11
20701000	20702000	12
20701000	20703000	21
20801000	20801000	22
20801000	20802000	31
20801000	20803000	32
20901000	20901000	41
20901000	20902000	42
20901000	20903000	51
103000	130010	11
103000	130020	12
103000	130030	21
104000	140010	11
104100	140110	11
104200	140210	11
105000	150210	11
131000	131010	11
131000	131020	12
141000	141010	11
141100	141110	11
132000	132010	11
132000	132020	12
142000	142010	11
142100	142110	11
134000	134010	11
134000	134020	12
134000	134030	21
144000	144010	11
144100	144110	11
144200	144210	11
154000	154210	11
135000	135010	11
135000	135020	12
135000	135030	21
145000	145010	11
145100	145110	11
145200	145210	11
155000	155210	11
136000	136010	11
136000	136020	12
146000	146010	11
146100	146110	11
137000	137010	11
137000	137020	12
147000	147010	11
147100	147110	11
138000	138010	11
138000	138020	12
148000	148010	11
148100	148110	11
139000	139010	11
139000	139020	12
149000	149010	11
149100	149110	11
100001	30	11
100001	32	12
100001	34	13
100002	31	11
100002	33	12
100002	35	13
1430000	1430010	11
1430000	1430020	12
1430000	1430030	21
1440000	1440010	11
1440100	1440110	11
1440200	1440210	11
1450000	1450010	11
1431000	1431010	11
1431000	1431020	12
1441000	1441010	11
1441100	1441110	11
1432000	1432010	11
1432000	1432020	12
1442000	1442010	11
1442100	1442110	11
1434000	1434010	11
1434000	1434020	12
1434000	1434030	21
1444000	1444010	11
1444100	1444110	11
1444200	1444210	11
1454000	1454010	11
1435000	1435010	11
1435000	1435020	12
1435000	1435030	21
1445000	1445010	11
1445100	1445110	11
1445200	1445210	11
1455000	1455010	11
1436000	1436010	11
1436000	1436020	12
1446000	1446010	11
1446100	1446110	11
1437000	1437010	11
1437000	1437020	12
1447000	1447010	11
1447100	1447110	11
1438000	1438010	11
1438000	1438020	12
1448000	1448010	11
1448100	1448110	11
1439000	1439010	11
1439000	1439020	12
1449000	1449010	11
1449100	1449110	11
1420001	1420040	11
1420001	1420060	12
1420001	1420080	21
1420002	1420050	11
1420002	1420070	12
1420002	1420090	21
1520001	1520050	11
1520001	1520070	12
1520001	1520090	21
1520001	1520110	22
1520002	1520060	11
1520002	1520080	12
1520002	1520100	21
1520002	1520120	22
1530000	1530010	11
1530000	1530020	12
1530000	1530030	21
1540000	1540010	11
1540000	1540020	12
1540100	1540110	11
1540100	1540120	12
1540200	1540210	11
1540200	1540220	12
1531000	1531010	11
1531000	1531020	12
1531000	1531030	21
1541000	1541010	11
1541000	1541020	12
1541100	1541110	11
1541100	1541120	12
1541200	1541210	11
1541200	1541220	12
1551000	1551010	11
1551100	1551110	11
1532000	1532010	11
1532000	1532020	12
1532000	1532030	21
1542000	1542010	11
1542000	1542020	12
1542100	1542110	11
1542100	1542120	12
1542200	1542210	11
1542200	1542220	12
1533000	1533010	11
1533000	1533020	12
1533000	1533030	21
1543000	1543010	11
1543000	1543020	12
1543100	1543110	11
1543100	1543120	12
1543200	1543210	11
1543200	1543220	12
1553000	1553010	11
1553100	1553110	11
1534000	1534010	11
1534000	1534020	12
1534000	1534030	21
1544000	1544010	11
1544000	1544020	12
1544100	1544110	11
1544100	1544120	12
1544200	1544210	11
1544200	1544220	12
1535000	1535010	11
1535000	1535020	12
1535000	1535030	21
1545000	1545010	11
1545000	1545020	12
1545100	1545110	11
1545100	1545120	12
1545200	1545210	11
1545200	1545220	12
1536000	1536010	11
1536000	1536020	12
1536000	1536030	21
1546000	1546010	11
1546000	1546020	12
1546100	1546110	11
1546100	1546120	12
1546200	1546210	11
1546200	1546220	12
1556000	1556010	11
1556100	1556110	11
1537000	1537010	11
1537000	1537020	12
1537000	1537030	21
1547000	1547010	11
1547000	1547020	12
1547100	1547110	11
1547100	1547120	12
1547200	1547210	11
1547200	1547220	12
1557000	1557010	11
1557100	1557110	11
1538000	1538010	11
1538000	1538020	12
1538000	1538030	21
1548000	1548010	11
1548000	1548020	12
1548100	1548110	11
1548100	1548120	12
1548200	1548210	11
1548200	1548220	12
1539000	1539010	11
1539000	1539020	12
1539000	1539030	21
1549000	1549010	11
1549000	1549020	12
1549100	1549110	11
1549100	1549120	12
1549200	1549210	11
1549200	1549220	12
15310000	15310010	11
15310000	15310020	12
15310000	15310030	21
15410000	15410010	11
15410000	15410020	12
15410100	15410110	11
15410100	15410120	12
15410200	15410210	11
15410200	15410220	12
15510000	15510010	11
15510100	15510110	11
15311000	15311010	11
15311000	15311020	12
15311000	15311030	21
15411000	15411010	11
15411000	15411020	12
15411100	15411110	11
15411100	15411120	12
15411200	15411210	11
15411200	15411220	12
15511000	15511010	11
15511100	15511110	11
20101100	20101100	11
20101100	20101200	12
20102100	20102100	11
20102100	20102200	12
20103100	20103100	11
20103100	20103200	12
20201100	20201100	11
20201100	20201200	12
20202100	20202100	11
20202100	20202200	12
20203100	20203100	11
20203100	20203200	12
20301100	20301100	11
20301100	20301200	12
20302100	20302100	11
20302100	20302200	12
20303100	20303100	11
20303100	20303200	12
20401000	20401000	11
20401000	20402000	12
20401000	20403000	21
20501000	20501000	22
20501000	20502000	31
20501000	20503000	32
20601000	20601000	41
20601000	20602000	42
20601000	20603000	51
15	20100000	11
15	20200000	12
15	20300000	21
15	20400000	22
15	20500000	31
15	20600000	32
15	20700000	41
15	20800000	42
15	20900000	51
20101000	20101000	11
20101000	20102000	12
20101000	20103000	21
20201000	20201000	22
20201000	20202000	31
20201000	20203000	32
20301000	20301000	41
20301000	20302000	42
20301000	20303000	51
17	119	11
17	120	12
17	121	21
17	122	22
17	123	31
17	124	32
17	125	41
17	126	42
18	127	11
19	128	11
20	129	11
21	130	11
22	131	11
23	132	11
24	133	11
25	134	11
27	135	11
1001	1002	1
1001	1001	1
1002	1012	52
1002	1011	51
1002	1010	42
1002	1009	41
1002	1008	32
1002	1007	31
1002	1006	22
1002	1005	21
1002	1004	12
1002	1003	11
1000000	1010000	11
1010000	1011000	11
1010000	1012000	12
1010000	1013000	21
1010000	1014000	22
1010000	1015000	31
1011000	1011100	11
1012000	1012100	11
1013000	1013100	11
1014000	1014100	11
1015000	1015100	11
1000000	1020000	12
1020000	1021000	11
1020000	1022000	12
1020000	1023000	21
1020000	1024000	22
1020000	1025000	31
1021000	1021100	11
1022000	1022100	11
1023000	1023100	11
1024000	1024100	11
1025000	1025100	11
1000000	1030000	21
1030000	1031000	11
1030000	1032000	12
1030000	1033000	21
1030000	1034000	22
1030000	1035000	31
1031000	1031100	11
1032000	1032100	11
1033000	1033100	11
1034000	1034100	11
1035000	1035100	11
901000	901010	11
902000	902010	11
903000	903010	11
904000	904010	11
905000	905010	11
4400000	4410000	11
4400000	4420000	12
4400000	4430000	21
4410000	4411000	11
4411000	4411100	11
4420000	4421000	11
4420000	4422000	12
4421000	4421100	11
4422000	4422100	11
4422100	4422110	11
4430000	4431000	11
4430000	4432000	12
4431000	4431100	11
4431100	4431110	11
4432000	4432100	11
4510000	4511000	11
4511000	4511100	11
4520000	4521000	11
4530000	4531000	11
4531000	4531100	11
4551000	4551100	11
4551100	4551110	11
4552000	4552100	11
4553000	4553100	11
4553100	4553110	11
4555000	4555100	11
4555000	4555200	12
4555100	4555110	11
4555110	45551110	11
4555200	4555210	11
4555210	45552110	11
4560000	4561000	11
4560000	4562000	12
4561000	4561100	11
4561100	4561110	11
4562000	4562100	11
4562100	4562110	11
46000000	46100000	11
46100000	46110000	11
46100000	46120000	12
46100000	46130000	21
46110000	46111000	11
46110000	46112000	12
46111000	46111100	11
46112000	46112100	11
46112100	46112110	11
46120000	46121000	11
46120000	46122000	12
46121000	46121100	11
46122000	46122100	11
46122100	46122110	11
46130000	46131000	11
46130000	46132000	12
46131000	46131100	11
46131100	46131110	11
46132000	46132100	11
46132100	46132110	11
46000000	46200000	12
46200000	46210000	11
46200000	46220000	12
46210000	46211000	11
46220000	46221000	11
46221000	46221100	11
46000000	46300000	21
46300000	46310000	11
46310000	46311000	11
46311000	46311100	11
46300000	46320000	12
46320000	46321000	11
46300000	46330000	21
46330000	46331000	11
46331000	46331100	11
46300000	46340000	22
46300000	46350000	31
46000000	46400000	22
46400000	46410000	11
46410000	46411000	11
46411000	46411100	11
46400000	46420000	12
46420000	46421000	11
46420000	46422000	11
46421000	46421100	11
46422000	46422100	11
46422100	46422110	11
46400000	46430000	21
46430000	46431000	11
46431000	46431100	11
46431100	46431110	11
46430000	46432000	12
46432000	46432100	11
41000000	41200000	12
41000000	41300000	21
41000000	41400000	22
41000000	41500000	31
41000000	41600000	32
41100000	41110000	11
41110000	41111000	11
41200000	41210000	11
41300000	41310000	11
41310000	41311000	11
41500000	41510000	11
41500000	41520000	12
41500000	41530000	21
41500000	41540000	22
41500000	41550000	31
41510000	41511000	11
41511000	41511100	11
41520000	41521000	11
41530000	41531000	11
41531000	41531100	11
41550000	41551000	11
41550000	41552000	12
41551000	41551100	11
41552000	41552100	11
41551100	41551110	11
41552100	41552110	11
41600000	41610000	11
41600000	41620000	12
41610000	41611000	11
41620000	41621000	11
41611000	41611100	11
41621000	41621100	11
42000000	42100000	11
42000000	42200000	12
42000000	42300000	21
42100000	42110000	11
42100000	42120000	12
42200000	42210000	11
42200000	42220000	12
42300000	42310000	11
42300000	42320000	12
42110000	42111000	11
42120000	42121000	11
42121000	42121100	11
42210000	42211000	11
42220000	42221000	11
42221000	42221100	11
42310000	42311000	11
42320000	42321000	11
42311000	42311100	11
42321000	42321100	11
43000000	43100000	11
43000000	43200000	12
43100000	43110000	11
43200000	43210000	11
43210000	43211000	11
41000000	41100000	11
4550000	4551000	11
4550000	4553000	21
4550000	4554000	22
4550000	4555000	31
4550000	4552000	12
4500000	4510000	11
4500000	4520000	12
4500000	4530000	21
4500000	4540000	22
4500000	4550000	31
4500000	4560000	32
400000	4400000	22
400000	4500000	31
400000	46000000	32
400000	41000000	11
400000	42000000	12
400000	43000000	21
7100000	7110000	11
7100000	7120000	12
7100000	7130000	21
7110000	7111000	11
7110000	7112000	12
7110000	7113000	21
7111000	7111100	11
7112000	7112100	11
7113000	7113100	11
7113100	7113110	11
7120000	7121000	11
7120000	7122000	12
7121000	7121100	11
7122000	7122100	11
7130000	7131000	11
7130000	7132000	12
7131000	7131100	11
7132000	7132100	11
7200000	7210000	11
7200000	7220000	12
7200000	7230000	21
7200000	7240000	22
7210000	7211000	11
7210000	7212000	12
7210000	7213000	21
7211000	7211100	11
7211000	7211200	12
7212000	7212100	11
7212000	7212200	12
7213000	7213100	11
7213000	7213200	12
7220000	7221000	11
7220000	7222000	12
7220000	7223000	21
7221000	7221100	11
7221000	7221200	12
7222000	7222100	11
7222000	7222200	12
7223000	7223100	11
7223000	7223200	12
7223100	7223110	11
7223200	7223210	11
7230000	7231000	11
7230000	7232000	12
7230000	7233000	21
7231000	7231100	11
7231000	7231200	12
7232000	7232100	11
7232000	7232200	12
7233000	7233100	11
7233000	7233200	12
7240000	7241000	11
7240000	7242000	12
7240000	7243000	21
7241000	7241100	11
7241000	7241200	12
7242000	7242100	11
7242000	7242200	12
7243000	7243100	11
7243000	7243200	12
7243100	7243110	11
7243200	7243210	11
7300000	7310000	11
7300000	7320000	12
7300000	7330000	21
7310000	7311000	11
7310000	7312000	12
7310000	7313000	21
7311000	7311100	11
7312000	7312100	11
7313000	7313100	11
7313100	7313110	11
7320000	7321000	11
7320000	7322000	12
7321000	7321100	11
7322000	7322100	11
7330000	7331000	11
7330000	7332000	12
7331000	7331100	11
7332000	7332100	11
7400000	7410000	11
7400000	7420000	12
7400000	7430000	21
7410000	7411000	11
7410000	7412000	12
7410000	7413000	21
7411000	7411100	11
7411000	7411200	12
7412000	7412100	11
7412000	7412200	12
7413000	7413100	11
7413000	7413200	12
7420000	7421000	11
7420000	7422000	12
7421000	7421100	11
7422000	7422100	11
7430000	7431000	11
7430000	7432000	12
7431000	7431100	11
7432000	7432100	11
81000000	81100000	11
81000000	81200000	12
81000000	81300000	21
81000000	81400000	22
81000000	81500000	31
81100000	81110000	11
81200000	81210000	11
81400000	81410000	11
81400000	81420000	12
81400000	81430000	21
81400000	81440000	22
81500000	81510000	11
81110000	81111000	11
81410000	81411000	11
81420000	81421000	11
81440000	81441000	11
81411000	81411100	11
81441000	81441100	11
81441100	81441110	11
81510000	81511000	11
81511000	81511100	11
82000000	82100000	11
82000000	82200000	12
82100000	82110000	11
82200000	82210000	11
82110000	82111000	11
82210000	82211000	11
83000000	83100000	11
83100000	83110000	11
84000000	84100000	11
84000000	84200000	12
84000000	84300000	21
84000000	84400000	22
84000000	84500000	31
84100000	84110000	11
84200000	84210000	11
84400000	84410000	11
84400000	84420000	12
84400000	84430000	21
84400000	84440000	22
84110000	84111000	11
84410000	84411000	11
84420000	84421000	11
84440000	84441000	11
84411000	84411100	11
84441000	84441100	11
84441100	84441110	11
84500000	84510000	11
84510000	84511000	11
84511000	84511100	11
800000	81000000	11
800000	82000000	12
800000	83000000	21
800000	84000000	22
600000	6100000	11
600000	6200000	12
600000	6300000	21
600000	6400000	22
600000	6500000	31
600000	6600000	32
600000	6700000	41
6100000	6110000	11
6100000	6120000	12
6100000	6130000	21
6110000	6111000	11
6120000	6121000	11
6130000	6131000	11
6200000	6210000	11
6200000	6220000	12
6200000	6230000	21
6210000	6211000	11
6220000	6221000	11
6230000	6231000	11
6300000	6310000	11
6300000	6320000	12
6300000	6330000	21
6310000	6311000	11
6320000	6321000	11
6330000	6331000	11
6400000	6410000	11
6400000	6420000	12
6400000	6430000	21
6410000	6411000	11
6420000	6421000	11
6430000	6431000	11
6500000	6510000	11
6500000	6520000	12
6500000	6530000	21
6510000	6511000	11
6520000	6521000	11
6530000	6531000	11
6600000	6610000	11
6600000	6620000	12
6600000	6630000	21
6610000	6611000	11
6620000	6621000	11
6630000	6631000	11
6700000	6710000	11
6700000	6720000	12
6700000	6730000	21
6700000	6740000	22
6710000	6711000	11
6720000	6721000	11
6730000	6731000	11
6730000	6732000	12
6740000	6741000	11
6740000	6742000	12
700000	7100000	11
700000	7200000	12
700000	7300000	21
700000	7400000	22
510000	511000	11
510000	512000	12
510000	513000	21
510000	514000	22
510000	515000	31
511000	511100	11
512000	512100	11
513000	513100	11
514000	514100	11
515000	515100	11
520000	521000	11
520000	522000	12
520000	523000	21
520000	524000	22
520000	525000	31
521000	521100	11
522000	522100	11
523000	523100	11
524000	524100	11
525000	525100	11
530000	531000	11
530000	532000	12
530000	533000	21
530000	534000	22
530000	535000	31
540000	541000	11
540000	542000	12
540000	543000	21
540000	544000	22
540000	545000	31
550000	551000	11
550000	552000	12
550000	553000	21
550000	554000	22
550000	555000	31
531000	531100	11
532000	532100	11
533000	533100	11
534000	534100	11
535000	535100	11
541000	541100	11
542000	542100	11
543000	543100	11
544000	544100	11
545000	545100	11
551000	551100	11
552000	552100	11
553000	553100	11
554000	554100	11
555000	555100	11
500000	510000	11
500000	520000	12
500000	530000	21
500000	540000	22
500000	550000	31
91000000	91100000	11
91000000	91200000	12
91000000	91300000	21
91000000	91400000	22
91000000	91500000	31
91000000	91600000	32
91100000	91110000	11
91200000	91210000	11
91300000	91310000	11
91400000	91410000	11
91500000	91510000	11
91600000	91610000	11
93000000	93100000	11
93000000	93200000	12
93000000	93300000	21
93100000	93110000	11
93200000	93210000	11
93300000	93310000	11
94000000	94100000	11
94000000	94200000	12
94000000	94300000	21
94100000	94110000	11
94200000	94210000	11
94300000	94310000	11
97000000	97100000	11
97000000	97200000	12
97000000	97300000	21
97000000	97400000	22
97000000	97500000	31
97100000	97110000	11
97200000	97210000	11
97300000	97310000	11
97400000	97410000	11
97500000	97510000	11
900000	91000000	11
900000	92000000	12
900000	93000000	21
900000	94000000	22
900000	97000000	31
1100000	11100000	11
1100000	11200000	12
1100000	11300000	21
1100000	11400000	22
1100000	11500000	31
11300000	11310000	11
11300000	11320000	12
11300000	11330000	21
11310000	11311000	11
11311000	11311100	11
11310000	11312000	12
11312000	11312100	11
11310000	11313000	21
11313000	11313100	11
11320000	11321000	11
11320000	11322000	12
11320000	11323000	21
11321000	11321100	11
11322000	11322100	11
11323000	11323100	11
11330000	11331000	11
11330000	11332000	12
11330000	11333000	21
11331000	11331100	11
11332000	11332100	11
11333000	11333100	11
11400000	11410000	11
11410000	11411000	11
11410000	11412000	12
11410000	11413000	21
11410000	11414000	22
11410000	11415000	31
11411000	11411100	11
11411000	11411200	12
11411000	11411300	21
11411000	11411400	22
11411000	11411500	31
11411100	11411110	11
11411200	11411210	11
11411300	11411310	11
11411400	11411410	11
11411500	11411510	11
11412000	11412100	11
11412000	11412200	12
11412000	11412300	21
11412000	11412400	22
11412000	11412500	31
11412100	11412110	11
11412200	11412210	11
11412300	11412310	11
11412400	11412410	11
11412500	11412510	11
11413000	11413100	11
11413000	11413200	12
11413000	11413300	21
11413000	11413400	22
11413000	11413500	31
11413100	11413110	11
11413200	11413210	11
11413300	11413310	11
11413400	11413410	11
11413500	11413510	11
11414000	11414100	11
11414000	11414200	12
11414000	11414300	21
11414000	11414400	22
11414000	11414500	31
11414100	11414110	11
11414200	11414210	11
11414300	11414310	11
11414400	11414410	11
11414500	11414510	11
11415000	11415100	11
11415000	11415200	12
11415000	11415300	21
11415000	11415400	22
11415000	11415500	31
11415100	11415110	11
11415200	11415210	11
11415300	11415310	11
11415400	11415410	11
11415500	11415510	11
11500000	11510000	11
11500000	11520000	12
11510000	11511000	11
11510000	11512000	12
11510000	11513000	21
11510000	11514000	22
11511000	11511100	11
11511000	11511200	12
11511000	11511300	21
11511100	11511110	11
11511200	11511210	11
11511300	11511310	11
11512000	11512100	11
11512000	11512200	12
11512000	11512300	21
11512100	11512110	11
11512200	11512210	11
11512300	11512310	11
11513000	11513100	11
11513000	11513200	12
11513000	11513300	21
11513100	11513110	11
11513200	11513210	11
11513300	11513310	11
11514000	11514100	11
11514000	11514200	12
11514000	11514300	21
11514100	11514110	11
11514200	11514210	11
11514300	11514310	11
11520000	11521000	11
11520000	11522000	12
11520000	11523000	21
11520000	11524000	22
11521000	11521100	11
11521000	11521200	12
11521000	11521300	21
11521100	11521110	11
11521200	11521210	11
11521300	11521310	11
11522000	11522100	11
11522000	11522200	12
11522000	11522300	21
11522100	11522110	11
11522200	11522210	11
11522300	11522310	11
11523000	11523100	11
11523000	11523200	12
11523000	11523300	21
11523100	11523110	11
11523200	11523210	11
11523300	11523310	11
11524000	11524100	11
11524000	11524200	12
11524000	11524300	21
11524100	11524110	11
11524200	11524210	11
11524300	11524310	11
92000000	92100000	11
92000000	92200000	12
92000000	92300000	21
92100000	92110000	11
92200000	92210000	11
92300000	92310000	11
26	26010	11
26	26020	12
26	26030	21
26	26040	22
26	26050	31
26	26060	32
26	26070	41
26	26080	42
28	28010	11
28	28020	12
28	28030	21
28	28040	22
28	28050	31
28	28060	32
28	28070	41
28	28080	42
28	28090	51
29	29010	11
29	29020	12
29	29030	21
29	29040	22
29	29050	31
29	29060	32
29	29070	41
29	29080	42
29	29090	51
29	29100	52
2000000	16	11
2000000	20100000	12
2000000	41000000	21
2000000	46000000	22
2000000	530000	31
2000000	7100000	32
20000	20100	11
20000	20200	12
20000	20300	21
20100	20110	11
20200	20210	11
20300	20310	11
20300	20320	12
\.



DROP TABLE IF EXISTS tblrole;
CREATE TABLE tblrole (
    roleid serial,
    rolename character varying(15) DEFAULT NULL::character varying,
    level integer
);



COPY tblrole (roleid, rolename, level) FROM stdin;
1	Super Admin	1
2	Admin	2
3	Viewer	3
\.

ALTER SEQUENCE tblrole_roleid_seq RESTART  4; 

ALTER TABLE ONLY tblrole
    ADD CONSTRAINT tblrole_pkey PRIMARY KEY (roleid);

ALTER TABLE ONLY tblrole
    ADD CONSTRAINT tblrole_rolename_key UNIQUE (rolename);


DROP TABLE IF EXISTS tbltranslation;
CREATE TABLE tbltranslation (
    messageid serial NOT NULL,
    message text,
    translatedmessage text,
    type text,
    languageid integer
);

COPY tbltranslation (messageid, message, translatedmessage, type, languageid) FROM stdin;
117	Error in Report profile Deleting.	##Error in Report profile Deleting.##	\N	2
191	Add Profile	##Add Profile##	\N	2
192	of	##of##	\N	2
200	|Archives	|##Archives##	\N	2
277	Top Category type	##Top Category type##	\N	2
366	Category Type	##Category Type##	\N	2
367	Content	##Content##	\N	2
0	Are you sure you want to update configuration?	##Are you sure you want to update configuration?##	\N	2
1	iView Configuration	##iView Configuration##	\N	2
2	DNS Configuration	##DNS Configuration##	\N	2
3	Do Reverse lookup automatically. I want to see DNS name everywhere instead of IPAddress.	##Do Reverse lookup automatically. I want to see DNS name everywhere instead of IPAddress.##	\N	2
4	No lookup at all. I want to see IPAddresses everywhere.	##No lookup at all. I want to see IPAddresses everywhere.##	\N	2
5	DNS Name mapping size in memory	##DNS Name mapping size in memory##	\N	2
6	Language Setting	##Language Setting##	\N	2
7	Select Language	##Select Language##	\N	2
11	Username	##Username##	\N	2
8	You must select atleast one user	##You must select atleast one user##	\N	2
9	Are you sure you want to delete the selected User(s)?	##Are you sure you want to delete the selected User(s)?##	\N	2
10	User Configuration	##User Configuration##	\N	2
12	Name	##Name##	\N	2
13	User Type	##User Type##	\N	2
14	Email	##Email##	\N	2
15	Created By	##Created By##	\N	2
16	Last Login Time	##Last Login Time##	\N	2
17	Sel	##Sel##	\N	2
18	Select All	##Select All##	\N	2
19	New User	##New User##	\N	2
20	Delete	##Delete##	\N	2
21	You must enter the Name	##You must enter the Name##	\N	2
22	Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Name	##Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Name##	\N	2
23	You must enter the Username	##You must enter the Username##	\N	2
24	Only alpha numeric characters, '_', '@' and '.' allowed in username	##Only alpha numeric characters, '_', '@' and '.' allowed in username##	\N	2
25	Only alpha numeric characters allowed in username	##Only alpha numeric characters allowed in username##	\N	2
26	You must enter the Password	##You must enter the Password##	\N	2
27	The passwords you typed do not match	##The passwords you typed do not match##	\N	2
28	You must enter email address	##You must enter email address##	\N	2
29	Invalid Email Address	##Invalid Email Address##	\N	2
30	You must select atleast one device	##You must select atleast one device##	\N	2
31	Are you sure you want to add the User?	##Are you sure you want to add the User?##	\N	2
32	Update User	##Update User##	\N	2
33	Add User	##Add User##	\N	2
34	User Information	##User Information##	\N	2
35	Password	##Password##	\N	2
36	Confirm Password	##Confirm Password##	\N	2
37	E-mail	##E-mail##	\N	2
38	Device Assignment	##Device Assignment##	\N	2
39	By default, Admin can view all devices.	##By default, Admin can view all devices.##	\N	2
40	Available Devices	##Available Devices##	\N	2
41	Selected Devices	##Selected Devices##	\N	2
42	Update	##Update##	\N	2
43	Add	##Add##	\N	2
44	New Device Discoverd	##New Device Discoverd##	\N	2
45	Pending Decision by User	##Pending Decision by User##	\N	2
46	Active Device	##Active Device##	\N	2
47	Deactive Device	##Deactive Device##	\N	2
48	Device updated successfully.	##Device updated successfully.##	\N	2
53	Device Name	##Device Name##	\N	2
49	Error in Device updation.	##Error in Device updation.##	\N	2
50	Are you sure you want to save changes?	##Are you sure you want to save changes?##	\N	2
51	Device Management	##Device Management##	\N	2
52	Current Status	##Current Status##	\N	2
54	Set Status	##Set Status##	\N	2
55	Active	##Active##	\N	2
56	Deactive	##Deactive##	\N	2
57	Decision Pending	##Decision Pending##	\N	2
58	Save	##Save##	\N	2
123	Edit Report Profile	##Edit Report Profile##	\N	2
368	Count	##Count##	\N	2
370	Device	##Device##	\N	2
371	Domain	##Domain##	\N	2
372	File	##File##	\N	2
373	File Affected	##File Affected##	\N	2
374	File Name	##File Name##	\N	2
375	File Uploaded	##File Uploaded##	\N	2
381	Protocols	##Protocols##	\N	2
59	You must enter the Device Name	##You must enter the Device Name##	\N	2
61	Are you sure you want to update the device?	##Are you sure you want to update the device?##	\N	2
101	Error in Protocol Identifier Deletion.	##Error in Protocol Identifier Deletion.##	\N	2
102	Protocol Identifier added successfully.	##Protocol Identifier added successfully.##	\N	2
103	Error in Protocol Identifier Addition.	##Error in Protocol Identifier Addition.##	\N	2
104	Protocol Identifier already exists in	##Protocol Identifier already exists in##	\N	2
105	Protocol Name	##Protocol Name##	\N	2
106	Add Protocol Identifier	##Add Protocol Identifier##	\N	2
107	Protocol Identifiers	##Protocol Identifiers##	\N	2
84	Are you sure to delete	##Are you sure to delete##	\N	2
85	protocol group?	##protocol group?##	\N	2
86	protocol?	##protocol?##	\N	2
87	Protocol Groups	##Protocol Groups##	\N	2
88	Add Protocol	##Add Protocol##	\N	2
89	Add Protocol Group	##Add Protocol Group##	\N	2
90	Protocol	##Protocol##	\N	2
91	No Identifiers	##No Identifiers##	\N	2
92	No Protocol Group exists.	##No Protocol Group exists.##	\N	2
93	Edit	##Edit##	\N	2
94	Close	##Close##	\N	2
95	Protocol Group	##Protocol Group##	\N	2
96	Group Name	##Group Name##	\N	2
97	Unassigned Protocols	##Unassigned Protocols##	\N	2
98	Selected Protocols	##Selected Protocols##	\N	2
99	Done	##Done##	\N	2
100	Protocol Identifier deleted successfully.	##Protocol Identifier deleted successfully.##	\N	2
151	Search	##Search##	\N	2
109	Port Type	##Port Type##	\N	2
110	From	##From##	\N	2
111	To	##To##	\N	2
112	Report profile Added Successfully.	##Report profile Added Successfully.##	\N	2
114	Report profile Updated Successfully.	##Report profile Updated Successfully.##	\N	2
115	Error in Report profile Updating Adding.	##Error in Report profile Updating Adding.##	\N	2
116	Report profile Deleted Successfully.	##Report profile Deleted Successfully.##	\N	2
118	Report Profiles	##Report Profiles##	\N	2
119	Report Profile Name	##Report Profile Name##	\N	2
120	Report Profile Description	##Report Profile Description##	\N	2
121	Report Profiles Not Available	##Report Profiles Not Available##	\N	2
122	Add Report Profile	##Add Report Profile##	\N	2
124	You must enter the Profile Name	##You must enter the Profile Name##	\N	2
125	Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Profile Name	##Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Profile Name##	\N	2
126	You must select atleast one report.	##You must select atleast one report.##	\N	2
127	maximum 8 reports are allowed in one profile.	##maximum 8 reports are allowed in one profile.##	\N	2
60	Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Device Name	##Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Device Name##	\N	2
62	Update Device	##Update Device##	\N	2
63	Device Information	##Device Information##	\N	2
64	Appliance ID	##Appliance ID##	\N	2
66	Status	##Status##	\N	2
67	User Decision	##User Decision##	\N	2
68	Cancel	##Cancel##	\N	2
70	Protocol Group added successfully.	##Protocol Group added successfully.##	\N	2
71	Protocol Group already exists.	##Protocol Group already exists.##	\N	2
72	Error in Protocol Group Creation.	##Error in Protocol Group Creation.##	\N	2
73	Protocol Group updated successfully.	##Protocol Group updated successfully.##	\N	2
74	Error in Protocol Group Updation.	##Error in Protocol Group Updation.##	\N	2
75	Protocol Group deleted successfully.	##Protocol Group deleted successfully.##	\N	2
76	Error in Protocol Group Deletion.	##Error in Protocol Group Deletion.##	\N	2
77	Protocol added successfully.	##Protocol added successfully.##	\N	2
78	Protocol already exists.	##Protocol already exists.##	\N	2
79	Error in Protocol Creation.	##Error in Protocol Creation.##	\N	2
80	Protocol updated successfully.	##Protocol updated successfully.##	\N	2
81	Error in Protocol Updation.	##Error in Protocol Updation.##	\N	2
82	Protocol deleted successfully.	##Protocol deleted successfully.##	\N	2
83	Error in Protocol Deletion.	##Error in Protocol Deletion.##	\N	2
128	Are you sure you want to update report profile?	##Are you sure you want to update report profile?##	\N	2
130	Report Profile Name :	##Report Profile Name :##	\N	2
113	Error in Report profile Adding.	##Error in Report profile Adding.##	\N	2
129	Are you sure you want to add report profile?	##Are you sure you want to add report profile?##	\N	2
131	Report Profile Description :	##Report Profile Description :##	\N	2
132	Select Report :	##Select Report :##	\N	2
133	Report Groups	##Report Groups##	\N	2
134	Loading Process Already Running	##Loading Process Already Running##	\N	2
135	Select atleast one check box to load data to search	##Select atleast one check box to load data to search##	\N	2
136	Please enter valid page no.	##Please enter valid page no.##	\N	2
137	There is a problem with the request.	##There is a problem with the request.##	\N	2
138	Archived Files	##Archived Files##	\N	2
139	Archive Settings	##Archive Settings##	\N	2
140	Delete Files	##Delete Files##	\N	2
141	Show	##Show##	\N	2
142	days per page	##days per page##	\N	2
143	Page	##Page##	\N	2
144	Go to page :	##Go to page :##	\N	2
145	Date	##Date##	\N	2
147	Total Size	##Total Size##	\N	2
148	Action	##Action##	\N	2
149	No Logs Available	##No Logs Available##	\N	2
150	Load	##Load##	\N	2
65	Description	वर्णन	\N	2
152	No File is Available for loading between	##No File is Available for loading between##	\N	2
153	and	##and##	\N	2
154	Process of loading index file is running.....Please wait....	##Process of loading index file is running.....Please wait....##	\N	2
155	Extracting row file(s), Please wait...	##Extracting row file(s), Please wait...##	\N	2
156	Loading index files, Please wait...	##Loading index files, Please wait...##	\N	2
157	Loading Process is Already running Please Wait...	##Loading Process is Already running Please Wait...##	\N	2
158	Source	##Source##	\N	2
159	Destination	##Destination##	\N	2
160	User	##User##	\N	2
161	URL	##URL##	\N	2
162	Sent (in Bytes)	##Sent (in Bytes)##	\N	2
163	Received (in Bytes)	##Received (in Bytes)##	\N	2
164	Rule	##Rule##	\N	2
165	is	##is##	\N	2
166	isn't	##isn't##	\N	2
167	contains	##contains##	\N	2
168	starts with	##starts with##	\N	2
170	Criteria should not be Empty	##Criteria should not be Empty##	\N	2
171	Advanced Search	##Advanced Search##	\N	2
172	Or	##Or##	\N	2
173	Match all of the following	##Match all of the following##	\N	2
174	Match any of the following	##Match any of the following##	\N	2
175	Add Criteria	##Add Criteria##	\N	2
176	Remove Criteria	##Remove Criteria##	\N	2
177	Formated Logs	##Formated Logs##	\N	2
178	Row Logs	##Row Logs##	\N	2
179	results per page	##results per page##	\N	2
181	DateTime	##DateTime##	\N	2
183	Firewall Rule ID	##Firewall Rule ID##	\N	2
184	User Name	##User Name##	\N	2
185	Source IP	##Source IP##	\N	2
186	Destination IP	##Destination IP##	\N	2
188	Sent Bytes	##Sent Bytes##	\N	2
189	Received Bytes	##Received Bytes##	\N	2
190	No Logs Avaiable	##No Logs Avaiable##	\N	2
193	System Configuration	##System Configuration##	\N	2
194	|Configure	|##Configure##	\N	2
195	||General Settings	||##General Settings##	\N	2
196	||User Management	||##User Management##	\N	2
197	||Device Management	||##Device Management##	\N	2
198	||Protocol Groups	||##Protocol Groups##	\N	2
199	||Report Profiles	||##Report Profiles##	\N	2
201	Category {0} and User {1} Reports	##Category {0} and User {1} Reports##	\N	2
202	Category {0} Reports	##Category {0} Reports##	\N	2
203	Category {0} Repots	##Category {0} Repots##	\N	2
204	Category Type {0} Reports	##Category Type {0} Reports##	\N	2
205	Clean FTP Reports Group	##Clean FTP Reports Group##	\N	2
206	Clean Mail Report group	##Clean Mail Report group##	\N	2
207	Content {0} Reports	##Content {0} Reports##	\N	2
208	Denied Traffic Reports Group	##Denied Traffic Reports Group##	\N	2
209	Denied Web Content Categorization Reports Group	##Denied Web Content Categorization Reports Group##	\N	2
210	Destination {0} Reports	##Destination {0} Reports##	\N	2
211	Domain {0} Reports	##Domain {0} Reports##	\N	2
212	File {0} Reports	##File {0} Reports##	\N	2
213	Firewall Rules Reports	##Firewall Rules Reports##	\N	2
214	Host {0} and Protocol Group {1} Reports	##Host {0} and Protocol Group {1} Reports##	\N	2
215	Host {0} Report	##Host {0} Report##	\N	2
216	Host {0} Reports	##Host {0} Reports##	\N	2
218	IDP Alerts Reports Group	##IDP Alerts Reports Group##	\N	2
219	Incoming Virus {0} and Protocol {1} Reports	##Incoming Virus {0} and Protocol {1} Reports##	\N	2
220	Incoming Virus {0} Reports	##Incoming Virus {0} Reports##	\N	2
221	Mail Receiver {0} Reports	##Mail Receiver {0} Reports##	\N	2
222	Mail Sender {0} Reports	##Mail Sender {0} Reports##	\N	2
223	Outgoing Virus {0} and Protocol {1} Reports	##Outgoing Virus {0} and Protocol {1} Reports##	\N	2
224	Outgoing Virus {0} Reports	##Outgoing Virus {0} Reports##	\N	2
225	Protocol {0} Reports	##Protocol {0} Reports##	\N	2
226	Protocol Goup {0} Reports	##Protocol Goup {0} Reports##	\N	2
227	Protocol Group {0} Destination {1} Reports	##Protocol Group {0} Destination {1} Reports##	\N	2
228	Protocol Group {0} Protocol {1} Reports	##Protocol Group {0} Protocol {1} Reports##	\N	2
229	Protocol Group Based Traffic Reports	##Protocol Group Based Traffic Reports##	\N	2
230	Rule Id {0} Accept Report	##Rule Id {0} Accept Report##	\N	2
231	Rule Id {0} and Destination {1} Accept Report	##Rule Id {0} and Destination {1} Accept Report##	\N	2
232	Rule Id {0} and Destination {1} Deny Report	##Rule Id {0} and Destination {1} Deny Report##	\N	2
233	Rule Id {0} and Host {1} Accept Report	##Rule Id {0} and Host {1} Accept Report##	\N	2
234	Rule Id {0} and Host {1} Deny Report	##Rule Id {0} and Host {1} Deny Report##	\N	2
235	Rule Id {0} and Protocol Group {1} Accept Report	##Rule Id {0} and Protocol Group {1} Accept Report##	\N	2
236	Rule Id {0} and Protocol Group {1} Deny Report	##Rule Id {0} and Protocol Group {1} Deny Report##	\N	2
237	Rule Id {0} Deny Report	##Rule Id {0} Deny Report##	\N	2
238	Rule id {0} Reports	##Rule id {0} Reports##	\N	2
239	Spam Receiver {0} Reports	##Spam Receiver {0} Reports##	\N	2
240	Spam Reports Group	##Spam Reports Group##	\N	2
241	Spam Sender {0} Reports	##Spam Sender {0} Reports##	\N	2
242	Uploaded File {0} Reports	##Uploaded File {0} Reports##	\N	2
243	User {0} and Category {1} Reports	##User {0} and Category {1} Reports##	\N	2
244	User {0} and Protocol Group {1} Reports	##User {0} and Protocol Group {1} Reports##	\N	2
245	User {0} Protocol Group {1}	##User {0} Protocol Group {1}##	\N	2
246	User {0} Reports	##User {0} Reports##	\N	2
247	User Group {0} Reports	##User Group {0} Reports##	\N	2
248	Victim {0} Reports	##Victim {0} Reports##	\N	2
249	Virus {0} Reports	##Virus {0} Reports##	\N	2
250	Virus Reciever {0} Reports	##Virus Reciever {0} Reports##	\N	2
251	Virus Reports Group	##Virus Reports Group##	\N	2
252	Virus Sender {0} Reports	##Virus Sender {0} Reports##	\N	2
253	Web Content Categorization Reports Group	##Web Content Categorization Reports Group##	\N	2
254	Web Usage Reports	##Web Usage Reports##	\N	2
255	Allowed Traffic Overview	##Allowed Traffic Overview##	\N	2
256	Allowed Traffic Summary	##Allowed Traffic Summary##	\N	2
257	Content Filtering Denied Summary	##Content Filtering Denied Summary##	\N	2
258	Denied Traffic Overview	##Denied Traffic Overview##	\N	2
259	Denied Traffic Summary	##Denied Traffic Summary##	\N	2
260	Firewall Denied Summary	##Firewall Denied Summary##	\N	2
261	FTP Traffic Summary	##FTP Traffic Summary##	\N	2
262	IDP Attacks Summary	##IDP Attacks Summary##	\N	2
263	Mail Traffic Summary	##Mail Traffic Summary##	\N	2
264	Spam Summary	##Spam Summary##	\N	2
265	Top Accept Rules	##Top Accept Rules##	\N	2
266	Top Accept Rules - Destination Wise	##Top Accept Rules - Destination Wise##	\N	2
267	Top Accept Rules - Host Wise	##Top Accept Rules - Host Wise##	\N	2
268	Top Accept Rules - Protocol Group Wise	##Top Accept Rules - Protocol Group Wise##	\N	2
269	Top Applications (Received)	##Top Applications (Received)##	\N	2
270	Top Applications (Sent + Received)	##Top Applications (Sent + Received)##	\N	2
271	Top Applications (Sent)	##Top Applications (Sent)##	\N	2
272	Top Attackers	##Top Attackers##	\N	2
273	Top Attacks	##Top Attacks##	\N	2
274	Top Attacks - Severity Wise	##Top Attacks - Severity Wise##	\N	2
275	Top Categories	##Top Categories##	\N	2
276	Top Categories (Sent + Received)	##Top Categories (Sent + Received)##	\N	2
278	Top Category Types (Sent + Received)	##Top Category Types (Sent + Received)##	\N	2
279	Top Contents	##Top Contents##	\N	2
280	Top Denied Categories	##Top Denied Categories##	\N	2
281	Top Denied Categories - Users Wise	##Top Denied Categories - Users Wise##	\N	2
282	Top Denied Destinations	##Top Denied Destinations##	\N	2
283	Top Denied Domains	##Top Denied Domains##	\N	2
284	Top Denied File Uploads	##Top Denied File Uploads##	\N	2
285	Top Denied Hosts	##Top Denied Hosts##	\N	2
286	Top Denied Protocols	##Top Denied Protocols##	\N	2
287	Top Denied Users	##Top Denied Users##	\N	2
288	Top Denied Users - Category Wise	##Top Denied Users - Category Wise##	\N	2
289	Top Denied Users - Protocol Group Wise	##Top Denied Users - Protocol Group Wise##	\N	2
290	Top Deny Rules	##Top Deny Rules##	\N	2
291	Top Deny Rules - Destination Wise	##Top Deny Rules - Destination Wise##	\N	2
292	Top Deny Rules - Host Wise	##Top Deny Rules - Host Wise##	\N	2
293	Top Deny Rules - Protocol Group Wise	##Top Deny Rules - Protocol Group Wise##	\N	2
294	Top Destination	##Top Destination##	\N	2
295	Top Destination (Received)	##Top Destination (Received)##	\N	2
296	Top Destination (Sent + Received)	##Top Destination (Sent + Received)##	\N	2
297	Top Destination (Sent)	##Top Destination (Sent)##	\N	2
298	Top Destinations	##Top Destinations##	\N	2
299	Top Destinations  (Received)	##Top Destinations  (Received)##	\N	2
300	Top Destinations  (Sent + Received)	##Top Destinations  (Sent + Received)##	\N	2
301	Top Destinations  (Sent)	##Top Destinations  (Sent)##	\N	2
302	Top Domain	##Top Domain##	\N	2
303	Top Domains	##Top Domains##	\N	2
304	Top Domains (Sent + Received)	##Top Domains (Sent + Received)##	\N	2
305	Top File Uploads	##Top File Uploads##	\N	2
306	Top Files	##Top Files##	\N	2
307	Top Files Downloaded	##Top Files Downloaded##	\N	2
308	Top Files Uploaded	##Top Files Uploaded##	\N	2
309	Top Hosts	##Top Hosts##	\N	2
310	Top Hosts (Received)	##Top Hosts (Received)##	\N	2
312	Top Hosts (Sent)	##Top Hosts (Sent)##	\N	2
313	Top Hosts Per Protocol Group (Received)	##Top Hosts Per Protocol Group (Received)##	\N	2
314	Top Hosts Per Protocol Group (Sent + Received)	##Top Hosts Per Protocol Group (Sent + Received)##	\N	2
315	Top Hosts Per Protocol Group (Sent)	##Top Hosts Per Protocol Group (Sent)##	\N	2
316	Top Incoming Virus	##Top Incoming Virus##	\N	2
317	Top Incoming Virus - Per Protocol Group	##Top Incoming Virus - Per Protocol Group##	\N	2
318	Top Mail Receivers	##Top Mail Receivers##	\N	2
319	Top Mail Senders	##Top Mail Senders##	\N	2
320	Top Outgoing Virus	##Top Outgoing Virus##	\N	2
321	Top Outgoing Virus - Per Protocol Group	##Top Outgoing Virus - Per Protocol Group##	\N	2
322	Top Protocol (Received)	##Top Protocol (Received)##	\N	2
323	Top Protocol (Sent + Received)	##Top Protocol (Sent + Received)##	\N	2
324	Top Protocol (Sent)	##Top Protocol (Sent)##	\N	2
325	Top Protocol Groups (Received)	##Top Protocol Groups (Received)##	\N	2
326	Top Protocol Groups (Sent + Received)	##Top Protocol Groups (Sent + Received)##	\N	2
327	Top Protocol Groups (Sent)	##Top Protocol Groups (Sent)##	\N	2
328	Top Protocols	##Top Protocols##	\N	2
329	Top Protocols (Received)	##Top Protocols (Received)##	\N	2
330	Top Protocols (Sent + Received)	##Top Protocols (Sent + Received)##	\N	2
331	Top Protocols (Sent)	##Top Protocols (Sent)##	\N	2
332	Top Protocols used by attacks	##Top Protocols used by attacks##	\N	2
333	Top Receivers	##Top Receivers##	\N	2
334	Top Rules	##Top Rules##	\N	2
335	Top Senders	##Top Senders##	\N	2
336	Top Spam Receivers	##Top Spam Receivers##	\N	2
337	Top Spam Senders	##Top Spam Senders##	\N	2
338	Top URL	##Top URL##	\N	2
339	Top User Groups	##Top User Groups##	\N	2
340	Top Users	##Top Users##	\N	2
341	Top Users (Received)	##Top Users (Received)##	\N	2
342	Top Users (sent + received)	##Top Users (sent + received)##	\N	2
343	Top Users (Sent + Received)	##Top Users (Sent + Received)##	\N	2
344	Top Users (Sent)	##Top Users (Sent)##	\N	2
345	Top Users Groups (Sent + Received)	##Top Users Groups (Sent + Received)##	\N	2
346	Top Users Per Protocol Group (Received)	##Top Users Per Protocol Group (Received)##	\N	2
347	Top Users Per Protocol Group (Sent)	##Top Users Per Protocol Group (Sent)##	\N	2
348	Top Users Per Protocol Group(Sent + Received)	##Top Users Per Protocol Group(Sent + Received)##	\N	2
349	Top Victims	##Top Victims##	\N	2
350	Top Virus	##Top Virus##	\N	2
351	Top Virus affected files	##Top Virus affected files##	\N	2
352	Top Virus Receivers	##Top Virus Receivers##	\N	2
353	Top Virus Senders	##Top Virus Senders##	\N	2
354	Virus Summary	##Virus Summary##	\N	2
355	Web Traffic Summary	##Web Traffic Summary##	\N	2
217	Host Based Traffic Reports	##Host Based Traffic Reports##	\N	2
357	Allowed Traffic	##Allowed Traffic##	\N	2
358	Application	##Application##	\N	2
359	Attack	##Attack##	\N	2
360	Attack Type	##Attack Type##	\N	2
361	Attacker	##Attacker##	\N	2
362	Attackers	##Attackers##	\N	2
364	Catagory	##Catagory##	\N	2
365	Category	##Category##	\N	2
311	Top Hosts (Sent + Received)	शीर्ष मेजबान (भेजा गया + प्राप्त)	\N	2
363	Bytes	बाइट	\N	2
382	Receiver	##Receiver##	\N	2
383	Rule Id	##Rule Id##	\N	2
384	Sender	##Sender##	\N	2
385	Severity	##Severity##	\N	2
386	Sevirity	##Sevirity##	\N	2
388	Spam Receiver	##Spam Receiver##	\N	2
389	Spam Sender	##Spam Sender##	\N	2
390	Traffic	##Traffic##	\N	2
391	Url	##Url##	\N	2
393	user	##user##	\N	2
395	User Group	##User Group##	\N	2
396	Victim	##Victim##	\N	2
397	Victims	##Victims##	\N	2
398	Virus	##Virus##	\N	2
399	Virus Receiver	##Virus Receiver##	\N	2
400	Virus Sender	##Virus Sender##	\N	2
401	Reports	##Reports##	\N	2
402	View	##View##	\N	2
146	File Details	फ़ाइल विवरण	\N	2
376	hits	क्लिकें	\N	2
377	Hits	क्लिकें	\N	2
378	Host	मेज़बान	\N	2
403	Main Dashboard	##Main Dashboard##	\N	2
404	Dashboard	##Dashboard##	\N	2
406	Licensing	##Licensing##	\N	2
407	Support	##Support##	\N	2
408	Help	##Help##	\N	2
410	All devices	##All devices##	\N	2
411	Start Date	##Start Date##	\N	2
412	End Date	##End Date##	\N	2
413	Go	##Go##	\N	2
414	Logout	##Logout##	\N	2
405	Home	मुख्य पृष्ठ	\N	2
409	Welcome	स्वागत	\N	2
417	Please enter valid Username	##Please enter valid Username##	\N	2
418	Only alpha numeric characters are allowed in Username	##Only alpha numeric characters are allowed in Username##	\N	2
419	Wrong username / password	##Wrong username / password##	\N	2
\.

ALTER SEQUENCE tbltranslation_messageid_seq RESTART 1000; 

ALTER TABLE ONLY tbltranslation
    ADD CONSTRAINT tbltranslation_message_key UNIQUE (message, languageid);

ALTER TABLE ONLY tbltranslation
    ADD CONSTRAINT tbltranslation_pkey PRIMARY KEY (messageid);



DROP TABLE IF EXISTS tbluser;
CREATE TABLE tbluser (
    userid serial NOT NULL,
    name character varying(50) DEFAULT NULL::character varying,
    username character varying(30) DEFAULT NULL::character varying,
    password character varying(30) DEFAULT NULL::character varying,
    createdby character varying(30) DEFAULT NULL::character varying,
    email character varying(100) DEFAULT NULL::character varying,
    lastlogintime timestamp without time zone DEFAULT current_timestamp,
    roleid integer
);

COPY tbluser (userid, name, username, password, createdby, email, roleid) FROM stdin;
1	Admin	admin	admin	DEFAULT	admin@admin.com	1
\.

ALTER SEQUENCE tbluser_userid_seq RESTART 2; 

ALTER TABLE ONLY tbluser
    ADD CONSTRAINT tbluser_pkey PRIMARY KEY (userid);

ALTER TABLE ONLY tbluser
    ADD CONSTRAINT tbluser_username_key UNIQUE (username);






DROP TABLE IF EXISTS tbldevice;
CREATE TABLE tbldevice
(
  deviceid serial NOT NULL ,
  "name" character varying(50) DEFAULT NULL::character varying,
  descr character varying(255) DEFAULT NULL::character varying,
  ip character varying(15) DEFAULT NULL::character varying,
  appid character varying(32),
  devicestatus integer DEFAULT 0,
  CONSTRAINT tbldevice_pkey PRIMARY KEY (deviceid)
);


DROP TABLE IF EXISTS tbluserdevicerel;
CREATE TABLE tbluserdevicerel
(
  userdevicerelid serial NOT NULL,
  userid integer,
  deviceid text,
  devicegroupid text,
  CONSTRAINT tbluserdevicerel_pkey PRIMARY KEY (userdevicerelid)
);

insert into tbluserdevicerel values(1,1,'-1','-1');


ALTER SEQUENCE tbluserdevicerel_userdevicerelid_seq RESTART 2; 


DROP TABLE IF EXISTS tblapplicationname;
CREATE TABLE tblapplicationname (
    applicationnameid serial NOT NULL,
    applicationname character varying(23) DEFAULT NULL::character varying,
    protocolgroupid integer,
    type integer DEFAULT 0
);


ALTER TABLE public.tblapplicationname OWNER TO postgres;


COPY tblapplicationname (applicationnameid, applicationname, protocolgroupid, type) FROM stdin;
379	qsc	1	1
3	PC Anywhere	39	1
5	1200/tcp	39	1
2	Syslog	40	1
4	SIP	40	1
1	Filemaker	1	1
78	remote-kis	1	1
63	netsc-dev	1	1
64	s-net	1	1
65	rsvd	1	1
66	cl/1	1	1
67	cl/2	1	1
68	xyplex-mux	1	1
69	vmnet	1	1
70	genrad-mux	1	1
71	xdmcp	1	1
72	nextstep	1	1
73	ris	1	1
74	unify	1	1
75	audit	1	1
76	ocbinder	1	1
77	ocserver	1	1
79	kis	1	1
80	aci	1	1
81	mumps	1	1
157	uis	1	1
155	ibm-app	1	1
156	unidata-ldm	1	1
158	synotics-broker	1	1
159	meta5	1	1
160	embl-ndt	1	1
161	netcp	1	1
162	netware-ip	1	1
163	mptn	1	1
164	kryptolan	1	1
327	rmc	1	1
165	iso-tsap-c2	1	1
166	work-sol	1	1
167	genie	1	1
168	decap	1	1
169	nced	1	1
170	ncld	1	1
171	timbuktu	1	1
172	bnet	1	1
173	silverplatter	1	1
174	onmux	1	1
175	ariel1	1	1
176	ariel2	1	1
177	ariel3	1	1
178	icad-el	1	1
179	smartsdp	1	1
180	svrloc	1	1
181	ocs_cmu	1	1
182	ocs_amu	1	1
183	utmpsd	1	1
184	utmpcd	1	1
185	iasd	1	1
186	mobileip-agent	1	1
187	mobilip-mn	1	1
188	dna-cml	1	1
189	comscm	1	1
190	dsfgw	1	1
191	dasp	1	1
192	sgcp	1	1
193	cvc_hostd	1	1
194	ddm-rdb	1	1
195	ddm-dfm	1	1
196	ddm-ssl	1	1
197	as-servermap	1	1
198	tserver	1	1
199	sfs-smp-net	1	1
200	sfs-config	1	1
201	creativeserver	1	1
202	contentserver	1	1
378	wpgs	1	1
312	3com-amp3	49	1
313	servstat	1	1
320	dwr	1	1
260	deviceshare	1	1
261	dsf	1	1
262	remotefs	1	1
263	openvms-sysipc	1	1
424	ping	4	1
425	icmp	2	1
426	nntp	3	1
427	nntps	3	1
428	news	3	1
429	tacnews	3	1
430	audionews	3	1
431	nnsp	3	1
432	netnews	3	1
433	nas	3	1
434	snmp	4	1
435	snmptrap	4	1
436	smux	4	1
437	synotics-relay	4	1
438	agentx	4	1
439	dns	5	1
440	rmi	5	1
441	ldap	5	1
442	ldaps	5	1
443	who	5	1
444	nba	5	1
445	dsp	5	1
446	rlp	5	1
447	name	5	1
448	nicname	5	1
449	domain	5	1
450	finger	5	1
451	hosts2-ns	5	1
452	dnsix	5	1
453	cso	5	1
454	profile	5	1
455	bl-idm	5	1
456	prospero	5	1
457	dn6-nlm-aud	5	1
458	dn6-smm-red	5	1
459	dls	5	1
460	dls-mon	5	1
461	at-nbp	5	1
462	nsiiops	5	1
463	hdap	5	1
464	efs	5	1
465	ulp	5	1
466	iiop	5	1
467	pirp	5	1
468	ptcnameservice	5	1
469	rrp	5	1
470	corba-iiop	5	1
264	sdnskmp	1	1
265	teedtap	1	1
266	rmonitor	1	1
267	monitor	1	1
268	chshell	1	1
269	9pfs	1	1
270	whoami	1	1
271	streettalk	1	1
272	banyan-rpc	1	1
273	meter	1	1
274	sonar	1	1
275	banyan-vip	1	1
276	ipcd	1	1
277	vnas	1	1
278	ipdd	1	1
279	decbsrv	1	1
280	sntp-heartbeat	1	1
281	bdp	1	1
282	scc-security	1	1
283	submission	1	1
284	cal	1	1
285	eyelink	1	1
286	tns-cml	1	1
287	eudora-set	1	1
288	tpip	1	1
289	cab-PROT_IDcol	1	1
290	smsd	1	1
291	acp	1	1
292	urm	1	1
293	nqs	1	1
294	npmp-trap	1	1
295	npmp-local	1	1
296	npmp-gui	1	1
297	hmmp-ind	1	1
298	hmmp-op	1	1
299	sco-inetmgr	1	1
300	sco-sysmgr	1	1
301	sco-dtmgr	1	1
302	dei-icda	1	1
303	compaq-evm	1	1
304	sco-websrvrmgr	1	1
305	escp-ip	1	1
306	collaborator	1	1
307	aux_bus_shunt	1	1
308	cryptoadmin	1	1
471	corba-iiop-ssl	5	1
472	omginitialrefs	5	1
473	rmiactivation	5	1
474	rmiregistry	5	1
475	wins	5	1
476	orbix-locator	5	1
477	orbix-config	5	1
478	print	6	1
479	npp	6	1
480	xns-courier	6	1
481	print-srv	6	1
482	exec	6	1
483	printer	6	1
484	ipp	6	1
485	mdqs	6	1
486	pptp	7	1
487	gppitnp	7	1
488	ncp	7	1
489	rtip	7	1
490	l2tp	7	1
491	Kerberos	8	1
492	esp	8	1
493	ike	8	1
494	auth	8	1
495	Authentication Service	8	1
496	auditd	8	1
497	tacacs	8	1
498	xns-auth	8	1
499	nxedit	8	1
500	pwdgen	8	1
501	send	8	1
502	cdc	8	1
503	x-bone-ctl	8	1
504	nsrmp	8	1
505	kpasswd	8	1
506	isakmp	8	1
507	snare	8	1
508	fcp	8	1
509	keyserver	8	1
510	password-chg	8	1
511	tinc	8	1
512	purenoise	8	1
513	secure-aux-bus	8	1
514	entrust-kmsh	8	1
515	entrust-ash	8	1
516	kerberos-adm	8	1
517	kerberos-iv	8	1
518	qrh	8	1
519	rrh	8	1
520	rpasswd	8	1
521	radius	8	1
522	radacct	8	1
523	6129/tcp	8	1
524	ssh	9	1
525	sshell	9	1
526	ieee-mms-ssl	9	1
527	udp	10	1
528	tcp	11	1
529	telnet	12	1
530	9080/tcp	12	1
531	su-mit-tg	12	1
532	rtelnet	12	1
533	fln-spx	12	1
534	rsh-spx	12	1
535	login	12	1
536	telnets	12	1
537	h323	13	1
538	appleqtc	13	1
539	digital-vrc	13	1
540	videotex	13	1
541	philips-vc	13	1
542	ipcserver	13	1
543	irc	13	1
544	ircs	13	1
545	chat	13	1
546	yak-chat	13	1
547	irc-serv	13	1
548	conference	13	1
549	tell	13	1
550	ideafarm-chat	13	1
551	realaudio	13	1
552	RTSP	13	1
553	Quicktime	13	1
554	smpte	13	1
555	siam	13	1
556	talk	13	1
557	ntalk	13	1
558	nmsp	13	1
559	smtp	14	1
560	smtps	14	1
561	mapi	14	1
562	imap	14	1
563	imaps	14	1
564	pop3	14	1
565	pop3s	14	1
566	pop2	14	1
567	imap3	14	1
568	re-mail-ck	14	1
569	xns-mail	14	1
570	ni-mail	14	1
571	pcmail-srv	14	1
572	mailq	14	1
573	qmtp	14	1
574	z39.50	14	1
575	vslmp	14	1
576	odmr	14	1
577	imsp	14	1
578	smsp	14	1
579	hybrid-pop	14	1
580	mailbox-lm	14	1
581	comsat	14	1
582	imap4-ssl	14	1
583	qmqp	14	1
584	bmpp	14	1
585	esro-emsdp	14	1
586	kpop	14	1
587	lotusnote	14	1
588	ftp	15	1
589	tftp	15	1
590	ftps	15	1
591	tftps	15	1
592	kftp	15	1
593	ftp-data	15	1
594	ni-ftp	15	1
595	xfer	15	1
596	swift-rvf	15	1
597	sftp	15	1
598	bftp	15	1
599	qft	15	1
600	subntbcst_tftp	15	1
601	zannet	15	1
602	mftp	15	1
603	rcp	15	1
604	saft	15	1
605	uucp	15	1
606	uucp-rlogin	15	1
607	ftp-agent	15	1
608	sift-uft	15	1
609	pftp	15	1
610	xfr	15	1
611	rsync	15	1
612	ftps-data	15	1
613	http	16	1
614	https	16	1
615	gopher	16	1
616	Soap	16	1
617	http-mgmt	16	1
618	asip-webadmin	16	1
619	hyper-g	16	1
620	gss-http	16	1
621	vemmi	16	1
622	http-alt	16	1
623	http-rpc-epmap	16	1
624	sco-websrvrmg3	16	1
625	soap-beep	16	1
626	rlzdbase	16	1
627	obex	16	1
628	multiling-http	16	1
629	HTTP-Proxy	16	1
630	weblogic	16	1
631	websphere	16	1
632	webmethods	16	1
633	mysql	17	1
634	oracle	17	1
635	mssql	17	1
636	msql	17	1
637	sybase	17	1
638	tacacs-ds	17	1
639	sql*net	17	1
640	sqlserv	17	1
641	ingres-net	17	1
642	sql-net	17	1
643	sqlsrv	17	1
644	dbase	17	1
645	passgo	17	1
646	ibm-db2	17	1
647	rda	17	1
648	ms-sql-s	17	1
649	ms-sql-m	17	1
650	ingres	17	1
651	tl1	18	1
652	daytime	19	1
653	qotd	19	1
654	time	19	1
655	xns-time	19	1
656	deos	19	1
657	vettcp	19	1
658	mit-ml-dev	19	1
659	ansatrader	19	1
660	locus-map	19	1
661	locus-con	19	1
662	statsrv	19	1
663	epmap	19	1
664	emfis-data	19	1
665	emfis-cntl	19	1
666	aed-512	19	1
667	multiplex	19	1
668	esro-gen	19	1
669	arns	19	1
670	utime	19	1
671	dhcpv6-client	19	1
672	dhcpv6-server	19	1
673	syslog-conn	19	1
674	msdp	19	1
675	dhcp-failover	19	1
676	hap	19	1
677	hcp-wismar	19	1
678	asipregistry	19	1
679	nmap	19	1
680	elcsd	19	1
681	webster	19	1
682	dhcp-failover2	19	1
683	fs	19	1
684	jboss-iiop	19	1
685	jboss-iiop-ssl	19	1
686	jrun_ejb	19	1
687	dhcp-server	19	1
688	msp	20	1
689	messaging	20	1
690	msg-icp	20	1
691	msg-auth	20	1
692	mpm-flags	20	1
693	mpm	20	1
694	mpm-snd	20	1
695	knet-cmp	20	1
696	mpp	20	1
697	snpp	20	1
698	spsc	20	1
699	nessus	20	1
700	man	20	1
701	dtspc	20	1
702	msmq	20	1
703	iims	20	1
704	rap	21	1
705	sgmp	21	1
706	nss-routing	21	1
707	sgmp-traps	21	1
708	namp	21	1
709	bgp	21	1
710	gacp	21	1
711	at-rtmp	21	1
712	masqdialer	21	1
713	link	21	1
714	bgmp	21	1
715	asa	21	1
716	aurp	21	1
717	router	21	1
718	ripng	21	1
719	ldp	21	1
720	aodv	21	1
721	mrm	21	1
722	msexch-routing	21	1
723	olsr	21	1
724	cisco-tdp	21	1
725	netbios-ns	22	1
726	netbios-dgm	22	1
727	netbios-ssn	22	1
728	softpc	22	1
729	microsoft-ds	22	1
730	klogin	22	1
731	kshell	22	1
732	appleqtcsrvr	22	1
733	ms-shuttle	22	1
734	ms-rome	22	1
735	smpnameres	22	1
736	netmeeting	22	1
737	gss-xlicen	23	1
738	flexlm	23	1
739	vsinet	23	1
740	uma	24	1
741	hems	24	1
742	cmip-man	24	1
743	cmip-agent	24	1
744	osu-nms	24	1
745	srmp	24	1
746	src	24	1
747	ipx	24	1
748	nip	24	1
749	hp-collector	24	1
750	hp-managed-node	24	1
751	hp-alarm-mgr	24	1
752	ups	24	1
753	prm-sm	24	1
754	prm-nm	24	1
755	decladebug	24	1
756	rmt	24	1
757	synoptics-trap	24	1
758	infoseek	24	1
759	opc-job-start	24	1
760	opc-job-track	24	1
761	decvms-sysmgt	24	1
762	alpes	24	1
763	photuris	24	1
764	nest-PROT_IDcol	24	1
765	stmf	24	1
766	courier	25	1
767	vpps-qua	25	1
768	vpps-via	25	1
769	vpp	25	1
770	kazaa	25	1
771	X11	25	1
772	gnutella-svc	25	1
773	gnutella-rtr	25	1
774	peoplesoft	25	1
775	edonkey2000	25	1
776	listen	25	1
777	vnc	25	1
778	gnutella2	25	1
779	phonebook	26	1
11	acmsoda	1	1
12	traceroute	1	1
13	tcpmux	1	1
14	compressnet	1	1
16	echo	1	1
17	discard	1	1
18	systat	1	1
19	chargen	1	1
20	nsw-fe	1	1
21	graphics	1	1
22	la-maint	1	1
23	xns-ch	1	1
24	isi-gl	1	1
25	acas	1	1
26	whois++	1	1
27	covia	1	1
28	bootps	1	1
29	bootpc	1	1
30	netrjs-1	1	1
31	netrjs-2	1	1
32	netrjs-3	1	1
33	netrjs-4	1	1
34	ctf	1	1
35	mfcobol	1	1
36	mit-dov	1	1
37	dcp	1	1
38	objcall	1	1
39	supdup	1	1
40	dixie	1	1
41	metagram	1	1
42	newacct	1	1
43	hostname	1	1
44	iso-tsap	1	1
45	acr-nema	1	1
47	snagas	1	1
48	sunrpc	1	1
49	mcidas	1	1
50	ansanotify	1	1
51	uucp-path	1	1
52	cfdptkt	1	1
53	erpc	1	1
54	smakynet	1	1
55	cisco-fna	1	1
56	cisco-tna	1	1
57	cisco-sys	1	1
58	uaac	1	1
59	iso-tp0	1	1
60	iso-ip	1	1
61	jargon	1	1
62	netsc-prod	1	1
10	complex-main	38	1
46	3com-tsmux	1	1
88	914c/g	49	1
82	at-3	1	1
83	at-echo	1	1
84	at-5	1	1
85	at-zis	1	1
86	at-7	1	1
87	at-8	1	1
89	anet	1	1
90	vmpwscs	1	1
91	CAIlic	1	1
92	uarps	1	1
93	direct	1	1
94	sur-meas	1	1
95	inbusiness	1	1
96	dsp3270	1	1
97	bhfhs	1	1
98	set	1	1
99	openPORT	1	1
100	arcisdms	1	1
101	sst	1	1
102	td-service	1	1
103	td-replica	1	1
104	personal-link	1	1
105	cablePORT-ax	1	1
106	rescap	1	1
107	corerjd	1	1
108	fxp-1	1	1
109	k-block	1	1
110	novastorbakcup	1	1
111	entrusttime	1	1
112	bhmds	1	1
113	magenta-logic	1	1
114	opalis-robot	1	1
115	dpsi	1	1
116	decauth	1	1
117	pkix-timestamp	1	1
118	ptp-event	1	1
119	ptp-general	1	1
120	pip	1	1
121	texar	1	1
122	pdap	1	1
123	pawserv	1	1
124	zserv	1	1
125	fatserv	1	1
126	csi-sgwp	1	1
127	matip-type-a	1	1
128	matip-type-b	1	1
129	dtag-ste-sb	1	1
130	ndsauth	1	1
131	bh611	1	1
132	datex-asn	1	1
133	cloanto-net-1	1	1
134	bhevent	1	1
135	shrinkwrap	1	1
136	scoi2odialog	1	1
137	semantix	1	1
138	srssend	1	1
139	rsvp_tunnel	1	1
140	aurora-cmgr	1	1
141	dtk	1	1
142	mortgageware	1	1
143	qbikgdp	1	1
144	rpc2PORTmap	1	1
145	codaauth2	1	1
146	clearcase	1	1
147	ulistproc	1	1
148	legent-1	1	1
149	legent-2	1	1
150	hassle	1	1
151	tnETOS	1	1
152	dsETOS	1	1
6	Unknown	39	1
422	soulseek	1	1
423	citrix_metaframe	1	1
324	hello-PORT	1	1
325	repscmd	1	1
326	spmp	1	1
328	tenfold	1	1
329	mac-srvr-admin	1	1
330	sun-dr	1	1
331	disclose	1	1
332	mecomm	1	1
333	meregister	1	1
334	vacdsm-sws	1	1
335	vacdsm-app	1	1
336	cimplex	1	1
337	acap	1	1
338	dctp	1	1
339	ggf-ncp	1	1
340	entrust-aaas	1	1
341	entrust-aams	1	1
342	mdc-PORTmapper	1	1
343	realm-rusd	1	1
344	vatp	1	1
345	hyperwave-isp	1	1
346	connendp	1	1
347	ha-cluster	1	1
348	rushd	1	1
349	uuidgen	1	1
350	accessnetwork	1	1
351	silc	1	1
352	borland-dsj	1	1
353	netviewdm1	1	1
372	submit	1	1
373	notify	1	1
374	acmaint_dbd	1	1
375	entomb	1	1
376	acmaint_transd	1	1
377	wpages	1	1
153	is99c	1	1
154	is99s	1	1
203	creativepartnr	1	1
204	macon-tcp	1	1
205	macon-udp	1	1
206	scohelp	1	1
401	rrac	1	1
402	dccm	1	1
403	WWW	1	1
404	NFS	1	1
405	Netflow	1	1
406	gds_db	1	1
407	jdedwards	1	1
408	visibroker	1	1
409	hpov	1	1
410	tivoli	1	1
411	tibco	1	1
412	tuxedo	1	1
413	mom	1	1
414	ias	1	1
218	tn-tl-w2	1	1
219	tcpnethaspsrv	1	1
220	tn-tl-fd1	1	1
221	ss7ns	1	1
222	iafserver	1	1
223	iafdbase	1	1
224	ph	1	1
225	bgs-nsi	1	1
226	ulpnet	1	1
227	integra-sme	1	1
228	powerburst	1	1
229	avian	1	1
230	micom-pfs	1	1
231	go-login	1	1
232	ticf-1	1	1
233	ticf-2	1	1
234	pov-ray	1	1
235	intecourier	1	1
236	pim-rp-disc	1	1
237	dantz	1	1
238	iso-ill	1	1
239	asa-appl-proto	1	1
240	intrinsa	1	1
241	citadel	1	1
242	ohimsrv	1	1
243	crs	1	1
244	xvttp	1	1
245	shell	1	1
246	timed	1	1
247	tempo	1	1
248	stx	1	1
249	custix	1	1
250	netwall	1	1
251	mm-admin	1	1
252	opalis-rdv	1	1
253	gdomap	1	1
254	apertus-ldp	1	1
255	commerce	1	1
256	afpovertcp	1	1
257	idfp	1	1
258	new-rwho	1	1
259	cybercash	1	1
309	dec_dlm	1	1
310	asia	1	1
311	passgo-tivoli	1	1
319	sanity	1	1
321	pssc	1	1
322	aminet	1	1
323	ieee-mms	1	1
15	rje	1	1
380	mdbs_daemon	1	1
381	device	1	1
382	fcp-udp	1	1
383	itm-mcell-s	1	1
384	pkix-3-ca-ra	1	1
385	iclcnet-locate	1	1
386	iclcnet_svinfo	1	1
387	accessbuilder	1	1
388	ideafarm-catch	1	1
389	xact-backup	1	1
390	apex-mesh	1	1
391	apex-edge	1	1
392	maitrd	1	1
393	busboy	1	1
394	puparp	1	1
395	puprouter	1	1
396	cadlock2	1	1
397	surf	1	1
398	phone	1	1
399	knetd	1	1
400	lockd	1	1
354	netviewdm2	1	1
355	netviewdm3	1	1
356	netgw	1	1
357	netrcs	1	1
358	fujitsu-dev	1	1
359	ris-cm	1	1
360	rfile	1	1
361	pump	1	1
362	nlogin	1	1
363	con	1	1
364	ns	1	1
365	rxe	1	1
366	quotad	1	1
367	cycleserv	1	1
368	omserv	1	1
369	vid	1	1
370	cadlock	1	1
371	cycleserv2	1	1
415	sql-server	1	1
416	bittorrent	1	1
417	battlenet	1	1
418	overnet	1	1
419	emule	1	1
420	opennap	1	1
421	direct_connect	1	1
314	ginad	1	1
315	lanserver	1	1
316	mcns-sec	1	1
317	entrust-sps	1	1
318	repcmd	1	1
207	ampr-rcmd	1	1
208	skronk	1	1
211	urd	1	1
209	datasurfsrv	1	1
210	datasurfsrvsec	1	1
212	igmpv3lite	1	1
213	mylex-mapd	1	1
214	scx-proxy	1	1
215	mondex	1	1
216	ljk-login	1	1
217	tn-tl-w1	1	1
782	ntp	48	2
783	protocol	3	2
780	test	1	2
7	pxc-epmap	39	1
9	prodigy-internet	12	1
781	test by narendra	1	2
\.


ALTER TABLE ONLY tblapplicationname
    ADD CONSTRAINT tblapplicationname_applicationname_key UNIQUE (applicationname);



ALTER TABLE ONLY tblapplicationname
    ADD CONSTRAINT tblapplicationname_pkey PRIMARY KEY (applicationnameid);



ALTER SEQUENCE tblapplicationname_applicationnameid_seq RESTART 1000; 



drop table if exists tblmailschedule;
CREATE TABLE tblmailschedule
(
  mailscheduleid serial NOT NULL,
  schedulename character varying(25),
  descr character varying(255),
  reportgroupid integer,
  "day" integer,
  hours integer,
  toaddress text,
  deviceid character varying(100),
  lastsendtime timestamp without time zone,
  CONSTRAINT tblmailschedule_pkey PRIMARY KEY (mailscheduleid)
 );



-- Table and Procedure for table deletion


DROP TABLE IF EXISTS tbldatastatus cascade;

create table tbldatastatus (
	table_name varchar(64),
	size bigint,
	status varchar(1)
);

insert into tbldatastatus values('DetailTable',0,'1');
insert into tbldatastatus values('SummaryTable',0,'1');




create table tbl_marked_for_delete (
	table_name varchar(64)
);


DROP TABLE IF EXISTS tbldataconfig;
CREATE TABLE tbldataconfig (
  key varchar(70) NOT NULL,
  value integer NOT NULL
);



INSERT INTO tbldataconfig (key,value) VALUES 
 ('MaxNoRotatedTablesFor5min',5),
 ('MaxNoRotatedTablesFor4hr',3),
 ('MaxNoRotatedTablesFor12hr',2),
 ('MaxNoRotatedTablesFor24hr',99),
 ('TopRecordsFor5min',15),
 ('TopRecordsFor4hr',10),
 ('TopRecordsFor12hr',10),
 ('TopRecordsFor24hr',10),
 ('MinRecordsForRotation',1000000);


insert into tbldataconfig values('TopSignificantRecordsFor5min',4000);
insert into tbldataconfig values('TopSignificantRecordsFor4hr',10000);
insert into tbldataconfig values('TopSignificantRecordsFor12hr',6500);
insert into tbldataconfig values('TopSignificantRecordsFor24hr',1000);
insert into tbldataconfig values('DeleteTablePerMinite',5);
insert into tbldataconfig values('ArchieveData',-1);



drop table if exists tbldevicegroup cascade;
CREATE TABLE tbldevicegroup
(
  groupid serial NOT NULL,
  descr character varying(255),
  "name" character varying(50) UNIQUE,
  CONSTRAINT tbldevicegroup_pkey PRIMARY KEY (groupid) 
);

drop table if exists tbldevicegrouprel cascade;
CREATE TABLE tbldevicegrouprel
(
  devicegroupid serial NOT NULL,
  groupid integer,
  deviceid integer,
  CONSTRAINT tbldevicegrouprel_pkey PRIMARY KEY (devicegroupid),
  CONSTRAINT tbldevicegrouprel_deviceid_fkey FOREIGN KEY (deviceid)
      REFERENCES tbldevice (deviceid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT tbldevicegrouprel_groupid_fkey FOREIGN KEY (groupid)
      REFERENCES tbldevicegroup (groupid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);



DROP TABLE IF EXISTS tblprotocolgroup_default;
CREATE TABLE tblprotocolgroup_default (
    protocolgroupid serial primary key,
    protocolgroup character varying(23) DEFAULT NULL::character varying,
    description text
);

insert into tblprotocolgroup_default select * from tblprotocolgroup;

DROP TABLE IF EXISTS tblprotocolidentifier_default;
CREATE TABLE tblprotocolidentifier_default (
    id serial primary key,
    applicationnameid integer,
    protocol integer DEFAULT 0,
    port integer DEFAULT 0,
    type integer DEFAULT 0
);

insert into tblprotocolidentifier_default select * from tblprotocolidentifier;


DROP TABLE IF EXISTS tblapplicationname_default;
CREATE TABLE tblapplicationname_default (
    applicationnameid serial primary key,
    applicationname character varying(23) DEFAULT NULL::character varying,
    protocolgroupid integer,
    type integer DEFAULT 0
);

insert into tblapplicationname_default select * from tblapplicationname;

insert into tblapplication values (13,'auditlog.jsp','N',2);



DROP TABLE if exists tblprotocol ;
CREATE TABLE tblprotocol
(
  protocolid integer NOT NULL,
  protocolname character varying(50),
  descr character varying(255),
  CONSTRAINT tblprotocol_pkey PRIMARY KEY (protocolid)
);

 insert into tblprotocol  values (0,'HOPOPT','IPv6 Hop-by-Hop');
 insert into tblprotocol  values (1,'ICMP','Internet Control Message');
 insert into tblprotocol  values (2,'IGMP','Internet Group Management');
 insert into tblprotocol  values (3,'GGP','Gateway-to-Gateway [RFC823]');
 insert into tblprotocol  values (4,'IP','IP in IP (encapsulation)');
 insert into tblprotocol  values (5,'ST','Stream');
 insert into tblprotocol  values (6,'TCP','Transmission Control');
 insert into tblprotocol  values (7,'CBT','CBT [Ballardie]');
 insert into tblprotocol  values (8,'EGP','Exterior Gateway Protocol');
 insert into tblprotocol  values (9,'IGP','any private interior gateway');
 insert into tblprotocol  values (10,'BBN-RCC-MON','');
 insert into tblprotocol  values (11,'NVP-II','BBN RCC Monitoring');
 insert into tblprotocol  values (12,'PUP','Network Voice Protocol');
 insert into tblprotocol  values (13,'ARGUS','PUP');
 insert into tblprotocol  values (14,'EMCON','ARGUS');
 insert into tblprotocol  values (15,'XNET','EMCON');
 insert into tblprotocol  values (16,'CHAOS','Cross Net Debugger');
 insert into tblprotocol  values (17,'UDP','Chaos');
 insert into tblprotocol  values (18,'MUX','User Datagram');
 insert into tblprotocol  values (19,'DCN-MEAS','Multiplexing');
 insert into tblprotocol  values (20,'HMP','DCN Measurement Subsystems');
 insert into tblprotocol  values (21,'PRM','Host Monitoring');
 insert into tblprotocol  values (22,'XNS-IDP','Packet Radio Measurement');
 insert into tblprotocol  values (23,'TRUNK-1','XEROX NS IDP');
 insert into tblprotocol  values (24,'TRUNK-2','Trunk-1');
 insert into tblprotocol  values (25,'LEAF-1','Trunk-2');
 insert into tblprotocol  values (26,'LEAF-2','Leaf-1');
 insert into tblprotocol  values (27,'RDP','Leaf-2');
 insert into tblprotocol  values (28,'IRTP','Reliable Data Protocol');
 insert into tblprotocol  values (29,'ISO-TP4','Internet Reliable Transaction');
 insert into tblprotocol  values (30,'NETBLT','ISO Transport Protocol Class 4');
 insert into tblprotocol  values (31,'MFE-NSP','Bulk Data Transfer Protocol');
 insert into tblprotocol  values (32,'MERIT-INP','MFE Network Services Protocol');
 insert into tblprotocol  values (33,'DCCP','MERIT Internodal Protocol');
 insert into tblprotocol  values (34,'3PC','Datagram Congestion Control Protocol');
 insert into tblprotocol  values (35,'IDPR','Third Party Connect Protocol');
 insert into tblprotocol  values (36,'XTP','Inter-Domain Policy Routing Protocol');
 insert into tblprotocol  values (37,'DDP','XTP');
 insert into tblprotocol  values (38,'IDPR-CMTP','Datagram Delivery Protocol');
 insert into tblprotocol  values (39,'TP++','IDPR Control Message Transport Proto');
 insert into tblprotocol  values (40,'IL','TP++ Transport Protocol');
 insert into tblprotocol  values (41,'IPv6','IL Transport Protocol');
 insert into tblprotocol  values (42,'SDRP','Ipv6');
 insert into tblprotocol  values (43,'IPv6-Route','Source Demand Routing Protocol');
 insert into tblprotocol  values (44,'IPv6-Frag','Routing Header for IPv6');
 insert into tblprotocol  values (45,'IDRP','Fragment Header for IPv6');
 insert into tblprotocol  values (46,'RSVP','Inter-Domain Routing Protocol');
 insert into tblprotocol  values (47,'GRE','Reservation Protocol');
 insert into tblprotocol  values (48,'DSR','General Routing Encapsulation');
 insert into tblprotocol  values (49,'BNA','Dynamic Source Routing Protocol');
 insert into tblprotocol  values (50,'ESP','BNA');
 insert into tblprotocol  values (51,'AH','Encap Security Payload');
 insert into tblprotocol  values (52,'I-NLSP','Authentication Header');
 insert into tblprotocol  values (53,'SWIPE','Integrated Net Layer Security TUBA');
 insert into tblprotocol  values (54,'NARP','IP with Encryption');
 insert into tblprotocol  values (55,'MOBILE','NBMA Address Resolution Protocol');
 insert into tblprotocol  values (56,'TLSP','IP Mobility');
 insert into tblprotocol  values (57,'SKIP','Transport Layer Security Protocol');
 insert into tblprotocol  values (58,'IPv6-ICMP','Kryptonet key management');
 insert into tblprotocol  values (59,'IPv6-NoNxt','SKIP');
 insert into tblprotocol  values (60,'IPv6-Opts','ICMP for IPv6');
 insert into tblprotocol  values (61,'any','No Next Header for IPv6');
 insert into tblprotocol  values (62,'CFTP','Destination Options for IPv6');
 insert into tblprotocol  values (63,'any','host internal protocol');
 insert into tblprotocol  values (64,'SAT-EXPAK','CFTP');
 insert into tblprotocol  values (65,'KRYPTOLAN','local network');
 insert into tblprotocol  values (66,'RVD','SATNET and Backroom EXPAK');
 insert into tblprotocol  values (67,'IPPC','Kryptolan');
 insert into tblprotocol  values (68,'any','MIT Remote Virtual Disk Protocol');
 insert into tblprotocol  values (69,'SAT-MON','Internet Pluribus Packet Core');
 insert into tblprotocol  values (70,'VISA','distributed file system');
 insert into tblprotocol  values (71,'IPCV','SATNET Monitoring');
 insert into tblprotocol  values (72,'CPNX','VISA Protocol');
 insert into tblprotocol  values (73,'CPHB','Internet Packet Core Utility');
 insert into tblprotocol  values (74,'WSN','Computer Protocol Network Executive');
 insert into tblprotocol  values (75,'PVP','Computer Protocol Heart Beat');
 insert into tblprotocol  values (76,'BR-SAT-MON','Wang Span Network');
 insert into tblprotocol  values (77,'SUN-ND','Packet Video Protocol');
 insert into tblprotocol  values (78,'WB-MON','Backroom SATNET Monitoring');
 insert into tblprotocol  values (79,'WB-EXPAK','SUN ND PROTOCOL-Temporary');
 insert into tblprotocol  values (80,'ISO-IP','WIDEBAND Monitoring');
 insert into tblprotocol  values (81,'VMTP','WIDEBAND EXPAK');
 insert into tblprotocol  values (82,'SECURE-VMTP','ISO Internet Protocol');
 insert into tblprotocol  values (83,'VINES','VMTP');
 insert into tblprotocol  values (84,'TTP','SECURE-VMTP');
 insert into tblprotocol  values (85,'NSFNET-IGP','VINES');
 insert into tblprotocol  values (86,'DGP','TTP');
 insert into tblprotocol  values (87,'TCF','NSFNET-IGP');
 insert into tblprotocol  values (88,'EIGRP','Dissimilar Gateway Protocol');
 insert into tblprotocol  values (89,'OSPFIGP','TCF');
 insert into tblprotocol  values (90,'Sprite-RPC','EIGRP');
 insert into tblprotocol  values (91,'LARP','OSPFIGP');
 insert into tblprotocol  values (92,'MTP','Sprite RPC Protocol');
 insert into tblprotocol  values (93,'AX.25','Locus Address Resolution Protocol');
 insert into tblprotocol  values (94,'IPIP','Multicast Transport Protocol');
 insert into tblprotocol  values (95,'MICP','AX.25 Frames');
 insert into tblprotocol  values (96,'SCC-SP','IP-within-IP Encapsulation Protocol');
 insert into tblprotocol  values (97,'ETHERIP','Mobile Internetworking Control Pro.');
 insert into tblprotocol  values (98,'ENCAP','Semaphore Communications Sec. Pro.');
 insert into tblprotocol  values (99,'any','Ethernet-within-IP Encapsulation');
 insert into tblprotocol  values (100,'GMTP','Encapsulation Header');
 insert into tblprotocol  values (101,'IFMP','private encryption scheme');
 insert into tblprotocol  values (102,'PNNI','GMTP');
 insert into tblprotocol  values (103,'PIM','Ipsilon Flow Management Protocol');
 insert into tblprotocol  values (104,'ARIS','PNNI over IP');
 insert into tblprotocol  values (105,'SCPS','Protocol Independent Multicast');
 insert into tblprotocol  values (106,'QNX','ARIS');
 insert into tblprotocol  values (107,'A/N','SCPS');
 insert into tblprotocol  values (108,'IPComp','QNX');
 insert into tblprotocol  values (109,'SNP','Active Networks');
 insert into tblprotocol  values (110,'Compaq-Peer','IP Payload Compression Protocol');
 insert into tblprotocol  values (111,'IPX-in-IP','Sitara Networks Protocol');
 insert into tblprotocol  values (112,'VRRP','Compaq Peer Protocol');
 insert into tblprotocol  values (113,'PGM','IPX in IP');
 insert into tblprotocol  values (114,'any','Virtual Router Redundancy Protocol');
 insert into tblprotocol  values (115,'L2TP','PGM Reliable Transport Protocol');
 insert into tblprotocol  values (116,'DDX','0-hop protocol');
 insert into tblprotocol  values (117,'IATP','Layer Two Tunneling Protocol');
 insert into tblprotocol  values (118,'STP','D-II Data Exchange (DDX)');
 insert into tblprotocol  values (119,'SRP','Interactive Agent Transfer Protocol');
 insert into tblprotocol  values (120,'UTI','Schedule Transfer Protocol');
 insert into tblprotocol  values (121,'SMP','SpectraLink Radio Protocol');
 insert into tblprotocol  values (122,'SM','UTI');
 insert into tblprotocol  values (123,'PTP','Simple Message Protocol');
 insert into tblprotocol  values (124,'ISIS','SM');
 insert into tblprotocol  values (125,'FIRE','Performance Transparency Protocol');
 insert into tblprotocol  values (126,'CRTP','over IPv4');
 insert into tblprotocol  values (127,'CRUDP','');
 insert into tblprotocol  values (128,'SSCOPMCE','Combat Radio Transport Protocol');
 insert into tblprotocol  values (129,'IPLT','Combat Radio User Datagram');
 insert into tblprotocol  values (130,'SPS','');
 insert into tblprotocol  values (131,'PIPE','');
 insert into tblprotocol  values (132,'SCTP','Secure Packet Shield');
 insert into tblprotocol  values (133,'FC','Private IP Encapsulation within IP');
 insert into tblprotocol  values (134,'RSVP-E2E-IGNORE','Stream Control Transmission Protocol');
 insert into tblprotocol  values (135,'Mobility','Fibre Channel');
 insert into tblprotocol  values (136,'UDPLite','');
 insert into tblprotocol  values (137,'MPLS-in-IP','Header');
 insert into tblprotocol  values (138,'manet','');
 insert into tblprotocol  values (139,'HIP','');
 insert into tblprotocol  values (140,'Shim6','MANET Protocols');
 insert into tblprotocol  values (253,'Use','Host Identity Protocol');
 insert into tblprotocol  values (254,'Use','Shim6 Protocol');
 insert into tblprotocol  values (255,'Reserved','');




drop table if exists tbldiskusage;
create table tbldiskusage 
(usagetimestamp timestamp default 'now()',
freeindata int8 default '0',
usedindata int8 default '0',
freeinarchive int8 default '0',
usedinarchive int8 default '0',
issamedrive boolean default false
);

drop table if exists tblmemoryusage;
create table tblmemoryusage 
(usagetimestamp timestamp default 'now()',
memoryinuse int8 default '0',
freememory int8 default '0');


drop table if exists tblcpuusage;
create table tblcpuusage 
(usagetimestamp timestamp default 'now()',
idlecpu int8 default '0');




update tbliviewconfig set value='' where keyname='MailAdminId';
insert into tbliviewconfig values ('iviewversion','0.0.0.1 Beta');
insert into tbliviewconfig values ('dbversion','0.0.0.1');

update tblreport set inputparams='startdate,enddate,tbl,appid',query=E'select * from getMainDashboardData(\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',$${3}$$)' where reportid = 1001;




-- ===========================
--	17-08-2009
-- ===========================

update tblreportcolumn set columnformat=8 where columnname = 'Action';

update tbldatalink set url = $$/webpages/reportgroup.jsp?reportgroupid=146100$$ where datalinkid = 146100;
update tbldatalink set url = $$/webpages/reportgroup.jsp?reportgroupid=147100$$ where datalinkid = 147100;


update tblreport set query=E'select deviceid, b.name as devicename,sum(a.hits) as total,a.traffic as Traffic from tblmaindeniedtraffic{4} a, tbldevice b where a.appid=b.appid and a.appid in ({7}) and "5mintime" >= \'\'{0}\'\' and "5mintime" <= \'\'{1}\'\' and traffic in ( select traffic from ( select traffic,sum(hits) as total from tblmaindeniedtraffic{4} where "5mintime" >= \'\'{0}\'\' and "5mintime" <= \'\'{1}\'\' and appid in ({7}) group by traffic order by total desc limit 5 ) as p ) GROUP BY a.traffic, b.name,b.deviceid order by traffic ,total desc' where reportid = 1002;


update tbldatalink set url = $$/webpages/reportgroup.jsp?reportgroupid=141100$$ where datalinkid = 141100;
update tblreportgroup set inputparams = 'srcip,destip,application' where reportgroupid in (141000,146000,147000); 



-- =========================================
--	8/24/2009
-- =========================================

-- Changes from amit

update tblreport set query = E'select * from getdashboarddata(\'\'proto_group\'\',\'\'bytes\'\',\'\'tblmainallowedtraffic\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1003;
update tblreport set query = E'select * from getdashboarddata(\'\'traffic\'\',\'\'hits\'\',\'\'tblmaindeniedtraffic\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1004;
update tblreport set query = E'select * from getdashboarddata(\'\'traffic\'\',\'\'bytes\'\',\'\'tblwebtrafficsummary\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1005;
update tblreport set query = E'select * from getdashboarddata(\'\'traffic\'\',\'\'bytes\'\',\'\'tblmailtrafficsummary\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1006;
update tblreport set query = E'select * from getdashboarddata(\'\'traffic\'\',\'\'bytes\'\',\'\'tblftptrafficsummary\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1007;
update tblreport set query = E'select * from getdashboarddata(\'\'proto_group\'\',\'\'hits\'\',\'\'tblvirussummary\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1008;
update tblreport set query = E'select * from getdashboarddata(\'\'application\'\',\'\'hits\'\',\'\'spam_app\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1009;
update tblreport set query = E'select * from getdashboarddata(\'\'attacktype\'\',\'\'hits\'\',\'\'tblidpattacksummary\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1010;
update tblreport set query = E'select * from getdashboarddata(\'\'application\'\',\'\'hits\'\',\'\'blocked_app_protogroup\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1011;
update tblreport set query = E'select * from getdashboarddata(\'\'application\'\',\'\'hits\'\',\'\'tblcontentfilteringdeniedsummary\'\',\'\'{0}\'\',\'\'{1}\'\',\'\'{2}\'\',\'\'{3}\'\',\'\'{4}\'\',\'\'{5}\'\',\'\'{6}\'\',$${7}$$,\'\'{8}\'\')' where reportid = 1012;
update tbldashboardmenu set link='reportgroup.jsp?device=false&reportgroupid=20000' where iviewmenuid = 103;
update tbldatalink set url='/webpages/reportgroup.jsp?device=false&reportgroupid=20100' where datalinkid = 20100;
update tbldatalink set url='/webpages/reportgroup.jsp?device=false&reportgroupid=20200' where datalinkid = 20200;
update tbldatalink set url='/webpages/reportgroup.jsp?device=false&reportgroupid=20300' where datalinkid = 20300;


-- Changes from atit

insert into tblreport values(20400,'Device wise Event Frequency','startdate,enddate,appid',E'select date_trunc(''''minute'''', "5mintime") as tm,tbldevice.name as Device,sum(events) from tbl_device_event_4hr, tbldevice  where "5mintime" >=\'\'{0}\'\' and "5mintime" <= \'\'{1}\'\'  and tbl_device_event_4hr.appid in ({2}) and tbldevice.appid=tbl_device_event_4hr.appid group by tm,tbldevice.name  order by tm;',20400,0,1,'',1,'');
insert into tblreport values(20500,'Event Frequency','',E'select \'\'24 hour (Average)\'\' as tm,sum(events)/120 as events from tbl_device_event_4hr where   "5mintime" <= current_timestamp and "5mintime" > current_timestamp - interval \'\'24 hour\'\' union select \'\'12 hour (Average)\'\' as tm,sum(events)/60  as events from tbl_device_event_4hr where   "5mintime" <= current_timestamp and "5mintime" > current_timestamp - interval \'\'12 hour\'\' union select \'\'1 hour (Average)\'\' as tm,sum(events)/12 as events  from tbl_device_event_4hr where   "5mintime" <= current_timestamp and "5mintime" > current_timestamp - interval \'\'1 hour\'\' order by tm ',20500,0,1,'',1,'');


insert into tblreportcolumn values(20401,20400,'Time','tm',0,-1,0,0,'tm');
insert into tblreportcolumn values(20402,20400,'Device','Device',0,-1,0,0,'tm');
insert into tblreportcolumn values(20403,20400,'Events','sum',0,-1,0,0,'tm');


insert into tblreportcolumn values(20501,20500,'Time','tm',0,20500,0,0,'tm');
insert into tblreportcolumn values(20502,20500,'Events per Minute','events',0,-1,0,0,'tm');


insert into tblreportgrouprel values(20000,20500,22);
insert into tblreportgrouprel values(20500,20400,11);

insert into tblgraph values(20400,'Device','','',250,380,3,20401,20403,20402,2);
insert into tblgraph values(20500,'Events','','',250,380,41,20501,20502,-1,2);


insert into tbldatalink values(20500,'/webpages/reportgroup.jsp?reportgroupid=20500',1,'','');

insert into tblreportgroup values(20500,'Event Frequency','','',0,100);


-- Table:- tblprotocolgroup

alter table tblprotocolgroup add IsDefault numeric(1) default 1;

update tblprotocolgroup set IsDefault = 0;

-- Table:- tblapplicationname

alter table tblapplicationname add IsDefault numeric(1) default 1;

update tblapplicationname set isDefault=0;

-- Table:- tblprotocolidentifier

alter table tblprotocolidentifier add isDefault numeric(1) default 1;

update  tblprotocolidentifier set isDefault =0;


update tbliviewconfig set value='0.0.0.4 Beta' where keyname='iviewversion';
update tbliviewconfig set value='0.0.0.4' where keyname='dbversion';
