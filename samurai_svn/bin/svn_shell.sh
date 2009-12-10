#!/bin/bash

# Script to set the PATH variable to the backup directory of the specific tool
# received as the first argument or to all tools available in the backup directory
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    October 2009
# Version: 0.1
#

# Main dir
DIR=/usr/bin/samurai_svn

# Directory to save a backup of the current version of the tool
BACKUP_DIR=$DIR/svn_backup

# Tool name
TOOL=$1


if [ "::" == ":$TOOL:" ]; then
	echo "*** Adding $BACKUP_DIR/* to the PATH to be able to use"
	echo "    the backup copies of all the available tools..."
	echo
	echo "(You can change the PATH to just a single tool by providing the tool name"
	echo " to the svn_shell.sh script)"
	echo
	for i in $(ls $BACKUP_DIR) 
	do
		MYPATH=$BACKUP_DIR/$i
		PATH=$MYPATH:$PATH
	done
else
	echo "*** Adding $BACKUP_DIR/$TOOL to the PATH to be able"
	echo "    to use the backup copy of $TOOL."
	echo
	MYPATH=$BACKUP_DIR/$TOOL
	PATH=$MYPATH:$PATH
fi

export PATH
echo $PATH

