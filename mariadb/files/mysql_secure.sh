#!/bin/sh

newpass=$1

mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('$newpass') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

touch /etc/ansible_mariadb_secured