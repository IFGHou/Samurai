#!/bin/bash
#
# Script to clean up /usr/bin/samurai on Samurai v0.7 for the new 
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

# File with the list of tools available on Samurai
TOOL_LIST=$SAMURAI_DIR/tools.txt


echo
echo "Creating new directories under $SAMURAI_DIR..."

mkdir $SAMURAI_DIR/fierce
mkdir $SAMURAI_DIR/gooscan.dir
mkdir $SAMURAI_DIR/gpscan
mkdir $SAMURAI_DIR/jbrofuzz
mkdir $SAMURAI_DIR/ratproxy.dir
mkdir $SAMURAI_DIR/sqlbrute
mkdir $SAMURAI_DIR/webscarab
mkdir $SAMURAI_DIR/webshag.dir


echo "Renaming directories under $SAMURAI_DIR..."

mv $SAMURAI_DIR/burpsuite_v1.2 $SAMURAI_DIR/burpsuite
mv $SAMURAI_DIR/DirBuster-0.10 $SAMURAI_DIR/DirBuster 
mv $SAMURAI_DIR/grendel-scan $SAMURAI_DIR/Grendel-Scan
mkdir -p $SAMURAI_DIR/reconnoiter
mv $SAMURAI_DIR/jwUserGen $SAMURAI_DIR/reconnoiter/usernameGen
mv $SAMURAI_DIR/nikto $SAMURAI_DIR/Nikto_2
mv $SAMURAI_DIR/ProxyStrike-2.2 $SAMURAI_DIR/proxystrike
mv $SAMURAI_DIR/sqlninja-0.2.3-r1 $SAMURAI_DIR/sqlninja
mv $SAMURAI_DIR/wapiti-1.1.6 $SAMURAI_DIR/wapiti


echo "Moving files to the new directories under $SAMURAI_DIR..."

# Individual Fierce files spread in the directory (move them):
mv $SAMURAI_DIR/fierce.pl $SAMURAI_DIR/fierce
mv $SAMURAI_DIR/hosts.txt $SAMURAI_DIR/fierce

# Individual gooscan files spread in the directory (move them):
mv $SAMURAI_DIR/gooscan $SAMURAI_DIR/gooscan.dir
mv $SAMURAI_DIR/data_files $SAMURAI_DIR/gooscan.dir
mv $SAMURAI_DIR/gooscan.dir $SAMURAI_DIR/gooscan

# Individual gpscan files spread in the directory (move them):
mv $SAMURAI_DIR/gpscan.rb $SAMURAI_DIR/gpscan

# Individual jbrofuzz files spread in the directory (move them):
mv $SAMURAI_DIR/examples $SAMURAI_DIR/jbrofuzz
mv $SAMURAI_DIR/jbrofuzz.bat $SAMURAI_DIR/jbrofuzz
mv $SAMURAI_DIR/JBroFuzz.jar $SAMURAI_DIR/jbrofuzz

# Individual ratproxy files spread in the directory (move them):
mv $SAMURAI_DIR/ratproxy $SAMURAI_DIR/ratproxy.dir
mv $SAMURAI_DIR/messages.list $SAMURAI_DIR/ratproxy.dir
mv $SAMURAI_DIR/ratproxy-back.png $SAMURAI_DIR/ratproxy.dir
mv $SAMURAI_DIR/ratproxy-report.sh $SAMURAI_DIR/ratproxy.dir
mv $SAMURAI_DIR/flare-dist $SAMURAI_DIR/ratproxy.dir
mv $SAMURAI_DIR/ratproxy.dir $SAMURAI_DIR/ratproxy

# Remove symbolic link to flare and create a new one under ./flare
rm -f $SAMURAI_DIR/flare
mkdir $SAMURAI_DIR/flare
ln -s $SAMURAI_DIR/ratproxy/flare-dist/flare $SAMURAI_DIR/flare 

# Individual sqlbrute files spread in the directory (move them):
mv $SAMURAI_DIR/sqlbrute.py $SAMURAI_DIR/sqlbrute

# Individual Webscarab files spread in the directory (move them):
mv $SAMURAI_DIR/webscarab-selfcontained-20070504-1631.jar $SAMURAI_DIR/webscarab

# Individual webshag files or dirs spread in the directory (move them):
mv $SAMURAI_DIR/webshag $SAMURAI_DIR/webshag.dir
mv $SAMURAI_DIR/webshag.py $SAMURAI_DIR/webshag.dir
mv $SAMURAI_DIR/config $SAMURAI_DIR/webshag.dir
mv $SAMURAI_DIR/config_linux.py $SAMURAI_DIR/webshag.dir
mv $SAMURAI_DIR/database $SAMURAI_DIR/webshag.dir
mv $SAMURAI_DIR/LICENSE.txt $SAMURAI_DIR/webshag.dir
mv $SAMURAI_DIR/DISCLAIMER.txt $SAMURAI_DIR/webshag.dir
mv $SAMURAI_DIR/images $SAMURAI_DIR/webshag.dir
mv $SAMURAI_DIR/webshag.dir $SAMURAI_DIR/webshag


echo "Fixing ownership and permissions in dirs/files under $SAMURAI_DIR..."

# For directories: (general set)
find $SAMURAI_DIR/* -type d -exec chmod 755 {} \;
find $SAMURAI_DIR/* -type d -exec chown samurai:samurai {} \;

# For files: (general set)
# find $SAMURAI_DIR/* -type f -exec chmod 750 {} \;
# find $SAMURAI_DIR/* -type f -exec chown samurai:samurai {} \;

# Individual fixes for files:

chown samurai:samurai $SAMURAI_DIR/webscarab/webscarab-selfcontained-20070504-1631.jar
chmod 644 $SAMURAI_DIR/burpsuite/*
find $SAMURAI_DIR/DirBuster -type f -exec chmod 644 {} \;
chown -R samurai:samurai $SAMURAI_DIR/Nikto_2
chmod 644 $SAMURAI_DIR/proxystrike/libcurl.so.4


echo "Copying the list of tools to $TOOL_LIST"

cp -pf $PWD/cleanup_v0.7/tools.txt $TOOL_LIST


