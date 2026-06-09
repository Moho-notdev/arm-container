# ARM-GDK

Un'interfaccia di debugging e apprendimento per ARM assembly semplice e veloce, basata su Docker. Originariamente creata per il corso di Architettura dei Sistemi di Elaborazione di Tor Vergata.

Il sistema compila, configura e unifica tutto l'ambiente dentro i container in totale automazione, fornendo un'esperienza di debugging integrata e facile da usare.

## Prerequisiti

- **Docker Desktop** installato e avviato

## Guida Rapida

### Avvio
Fai doppio click sul file Docker_runner.bat (oppure esegui docker compose up --build dal terminale).

Lo script compilerà il codice ARM, avvierà i servizi e ti mostrerà i log unificati a schermo con QEMU in ascolto sulla porta 1234.

### Debugging

Apri il browser web e vai all'indirizzo: **http://localhost:5000**

L'interfaccia di gdbgui caricherà in automatico l'eseguibile (`main.elf`) e si collegherà a QEMU, pronti per l'esecuzione passo-passo dal `_start`.

### Arresto

Per spegnere l'ambiente Docker in modo pulito, premi semplicemente **CTRL + C** nel terminale.
