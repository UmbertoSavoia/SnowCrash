# Level14
### 1 passaggio:
In questo livello non troviamo nessun file nella home ed eseguendo il comando 
`find \ -user flag14 2> /dev/null` oppure `find \ -user level14 2> /dev/null`
non si trova nulla di interessante, dunque non resta che attaccare `/bin/getflag`

### 2 passaggio:
Con `objdump -d /bin/getflag` e leggendo nella sezione della funzione `main` dobbiamo prestare
attenzione a due passaggi fondamentali:
```debug
08048946 <main>:
 (...)
 8048989:       e8 b2 fb ff ff          call   8048540 <ptrace@plt>
 804898e:       85 c0                   test   %eax,%eax
 8048990:       79 16                   jns    80489a8 <main+0x62>
 (...)
 8048afd:       e8 ae f9 ff ff          call   80484b0 <getuid@plt>
 8048b02:       89 44 24 18             mov    %eax,0x18(%esp)
 (...)
```
nella prima parte abbiamo davanti una semplicissima tecnica di anti-debugging che sfrutta l'errore
della syscall `ptrace` per capire se l'eseguibile è stato aperto da qualche programma di debbugging
dunque basta impostare `eax` a 0 prima dell'istruzione `test`.
Mentre della seconda parte viene chiamata la funzione `getuid` che ovviamente restituirà il numero
`2014` quindi anche qui basta sostituire subito dopo il ritorno della chiamata il valore di `eax`
con il numero `3014` letto dal file `/etc/passwd`:
> flag14:x:3014:3014::/home/flag/flag14:/bin/bash

Di seguito abbiamo tutte le istruzioni eseguite in `gdb`:
```bash
level14@SnowCrash:~$ gdb /bin/getflag

(gdb) b *0x804898e
Breakpoint 1 at 0x804898e
(gdb) r
Starting program: /bin/getflag

Breakpoint 1, 0x0804898e in main ()
(gdb) set $eax=0
(gdb) b *0x8048b02
Breakpoint 2 at 0x8048b02
(gdb) c
Continuing.

Breakpoint 2, 0x08048b02 in main ()
(gdb) set $eax=3014
(gdb) c
Continuing.
Check flag.Here is your token : 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
[Inferior 1 (process 3295) exited normally]
```

### 3 passaggio:
```bash
level14@SnowCrash:~$ su flag14
Password: 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
Congratulation. Type getflag to get the key and send it to me the owner of this livecd :)
```
