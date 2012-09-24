#!/bin/bash

FILES="./files"
DATE=$(date +%F_%R:%S | sed 's/://g')

cp /usr/share/samurai-dojo/basic/header.php /usr/share/samurai-dojo/basic/header.php.$DATE
cp $FILES/header_ua.php /usr/share/samurai-dojo/basic/header.php
