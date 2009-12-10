#!/bin/bash

# Template to add new update scripts from CVS for a specific tool
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    December 2009
# Version: 0.2
#
# Changelog:
# 0.2 - Added checks due to its EXPERIMENTAL state
#
# Usage:
# 0. Copy this template to /usr/bin/samurai_svn/scripts as cvs_TOOL-NAME.sh,
#    replacing TOOL-NAME by the name of the tool (eg. cvs_DirBuster.sh)
#    $ cp cvs_template ../scripts/cvs_DirBuster.sh
# 1. Change the permissions of the new script to 755:
#    $ chmod 755 /usr/bin/samurai_svn/scripts/cvs_DirBuster.sh
# 2. Edit the new script file...
# 3. Replace the TOOL variable below with the tool name
#    eg. TOOL=DirBuster
# 4. Replace the CVS variable below with the reference to the CVS repository,
#    that is, with the value for the cvs "-d" option
#    eg. CVS=pserver:anonymous@dirbuster.cvs.sourceforge.net:/cvsroot/dirbuster
# 5. Create a new CVS update menu pointing to this new CVS update script
# 6. Include any other commands specific for this tool under the "Additional 
#    instructions/actions" section (at the end), such as how to build or 
#    compile the tool from the CVS source code
#

# Tool name
TOOL=paros

# CVS repository
CVS=pserver:anonymous@paros.cvs.sourceforge.net:/cvsroot/paros

# Main dir
DIR=/usr/bin/samurai_svn

# CVS update script
CVS_UPDATE=$DIR/bin/cvs_update.sh

# EXPERIMENTAL
echo "*** The SVN/CVS update for $TOOL is EXPERIMENTAL! ***"
echo
echo "*** It is NOT recommended to update $TOOL from SVN/CVS"
echo -n "*** at this point. Do you want to continue (yes/no)? " 
read answer
echo

if [ ":yes:" == ":$answer:" ]; then

# Launch the update
$CVS_UPDATE $TOOL $CVS

# Additional instructions/actions
# ...

if [ $? = 0 ]; then
	echo
	echo "*** You now need to compile $TOOL... and generate paros.jar"
	echo "*** javac (JDK) required but not found on Samurai v0.7"
fi

else
	echo "*** No changes applied. Press any key to exit."
	read key
fi # EXPERIMENTAL
