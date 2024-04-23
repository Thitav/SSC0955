jmp data_e
tty_buff : var #1200
tty_buff_e:
data_e:

main:
  call tgetc
  jmp main

halt

; in r0  : cursor
; out r7 : character
tgetc:
  push r1
  push r2

  loadn r1, #255
  loadn r2, #126

  outchar r2, r0

  tgetc_loop:
    inchar r7
    cmp r7, r1
    jeq tgetc_loop

  outchar r7, r0
  inc r0

  tgetc_rts:
    pop r2
    pop r1
    rts

