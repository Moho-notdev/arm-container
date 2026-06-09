#!/bin/sh

# Aspetta la prima build
while [ ! -f /workspace/build_docker/main.elf ]; do
    sleep 1
done

# Loop del Live Reload
while true; do
    # Rimosso il flag -S, qemu-arm aspetta GDB di default con -g
    qemu-arm -g 1234 /workspace/build_docker/main.elf
    sleep 1
done