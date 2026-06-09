#!/bin/bash

cat << 'EOF' > /tmp/gdbinit
set confirm off
set pagination off
set mi-async on
set architecture arm
set breakpoint pending on

# Questi comandi vengono eseguiti SUBITO all'apertura per caricare il file
file /workspace/build_docker/main.elf
target extended-remote qemu:1234

define reload
    echo \n[ARM-GDK] Ricompilazione...\n
    shell make clean -C /workspace BUILD_DIR=build_docker && make --always-make -C /workspace BUILD_DIR=build_docker
    shell sleep 1
    symbol-file /workspace/build_docker/main.elf
    target extended-remote qemu:1234
    file /workspace/build_docker/main.elf
    load
    tbreak _start
    continue
    echo \n[ARM-GDK] Modifiche caricate!\n
end

document reload
Ricarica il codice Assembly salvato senza riavviare Docker.
end

EOF

exec gdb-multiarch -q -x /tmp/gdbinit "$@"