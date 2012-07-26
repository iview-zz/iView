#!/bin/sh
# ***********************************************************************
# Cyberoam iView - The Intelligent logging and reporting solution that 
# provides network visibility for security, regulatory compliance and 
# data confidentiality 
# Copyright  (C ) 2009  Elitecore Technologies Ltd.
# 
# This program is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by 
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License 
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# The interactive user interfaces in modified source and object code 
# versions of this program must display Appropriate Legal Notices, as 
# required under Section 5 of the GNU General Public License version 3.
# 
# In accordance with Section 7(b) of the GNU General Public License 
# version 3, these Appropriate Legal Notices must retain the display of
#  the "Cyberoam Elitecore Technologies Initiative" logo.
# ***********************************************************************

# Redhat spec files (from RPMs)
REDHAT_DIR = packaging/redhat
REDHAT = \
	$(REDHAT_DIR)/garner-2-config-patch \
	$(REDHAT_DIR)/garner-initd \
	$(REDHAT_DIR)/garner.spec

# Packaging files
PACKAGING = $(REDHAT)
INPUT_PLUGINS = plugins/InputPlugin/fwstub 
#		plugins/InputPlugin/stdevent

OUTPUT_PLUGINS = plugins/OutputPlugin/libarchiever \
		 plugins/OutputPlugin/libdevdiscovery \
		 plugins/OutputPlugin/libpgtrigger \
		 plugins/OutputPlugin/libpostgres \
		 plugins/OutputPlugin/libresolver \
		 plugins/OutputPlugin/hbtlvclient \
		 plugins/OutputPlugin/libsethreshold 
		 

EXTRA_DIST = TODO $(PACKAGING)
SUBDIRS = doc src $(INPUT_PLUGINS) $(OUTPUT_PLUGINS)

install-data-local: garner-configure-file garner-html-files

# Install the configuration file if it doesn't already exist
garner-configure-file:
	$(mkinstalldirs) $(DESTDIR)@GARNER_CONFIG_DIR@
	$(INSTALL) -m 600 $(srcdir)/doc/garner.conf \
		$(DESTDIR)@GARNER_CONFIG_DIR@/@GARNER_CONFIG_FILE@-dist
	test -f $(DESTDIR)@GARNER_CONFIG_DIR@/@GARNER_CONFIG_FILE@ \
		|| $(INSTALL) -m 600 $(srcdir)/doc/garner.conf \
			$(DESTDIR)@GARNER_CONFIG_DIR@/@GARNER_CONFIG_FILE@
	@echo ""
	@echo "A configuration file has been copied to:"
	@echo ""
	@echo "@GARNER_CONFIG_DIR@/@GARNER_CONFIG_FILE@-dist"
	@echo ""
	@echo "You will need to rename this file to:"
	@echo ""
	@echo "@GARNER_CONFIG_DIR@/@GARNER_CONFIG_FILE@"
	@echo ""
	@echo "and modify the values to suit your local system."
	@echo ""
	@echo "All the configuration directives are commented in the file, so"
	@echo "you should not have any problems configuring your system."
	@echo ""

# Install the HTML files
garner-html-files:
	$(mkinstalldirs) $(DESTDIR)$(datadir)/garner

	for file in debug default stats; do \
	  $(INSTALL) -m 644 $(srcdir)/doc/$$file.html $(DESTDIR)$(datadir)/garner/$$file.html.dist ; \
	  test -f $(DESTDIR)$(datadir)/garner/$$file.html || \
	    $(INSTALL) -m 644 $(srcdir)/doc/$$file.html $(DESTDIR)$(datadir)/garner/$$file.html ; \
	done
	$(INSTALL) -m 644 $(srcdir)/doc/HTML_VARIABLES $(DESTDIR)$(datadir)/garner/HTML_VARIABLES
