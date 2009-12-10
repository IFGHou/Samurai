#!/bin/bash
#
# Script to set the Samurai version when updating from SVN and add the
# proper changelog entries and credits for thenew updates
#
# NOTE: Run this script with root privileges using "sudo"
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    December 2009
# Version: 0.1
#

# Local dir
LOCALDIR=samurai_version

# Samurai directory containing version details
VERSIONDIR=/home/samurai/Desktop

# README file
READMEFILE=README

# CHANGELOG file
CHANGELOGFILE=CHANGELOG


# Replace the current files (README and CHANGELOG) with the copy for the
# new SVN version that is being installed:

echo "Updating the $READMEFILE and $CHANGELOGFILE files on $VERSIONDIR..."

cp -f ./$LOCALDIR/$READMEFILE $VERSIONDIR/$READMEFILE
cp -f ./$LOCALDIR/$CHANGELOGFILE $VERSIONDIR/$CHANGELOGFILE

