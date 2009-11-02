#!/bin/bash
#
# Script to clean up Samurai v0.7 for the new samurai_svn infrastructure
#
# NOTE: Run this script with root privileges using "sudo"
#
# Author: Raul Siles (raul _AT_ raulsiles _DOT_ com)
# Date: October 2009
# Version: 0.1
#

# Local dir
LOCALDIR=cleanup_v0.7

# Clean up /usr/bin/samurai
./$LOCALDIR/cleanup_v0.7_usr_bin_samurai.sh

# Clean up /home/samurai/tools
./$LOCALDIR/cleanup_v0.7_home_samurai_tools.sh

# Clean up the Applications menus
./$LOCALDIR/cleanup_v0.7_Applications_menus.sh

