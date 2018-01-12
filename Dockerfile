FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

ENV container docker

RUN yum -y install epel-release; yum clean all
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
 && rpm -Uvh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

# normal updates
RUN yum -y update

# php 
RUN yum -y install nginx curl mysql-server php70w php70w-fpm php70w-opcache php70w-cli php70w-common php70w-gd php70w-intl php70w-mbstring php70w-mcrypt php70w-mysql php70w-mssql php70w-pdo php70w-pear php70w-soap php70w-xml php70w-xmlrpc

# Adding the configuration file of the nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf

# ADD phpMyAdmin  /var/www/phpMyAdmin/
ADD index.php  /var/www/index.php
ADD adminer.php /var/www/adminer.php

EXPOSE 80

# RUN systemctl enable php-fpm \
# systemctl enable nginx 
#  && systemctl enable mysqld  
# RUN systemctl enable nginx 
# RUN /usr/sbin/nginx
# RUN /usr/sbin/php-fpm

# RUN mysql_secure_installation
# RUN su mysql -c /usr/bin/mysqld_safe &
# RUN mysqladmin -u root password '654321'
#  RUN su mysql -c /usr/bin/mysqld_safe &
# RUN /usr/bin/mysqladmin -u root password '654321'
# CMD [ "/usr/sbin/nginx",'/usr/sbin/php-fpm']:
# RUN php /var/www/yyoRawFish/artisan serve 
# CMD ["/usr/sbin/init"]
#  CMD php /var/www/yyoRawFish/artisan --host=0.0.0.0 --port=80

# CMD ["/usr/sbin/nginx"]
RUN cd /var/www/
WORKDIR /var/www/
# CMD php -S 0.0.0.0:80
# COPY start.sh /var/www/start.sh
# CMD /var/www/start.sh
COPY start.sh /start.sh
# CMD [ "/start.sh" ]
# CMD ["/usr/sbin/nginx"]
# RUN /bin/bash -c "/usr/bin/mysqld_safe --skip-grant-tables &"

CMD ["/start.sh"]
