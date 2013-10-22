#!/bin/bash

echo "###########################################";
echo "## Actualizando Sistema para instalacion ##";
echo "###########################################";

	apt-get update;

echo "###############################################";
echo "## Sistema Actualizado se Procede a Instalar ##";
echo "###############################################";
echo " ";
echo "###########################################";
echo "## PLATAFORMA LAMP ENJAULADA INSTALANDO  ##";
echo "###########################################";
echo "";

	apt-get -y install apache2 debootstrap;
	debootstrap squeeze /var/chroot http://ftp.es.debian.org/debian;
	cp -a /etc/resolv.conf /var/chroot/etc/;
	cp -a /etc/hosts /var/chroot/etc/;
	cp -a /etc/mime.types /var/chroot/etc/;
	cp -a /usr/share/zoneinfo/Europe/Madrid /var/chroot/usr/share/zoneinfo/Europe/;
	cp -a /etc/adjtime /var/chroot/etc/;
	chroot /var/chroot apt-get update;
	chroot /var/chroot apt-get install -y apache2.2-common apache2-utils;
	mv /var/run/apache2.pid /var/chroot/var/run/apache2.pid;
	ln -s /var/chroot/var/run/apache2.pid /var/run/apache2.pid;

echo "#################################";
echo "## Apache ENJAULADO Instalado  ##";
echo "#################################";
echo "";
echo "#######################################";
echo "## Instalando PHP y sus componentes  ##";
echo "#######################################";
echo "";

	apt-get -y install php5 libapache2-mod-php5 php5-gd php5-ps php5-cli php-pear php5-gd;
	chroot /var/chroot apt-get install -y php5-common;

echo "###################";
echo "## PHP Instalado ##";
echo "###################";
echo "";
echo "######################";
echo "## Instalando MySQL ##";
echo "######################";
echo "";

	apt-get install -y mysql-server-5.1 mysql-client-5.1 php5-mysql;
	/etc/init.d/mysql stop;
	mv /var/run/mysqld /var/chroot/var/run/mysqld;
	ln -s /var/chroot/var/run/mysqld/ /var/run/mysqld;
	/etc/init.d/mysql start;

echo "#####################";
echo "## MySQL Instalado ##";
echo "#####################";
echo "";
echo "##############################";
echo "## Instalando Librerias PHP ##";
echo "##############################";
echo "";

	apt-get install -y curl;
	apt-get install -y libcurl3;
	apt-get install -y libcurl3-dev;
	apt-get install -y php5-curl;
	apt-get install -y php5-mycrypt;
	apt-get install -y php5-xmlrpc;
	apt-get install -y php5-gd;
	apt-get install -y php5-intl;
	
echo "###############################";
echo "## LAMP ENJAULADO Instalado  ##";
echo "###############################";
echo "";
echo "";
echo "Ahora solo debe de irse al directorio /etc/apache2/sites-available/default y editar el fichero poniendo la direccion de la plataforma LAMP que es";
echo "/var/chroot/var/www/ en el PATH De ROOT."

echo "Restart Apache2 y Actualizamos";

	apache2 services restart;
	apt-get update;