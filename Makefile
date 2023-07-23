ASM = hack.asm
HACK = hack.sfc
ROM = kirbysuperstar.sfc

$(HACK): $(ASM)
	cp $(ROM) $(HACK)
	asar $(ASM) $(HACK)

.PHONY: clean
clean:
	rm -rf $(HACK)
