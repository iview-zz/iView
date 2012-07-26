This is a release of Cyberoam iView, the Open Source logging and reporting solution that provides network visibility for security, regulatory compliance and data confidentiality. This is available under a dual-license as follows: 
- For GPL (free) distributions, it is available under the GPLv3 License, see the COPYING file for the detailed license
- For commercial distribution such as OEM, ISVs, rebranding please contact Elitecore Technologies Ltd by visiting the www.cyberoam-iview.com website

For further information about Cyberoam iView or additional documentation, visit the www.cyberoam-iview.org website

Cyberoam iView is free software, if you are using and/or enhancing / developing open source applications: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 
A copy of the GNU General Public License is available along with this program; see the COPYING file for the detailed license. 
The interactive user interfaces in modified source and object code versions of this program must display Appropriate Legal Notices, as required under  Section 5 of the GNU General Public License version 3.

In accordance with Section 7(b) of the GNU General Public License version 3, these Appropriate Legal Notices must retain the display of the "Cyberoam Elitecore Technologies Initiative" logo. 
 
Cyberoam iView  is the trademark of Elitecore Technologies Ltd.

****                    


Compilation Prerequisite:
Ant 1.6+
JDK 1.5

Deployement prerequisite:
It will install following tools in your machine.
Cygwin 1.5
JDK 1.5 
Tomcat 5.5
and Postgresql 8.4 (if not exist)

To compile java source code you need to setup Apache Ant tool and JDK 1.5+ installed in your machine. 

The Cyberoam iView Web application source code is organized in following manner:

	/src                    // production source
              /java              // java source.  First directory in here is "com"
              /web               // html, jsp, image and any other files for a web site
              /docs              // Contains online help
         /lib                    // jar files and the like that the project uses
              /production        // stuff that will need to be copied into production
              /development       // stuff that is used only during development
                                 //        and should not find its way to production
         /build                  // this dir does not go in version control.
                                 //        frequently deleted and re-created by ant
              /gen-src           // if your app generates any source, it goes in here. Usually a jsp generated source
                                 //        (generated source never goes in VC!)
              /classes           // compiled production classes
              /dist              // the final artifacts destined for production.
                                 //        Usually a ROOT.war file. 
         build.xml               // ant build file
         readme.txt              // notes between developers about this project

Ant build Commands:

ant help# Provides ant command help for compiling cyberoam source
ant / ant build# Generate ROOT.war File in ./build/dist
ant build -Dapp.name=ROOT#  Generate <app.name>.war File in ./build/dist
ant build deploy -Ddeploy.dir=c:\tomcat\webapps -Dapp.name=iview#  Generate <app.name>.war File in ./build/dist and move it to deployement path(deploy.dir path).
