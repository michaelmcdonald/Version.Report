#!/bin/bash

#   TITLE: Version Report
#  AUTHOR: michael mcdonald
# CONTACT: michael@liquidweb.com
# PURPOSE: to crawl various application websites and extract
#          the latest version number for display


# Special thanks to James Dooley for peer reviewing my work and offering
# numerous suggestions on how to improve / speed up my bash scripting
# within this script and the predecessor of it.


##################################################################################

# Quick place to set the script's version number (adjusts the header version too)
SCRIPTVERSION="v2.0.1"

# Variable for identifying the date / time of updates
UPDATE=$(date "+%m.%d.%y @ %H:%M")


################################################################################################
#                                      BEGIN APP VERSION LOOP                                  #
#----------------------------------------------------------------------------------------------#

function appversion {

# Takes the stored string in $VERSION (typically a large mess of code from the application's site) and 
# applies the regex stored in $REGEX (this changes per app) which extracts the appropriate version 
# string. The entire version string is stored in a variable itself, and then it's component of the version
# is stored in a separate variable.
[[ $VERSION =~ $REGEX ]] &&
ENTIREVERSION=${BASH_REMATCH[1]} && # The whole version #: xx.xx.xx
MAJORVERSION=${BASH_REMATCH[2]} &&  # The major version #: x
MINORVERSION=${BASH_REMATCH[3]} &&  # The minor version #: x
# If the application is cPanel or Magento, we're going to add an additional variable after $PATCHVERSION 
# to capture the fourth digit in the version number. We call this variable $BUILDVERSION. If the application
# is NOT cPanel or Magento, we only store up to the third digit ($PATCHVERSION).
if [[ $APP == "cpanel" ]] || [[ $APP == "magento" ]]; then
	PATCHVERSION=${BASH_REMATCH[4]} &&    # The patch version #: x
	BUILDVERSION=${BASH_REMATCH[5]}
else
	PATCHVERSION=${BASH_REMATCH[4]}
fi
# Compares the recently acquired full version string ($ENTIREVERSION) against what is already listed 
# on the site ($CURRENT). If the strings are different, proceeds; otherwise it moves on to the next application.
if [[ "$ENTIREVERSION" != "$CURRENT" ]]; then
	# Replace the pre-existing version numbers in the global version file (variables.php) with the latest 
	# using a sed call that substitutes the $APP variable with the appropriate application name, then replaces
	# the value on the other side of the "=" with the contents of the $*VERSION variables that were set above.
        sed -i "s/\(\$"$APP"_all =\).*/\1 \'$ENTIREVERSION\';/" ./variables.php
        sed -i "s/\(\$"$APP"_major =\).*/\1 $MAJORVERSION;/" ./variables.php
        sed -i "s/\(\$"$APP"_minor =\).*/\1 $MINORVERSION;/" ./variables.php
	# If the application is either CentOS 7 or Wordpress we have to examine the $PATCHVERSION variable because
	# if it's empty it has to be set to "NULL" in variables.php to prevent the page from crashing. If there
	# actually is a value we write it to the appropriate location in variables.php based on $PATCHVERSION. If 
	# we're not looking at CentOS 7 or Wordpress we proceed as normal.
	if [[ $APP == "centos7" ]] || [[ $APP == "word" ]]; then
		if [[ "$PATCHVERSION" == "" ]]; then
                	sed -i "s/\(\$"$APP"_patch =\).*/\1 NULL;/" ./variables.php
        	else
                	sed -i "s/\(\$"$APP"_patch =\).*/\1 $PATCHVERSION;/" ./variables.php
        	fi
	else
		sed -i "s/\(\$"$APP"_patch =\).*/\1 $PATCHVERSION;/" ./variables.php
	fi
	# If the application is cPanel we ensure that the fourth digit of the version string stored in $BUILDVERSION
	# is written to the appropriate variable in variables.php.
	if [[ $APP == "cpanel" ]]; then
		sed -i "s/\(\$cpanel_build =\).*/\1 $BUILDVERSION;/" ./variables.php
	fi
	# Write out the date string that the application was updated to the variables.php file.
        sed -i "s/\(\$"$APP"_update =\).*/\1 \'$UPDATE\';/" ./variables.php
	# Write an entry to the version.log file stating the date / time, the application, and what the previous version
	# listed was and the new version listed.
	echo -e [`date "+%a %b %d %H:%M:%S %Y"`] [$APP] "Previous Version: $CURRENT -- New Version: $ENTIREVERSION" >> ./version.log
fi

}

#----------------------------------------------------------------------------------------------#
#                                       END APP VERSION LOOP                                   #
################################################################################################




################################################################################################
#                                      BEGIN APACHE VARIABLES                                  #
#----------------------------------------------------------------------------------------------#

function apacheversion {

# Curl command that grabs a chunk of code / text from the applications page and stores it in a
# variable for later parsing.
VERSION=$(curl -s http://httpd.apache.org/download.cgi | grep latest)
# Individual regex string used to parse just the version number from the $VERSION text
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
# Curl command to grab the currently stored version for the application and storing in a variable
# later comparison.
CURRENT=$(curl -Lks http://version.report/apache)
# Defining what application we're currently working with
APP=apache

# Calls the "appversion" function, passing along the information related to this application in the
# standard variables above that are used across application functions and the "appversion" function.
appversion

}

#----------------------------------------------------------------------------------------------#
#                                       END APACHE VARIABLES                                   #
################################################################################################




################################################################################################
#                                     BEGIN BBPRESS VARIABLES                                  #
#----------------------------------------------------------------------------------------------#

function bbpressversion {

VERSION=$(curl -s https://bbpress.org/blog/category/releases/ | grep post-)
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/bbpress)
APP=bbpress

appversion

}

#----------------------------------------------------------------------------------------------#
#                                      END BBPRESS VARIABLES                                   #
################################################################################################




################################################################################################
#                                    BEGIN CENTOS 6 VARIABLES                                  #
#----------------------------------------------------------------------------------------------#

function centos6version {

VERSION=$(curl -s http://wiki.centos.org/FrontPage | grep Current)
REGEX="(([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/centos6)
APP=centos6

appversion

}

#----------------------------------------------------------------------------------------------#
#                                      END CENTOS 6 VARIABLES                                  #
################################################################################################




################################################################################################
#                                     BEGIN CENTOS 7 VARIABLES                                 #
#----------------------------------------------------------------------------------------------#

function centos7version {

VERSION=$(curl -s http://wiki.centos.org/FrontPage | grep Current)
REGEX="(([0-9]+)\s\(([0-9]+)\)).*$"
CURRENT=$(curl -Lks http://version.report/centos7)
APP=centos7

appversion

}

#----------------------------------------------------------------------------------------------#
#                                      END CENTOS 7 VARIABLES                                  #
################################################################################################




################################################################################################
#                                      BEGIN CPANEL VARIABLES                                  #
#----------------------------------------------------------------------------------------------#

function cpanelversion {

VERSION=$(curl -s http://updates.cpanel.net | grep -A2 RELEASE)
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/cpanel)
APP=cpanel

appversion

}

#----------------------------------------------------------------------------------------------#
#                                       END CPANEL VARIABLES                                   #
################################################################################################




################################################################################################
#                                     BEGIN DRUPAL 6 VARIABLES                                 #
#----------------------------------------------------------------------------------------------#

function drupal6version {

VERSION=$(curl -s https://www.drupal.org/project/drupal | awk '/release-version/||/drupal-6/ {print};')
REGEX="(([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/drupal6)
APP=drupal6

appversion

}

#----------------------------------------------------------------------------------------------#
#                                      END DRUPAL 6 VARIABLES                                  #
################################################################################################




################################################################################################
#                                     BEGIN DRUPAL 7 VARIABLES                                 #
#----------------------------------------------------------------------------------------------#

function drupal7version {

VERSION=$(curl -s https://www.drupal.org/project/drupal | awk '/release-version/||/drupal-7/ {print};')
REGEX="(([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/drupal7)
APP=drupal7

appversion

}

#----------------------------------------------------------------------------------------------#
#                                       END DRUPAL 7 VARIABLES                                 #
################################################################################################




################################################################################################
#                                     BEGIN JOOMLA 2 VARIABLES                                 #
#----------------------------------------------------------------------------------------------#

function joomla2version {

VERSION=$(curl -s http://joomlacode.org/gf/project/joomla/frs/?action=index | awk '/Mature/ {print;exit}')
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/joomla2)
APP=joomla2

appversion

}

#----------------------------------------------------------------------------------------------#
#                                      END JOOMLA 2 VARIABLES                                  #
################################################################################################




################################################################################################
#                                     BEGIN JOOMLA 3 VARIABLES                                 #
#----------------------------------------------------------------------------------------------#

function joomla3version {

VERSION=$(curl -s https://github.com/joomla/joomla-cms/releases/ | awk '/Stable-Full_Package/ {print;exit}')
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/joomla3)
APP=joomla3

appversion

}

#----------------------------------------------------------------------------------------------#
#                                      END JOOMLA 3 VARIABLES                                  #
################################################################################################




################################################################################################
#                                     BEGIN MAGENTO VARIABLES                                  #
#----------------------------------------------------------------------------------------------#

function magentoversion {

VERSION=$(curl -s https://www.magentocommerce.com/download | grep -A6 "Full Release")
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/magento)
APP=magento

appversion

}

#----------------------------------------------------------------------------------------------#
#                                      END MAGENTO VARIABLES                                   #
################################################################################################




################################################################################################
#                                      BEGIN MARIADB VARIABLES                                 #
#----------------------------------------------------------------------------------------------#

function mariadbversion {

VERSION=$(curl -s https://downloads.mariadb.org/ | awk '/Stable/ {print;exit}')
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/mariadb)
APP=mariadb

appversion

}

#----------------------------------------------------------------------------------------------#
#                                       END MARIADB VARIABLES                                  #
################################################################################################




################################################################################################
#                                     BEGIN MEDIAWIKI VARIABLES                                #
#----------------------------------------------------------------------------------------------#

function mediawikiversion {

VERSION=$(curl -s https://www.mediawiki.org/wiki/Download | awk '/Download MediaWiki/ {print}')
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/mediawiki)
APP=mediawiki

appversion

}

#----------------------------------------------------------------------------------------------#
#                                      END MEDIAWIKI VARIABLES                                 #
################################################################################################




################################################################################################
#                                      BEGIN MYSQL VARIABLES                                   #
#----------------------------------------------------------------------------------------------#

function mysqlversion {

VERSION=$(curl -s http://dev.mysql.com/downloads/ | awk '/Current Generally Available Release/ {print;exit}')
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/mysql)
APP=mysql

appversion

}

#----------------------------------------------------------------------------------------------#
#                                       END MYSQL VARIABLES                                    #
################################################################################################




################################################################################################
#                                      BEGIN NGINX VARIABLES                                   #
#----------------------------------------------------------------------------------------------#

function nginxversion {

VERSION=$(curl -s http://nginx.org/en/download.html | awk '/Stable version/ {print}')
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/nginx)
APP=nginx

appversion

}

#----------------------------------------------------------------------------------------------#
#                                       END NGINX VARIABLES                                    #
################################################################################################




################################################################################################
#                                       BEGIN PHP VARIABLES                                    #
#----------------------------------------------------------------------------------------------#

function phpversion {

VERSION=$(curl -s http://php.net/downloads.php | grep -A2 "Current Stable")
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/php)
APP=php

appversion

}

#----------------------------------------------------------------------------------------------#
#                                        END PHP VARIABLES                                     #
################################################################################################




################################################################################################
#                                      BEGIN PHPBB VARIABLES                                   #
#----------------------------------------------------------------------------------------------#

function phpbbversion {

VERSION=$(curl -sk https://www.phpbb.com/downloads/ | awk '/Latest stable/ {print}')
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/phpbb)
APP=phpbb

appversion

}

#----------------------------------------------------------------------------------------------#
#                                       END PHPBB VARIABLES                                    #
################################################################################################




################################################################################################
#                                      BEGIN UBUNTU VARIABLES                                  #
#----------------------------------------------------------------------------------------------#

function ubuntuversion {

# The REGEX match for the overall breakdown / capture groups for the version numbers
UBUNTUREGEX="([0-9]+)\.?([0-9]+)?\.?([0-9]+)?"

# The curl command that will pull down ONLY the version numbers
LINES=$(curl -s http://releases.ubuntu.com/ | grep -A8 "Ubuntu are available" | egrep -o "1[0-9].*[0-9]")

# Counter I use for the Ubuntu version variables
X=0

# The for loop that goes through the version numbers pulled down by the curl command, breaks each one into 
# the respect group for major, minor, and patch values, and stores them to variables for later use
for line in $LINES;do
        if [[ $line =~ $UBUNTUREGEX ]]; then
                for ((i=0;i<${#BASH_REMATCH[*]};i++)); do
                        UBUNTU[$X]=${BASH_REMATCH[$i]}
                        let X++
                done
        fi
done

CURRENTUBUNTU15=$(curl -Lks http://version.report/ubuntu15)
CURRENTUBUNTU14=$(curl -Lks http://version.report/ubuntu14)
CURRENTUBUNTU14LTS=$(curl -Lks http://version.report/ubuntu14lts)
CURRENTUBUNTU12LTS=$(curl -Lks http://version.report/ubuntu12lts)
CURRENTUBUNTU10LTS=$(curl -Lks http://version.report/ubuntu10lts)

# Basically the same sed commands as previous ections that writes the version values to their correct
# location within the variables.php file
if [[ "${UBUNTU[0]}" != "$CURRENTUBUNTU15" ]]; then
sed -i "s/\(\$ubuntu15_all =\).*/\1 \'${UBUNTU[0]}\';/" ./variables.php
sed -i "s/\(\$ubuntu15_major =\).*/\1 ${UBUNTU[1]};/" ./variables.php
sed -i "s/\(\$ubuntu15_minor =\).*/\1 ${UBUNTU[2]};/" ./variables.php
sed -i "s/\(\$ubuntu15_update =\).*/\1 \'$UPDATE\';/" ./variables.php
fi

if [[ "${UBUNTU[4]}" != "$CURRENTUBUNTU14" ]]; then
sed -i "s/\(\$ubuntu14_all =\).*/\1 \'${UBUNTU[4]}\';/" ./variables.php
sed -i "s/\(\$ubuntu14_major =\).*/\1 ${UBUNTU[5]};/" ./variables.php
sed -i "s/\(\$ubuntu14_minor =\).*/\1 ${UBUNTU[6]};/" ./variables.php
sed -i "s/\(\$ubuntu14_update =\).*/\1 \'$UPDATE\';/" ./variables.php
fi

if [[ "${UBUNTU[8]}" != "$CURRENTUBUNTU14LTS" ]]; then
sed -i "s/\(\$ubuntu14LTS_all =\).*/\1 \'${UBUNTU[8]}\';/" ./variables.php
sed -i "s/\(\$ubuntu14LTS_major =\).*/\1 ${UBUNTU[9]};/" ./variables.php
sed -i "s/\(\$ubuntu14LTS_minor =\).*/\1 ${UBUNTU[10]};/" ./variables.php
sed -i "s/\(\$ubuntu14LTS_patch =\).*/\1 ${UBUNTU[11]};/" ./variables.php
sed -i "s/\(\$ubuntu14LTS_update =\).*/\1 \'$UPDATE\';/" ./variables.php
fi

if [[ "${UBUNTU[12]}" != "$CURRENTUBUNTU12LTS" ]]; then
sed -i "s/\(\$ubuntu12LTS_all =\).*/\1 \'${UBUNTU[12]}\';/" ./variables.php
sed -i "s/\(\$ubuntu12LTS_major =\).*/\1 ${UBUNTU[13]};/" ./variables.php
sed -i "s/\(\$ubuntu12LTS_minor =\).*/\1 ${UBUNTU[14]};/" ./variables.php
sed -i "s/\(\$ubuntu12LTS_patch =\).*/\1 ${UBUNTU[15]};/" ./variables.php
sed -i "s/\(\$ubuntu12LTS_update =\).*/\1 \'$UPDATE\';/" ./variables.php
fi

if [[ "${UBUNTU[16]}" != "$CURRENTUBUNTU10LTS" ]]; then
sed -i "s/\(\$ubuntu10LTS_all =\).*/\1 \'${UBUNTU[16]}\';/" ./variables.php
sed -i "s/\(\$ubuntu10LTS_major =\).*/\1 ${UBUNTU[17]};/" ./variables.php
sed -i "s/\(\$ubuntu10LTS_minor =\).*/\1 ${UBUNTU[18]};/" ./variables.php
sed -i "s/\(\$ubuntu10LTS_patch =\).*/\1 ${UBUNTU[19]};/" ./variables.php
sed -i "s/\(\$ubuntu10LTS_update =\).*/\1 \'$UPDATE\';/" ./variables.php
fi

}

#----------------------------------------------------------------------------------------------#
#                                       END UBUNTU VARIABLES                                   #
################################################################################################




################################################################################################
#                                    BEGIN VBULLETIN VARIABLES                                 #
#----------------------------------------------------------------------------------------------#

function vbulletinversion {

VERSION=$(curl -s http://www.vbulletin.com/download.php | awk '/Latest Version/ {print}')
REGEX="(([0-9]+)\.([0-9]+)\.([0-9]+)).*$"
CURRENT=$(curl -Lks http://version.report/vbulletin)
APP=vbulletin

appversion

}

#----------------------------------------------------------------------------------------------#
#                                     END VBULLETIN VARIABLES                                  #
################################################################################################




################################################################################################
#                                    BEGIN WORDPRESS VARIABLES                                 #
#----------------------------------------------------------------------------------------------#

function wordpressversion {

VERSION=$(curl -s https://wordpress.org/download/release-archive/ | grep -A2 Version)
REGEX="(([0-9]+)\.([0-9]+)\.?([0-9]+)?).*$"
CURRENT=$(curl -Lks http://version.report/wordpress)
APP=word

appversion

}

#----------------------------------------------------------------------------------------------#
#                                     END WORDPRESS VARIABLES                                  #
################################################################################################




################################################################################################
#                                    BEGIN FUNCTION EXECUTION                                  #
#----------------------------------------------------------------------------------------------#

# Execute the functions in order
apacheversion
bbpressversion
centos6version
centos7version
cpanelversion
drupal6version
drupal7version
joomla2version
joomla3version
magentoversion
mariadbversion
mediawikiversion
mysqlversion
nginxversion
phpversion
phpbbversion
ubuntuversion
vbulletinversion
wordpressversion

#----------------------------------------------------------------------------------------------#
#                                      END FUNCTION EXECUTION                                  #
################################################################################################
