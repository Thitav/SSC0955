data:
  buffer : var #1200
  buffer_end :
data_e:

; r1 reader
; r2 writer
; r3 buffer
; r4 buffer_end

loadn r1, #buffer
mov r2, r1
mov r3, r1
loadn r4, #buffer_end

loadn r5, #0
loadn r6, #1200
main:
  call getc
  outchar r7, r5

  inc r5
  cmp r5, r6
  jne main_ne
  push r4
  loadn r4, #40
  sub r5, r5, r4
  pop r4

  main_ne:
  mov r0, r7
  call twrite

  jmp main

halt

; out r7 : caractere
tread:
  loadi r7, r1
  inc r1

  cmp r1, r4
  jne tread_rts
  mov r1, r3

  tread_rts:
    rts

; in r0 : caractere
twrite:
  storei r2, r0
  inc r2

  cmp r2, r4
  jne twrite_ne
  mov r2, r3

  twrite_ne:
  cmp r2, r1
  jne twrite_rts
  call tflush

  twrite_rts:
    rts

tflush:
  push r5
  push r6

  push r2
  push r3
  loadn r2, #0
  loadn r3, #40
  call memset
  add r1, r1, r3
  sub r2, r2, r3
  pop r3
  pop r2

  loadn r5, #0
  loadn r6, #1200
  tflush_loop:
    call tread
    outchar r7, r5

    inc r5
    cmp r5, r6
    jne tflush_loop

  tflush_rts:
    pop r6
    pop r5
    rts
