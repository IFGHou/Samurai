#!/bin/bash

# Template to add new update scripts from SVN for a specific tool
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    December 2009
# Version: 0.2
#
# Changelog:
# 0.2 - Added checks due to its EXPERIMENTAL state
#
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
TOOL=Grendel-Scan

# SVN repository
SVN=http://svn2.assembla.com/svn/grendel/Grendel-Scan

# Main dir
DIR=/usr/bin/samurai_svn

# SVN update script
SVN_UPDATE=$DIR/bin/svn_update.sh

# EXPERIMENTAL
echo "*** The SVN/CVS update for $TOOL is EXPERIMENTAL! ***"
echo
echo "*** It is NOT recommended to update $TOOL from SVN/CVS"
echo -n "*** at this point. Do you want to continue (yes/no)? " 
read answer
echo

if [ ":yes:" == ":$answer:" ]; then

# Launch the update
$SVN_UPDATE $TOOL $SVN

# Additional instructions/actions
# ...

if [ $? = 0 ]; then
	echo
	echo "*** $TOOL needs to be compiled..."
	echo "*** The following tools are required but not found on Samurai v0.7:"
	echo "    Eclipse & Sun Java JDK & Eclipse subversive"
	echo 
	echo "    You can install them using the following command & URL: "
	echo "    $ sudo apt-get install sun-java6-jdk eclipse"
	echo "    http://www.eclipse.org/subversive/"
	echo
	echo "    Thanks to Eric Duprey (Grendel-Scan) for the guidance."
	echo
	echo "*** WARNING: This will require +400MB of disk space"
	echo "    Before adding these tools, check you really need the SVN revision"
	echo
	echo "Press any key to continue."
	read key

# 2 upgraded, 63 newly installed, 0 to remove and 95 not upgraded.
# Need to get 236MB of archives.
# After this operation, 407MB of additional disk space will be used.

# Plus Eclipse subversive...

fi

else
	echo "*** No changes applied. Press any key to exit."
	read key
fi # EXPERIMENTAL

