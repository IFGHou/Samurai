#!/bin/bash

# Script to restore the previous version of a tool after updating it
# from its SVN (or CVS) repository (only works if you selected the option to
# create a backup copy).
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    December 2009
# Version: 0.3
#
# Changelog:
# 0.3 - Fixed checking of previous backup directory (SVN or original, not
#       from SVN) - Thanks to Michael McLaurin
# 0.2 - Added new check for the existence of the backup directory
#
# Usage:
# This script expects one argument:
# $1 = Tool name

# Main dir
DIR=/usr/bin/samurai_svn

# Samurai dir
SAMURAI_DIR=/usr/bin/samurai

# Logging directory
LOGDIR=$DIR/log

# Directory where the backup of the previous version of the tool was saved
BACKUP_DIR=$DIR/svn_backup

# Tool name
TOOL=$1

# Usage
if [ "::" == ":$TOOL:" ]; then
	echo "*** Warning: You need to specify the tool name as an argument"
	echo "    Usage:"
	echo "    ./svn_restore.sh <tool-name>"
	exit 1
fi

echo -n "This script will restore $TOOL to the previous version available before updating from the official SVN (or CVS) repository. What do you want to do ("
echo -n "Restore the previous version from backup [R], or Cancel [C])? "
read answer
echo

# Check if the directory for the tool exists
if [ ! -d $SAMURAI_DIR/$TOOL ]; then
        echo "*** The directory tool name ($SAMURAI_DIR/$TOOL) does not exist. Aborting!"
        exit 1
fi

# Check if the backup directory for the tool exists
if [ ! -d $BACKUP_DIR/$TOOL ]; then
    if [ ! -d $BACKUP_DIR/$TOOL.original ]; then
        echo "*** The backup directory tool name ($BACKUP_DIR/$TOOL) does not exist. It seems a backup was not made previously. Nothing to restore. Aborting!"
        exit 1
    fi
fi

if [ ":R:" == ":$answer:" ]; then
	# Restore the tool from the backup copy

	# Check if the backup is available before deleting the current copy
	if [ -d $BACKUP_DIR/$TOOL ]; then
		# echo "--- Deleting the current $TOOL installation..."
		echo "*** Restoring the previous $TOOL installation from a SVN backup..."
		rm -rf $SAMURAI_DIR/$TOOL 
		cp -prf $BACKUP_DIR/$TOOL/ $SAMURAI_DIR/$TOOL 
	elif [ -d $BACKUP_DIR/$TOOL.original ]; then
                # echo "--- Deleting the current $TOOL installation..."
		echo "*** Restoring the previous $TOOL installation from the original (non-SVN) backup..."
                rm -rf $SAMURAI_DIR/$TOOL
                cp -prf $BACKUP_DIR/$TOOL.original/ $SAMURAI_DIR/$TOOL
	fi

	# This script does not remove the backup copy

	echo	
        echo "Hit enter to exit."
        read answer
else
	echo "*** No changes applied."
fi

