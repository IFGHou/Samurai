#!/bin/bash

cat > /etc/init.d/metasploit-postgresql <<EOL
#!/bin/sh
exec /usr/share/metasploit/ctlscript.sh "\$@" postgresql
EOL

chmod 755 /etc/init.d/metasploit-postgresql 

update-rc.d metasploit-postgresql defaults > /dev/null 2>&1

/etc/init.d/metasploit-postgresql restart > /dev/null 2>&1
