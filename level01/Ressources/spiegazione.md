# Level01

### 1 passaggio:
Osservando il file `/etc/passwd` possiamo notare che la password
dell'utente flag01 è presente, ovviamente criptata in DES
```bash
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
```

### 2 passaggio:
Basta creare un file con all'interno la coppia utente:password
```bash
flag01:42hDRfypTqqnw
```
e darlo in pasto al tool john the ripper
```bash
john password.txt
```
e in meno di un secondo abbiamo il seguente risultato
```bash
Loaded 1 password hash (descrypt, traditional crypt(3) [DES 128/128 SSE2-16])
Press 'q' or Ctrl-C to abort, almost any other key for status
abcdefg          (flag01)
1g 0:00:00:00 100% 2/3 50.00g/s 69650p/s 69650c/s 69650C/s raquel..bigman
Use the "--show" option to display all of the cracked passwords reliably
Session completed
```

### 3 passaggio:
Ora i seguenti comandi per ricevere la flag:
```bash
level01@SnowCrash:~$ su flag01
Password: abcdefg
Don't forget to launch getflag !
flag01@SnowCrash:~$ getflag
Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```
