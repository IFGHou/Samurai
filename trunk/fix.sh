#!/bin/bash
#
# Script to apply multiple actions from .sh files in order to 
# remove and fix various bugs on the current SamuraiWTF version,
# until the next version is released. 
#
# NOTE: Run this script with root privileges using "sudo".
#
# Author:  Raul Siles (raul _AT_ taddong _DOT_ com) - Taddong
# Date:    September 11, 2012
# Version: 0.1
#

VERSION="0.1"
FIXES_ALREADY_APPLIED_LOG=".fixes_already_applied.log"
DIR="./fixes"
PREFIX="fix_"

echo
echo "This script fixes multiple bugs in the current SamuraiWTF 2.0 version." 
echo
echo "Remember to run this script using sudo!"
echo "Press any key to continue..."
read KEY

# Go through the DIR directory and apply all fixes that have not
# been applied yet in previous executions of this same script.

cd $DIR

for i in $(ls $PREFIX*)
do
    # Check if the fix has been previously applied. 
    # If so, do not apply it again.
    echo -n $i

    # Check if log file already exists, and create it if does not
    if [ ! -f $FIXES_ALREADY_APPLIED_LOG ]; then
	touch $FIXES_ALREADY_APPLIED_LOG
    fi

    # If 0 fix has been applied before
    # If 1 fix has not been applied before (fix string not found)
    grep -q $i $FIXES_ALREADY_APPLIED_LOG >/dev/null 2>&1
    CHECK=$(echo $?)

    if [ $CHECK -eq 1 ]; then
	# Record the fix name in the already applied fixes log file
	echo $i >> $FIXES_ALREADY_APPLIED_LOG

	# Status
	echo " (applying fix...)"

	# Executing fix file
	sudo ./$i

    elif [ $CHECK -eq 0 ]; then
	#Status
	echo " (fix already applied)"
    else
	# Error - Eg. CHECK == 2
	echo " ()"
	echo "*** Unexpected error ($CHECK)"
    fi
done

