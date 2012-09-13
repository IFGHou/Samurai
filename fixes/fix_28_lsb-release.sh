#!/bin/bash

FILES="./files"
DATE=$(date +%F_%R:%S | sed 's/://g')

cp /etc/lsb-release /etc/lsb-release.backup.$DATE
cp $FILES/lsb-release /etc/lsb-release
