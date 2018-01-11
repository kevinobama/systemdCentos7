FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
 && rpm -Uvh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

# normal updates
RUN yum -y update

# php && httpd
RUN yum -y install nginx curl mysql-server php70w php70w-fpm php70w-opcache php70w-cli php70w-common php70w-gd php70w-intl php70w-mbstring php70w-mcrypt php70w-mysql php70w-mssql php70w-pdo php70w-pear php70w-soap php70w-xml php70w-xmlrpc


# Adding the configuration file of the nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf

# Adding the default file
# ADD phpMyAdmin  /var/www/phpMyAdmin/
ADD yyoRawFish  /var/www/yyoRawFish/

EXPOSE 80

RUN systemctl enable php-fpm \
 && systemctl enable mysqld  


# RUN mysql_secure_installation
# RUN su mysql -c /usr/bin/mysqld_safe &
# RUN mysqladmin -u root password '654321'
# RUN su mysql -c /usr/bin/mysqld_safe &
# RUN /usr/bin/mysqladmin -u root password '654321'

# RUN php /var/www/yyoRawFish/artisan serve 

CMD ["/usr/sbin/init"]
#  CMD php /var/www/yyoRawFish/artisan --host=0.0.0.0 --port=80
