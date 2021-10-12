# Level02
### 1 passaggio:
Con un semplice comando `ls` vediamo che è presente un file chiamato
`level02.pcap` l'estensione si riferisce a un packet capture dunque si può analizzare
con il tool Wireshark.

### 2 passaggio:
con il comando 
```bash
scp -P 4242 level02@192.168.56.130:level02.pcap .
```
copio il file `level02.pcap` così da poterlo aprire con Wireshark

### 3 passaggio:
Analizzo i pacchetti scambiati sul protocollo tcp e metto insieme tutti i pacchetti
con il campo `Data` così trovo la password: `ft_waNDReL0L`

### 4 passaggio:
Comandi per avere la flag:
```bash
level02@SnowCrash:~$ su flag02
Password: ft_waNDReL0L
Don't forget to launch getflag !
flag02@SnowCrash:~$ getflag
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq
```
