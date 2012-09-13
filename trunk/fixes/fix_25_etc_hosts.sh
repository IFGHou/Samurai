#!/bin/bash

DATE=$(date +%F_%R:%S | sed 's/://g')

cp /etc/hosts /etc/hosts.backup.$DATE
cp /etc/hosts.samurai /etc/hosts

HOSTNAME=$(hostname)
sed -i '/^127\.0\.1\.1/s|$| '$HOSTNAME'|' /etc/hosts
