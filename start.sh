#!/bin/bash
/usr/sbin/init

#systemctl start php-fpm
#systemctl start mysqld


# cd /var/www

# /usr/sbin/php-fpm
# /usr/sbin/nginx
# mysqld_safe &

# php -S 0.0.0.0:80  this is working

# exec /usr/sbin/nginx -D FOREGROUND
# exec mysqld_safe
#  systemctl start nginx

echo "starting the service"


php-fpm && nginx && mysqld_safe  
# && /usr/bin/mysqld_safe --skip-grant-tables &

# sleep 3s
# exec /usr/bin/mysqld_safe --skip-grant-tables &


# mysqld_safe --skip-grant-tables &

if [ ! -f /var/lib/mysql/ibdata1 ]; then
    mysql_install_db
fi

mysqld_safe --skip-grant-tables &

echo "ended the service"

