#!/bin/bash

FILES="./files"
DATE=$(date +%F_%R:%S | sed 's/://g')

cp /usr/share/samurai-dojo/scavenger/index.php /usr/share/samurai-dojo/scavenger/index.php.$DATE
cp $FILES/index_brucon2012.php /usr/share/samurai-dojo/scavenger/index.php

cp /usr/share/samurai-dojo/scavenger/contactus.php /usr/share/samurai-dojo/scavenger/contactus.php.$DATE
cp $FILES/contactus_brucon2012.php /usr/share/samurai-dojo/scavenger/contactus.php

ln -s contactus.php /usr/share/samurai-dojo/scavenger/contactus

cp /usr/share/samurai-dojo/scavenger/partners.php /usr/share/samurai-dojo/scavenger/partners.php.$DATE
cp $FILES/partners_brucon2012.php /usr/share/samurai-dojo/scavenger/partners.php

