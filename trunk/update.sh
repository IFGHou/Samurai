#!/bin/bash
#
# Script to apply multiple actions from .sh files in order to 
# update features and tools on the current SamuraiWTF version,
# until the next version is released. 
#
# NOTE: Run this script with root privileges using "sudo".
#
# Author:  Raul Siles (raul _AT_ taddong _DOT_ com) - Taddong
# Date:    October 29, 2012
# Version: 0.1
#

VERSION="0.1"
UPDATES_ALREADY_APPLIED_LOG=".updates_already_applied.log"
DIR="./updates"
PREFIX="update_"

echo
echo "This script updates multiple tools in the current SamuraiWTF 2.0 version." 
echo
echo "Remember to run this script using sudo!"
echo "Press any key to continue..."
read KEY

# Go through the DIR directory and apply all updates that have not
# been applied yet in previous executions of this same script.

cd $DIR

for i in $(ls $PREFIX*)
do
    # Check if the update has been previously applied. 
    # If so, do not apply it again.

    # Check if log file already exists, and create it if does not
    if [ ! -f $UPDATES_ALREADY_APPLIED_LOG ]; then
	touch $UPDATES_ALREADY_APPLIED_LOG
    fi

    # If 0 update has been applied before
    # If 1 update has not been applied before (update string not found)
    grep -q $i $UPDATES_ALREADY_APPLIED_LOG >/dev/null 2>&1
    CHECK=$(echo $?)

    if [ $CHECK -eq 1 ]; then
	# Ask the user if he/she wants to apply this update:
	read -p "+++ Do you want to apply this update: $i (y/n)? "
	if [[ $REPLY =~ ^[Yy]$ ]]
	then

	    # Record the update name in the already applied updates log file
	    echo $i >> $UPDATES_ALREADY_APPLIED_LOG

	    # Status
	    echo "$i (applying update...)"

	    # Executing update file
	    sudo ./$i
	fi

    elif [ $CHECK -eq 0 ]; then
	#Status
	echo "$i (update already applied)"
    else
	# Error - Eg. CHECK == 2
	echo " ()"
	echo "*** Unexpected error ($CHECK)"
    fi
done

