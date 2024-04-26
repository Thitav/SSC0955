jmp vars_e
vars:
  _ : var #10
  ebuf : 

  tstruct:
  ts_reader : var #1
  ts_writer : var #1
  ts_eaddr : var #1
  ts_bsize : var #1

  static ts_reader, #10
  static ts_writer, #10
  static ts_eaddr, #ebuf
  static ts_bsize, #10
vars_e:

loadn r1, #tstruct
loadn r2, #'A'
loadn r3, #0
loadn r4, #9
main:
  call twrite

  inc r3
  cmp r3, r4
  jne main

loadn r2, #'\0'
call twrite
loadn r2, #'B'
call twrite

loadn r1, #_
loadn r2, #0
call prints

halt

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
  push r1
  push r3
  push r4

  inc r1
  push r1
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
    cmp r3, r5
    jne twrite_rts

    loadn r6, #40
    sub r5, r5, r6

    loadn r6, #0
    loadn r7, #1200
    twrite_nz_loop:
      inc r6
      cmp r6, r7
      jne twrite_nz_loop

  twrite_rts:
    ; pop r1
    storei r1, r3

    pop r4
    pop r3
    pop r1
    rts
