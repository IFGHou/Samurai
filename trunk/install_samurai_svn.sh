#!/bin/bash
#
# Script to install the samurai_svn infrastructure
#
# NOTE: Run this script with root privileges using "sudo"
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    December 2009
# Version: 0.2
#
# Changelog:
# 0.2 - Restore ownershipt to samurai:samurai for the applications.menu file
#       and the backup file
#

# Main dir
DIR=/usr/bin/samurai_svn

# Local dir
LOCALDIR=samurai_svn

# Samurai tools home
LOCALMENUS=./$LOCALDIR/menus

echo
echo "Creating directories: $DIR..."

mkdir $DIR
chmod 755 $DIR
chown samurai:root $DIR

mkdir $DIR/bin
mkdir $DIR/log
mkdir $DIR/scripts
mkdir $DIR/svn_backup
mkdir $DIR/templates

chmod -R 755 $DIR/*
chown -R samurai:samurai $DIR/*


echo "Copying files to $DIR..."

cp -prf $LOCALDIR/bin/* $DIR/bin/
cp -prf $LOCALDIR/scripts/* $DIR/scripts/
cp -prf $LOCALDIR/templates/* $DIR/templates/
cp -pf $LOCALDIR/VERSION $DIR/VERSION


echo "Creating Samurai SVN menus under Applications..."

# Directories for menus: directories and applications
MENU_DIR=/home/samurai/.local/share/desktop-directories/
MENU_APP=/home/samurai/.local/share/applications/

cp -prf $LOCALMENUS/*.directory $MENU_DIR
cp -prf $LOCALMENUS/*.desktop $MENU_APP

# Modify the "Applications" menu
CURRENT_MENU=/home/samurai/.config/menus/applications.menu
TEMP_MENU=/tmp/applications.menu.temp

# Get the current "Applications" menu except the closing line (last line)
# and append the new Samurai SVN menu
head -n -1 $CURRENT_MENU > $TEMP_MENU
cat $LOCALMENUS/applications.menu.samurai_svn >> $TEMP_MENU

cp -pf $CURRENT_MENU $CURRENT_MENU.backup_svn
mv $TEMP_MENU $CURRENT_MENU

# Restore ownership for applications.menu and the backup file
chown samurai:samurai $CURRENT_MENU*

echo "Adding $DIR/bin to the samurai PATH variable..."
BASHRC=/home/samurai/.bashrc
echo -e "\n\n# Added by samurai_svn\n" >> $BASHRC
echo "PATH=$PATH:$DIR/bin" >> $BASHRC
echo "export PATH" >> $BASHRC

