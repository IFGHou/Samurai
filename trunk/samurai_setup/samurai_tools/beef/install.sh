#!/bin/bash
#
# Script to install a new tool into Samurai
#
# When creating the install.sh script for a new tool, read this template file
# and provide the details every time the "*** CHANGE THIS ***" string appears.
#
# NOTE: Run this script with root privileges using "sudo"
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    December 2009
# Version: 0.1
#

# Tool name				<---- *** CHANGE THIS ***
TOOL=beef

# *** IMPORTANT ***
# The name of the tool MUST match the name of the main directory used by
# the official SVN or CVS tool repository (it is case-sensitive).
# If it does not have a SVN/CVS repository, use the name of the directory
# it is extracted to from its official package (eg. .tgz).s

# Tool version				<---- *** CHANGE THIS ***
VERSION=0.4.0

# Type of tool (case-sensitive): 	<---- *** CHANGE THIS ***
# java, CLI, GUI, DIR, tgz, web		
# This script is not used for OS tools: use "apt-get install" instead.
TYPE=web

# Update method: no or cvs or svn	<---- *** CHANGE THIS ***
UPDATE=no

# Local dir
LOCALDIR=samurai_setup/samurai_tools/$TOOL


# Main Samurai files and directories 
# -----------------------------------

# Samurai dir
SAMURAI_DIR=/usr/bin/samurai

# Samurai tools home
SAMURAI_TOOLS=/home/samurai/tools

# Main SVN dir
SVN_DIR=/usr/bin/samurai_svn

# Samurai web server dir
WEBSERVER_DIR=/var/www

# Directories for menus: directories and applications
MENU_DIR=/home/samurai/.local/share/desktop-directories/
MENU_APP=/home/samurai/.local/share/applications/

# Directories for gnome-terminal profiles
PROFILES_DIR=/home/samurai/.gconf/apps/gnome-terminal/profiles
PROFILES_LIST=/home/samurai/.gconf/apps/gnome-terminal/global/%gconf.xml

# "Applications" menu (file)
APPS_MENUS=/home/samurai/.config/menus/applications.menu

# File with the list of tools available on Samurai
TOOL_LIST=$SAMURAI_DIR/tools.txt


# Local files and directories related to the tool
# ------------------------------------------------

# Tool installation file or archive		<---- *** CHANGE THIS ***
TOOL_ARCHIVE=beef-v0.4.0.0.tar.gz

# Local tool launch script
LOCALSCRIPT=$PWD/$LOCALDIR/scripts/$TOOL.sh

# Local tool menu
LOCALMENU=$PWD/$LOCALDIR/menus/$TOOL.desktop

# Local tool gnome-terminal profile (directory)
LOCALPROFILE=$PWD/$LOCALDIR/profile/$TOOL

# Local tool SVN script
if [ ":no:" == ":$UPDATE:" ]; then
	# No SVN/CVS update available for the tool
	LOCALSVNSCRIPT=no_svn-cvs_update_available
else
	LOCALSVNSCRIPT=$PWD/$LOCALDIR/scripts/$UPDATE_$TOOL.sh
fi

# Local tool SVN menu
if [ ":no:" == ":$UPDATE:" ]; then
	# No SVN/CVS update menu required for the tool
	LOCALSVNMENU=no_svn-cvs_update_menu_required
else
	LOCALSVNMENU=$PWD/$LOCALDIR/menus/$UPDATE_$TOOL.desktop
fi



#  MAIN
# ------

# 1. Create the tool directory under /usr/bin/samurai or /var/www

# TYPES:  java, CLI, GUI, DIR, tgz, web

if [ ":web:" == ":$TYPE:" ]; then
	echo "Creating tool directory: $WEBSERVER_DIR/$TOOL..."
	if [ ! -d $WEBSERVER_DIR/$TOOL ]; then
		mkdir $WEBSERVER_DIR/$TOOL
	else
		echo "*** Directory already exist: $WEBSERVER_DIR/$TOOL"
		echo "    Make a backup copy, delete/move it, and call this script again."
		exit -1
	fi
else
	echo "Creating tool directory: $SAMURAI_DIR/$TOOL..."
	if [ ! -d $SAMURAI_DIR/$TOOL ]; then
		mkdir $SAMURAI_DIR/$TOOL
	else
		echo "*** Directory already exist: $SAMURAI_DIR/$TOOL"
		echo "    Make a backup copy, delete/move it, and call this script again."
		exit -1
	fi
fi


# 2. Copy the tool to its new directory		<---- *** CHANGE THIS ***
echo "Copying tool files..."

# Add here the command(s) to copy the tool contents to its new directory:

# -- EXTRACT TOOL: START --
CURRENT_DIR=$PWD
cd $WEBSERVER_DIR
tar xvzf $CURRENT_DIR/$LOCALDIR/$TOOL_ARCHIVE

if [ "$?" -ne 0 ]; then
	echo "*** Error extracting the tool files. Review the actions in this script."
	exit -1
fi

cd $CURRENT_DIR
echo
# -- EXTRACT TOOL: END --




# 3. Change the ownership for all the tool files and directories
echo "Changing tool file ownership..."
if [ ":web:" == ":$TYPE:" ]; then
	chown -R  www-data:root $WEBSERVER_DIR/$TOOL
else
	chown -R samurai:samurai $SAMURAI_DIR/$TOOL
fi


# 4. Copy the tool launch script to /home/samurai/tools
if [ ":web:" == ":$TYPE:" ]; then
	echo "No tool launch script required ($TYPE)."
else
	echo "Creating tool launch script: $SAMURAI_TOOLS/$LOCALSCRIPT..."
	cp -pf $LOCALSCRIPT $SAMURAI_TOOLS
fi


# 5. Copy the tool menu to the applications menus directory
if [ ":web:" == ":$TYPE:" ]; then
	echo "No tool menu entry required ($TYPE)."
else
	echo "Copying the tool menu entry to the main Applications menu..."
	cp -pf $LOCALMENU $MENU_APP
fi

#
# *** MANUAL STEP ***
#
# 6. Update the main applications.menu file	
#    or add a new bookmark entry for web server tools.
if [ ":web:" == ":$TYPE:" ]; then
	echo
	echo "*** Add a new bookmark in Firefox for this web server tool:"
	echo " - Open the Firefox browser (as the samurai user)"
	echo " - Browse to the target web page"
	echo " - Go to the *Bookmarks* menu"
	echo " - Select the *Bookmark This Page* option"
	echo
	echo "*** Press any key once the previous procedure has been completed."
	read key
else
	echo
	echo "*** Edit the $APPS_MENUS file and"
	echo "    add the following new entry under the category or categories the new"
	echo "    tool ($TOOL) belongs to: (Remember there are three categories:"
	echo "    Recon & Mapping, Discovery, and Exploitation; a tool can belong to"
	echo "    more than one category)."
	echo
	echo "    <Include>"
	echo "            <Filename>$TOOL.desktop</Filename>"
	echo "    </Include>"
	echo
	echo "*** Press any key once the previous procedure has been completed."
	read key
fi


# 7. Copy the tool gnome-terminal profile (if applies) to the profiles 
#    directory
#
# If the tool is a command-line based tool (CLI) it is mandatory to
# create a new gnome-terminal profile.

if [ ":CLI:" == ":$TYPE:" ]; then
	echo "Copying the tool gnome-terminal profile: $PROFILES_DIR/$LOCALPROFILE..."
	cp -prf $LOCALPROFILE $PROFILES_DIR
else
	echo "No tool gnome-terminal profile required ($TYPE)."
fi

#
# *** MANUAL STEP ***
#
# 8. Update the main list of profiles (.xml file)
if [ ":CLI:" == ":$TYPE:" ]; then
	echo
	echo "*** Edit the $PROFILES_LIST file and"
	echo "    add the following new entry at the end of the list, right above the"
	echo "    </entry> and </gconf> tags." 
	echo
	echo "    <li type="string">"
	echo "            <stringvalue>$TOOL</stringvalue>"
	echo "    </li>"
	echo
	echo "*** Press any key once the previous procedure has been completed."
	read key
fi


# 9. Add the new tool to the list of available tools (tools.txt)
#
# Append the data for the new tool to the file
echo "Adding the new tool ($TOOL) to the $TOOL_LIST file"

# Format:
# NAME                  VERSION         CATEGORY
# -----                 --------        --------------------------

echo -e "$TOOL\t\t\t$VERSION\t\t$TYPE\n" >> $TOOL_LIST




#  SVN MAIN
# ----------

# If the tool has an SVN/CVS update repository, add the SVN/CVS update capabilities

if [ ":no:" != ":$UPDATE:" ]; then

echo "Adding SVN/CVS update capabilities for $TOOL..."

# A. Copy the tool SVN script under /usr/bin/samurai_svn/scripts
echo "Copying the tool SVN/CVS update script to $SVN_DIR/scripts/"
cp -pf $LOCALSVNSCRIPT $SVN_DIR/scripts/

# B. Copy the tool SVN menu to the SVN menus directory
echo "Copying the tool SVN/CVS update menu entry to the main SVN menu..."
cp -pf $LOCALSVNMENU $MENU_APP

#
# *** MANUAL STEP ***
#
# X. Update the main SVN applications.menu file	

echo "*** Edit the $APPS_MENUS file and"
echo "    add the following new entry under the 'Samurai SVN' category or"
echo "    menu (almost at the end of the file), right above the <Layout>"
echo "    tag:"
echo
echo "    <Include>"
echo "            <Filename>$UPDATE_$TOOL.desktop</Filename>"
echo "    </Include>"
echo
echo "*** You also must include the following new entry under the Layout"
echo "    list, in the right order you want the new menu item to appear:"
echo
echo "    <Filename>$UPDATE_$TOOL.desktop</Filename>"
echo
echo "*** You need to log out from the current session for the"
echo "*** gnome-terminal profile to be populated."
echo
echo "*** Press any key once the previous procedure has been completed."
read key


# D. Add the tool icon for the menu entry to the icons directory



fi # SVN/CVS update capabilities


