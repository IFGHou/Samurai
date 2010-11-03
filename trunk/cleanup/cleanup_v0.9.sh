#!/bin/bash
#
# Script to clean up varios "bugs" on Samurai v0.9 
#
# NOTE: Run this script with root privileges using "sudo"
#
# Author:  Raul Siles (raul _AT_ raulsiles _DOT_ com) - Taddong
# Date:    November 3, 2010
# Version: 0.1
#

echo
echo "Fixing 'Install' desktop icon..."

sudo chmod ugo+x ubiquity-gtkui.desktop

echo "Removing unnecessary files..."

sudo rm -f /var/www/index.html~

