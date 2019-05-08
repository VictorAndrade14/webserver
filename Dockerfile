FROM centos:7
MAINTAINER serverti <atendimento@serverti.com.br>
ENV container docker

RUN yum update -y  && \
        yum install -y yum-utils epel-* &&\
	yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm &&\
	yum-config-manager --enable remi-php73 &&\
    yum update -y 

RUN yum install -y httpd-tools.x86_64 mod_ssl.x86_64 &&\
    yum install -y php php-common php-mcrypt php-cli php-curl &&\
    yum install -y php-pecl-zip php-bcmath &&\
    yum install -y php-json php-geos.x86_64 php-interbase.x86_64 &&\
    yum install -y php-mbstring.x86_64 php-mysqlnd.x86_64 php-pdo.x86_64 php-pdo-*  &&\
    yum install -y php-soap.x86_64  php-gd php-xml.x86_64 php-gmp.x86_64  &&\
    yum clean all


RUN yum install -y wget git gcc-c++ make
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash
RUN yum install -y nodejs && curl -o- -L https://yarnpkg.com/install.sh | bash
RUN yum clean all


COPY start.sh /start.sh
RUN chmod 755 /start.sh

RUN chown -R apache:apache /var/www/ && chmod -R 770 /var/www/
RUN mkdir -p /usr/share/httpd/.composer/
RUN chown -R apache:apache /usr/share/httpd/.composer/

WORKDIR /var/www/html/

CMD /start.sh

##resolver o .htaccess 
