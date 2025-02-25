AS := as
LD := ld.lld -m elf_x86_64

LDFLAG := -Ttext 0x0 -s --oformat binary

image : linux.img

linux.img : tools/build bootsect setup kernel/system
	./tools/build bootsect setup kernel/system > $@

tools/build : tools/build.c
		gcc -o $@ $<

kernel/system :
	cd kernel; make system; cd ..

bootsect : bootsect.o
	$(LD) $(LDFLAG) -o $@ $<

bootsect.o : bootsect.S
	$(AS) -o $@ $<

setup : setup.o
		$(LD) $(LDFLAG) -e _start_setup -o $@ $<

setup.o : setup.S
		$(AS) -o $@ $<
clean:
	/bin/rm -f *.o
	/bin/rm -f bootsect
	/bin/rm -f setup
	/bin/rm -f tools/build
	/bin/rm -f linux.img
	cd kernel; make clean; cd ..

