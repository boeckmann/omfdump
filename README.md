# OMFDUMP
This program dumps and interprets the contents of object module files (.OBJ).
It is based on the one shipped with the source code of NASM. I made several
enhancements and fixes, especially regarding the decoding of FIXUP records.

## Sample
The following example was assembled with JWASM 2.17 into an .OBJ file.

### Input file
```
        .8086
        .model small
        .stack 200h

        .code
start:  mov ax,@data
        mov ds,ax
        mov ah,9
        mov dx, offset hellomsg
        int 21h
        mov ax,4c00h
        int 21h

        .data

hellomsg db 'Hello, World',13,10,'$'

        end start
```

### Output file
```
80 THEADR       13 bytes, checksum 86 (valid)
   0000: 0b 6c 65 61 72 6e 30 31-2e 61 73 6d              :  .learn01.asm
96 LNAMES       43 bytes, checksum 0E (valid)
   [0001] ''
   0000: 00 04 43 4f 44 45 05 5f-54 45 58 54 04 44 41 54  :  .
   [0002] 'CODE'
   0001: 04 43 4f 44 45 05 5f 54-45 58 54 04 44 41 54 41  :  .CODE
   [0003] '_TEXT'
   0006: 05 5f 54 45 58 54 04 44-41 54 41 05 5f 44 41 54  :  ._TEXT
   [0004] 'DATA'
   000c: 04 44 41 54 41 05 5f 44-41 54 41 06 44 47 52 4f  :  .DATA
   [0005] '_DATA'
   0011: 05 5f 44 41 54 41 06 44-47 52 4f 55 50 05 53 54  :  ._DATA
   [0006] 'DGROUP'
   0017: 06 44 47 52 4f 55 50 05-53 54 41 43 4b 05 53 54  :  .DGROUP
   [0007] 'STACK'
   001e: 05 53 54 41 43 4b 05 53-54 41 43 4b              :  .STACK
   [0008] 'STACK'
   0024: 05 53 54 41 43 4b                                :  .STACK
98 SEGDEF16      7 bytes, checksum 02 (valid)
     WORD (A2) PUBLIC (C2) USE16 size 0011
     name '_TEXT', class 'CODE'
   0000: 48 11 00 03 02 01                                :  H.....
88 COMENT        5 bytes, checksum A5 (valid)
   [NP=1 NL=0 UD=00] FE ???
   0002: 4f 01                                            :  O.
98 SEGDEF16      7 bytes, checksum 00 (valid)
     WORD (A2) PUBLIC (C2) USE16 size 000f
     name '_DATA', class 'DATA'
   0000: 48 0f 00 05 04 01                                :  H.....
98 SEGDEF16      7 bytes, checksum DB (valid)
     PARA (A3) STACK (C5) USE16 size 0200
     name 'STACK', class 'STACK'
   0000: 74 00 02 08 07 01                                :  t.....
9a GRPDEF        6 bytes, checksum 57 (valid)
     name 'DGROUP'
     segment '_DATA'
     segment 'STACK'
   0000: 06 ff 02 ff 03                                   :  .....
a0 LEDATA16     21 bytes, checksum D5 (valid)
                segment '_TEXT', offset 0000
   0000: b8 00 00 8e d8 b4 09 ba-00 00 cd 21 b8 00 4c cd  :  ...........!..L.
   0010: 21                                               :  !
9c FIXUPP16     10 bytes, checksum 58 (valid)
   FIXUP  segment-relative, type 2 (16-bit segment)
          record offset 0001
          frame method F5 (TARGET index)
          target method T5 (GRPDEF) index 0001 'DGROUP'
   0000: c8 01 55 01 c4 08 14 01-02                       :  ..U.
   FIXUP  segment-relative, type 1 (16-bit offset)
          record offset 0008
          frame method F1 (GRPDEF) index 0001 'DGROUP'
          target method T4 (SEGDEF) index 0002 '_DATA'
   0004: c4 08 14 01 02                                   :  .....
a0 LEDATA16     19 bytes, checksum C8 (valid)
                segment '_DATA', offset 0000
   0000: 48 65 6c 6c 6f 2c 20 57-6f 72 6c 64 0d 0a 24     :  Hello, World..$
8a MODEND16      6 bytes, checksum 5E (valid)
   0000: c1 50 01 00 00                                   :  .P...:  .
```

