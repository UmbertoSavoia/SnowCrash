# Level00

### 1 passaggio:
Con il comando:
```bash
 find / -user flag00 2> /dev/null 
```
trovo i file creati dall'utente flag00 ovvero:
```bash
/usr/sbin/john
/rofs/usr/sbin/john
```

### 2 passaggio:
Con il comando ` cat ` posso effettivamente
vedere la password cifrata:
` cdiiddwpgswtgt `

### 3 passaggio:
L' algoritmo usato è un Caesar Cipher dunque tramite il sito:
[Caesar-Cipher](https://www.boxentriq.com/code-breaking/caesar-cipher)
ho aumentato la key fino a ricevere una password con senso compiuto
key | password 
----|---------
15 | nottoohardhere

### 4 passaggio:
Quindi adesso con i seguenti comandi arrivo ad ottenere la flag:
```
level00@SnowCrash:~$ su flag00
Password: nottoohardhere
Don't forget to launch getflag !
flag00@SnowCrash:~$ getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```

