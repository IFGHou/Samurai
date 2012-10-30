#!/bin/bash

FILES="./files"

cd $FILES

# Need this to create our nmap upgrade package
dpkg -i checkinstall_1.6.2-3ubuntu1_i386.deb > /dev/null 2>&1

tar jxf nmap-6.01.tar.bz2 
cd nmap-6.01/

./configure --prefix=/usr > /dev/null 2>&1
make > /dev/null 2>&1

# Create the nmap Debian package and install it.
checkinstall -Dy --install=no -replaces=nmap,zenmap --showinstall=no > /dev/null 2>&1
dpkg -i nmap_6.01-1_i386.deb > /dev/null 2>&1

cd ../
rm -rf nmap-6.01/
