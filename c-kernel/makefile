CC := gcc
OUT_DIR := ./out
NASM := nasm
KERNERL_BIN := ./bin/kernel.bin
IDT := idt-func
PRINT := print
MAIN := main
ASM_DIR := ./asm
ENTRY_ADDRESS := 0xc0001500
build: $(KERNERL_BIN)
	dd if=$(KERNERL_BIN) of=../images/test.img bs=512 count=200 seek=9 conv=notrunc


$(MAIN).o:
	$(CC) -fno-builtin -m32 -I . -c ./$(MAIN).c -o $(OUT_DIR)/$(MAIN).o
$(PRINT).o:
	$(NASM) -f elf -i $(ASM_DIR) -o $(OUT_DIR)/$(PRINT).o $(ASM_DIR)/$(PRINT).asm
$(IDT).o:
	$(NASM) -f elf -i $(ASM_DIR) -o $(OUT_DIR)/$(IDT).o $(ASM_DIR)/$(IDT).asm
objs := $(IDT).o $(MAIN).o $(PRINT).o
$(KERNERL_BIN): $(objs)
	ld -m elf_i386 -Ttext $(ENTRY_ADDRESS) -e main -o $(KERNERL_BIN) $(OUT_DIR)/$(MAIN).o \
	$(OUT_DIR)/$(PRINT).o $(OUT_DIR)/$(IDT).o


