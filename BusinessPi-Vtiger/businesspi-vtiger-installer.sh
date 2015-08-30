#!/bin/bash
hostname vtiger
service hostname restart
cp /etc/hosts /etc/hosts.origin
cp configuration-files/hosts /etc/hosts

apt-get update && apt-get -y upgrade && apt-get -y install apache2 libapache2-mod-php5 mysql-server php5-mysql php-apc php5-xmlrpc php-soap php5-gd php5-curl unzip apache2-utils libgd-tools

mysql_secure_installation

wget http://sourceforge.net/projects/vtigercrm/files/vtiger%20CRM%206.3.0/Core%20Product/vtigercrm6.3.0.tar.gz
tar -xvzf vtigercrm6.3.0.tar.gz /var/www/
chmod -R 775 /var/www/vtigercrm
chown -R www-data:www-data /var/www/vtigercrm
cp /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.origin
cp /etc/mysql/my.cnf /etc/mysql/my.cnf.origin
cp configuration-files/php.ini /etc/php5/apache2/php.ini
cp configuration-files/my.cnf /etc/mysql/my.cnf
cp configuration-files/vtigercrmapache /etc/apache2/sites-available/

ln -s /etc/apache2/sites-available/vtigercrmapache /etc/apache2/sites-enabled/030-vtiger.conf

service	apache restart

echo ''
echo ''
echo ''
echo ''
echo 'Τώρα θα πρέπει να ρυθμίσετε τον υπολογιστή σας στο host αρχείο του να μεταφράζει το http://vtiger.businesspi.local στην IP που έχει λάβει (ή θέσατε εσείς) για να να συνδεθείτε στο Vtiger'
