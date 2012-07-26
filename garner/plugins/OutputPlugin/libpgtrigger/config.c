#include <string.h>
#include <stdlib.h>

#include "../../../src/std_event.h"
#include "oppgtrigger_db.h"
#include "utils.h"

/* SETTINGS CONFIGURATION ROUTINES */
static	char *g_server_addr	= NULL;
static	char *g_server_port	= NULL;
static	char *g_connect_options	= NULL;
static	char *g_database_name	= NULL;
static	char *g_username	= NULL;
static	char *g_password	= NULL;
static	u_int32_t g_reconnect_interval = OPPGTRIGGER_CONFIG_DEFAULT_RECONNECT_INTERVAL_SEC;

void
pgtrigger_config_set_server_addr(char *server_addr)
{
    if(server_addr) {
	if(g_server_addr) {
	    free(g_server_addr);
	}
	g_server_addr = server_addr ;
	oppgtrigger_log_msg(LG_DEBUG, "pgtrigger_config_set_server_addr: ServerAddress set to '%s'\n", 
											g_server_addr);
    }
    return ;
}
char *
pgtrigger_config_get_server_addr(void)
{
    if(g_server_addr) {
        return g_server_addr ;
    } else {
	return OPPGTRIGGER_CONFIG_DEFAULT_SERVER_ADDR ;
    }
}

void
pgtrigger_config_set_server_port(char *server_port)
{
    if(server_port) {
	if(g_server_port) {
	    free(g_server_port);
	}
	g_server_port = server_port ;
	oppgtrigger_log_msg(LG_DEBUG, "pgtrigger_config_set_server_port: ServerPort set to '%s'\n", g_server_port);
    }
    return ;
}
char *
pgtrigger_config_get_server_port(void)
{
    return g_server_port ;
}

void
pgtrigger_config_set_connect_options(char *connect_options)
{
    if(connect_options) {
	if(g_connect_options) {
	    free(g_connect_options);
	}
	g_connect_options = connect_options ;
	oppgtrigger_log_msg(LG_DEBUG, "pgtrigger_config_set_connect_options: ConnectOptions set to '%s'\n", 
											g_connect_options);
    }
    return ;
}
char *
pgtrigger_config_get_connect_options(void)
{
    return g_connect_options ;
}

void
pgtrigger_config_set_database_name(char *db_name)
{
    if(db_name) {
	if(g_database_name) {
	    free(g_database_name);
	}
	g_database_name = db_name;
	oppgtrigger_log_msg(LG_DEBUG, "pgtrigger_config_set_database_name: Databasename set to '%s'\n", 
											g_database_name);
    }
    return ;
}
char *
pgtrigger_config_get_database_name(void)
{
    if(g_database_name) {
	return g_database_name ;
    } else {
	return OPPGTRIGGER_CONFIG_DEFAULT_DATABASE_NAME ;
    }
}

void
pgtrigger_config_set_username(char *username)
{
    if(username) {
	if(g_username) {
	    free(g_username);
	}
	g_username = username ;
	oppgtrigger_log_msg(LG_DEBUG, "pgtrigger_config_set_username: Username set to '%s'\n", 
										g_username);
    }
    return ;
}
char *
pgtrigger_config_get_username(void)
{
    return g_username ;
}

void
pgtrigger_config_set_password(char *password)
{
    if(password) {
	if(g_password) {
	    free(g_password);
	}
	g_password = password ;
	oppgtrigger_log_msg(LG_DEBUG, "pgtrigger_config_set_password: Password set to '%s'\n", g_password);
    }
    return ;
}
char *
pgtrigger_config_get_password(void)
{
    return g_password ;
}

void
pgtrigger_config_set_reconnect_interval(u_int32_t interval_sec)
{
    g_reconnect_interval = interval_sec ;
    oppgtrigger_log_msg(LG_DEBUG, "pgtrigger_config_set_reconnect_interval: Reconnect Interval set to '%d'\n", 
											g_reconnect_interval);
    return ;
}
u_int32_t
pgtrigger_config_get_reconnect_interval(void)
{
    return g_reconnect_interval ;
}


struct _trigger *g_trigger_list = NULL;

struct _trigger *
pgtrigger_config_new_trigger()
{
    return (struct _trigger *) calloc(1, sizeof(struct _trigger));
}

struct _trigger *
pgtrigger_config_get_trigger_by_name(char *name)
{
    struct _trigger *trigger = g_trigger_list;

    while (trigger) {
        if (!strcasecmp(trigger->name, name)) {
	    return trigger;
	}
        trigger = trigger->next;
    }
    return NULL;
}

void
pgtrigger_config_insert_trigger_in_list(struct _trigger *trigger)
{
    trigger->next = g_trigger_list;
    g_trigger_list = trigger;

    return;
}

void
pgtrigger_config_free_trigger_list()
{
    struct _trigger *trigger = g_trigger_list;
    struct _trigger *next;

    while(trigger) {
        next = trigger->next;

	free(trigger->name);
	if(trigger->query) {
	    free(trigger->query);
	}
	free(trigger);

	trigger = next;
    }
    return;
}

void
pgtrigger_config_cleanup_parsed_state()
{
    pgtrigger_config_free_trigger_list();
    return ;
}

