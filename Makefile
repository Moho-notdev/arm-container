# Configurazione del compilatore per ARM cross-compilation
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld

# Nome del file finale e directory di output
BUILD_DIR ?= build_docker
TARGET = $(BUILD_DIR)/main.elf

# Cerca automaticamente tutti i file sorgente .s e .c nella cartella corrente
SRCS_S = $(wildcard src/*.s)
SRCS_C = $(wildcard src/*.c)

# Genera la lista dei file oggetto (.o) dentro la cartella di build
OBJS = $(patsubst %.s,$(BUILD_DIR)/%.o,$(SRCS_S)) $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRCS_C))

# Flag di compilazione per mantenere i simboli di debug (-g) utili per GDBGUI
CFLAGS = -g -O0 -Wall -nostdlib
ASFLAGS = -g

.PHONY: all clean

# Target principale
all: $(BUILD_DIR) $(TARGET)

# Crea la cartella di build se non esiste
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Linker: unisce i file oggetto nel file .elf finale
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)

# Regola per compilare i file Assembly (.s -> .o)
$(BUILD_DIR)/%.o: %.s
	mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) $< -o $@

# Regola per compilare i file C (.c -> .o)
$(BUILD_DIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Pulizia dei file generati
clean:
	rm -rf $(BUILD_DIR)