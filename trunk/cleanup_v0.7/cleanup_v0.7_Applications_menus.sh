#!/bin/bash
#
# Script to clean up the Applications menus on Samurai v0.7 for the new 
# samurai_svn infrastructure
#
# NOTE: Run this script with root privileges using "sudo"
#
# Author: Raul Siles (raul _AT_ raulsiles _DOT_ com)
# Date: October 2009
# Version: 0.1
#

# Samurai dir
SAMURAI_DIR=/usr/bin/samurai

# Samurai tools home
LOCALMENUS=$PWD/cleanup_v0.7/menus

# Samurai gnome-terminal profiles
LOCALPROFILES=$PWD/cleanup_v0.7/profiles
LOCALPROFILESLIST=$PWD/cleanup_v0.7/profiles_list.xml

# Directories for menus: directories and applications
MENU_DIR=/home/samurai/.local/share/desktop-directories/
MENU_APP=/home/samurai/.local/share/applications/

# Directories for gnome-terminal profiles
PROFILES_DIR=/home/samurai/.gconf/apps/gnome-terminal/profiles
PROFILES_LIST=/home/samurai/.gconf/apps/gnome-terminal/global/%gconf.xml

# "Applications" menu
APPS_MENUS=/home/samurai/.config/menus/applications.menu


echo
echo "Rebuilding the directory menus..."
rm $MENU_DIR/*
cp -prf $LOCALMENUS/desktop-directories/* $MENU_DIR


echo "Rebuilding the individual applications menus..."
rm $MENU_APP/*
cp -prf $LOCALMENUS/applications/* $MENU_APP


echo "Rebuilding the main Applications menus..."
cp $APPS_MENUS $APPS_MENUS.backup
cp -pf $LOCALMENUS/applications.menu.samurai $APPS_MENUS


echo "Rebuilding the gnome-terminal profiles..."
rm -rf $PROFILES_DIR/*
cp -prf $LOCALPROFILES/* $PROFILES_DIR
cp -pf $LOCALPROFILESLIST $PROFILES_LIST

echo
echo "*** You need to log out for the gnome-terminal profiles to be populated ***"

