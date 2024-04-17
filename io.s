loadn r1, #mystr
loadn r2, #0
call prints

halt

prints:
  push r0
  push r3
  push r4
  push r5
  push r6
  push r7

  mov r3, r1

  loadn r5, #'\0'
  loadn r6, #'\n'
  loadn r7, #40

  prints_loop:
    loadi r4, r3

    cmp r4, r5
    jeq prints_rts

    cmp r4, r6
    jne prints_loop_nnl
    mod r0, r2, r7
    sub r0, r7, r0
    add r2, r2, r0
    dec r2

    prints_loop_nnl:
    outchar r4, r2
    inc r2
    inc r3
    jmp prints_loop

  prints_rts:
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r0
    rts

mystr : string "test\ntest2\nbye"
