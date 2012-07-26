-- ========================================================
--	Database - iViewdb
--	Version - 0.0.0.1 Beta
-- ========================================================


CREATE DATABASE iviewdb WITH TEMPLATE = template0 ENCODING = 'WIN1252';


ALTER DATABASE iviewdb OWNER TO postgres;

\connect iviewdb

CREATE PROCEDURAL LANGUAGE plpgsql;

ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

-- Initial Procedure Call


select clean_ftp_data_proc();
select firewall_traffic_proc_first_level();
select denied_web_content_categorization_data_proc();
select idp_alerts_data_proc();
select mail_data_proc();
select virus_data_proc();
select web_usage_data_proc_first_level();
select firewall_blocked_traffic_proc();

select clean_ftp_data_proc_4hr();
select firewall_traffic_proc_4hr_first_level();
select firewall_blocked_traffic_proc_4hr();
select denied_web_content_categorization_data_proc_4hr();
select idp_alerts_data_proc_4hr();
select mail_data_proc_4hr();
select web_usage_data_proc_4hr_first_level();
select virus_data_proc_4hr();