# Banana Pi M1
![BPI-M1](https://raw.githubusercontent.com/ellak-monades-aristeias/BusinessPi/master/Images/BPI-M1.jpg)

---
**Περιεχόμενα**
- [Συνοπτική περιγραφή του Banana Pi M1](#Συνοπτική-περιγραφή-του-banana-pi-m1)
- [Τεχνικές προδιαγραφές](#Τεχνικές-προδιαγραφές)
   - [Παρελκόμενα](#Παρελκόμενα)

---

Για τις ανάγκες του έργου έγινε εκτεταμένη έρευνα αγοράς για να επιλέξουμε τον ιδανικό συνδυασμό hardware και software ώστε να πληρούν τις εξής προϋποθέσεις : 

- Ικανοποιητικές επιδόσεις για συνθήκες μιας μικρής επιχείρησης
- Συνδεσιμότητα και επεκτασιμότητα του hardware
- Βέλτιστο λόγο αξίας προς τιμή

Αφού αποκλείσαμε κάποια μοντέλα (λόγοι κόστους/διαθεσιμότητας/επιδόσεων) επιλέξαμε και συγκρίναμε τα board που εμφανίζονται στον παρακάτω πίνακα. (Σημείωση η τιμή κόστους είναι ενδεικτική) 

![](https://raw.githubusercontent.com/ellak-monades-aristeias/BusinessPi/master/Images/comparison-piboards.jpg)

Έτσι καταλήξαμε ότι η πρώτη έκδοση του έργου BusinessPi να γίνει διαθέσιμη για το **Banana Pi M1**. 

Παρόλα αυτά η εγκατάσταση των λογισμικών που διαθέτει το BusinessPi μπορεί να γίνει αυτόματα με χρήση του ειδικού λογισμικού που αναπτύξαμε, ανεξάρτητα από το Board ή το λειτουργικό Linux που διαθέτει το Board σας. [Βλέπε Software Stack](https://github.com/ellak-monades-aristeias/BusinessPi/wiki/Software-Stack)

## Συνοπτική περιγραφή του Banana Pi M1

Το Banana Pi M1 είναι ένας [single-board υπολογιστής](https://en.wikipedia.org/wiki/Single-board_computer) που κατασκευάζεται στην Κίνα. Χρησιμοποιεί την Allwinner Α20 SoC, διαθέτει διπύρηνο επεξεργαστή, 1GB RAM και η σύνδεση με το δίκτυο γίνεται διαμέσου της ενσωματωμένης ethernet.

Το βασικό και επίσημο λειτουργικό σύστημα του BananaPi είναι το **Bananian** το οποίο είναι μια βελτιστοποιημένη έκδοση του λειτουργικού συστήματος Debian GNU/Linux για την πλατφόρμα του Banana Pi.

Παρόλα αυτά όμως ο χρήστης μπορεί αν εγκαταστήσει και άλλες διανομές Linux. Ως λειτουργικά συστήματα υποστηρίζει : 
- Android
- Ubuntu
- Debian
- OpenSUSE
- Fedora

Μια εκτενείς λίστα διαθέσιμων λειτουργικών συστημάτων συμβατών με το Banana Pi M1 μπορείτε να δείτε εδώ <http://www.banana-pi.org/download.html>

## Τεχνικές προδιαγραφές

Οι τεχνικές προδιαγραφές του Banana Pi M1 έχουν ως εξής:
![BPI-M1-Specs](https://raw.githubusercontent.com/ellak-monades-aristeias/BusinessPi/master/Images/BPI-M1-Specs.png)

Οι θέσεις των προδιαγραφών που αναφέρονται στον παραπάνω πίνακα μπορούν να εντοπιστούν στο BananaPi στην παρακάτω εικόνα :

![m1int-front-back](https://raw.githubusercontent.com/ellak-monades-aristeias/BusinessPi/master/Images/m1int-front-back.jpg)

#### Παρελκόμενα

Επειδή τα board στην αγορά έρχονται ως έχουν (χωρίς δηλαδή περιφερικά), για τις ανάγκες του έργου χρησιμοποιήσαμε επίσης:
- μια SD Card Class 10 (για τις ανάγκες του OS/Software Stack)
- καλώδιο MicroUSB (για παροχή ρεύματος)
- καλώδιο δικτύου (για σύνδεση στο υφιστάμενο δίκτυο/internet)

τα οποία φαίνονται στην παρακάτω εικόνα όπως είναι συνδεδεμένα και [επί το έργον](http://businesspi.github.io/epi-to-ergon.html) :

![bananapi-businesspi-development](http://businesspi.github.io/images/bananapi-businesspi-development.jpg)