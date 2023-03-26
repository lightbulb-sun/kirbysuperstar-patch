ASM = hack.asm
HACK = hack.sfc
ROM = kirbysuperstar.sfc

all:
	cp $(ROM) $(HACK)
	asar $(ASM) $(HACK)
