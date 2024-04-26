jmp vars_e
vars:
  _ : var #1200
  ebuf : 

  tstruct:
  ts_reader : var #1
  ts_writer : var #1
  ts_eaddr : var #1
  ts_bsize : var #1

  static ts_reader, #1200
  static ts_writer, #1200
  static ts_eaddr, #ebuf
  static ts_bsize, #1200
vars_e:

loadn r0, #0
loadn r1, #tstruct
main:
  call getc
  ; outchar r7, r0
  mov r2, r7
  call twrite

  inc r0
  jmp main

halt

; in r0 : cursor
; in * r1 : tstruct
; out r7 : caractere
tread:
  push r2
  push r3
  push r1

  loadi r2, r1 ; reader
  inc r1
  inc r1
  loadi r3, r1 ; eaddr

  sub r3, r3, r2 
  loadi r7, r3

  dec r2
  jnz tread_rts
  inc r1
  loadi r2, r1 ; reader = size

  tread_rts:
    pop r1
    storei r1, r2

    pop r3
    pop r2
    rts

; in * r1 : tstruct
; in r2 : caractere
twrite:
  ; breakp
  push r3
  push r4
  push r1

  outchar r2, r0

  inc r1
  loadi r3, r1 ; writer
  inc r1
  loadi r4, r1 ; eaddr

  sub r4, r4, r3
  storei r4, r2

  dec r3
  jnz twrite_nz

  inc r1
  loadi r3, r1 ; writer = size

  twrite_nz:
    pop r1
    loadi r5, r1 ; reader
    push r1
    inc r1 ; writer
    cmp r3, r5
    jne twrite_rts

    loadn r6, #40
    sub r5, r5, r6
    dec r1
    storei r1, r5
    inc r1 
    add r4, r4, r6

    push r1
    push r2
    push r3

    mov r1, r4
    loadn r2, #0
    mov r3, r6
    call memset

    pop r3
    pop r2
    pop r1

    loadn r6, #0
    loadn r5, #1200
    twrite_nz_loop:
      call tread
      outchar r7, r6

      dec r4
      inc r6
      cmp r6, r5
      jne twrite_nz_loop

  twrite_rts:
    ; pop r1
    storei r1, r3

    pop r1
    pop r4
    pop r3
    rts
