#!/bin/bash

# Script to change the default Apache bindings: IP address(es) & port(s) in
# Samurai 0.9
#
# By default Apache listens on all interfaces, ports TCP/80 & TCP/443
# After applying this script it only listens in 127.0.0.1 & the given IP
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    November 3, 2010
# Version: 0.1
#
# Changelog: 
# 0.1 - First version
#
# Usage:
# This script expects no arguments: it will ask the user for the IP address.
#

echo "After running the script, you won't have access to the default"
echo "vulnerable websites available in Samurai +0.9 (127.42.84.x)..."
echo
echo "Enter the IP address where Apache will listen on:"
read IPADDR
echo

INFILE=ports.conf
OUTFILE=ports_$IPADDR.conf
DSTDIR=/etc/apache2

echo "Setting IP address ($IPADDR) on ports.conf for port TCP/80 & 443..."
sed "s/Listen 80/Listen 127.0.0.1:80\nListen $IPADDR:80/;s/Listen 443/Listen 127.0.0.1:443\n    Listen $IPADDR:443/" < $INFILE > $OUTFILE 

echo "Creating a backup copy of the config file in... (sudo)"
sudo cp -f $DSTDIR/ports.conf $DSTDIR/ports.conf.original

echo "Copying config files..."
sudo cp -f ports_$IPADDR.conf $DSTDIR/ports.conf

echo "Restarting Apache with the new config..."
sudo apache2ctl restart

echo
echo "You can restore the default configuration by running:"
echo "$ sudo cp $DSTDIR/ports.conf.original $DSTDIR/ports.conf"
echo
