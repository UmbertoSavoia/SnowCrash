# Level09
### 1 passaggio:
Eseguendo il comando `ls -l`:
```bash
total 12
-rwsr-sr-x 1 flag09 level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09 level09   26 Mar  5  2016 token
```
Abbiamo un eseguibile che stampa l'argomento passatogli criptato e un file `token` 
dove al suo intenro abbiamo una stringa criptata, facendo un po di prove sull'eseguibile
si può dedurre l'algoritmo, ovvero viene addizionato al singolo carattere il suo stesso indice.

### 2 passaggio:
Con il comando `hexdump -C token` ho estratto il contenuto in esadecimale per poi copiarlo nel
seguente programma per decifrare la password di flag09
```C
#include <stdio.h>
int main(void)
{
    char *str = "\x66\x34\x6b\x6d\x6d\x36\x70\x7c\x3d"
                "\x82\x7f\x70\x82\x6e\x83\x82\x44\x42"
                "\x83\x44\x75\x7b\x7f\x8c\x89\x0a";
    for (int i = 0; str[i]; ++i)
        printf("%c", str[i]-i);
    puts("");
}
```
Quindi otteniamo la password: `f3iji1ju5yuevaus41q1afiuq`
e procediamo con i seguenti comandi:
```bash
level09@SnowCrash:~$ su flag09
Password: f3iji1ju5yuevaus41q1afiuq
Don't forget to launch getflag !
flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```
