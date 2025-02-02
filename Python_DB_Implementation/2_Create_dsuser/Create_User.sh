#!/bin/bash

USER="dsuser"
PASSWORD="userCreateSQL"


mysql -u"root" -p <<EOF



CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
