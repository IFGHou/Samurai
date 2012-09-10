#!/bin/bash

cp /etc/hosts /etc/hosts.backup
cp /etc/hosts.samurai /etc/hosts

HOSTNAME=$(hostname)
sed -i '/^127\.0\.1\.1/s|$| '$HOSTNAME'|' /etc/hosts
