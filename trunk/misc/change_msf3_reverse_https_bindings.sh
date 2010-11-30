#!/bin/bash

# Script to change the default msf3 bindings for the reverse_https handler: 
# IP address(es) 
#
# By default the msf3 reverse_https handler listens on all interfaces:
# 0.0.0.0
# After applying this script it only listens in the given IP address
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

echo "Enter the IP address where the msf3 reverse_https handler will listen on:"
read IPADDR
echo

DIR=/usr/bin/samurai/msf3/lib/msf/core/handler
INFILE=reverse_https.rb
OUTFILE=reverse_https_$IPADDR.rb

echo "Setting IP address ($IPADDR) on $INFILE..."
sed "s/0.0.0.0/$IPADDR/" < $DIR/$INFILE > $DIR/$OUTFILE 

echo "Creating a backup copy of the oiriginal config file... (sudo)"
sudo cp -f $DIR/$INFILE $DIR/$INFILE.original

echo "Copying modified config files..."
sudo cp -f $DIR/$OUTFILE $DIR/$INFILE

echo
echo "You can restore the default configuration by running:"
echo "$ sudo cp $DIR/$INFILE.original $DIR/$INFILE"
echo
