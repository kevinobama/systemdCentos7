FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# normal updates
RUN yum -y update

# php && httpd
RUN yum -y install php70w php70w-fpm php70w-opcache php70w-cli php70w-common php70w-gd php70w-intl php70w-mbstring php70w-mcrypt php70w-mysql php70w-mssql php70w-pdo php70w-pear php70w-soap php70w-xml php70w-xmlrpc


RUN yum -y install nginx; yum clean all
RUN yum -y install curl; yum clean all
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN echo "nginx on CentOS 7 inside Docker" > /usr/share/nginx/html/index.html

# Adding the configuration file of the nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf

# Adding the default file
ADD index.php /var/www/index.php

EXPOSE 80

RUN systemctl enable nginx \
 && systemctl enable php-fpm

# CMD [ "/usr/sbin/nginx" ]
CMD ["/usr/sbin/init"]
