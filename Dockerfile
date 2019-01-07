FROM ubuntu:bionic

# install and configure php
RUN apt-get update && \
	apt-get install -y \
	php \
	php-bz2 \
	php-cgi \
	php-cli \
	php-common \
	php-curl \
	php-dev \
	php-fpm \
	php-gd \
	php-gmp \
	php-imap \
	php-json \
	php-mcrypt \
	php-mysql \
	php-odbc \
	php-opcache \
	php-phpdbg \
	php-xmlrpc \
	php-imagick \
	php-zip \
	php-soap \
	php-mbstring \
	php-xsl \
	apache2 \
	libapache2-mod-php \
	git \
	composer \
	curl \
	sudo
	
# install composer extension to allow faster composer install
RUN composer global require hirak/prestissimo

# install and configure db
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections

RUN apt-get update && \
	apt-get -y install mysql-server-5.7 && \
	mkdir -p /var/lib/mysql && \
	mkdir -p /var/run/mysqld && \
	mkdir -p /var/log/mysql && \
	chown -R mysql:mysql /var/lib/mysql && \
	chown -R mysql:mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/log/mysql

# UTF-8 and bind-address
RUN sed -i -e "$ a [client]\n\n[mysql]\n\n[mysqld]"  /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[client\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[mysql\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[mysqld\]\)/\1\ninit_connect='SET NAMES utf8'\ncharacter-set-server = utf8\ncollation-server=utf8_unicode_ci\nbind-address = 0.0.0.0/g" /etc/mysql/my.cnf && \
	echo "innodb_flush_log_at_trx_commit=0" >> /etc/mysql/my.cnf

# for some reason a writable volume is required for databases
VOLUME /var/lib/mysql

# enable sudo for docker user
RUN echo "docker ALL=NOPASSWD: ALL" >> /etc/sudoers

CMD ["/usr/bin/mysqld_safe"]
