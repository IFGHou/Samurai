#!/bin/bash
#
# Script to clean up /home/samurai/tools on Samurai v0.7 for the new 
# samurai_svn infrastructure
#
# NOTE: Run this script with root privileges using "sudo"
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    October 2009
# Version: 0.1
#

# Samurai dir
SAMURAI_DIR=/usr/bin/samurai

# Samurai tools home
SAMURAI_TOOLS=/home/samurai/tools

# Samurai tools home
LOCAL_TOOLS=$PWD/cleanup_v0.7/tools

echo
echo "Copying the new launch scripts to $SAMURAI_TOOLS..."

cp -pf $LOCAL_TOOLS/* $SAMURAI_TOOLS
rm -f $SAMURAI_TOOLS/grendel-scan.sh
rm -f $SAMURAI_TOOLS/nikto.sh

