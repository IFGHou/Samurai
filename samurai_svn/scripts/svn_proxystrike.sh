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
TOOL=proxystrike

# SVN repository
SVN=http://proxystrike.googlecode.com/svn/trunk/

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

f [ $? = 0 ]; then
        echo
        echo "*** You now need to compile $TOOL..."
	echo "*** On *nix systems, need pycurl,pyopenssl,pyqt4,pyopenssl..."
fi

else
	echo "*** No changes applied. Press any key to exit."
	read key
fi # EXPERIMENTAL

