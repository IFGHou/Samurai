#!/bin/bash
#
# Script to install the samurai_setup infrastructure
#
# NOTE: Run this script with root privileges using "sudo"
#
# Author: Raul Siles (raul _AT_ raulsiles _DOT_ com)
# Date: November 2009
# Version: 0.1
#

# Local dir
LOCALDIR=samurai_setup


# Removing applications and tools available by default on the OS distribution
#$PWD/$LOCALDIR/remove_default_tools.sh

# Adding new applications and tools from the official OS repositories
#$PWD/$LOCALDIR/install_repository_tools.sh

# Removing Firefox addons
#$PWD/$LOCALDIR/remove_firefox_addons.sh

# Adding Firefox addons from the Samurai Firefox addons Collection
#$PWD/$LOCALDIR/install_firefox_addons.sh

# Adding new applications and tools from their official webpage
$PWD/$LOCALDIR/install_samurai_tools.sh


