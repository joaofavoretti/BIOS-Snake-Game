target remote localhost:1234
set disassembly-flavor intel
break *0x7c00

display/10i $eip

continue