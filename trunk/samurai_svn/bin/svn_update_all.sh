#!/bin/bash

# Script to update ALL Samurai tools from their SVN (or CVS) repositories.
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    October 2009
# Version: 0.1
#

# Main dir
DIR=/usr/bin/samurai_svn

# Samurai dir
SAMURAI_DIR=/usr/bin/samurai

# Logging directory
LOGDIR=$DIR/log

# Directory to save a backup of the current version of the tool
BACKUP_DIR=$DIR/svn_backup

# Log file
LOGFILE=$LOGDIR/svn_update_all.log

# Scripts directory
SCRIPTS_DIR=$DIR/scripts


echo -n "This script will update ** ALL Samurai tools ** to the latest version from their official SVN (or CVS) repositories. What do you want to do ("
echo -n "Update from SVN/CVS [U], Update from SVN/CVS & Backup the current versions [B], or Cancel [C])? "
read answer
echo

case $answer in
U|B)
	echo >> $LOGFILE
	echo "------------------------------------------------" >> $LOGFILE
	echo `date` >> $LOGFILE
	echo "*** Executing svn_update_all.sh" >> $LOGFILE
	echo "------------------------------------------------" >> $LOGFILE
	echo >> $LOGFILE

	echo "-------------- STARTING SVN/CVS UPDATE -----------" >> $LOGFILE

	# Loop through all the SVN/CVS scripts to update (& backup) each tool
	for i in $(ls $SCRIPTS_DIR)
	do
		# Extract the tool name from its SVN/CVS update script
		# by removing "svn_" or "cvs_" at the begining and ".sh" at the end
		TOOL=${i#svn_}
		TOOL=${TOOL#cvs_}
		TOOL=${TOOL%.sh}
	
		if [ ":U:" == ":$answer:" ]; then
			echo -n `date` >> $LOGFILE
			echo " - Updating your current $TOOL installation..." >> $LOGFILE
			echo $answer | $SCRIPTS_DIR/$i
		elif [ ":B:" == ":$answer:" ]; then
			echo -n `date` >> $LOGFILE
			echo " - Updating (& creating a backup of) your current $TOOL installation..." >> $LOGFILE
			echo $answer | $SCRIPTS_DIR/$i
		else
			echo "*** Why on earth are we here ;)!"
			exit 1
		fi 
		echo -e "\n-----------------\n"
	done
	echo "-------------- END OF THE SVN/CVS UPDATE -----------" >> $LOGFILE
;;
* )
        echo "*** No changes applied."
        exit -1
;;
esac

# Check SVN server certificate errors
echo
echo "*** Check the following SVN server certificate errors (if any):"
grep "server certificate" $LOGDIR/*

echo
echo "*** Run updates for each of these tools individually and accept"
echo "    the server certificate manually after verifying its validity."
echo
echo "Hit enter to exit."
read answer

exit 0

