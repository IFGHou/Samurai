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
TOOL=wapiti

# SVN repository
SVN=https://wapiti.svn.sourceforge.net/svnroot/wapiti/trunk

# Main dir
DIR=/usr/bin/samurai_svn

# SVN update script
SVN_UPDATE=$DIR/bin/svn_update.sh

# Launch the update
$SVN_UPDATE $TOOL $SVN

# Additional instructions/actions
# ...


