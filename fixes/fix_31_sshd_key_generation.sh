#!/bin/bash

FILES="./files"
DATE=$(date +%F_%R:%S | sed 's/://g')

# copies the sshd-generate
cp $FILES/sshd-generate /usr/bin/sshd-generate

# copies modified samurai that creates new SSH keys
# during boot time for Live Environments
cp $FILES/samurai_ssh-live /etc/init.d/samurai

# copies modified remastersys-firstboot that creates
# new SSH keys during first boot of HD installs
cp $FILES/remastersys-firstboot_ssh /etc/init.d/remastersys-firstboot

# Ask the user if he/she wants to apply these ssh changes now
read -p "+++ Do you want to disable SSH at boot time now (y/n)? "
if [[ $REPLY =~ ^[Yy]$ ]]
then
	update-rc.d -f ssh remove
fi

read -p "+++ Do you want to regenerate the SSH keys now (y/n)? "
if [[ $REPLY =~ ^[Yy]$ ]]
then
	/usr/bin/sshd-generate > /dev/null 2>&1
fi
