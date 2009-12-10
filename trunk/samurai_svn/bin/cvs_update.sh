#!/bin/bash 

# Script to update a tool from its CVS repository.
# (It is similar to the SVN update script but uses CVS commands instead)
#
# The script updates the tool from CVS and saves a backup copy of the
# previous version (in case the CVS version is not stable enough and
# you want to restore to the previous stable version).
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    October 2009
# Version: 0.1
#
# Usage:
# This script expects two arguments:
# $1 = Tool name
# $2 = CVS repository for the tool
#

# Main dir
# (Yeah!, the directory is the same for SVN and CVS and it's still called SVN)
DIR=/usr/bin/samurai_svn

# Samurai dir
SAMURAI_DIR=/usr/bin/samurai

# Logging directory
LOGDIR=$DIR/log

# Directory to save a backup of the current version of the tool
BACKUP_DIR=$DIR/svn_backup

# Tool name
TOOL=$1

# CVS repository for the tool 
CVS=$2

# Log file
LOGFILE=$LOGDIR/$TOOL.log

function cvs_update {

	# We should be in the tool directory: (double check)
	cd $SAMURAI_DIR/$TOOL
	
	# Check if the current version of the tool was obtained through CVS
	cvs status > /dev/null 2>&1
	
	if [ $? = 0 ]; then
		# The tool was already installed from CVS

		# Eg.- cvs up
		cvs up 2>&1 | tee $LOGFILE
	else
		# There is no CVS information for the tool (first time CVS is used)

		# Make a copy of the tool to $TOOL.original in the backup directory
		rm -rf $BACKUP_DIR/$TOOL.original
		mv -f $SAMURAI_DIR/$TOOL $BACKUP_DIR/$TOOL.original

		# Eg.- cvs -z3 -d:pserver:anonymous@dirbuster.cvs.sourceforge.net:/cvsroot/dirbuster co -P DirBuster
		cd $SAMURAI_DIR
		cvs -z3 -d:$CVS co -P $TOOL 2>&1 | tee $LOGFILE
	fi
}

echo -n "This script will update $TOOL to the latest version from the official CVS repository. What do you want to do ("
echo -n "Update from SVN [U], Update from SVN & Backup the current version [B], or Cancel [C])? "
read answer
echo

# Check if the directory for the tool exists
if [ ! -d $SAMURAI_DIR/$TOOL ]; then
	echo "*** The directory tool name ($SAMURAI_DIR/$TOOL) does not exist. Aborting!"
	exit 1
fi

if [ ":U:" == ":$answer:" ]; then
	# Update the tool from CVS
	echo "*** Updating your current $TOOL installation..."
	cd $SAMURAI_DIR/$TOOL
	cvs_update

	echo
	echo "Hit enter to exit."
	read answer
elif [ ":B:" == ":$answer:" ]; then 
	# Create a backup of the current version AND...
	# Update the tool from CVS
        echo "*** Creating a backup copy of $TOOL under $BACKUP_DIR/$TOOL..."
        if [ -d $SAMURAI_DIR/$TOOL ]; then
		if [ -d $BACKUP_DIR/$TOOL ]; then
                	# echo "--- Deleting the previous $TOOL backup..."
                	rm -rf $BACKUP_DIR/$TOOL 
        	fi
		cp -prf $SAMURAI_DIR/$TOOL/ $BACKUP_DIR/$TOOL
	else
		echo "*** The directory tool name ($SAMURAI_DIR/$TOOL) does not exist. Aborting!"
		exit 1
	fi

	echo
	echo "*** Updating your current $TOOL installation..."
	cd $SAMURAI_DIR/$TOOL
        cvs_update

	echo
	echo "--- If the new $TOOL version from CVS is not stable enough,"
	echo "--- you can restore the previous version. Run this command:"
	echo "--- svn_restore.sh $TOOL"
	echo "--- ( Available at: $DIR/bin/ or PATH )"
	echo "--- ( The svn_restore.sh tool can be used to restore both SVN or CVS updates )"
	echo
	echo "Hit enter to exit."
        read answer
else
	echo "*** No changes applied."
	exit -1
fi

exit 0
