#!/bin/bash

log() { echo "[$(date +%H:%M:%S)] $1"; }

clear
echo "========================================="
echo "        ARM-GDK ORCHESTRATOR             "
echo "========================================="
echo ""

# 1. Attesa risoluzione DNS
log "[*] Attesa disponibilita' DNS per 'qemu'..."
until getent hosts qemu > /dev/null; do
    sleep 1
done
log "[OK] Risoluzione DNS attiva."

# 2. Attesa porta 1234
log "[*] Verifica socket Debug QEMU (Porta 1234)..."
until nc -z qemu 1234; do
    sleep 1
done
log "[OK] QEMU accetta connessioni."

# 3. Attesa porta 5000
log "[*] Attesa avvio GDBGUI..."
until nc -z gdbgui 5000; do
    sleep 1
done
log "[OK] GDBGUI pronto."

# Apertura automatica browser
sleep 1

echo "[OK] Browser aperto su http://localhost:5000"

clear
echo "========================================="
echo "        ARM-GDK SISTEMA OPERATIVO        "
echo "========================================="
echo ""
echo "  [OK] Compilazione completata."
echo "  [OK] QEMU in ascolto sulla porta 1234."
echo "  [OK] GDBGUI pronto su http://localhost:5000"
echo ""
echo "  Per modificare il codice:"
echo "    1. Modifica src/main.s"
echo "    2. Scrivi 'reload' nella console GDB"
echo ""
echo "  [CTRL+C per spegnere tutto]"
echo ""
echo "========= OUTPUT PROGRAMMA ARM =========="
echo ""

tail -f /dev/null