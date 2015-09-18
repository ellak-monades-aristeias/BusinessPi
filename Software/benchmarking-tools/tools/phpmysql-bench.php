/* Το παρακάτω αρχείο είναι για έλεγχο απόκρισης του server (PHP και MySQL)
Τοποθέτησε το αρχείο στο /var/www/ και μετά κάνε ενα test π.χ.

ab -n 1000 -c 5 http://domain-tou-server/phpmysql-bench.php

*/

<html>
<head><title>Έλεγχος απόκρισης Php MySQL</title></head>
<body>
<?php
   $link = mysql_connect("localhost", "ΟΝΟΜΑ ΧΡΗΣΤΗ ΒΑΣΗΣ", "ΣΥΝΘΗΜΑΤΙΚΌ");
   mysql_select_db("ΟΝΟΜΑΒΑΣΗΣ");
 
   $query = "SELECT * FROM TABLENAME";
   $result = mysql_query($query);
 
   while ($line = mysql_fetch_array($result))
   {
      foreach ($line as $value)
       {
         print "$value\n";
      }
   }
 
    mysql_close($link);
?>
</body>
</html>