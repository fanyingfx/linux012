#!/bin/bash
qemu-system-i386 -boot a -drive format=raw,file=linux.img,if=floppy,index=0
