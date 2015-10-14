#!/bin/bash
#_______________________________________________
# Πληροφορίες σχετικά με τον εγκαταστάτη
#_______________________________________________
# Name   : ΒusinessPi Vtiger Installer
# Licence: GPL3 (http://www.gnu.org/licenses/gpl-3.0.txt)
# Author : Salih Emin
# WebSite: http://businesspi.github.io
# Email  : salihemin (at) about.me 
# Date   : 30-08-2015
# Version: 1.0
# Compatible System : Debian and Ubuntu Linux
# Description:
# To ΒusinessPi Vtiger Installer αυτόματα θα ενηερώσει το σύστημά σας θα κάνει εγκατάσταση και ρύθμιση webserver 
# και mysql ενώ στο τέλος θα κάνει λήψη και εγκατάσταση του Vtiger.
#

# Έλεγχος αν το λογισμικό εκτελείται με δικαιώματα διαχειρστή. Αν όχι γίνεται έξωδος
if [ $EUID -ne 0 ] ; then
    clear
    echo ""
    echo "To ΒusinessPi Vtiger Installer θα πρέπει να εκτελεστεί με δικαιώματα διαχειρηστή ή ως root. Έξοδος... " 1>&2
    echo ""
    sleep 2
    exit 1
fi

clear
echo "_______________________________________________________"
echo "                                                       "
echo "      ΒusinessPi Vtiger Installer v1.0                 "
echo "                 ~  ''  ~                              "
echo "                                                       "
echo "  Το λογισμικό αυτό, σε λίγο θα ξεκινήσει αυτόματα να  "                                                    
echo "  ενημερώσει το σύστημά σας, έπειτα θα κάνει εγκατάσταση" 
echo "  και ρύθμιση webserver και mysql.                     "                                   
echo " "                                          
echo " "
echo "  Τέλος θα κάνει λήψη και εγκατάσταση του Vtiger.     "
echo " "      
echo "_______________________________________________________"
echo
echo " Η εγκατάσταση θα ξεκινήσει σε 5 δευτερόλεπτα... "		

sleep 6


echo '#########################################'
echo '########      Βήμα 1 απο 5      #########'
echo '# Αλλαγή το Hostname σε vtiger και      #'
echo '# domain σε vtiger.businesspi.local     #'
echo '#########################################'
sleep 3
cp /etc/hostname /etc/hostname.origin
echo 'vtiger' > /etc/hostname
cp /etc/hosts /etc/hosts.origin
cp configuration-files/hosts /etc/hosts
invoke-rc.d hostname.sh start
echo '#########################################'
echo '########      Βήμα 2 απο 5      #########'
echo '# Ενημέρωση συστήματος και εγκατάσταση  #'
echo '#               LAMP                    #'
echo '#########################################'
sleep 3
apt-get update && apt-get -y upgrade && apt-get -y install apache2 libapache2-mod-php5 mysql-server php5-mysql php5-imap php5-xmlrpc php5-gd php5-curl apache2-utils libgd-tools
echo '#########################################'
echo '########      Βήμα 3 απο 5      #########'
echo '# Ρυθμίσεις ασφαλείας για την MySQL     #'
echo '#                                       #'
echo '#########################################'
sleep 3
mysql_secure_installation
echo '#########################################'
echo '########      Βήμα 4 απο 5      #########'
echo '# Λήψη και εγατάσταση Vtiger CRM 6.3.0  #'
echo '#                                       #'
echo '#########################################'
sleep 3
wget http://sourceforge.net/projects/vtigercrm/files/vtiger%20CRM%206.3.0/Core%20Product/vtigercrm6.3.0.tar.gz
tar -xvzf vtigercrm6.3.0.tar.gz
rm /var/www/index.html
mv vtigercrm /var/www/vtigercrm
chmod -R 775 /var/www/vtigercrm
chown -R www-data:www-data /var/www/vtigercrm
cp /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.origin
cp configuration-files/php.ini /etc/php5/apache2/php.ini
cp configuration-files/vtigercrmapache.conf /etc/apache2/sites-available/
a2ensite vtigercrmapache.conf
a2dissite 000-default
echo '#########################################'
echo '########      Βήμα 5 απο 5      #########'
echo '# Επανεκκίνηση Apache και MySQL         #'
echo '#                                       #'
echo '#########################################'
sleep 3
service	apache2 restart
service mysql restart

echo ''
echo ''
echo ''
echo '#########################################'
echo '# H εγκατάσταση Ολοκληρώθηκε            #'
echo '#                                       #'
echo '#########################################'
echo ''
echo 'Τώρα θα πρέπει να ρυθμίσετε τον υπολογιστή σας στο host αρχείο του να μεταφράζει το http://vtiger.businesspi.local στην IP που έχει λάβει (ή θέσατε εσείς) για να να συνδεθείτε στο Vtiger'
echo ''
echo ''
