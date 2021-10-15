# Level13
### 1 passaggio:
Eseguendo il comando `ls -l`:
```bash
total 8
-rwsr-sr-x 1 flag13 level13 7303 Aug 30  2015 level13
```
e il comando `file level13`:
```bash
level13: setuid setgid ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=0xde91cfbf70ca6632d7e4122f8210985dea778605, not stripped
```
Capiamo che si tratta di un eseguibile a 32bit. Eseguendolo abbiamo il seguente output:
```bash
UID 2013 started us but we we expect 4242
```
Dunque si aspetta un UID 4242 che ovviamente non esiste, con il comando `strings level13` abbiamo
una stringa che contiene il seguente testo: `your token is %s`.
Quindi l'unica cosa che rimane da fare è disassemblare l'eseguibile con `objdump -d level13`
e leggiamo la sezione contenente la funzione `main`:
```
0804858c <main>:
 804858c:       55                      push   %ebp
 804858d:       89 e5                   mov    %esp,%ebp
 804858f:       83 e4 f0                and    $0xfffffff0,%esp
 8048592:       83 ec 10                sub    $0x10,%esp
 8048595:       e8 e6 fd ff ff          call   8048380 <getuid@plt>
 804859a:       3d 92 10 00 00          cmp    $0x1092,%eax
 804859f:       74 2a                   je     80485cb <main+0x3f>
 80485a1:       e8 da fd ff ff          call   8048380 <getuid@plt>
 80485a6:       ba c8 86 04 08          mov    $0x80486c8,%edx
 80485ab:       c7 44 24 08 92 10 00    movl   $0x1092,0x8(%esp)
 80485b2:       00
 80485b3:       89 44 24 04             mov    %eax,0x4(%esp)
 80485b7:       89 14 24                mov    %edx,(%esp)
 80485ba:       e8 a1 fd ff ff          call   8048360 <printf@plt>
 80485bf:       c7 04 24 01 00 00 00    movl   $0x1,(%esp)
 80485c6:       e8 d5 fd ff ff          call   80483a0 <exit@plt>
 80485cb:       c7 04 24 ef 86 04 08    movl   $0x80486ef,(%esp)
 80485d2:       e8 9d fe ff ff          call   8048474 <ft_des>
 80485d7:       ba 09 87 04 08          mov    $0x8048709,%edx
 80485dc:       89 44 24 04             mov    %eax,0x4(%esp)
 80485e0:       89 14 24                mov    %edx,(%esp)
 80485e3:       e8 78 fd ff ff          call   8048360 <printf@plt>
 80485e8:       c9                      leave
 80485e9:       c3                      ret
 80485ea:       90                      nop
 80485eb:       90                      nop
 80485ec:       90                      nop
 80485ed:       90                      nop
 80485ee:       90                      nop
 80485ef:       90                      nop
```
Dopo aver chiamato `getuid` compara il risultato con 0x1092 ovvero 4242 in decimale per poi fare un
salto all'istruzione che stamperà il token.

### 2 passaggio:
Apriamo `gdb` per modificare il valore del registro `eax` e far risultare vera l'uguaglianza:
```bash
level13@SnowCrash:~$ gdb level13
(gdb) b *0x804859a
Breakpoint 1 at 0x804859a
(gdb) r
Starting program: /home/user/level13/level13
Breakpoint 1, 0x0804859a in main ()
(gdb) set $eax=4242
(gdb) c
Continuing.
your token is 2A31L79asukciNyi8uppkEuSx
[Inferior 1 (process 2958) exited with code 050]
```
