#!/bin/bash

# Template to add new update scripts from SVN for a specific tool
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    October 2009
# Version: 0.1
#
# Usage:
# 0. Copy this template to /usr/bin/samurai_svn/scripts as svn_TOOL-NAME.sh,
#    replacing TOOL-NAME by the name of the tool (eg. svn_w3af.sh)
#    $ cp svn_template ../scripts/svn_w3af.sh
# 1. Change the permissions of the new script to 755:
#    $ chmod 755 /usr/bin/samurai_svn/scripts/svn_w3af.sh 
# 2. Edit the new script file...
# 3. Replace the TOOL variable below with the tool name
#    eg. TOOL=w3af
# 4. Replace the SVN variable below with the reference to the SVN repository
#    eg. SVN=https://w3af.svn.sourceforge.net/svnroot/w3af/trunk
# 5. Create a new SVN update menu pointing to this new SVN update script
# 6. Include any other commands specific for this tool under the "Additional 
#    instructions/actions" section (at the end), such as how to build or 
#    compile the tool from the SVN source code
#


# Tool name
TOOL=yokoso

# SVN repository
SVN=https://yokoso.svn.sourceforge.net/svnroot/yokoso

# Main dir
DIR=/usr/bin/samurai_svn

# SVN update script
SVN_UPDATE=$DIR/bin/svn_update.sh

# Launch the update
$SVN_UPDATE $TOOL $SVN

# Additional instructions/actions
# ...

if [ $? = 0 ]; then

	# Samurai dir
	SAMURAI_DIR=/usr/bin/samurai

	# Yokoso BeEF module
	YOKOSO_MODULE=yokoso_history

	# BeEF modules directory
	BEEF_MODULES=/var/www/beef/modules/symmetric

	# Nmap NSE library data directory
	NMAP_NSELIBDATA=/usr/local/share/nmap/nselib/data

	# Nmap fingerprints
	NMAP_FINGERPRINTS=yokoso-fingerprints

	# Yokoso fingerprints
	YOKOSO_FINGERPRINTS=fingerprints


	## Yokoso & BeEF integration

        echo -n "Do you want to copy the latest Yokoso BeEF module to the local BeEF installation directory (yes/no)? "
	read answer
	echo

	if [ ":yes:" == ":$answer:" ]; then
	    # sudo
	    echo "*** The copy of the files to the web server document root requires elevated privileges (sudo)..."
  	    # Create a backup copy of the previous Yokoso BeEF module (if existed)
	    if [ -d $BEEF_MODULES/$YOKOSO_MODULE ]; then
	        if [ -d $BEEF_MODULES/$YOKOSO_MODULE.backup ]; then
	           sudo rm -rf $BEEF_MODULES/$YOKOSO_MODULE.backup
	        fi
	        sudo mv $BEEF_MODULES/$YOKOSO_MODULE $BEEF_MODULES/$YOKOSO_MODULE.backup
	    fi
	    sudo cp -rf $SAMURAI_DIR/$TOOL/beef/$YOKOSO_MODULE $BEEF_MODULES
	else
            echo "*** No integration between Yokoso & BeEF applied."
        fi


	## Yokoso & nmap integration

	echo
        echo -n "Do you want to copy the latest Yokoso fingerprints to the local nmap installation directory (yes/no)? This integration requires the nmap SVN version as it does not work with the default nmap 5.00 version. Answer: (yes/no)? "
	read answer
	echo

	if [ ":yes:" == ":$answer:" ]; then
	    # sudo
	    echo "*** The copy of the fingerprints file to the nmap directory requires elevated privileges (sudo)..."
	    if [ ! -d $NMAP_NSELIBDATA ]; then
		echo "*** Error: The nmap NSE library data directory ,$NMAP_NSELIBDATA, does NOT exist. Aborting..."
		echo "*** Update nmap from SVN."

		echo
		echo "Hit enter to exit."
	        read answer
		exit 1
	    else
  	        # Create a backup copy of the previous nmap's Yokoso fingerprints file
	        if [ -d $NMAP_NSELIBDATA/$NMAP_FINGERPRINTS.backup ]; then
	           sudo rm -f $NMAP_NSELIBDATA/$NMAP_FINGERPRINTS.backup
	        fi
	        sudo mv $NMAP_NSELIBDATA/$NMAP_FINGERPRINTS $NMAP_NSELIBDATA/$NMAP_FINGERPRINTS.backup
	    fi
	    sudo cp -f $SAMURAI_DIR/$TOOL/$YOKOSO_FINGERPRINTS $NMAP_NSELIBDATA/$NMAP_FINGERPRINTS
	    sudo chmod 644 $NMAP_NSELIBDATA/$NMAP_FINGERPRINTS
	else
            echo "*** No integration between Yokoso & nmap applied."
        fi

	echo
        echo "Hit enter to exit."
        read answer
fi

