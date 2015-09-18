#!/usr/bin/perl
# Το παρακάτω αρχείο είναι για έλεγχο απόκρισης του server (perl)
# Τοποθέτησε το αρχείο στο /var/www/ και μετά κάνε ενα test π.χ.
# ab -n 3000 -c 5 http://domain-tou-server/perl-test.pl
# O κώδικας διατίθεται υπο την άδεια GPL v2.0 http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html

$command=`perl -v`;
$title = "Έκδοση Perl";
 
print "Content-type: text/html\n\n";
print "<html><head><title>$title</title></head>\n<body>\n\n";
 
print "<h1>$title</h1>\n";
print $command;
 
print "\n\n</body></html>";