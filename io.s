loadn r1, #mystr
loadn r2, #0
call prints

halt

; prints    : imprime uma string
; in * r1   : endereco da string
; in mut r2 : posicao para imprimir a string : posicao final da string
prints:
  push r1
  push r3
  push r4
  push r5
  push r6
  push r7

  loadn r5, #'\0'
  loadn r6, #'\n'
  loadn r7, #40

  prints_loop:
    loadi r3, r1

    cmp r3, r5
    jeq prints_rts

    cmp r3, r6
    jne prints_loop_nnl
    mod r4, r2, r7
    sub r4, r7, r4
    add r2, r2, r4
    dec r2

    prints_loop_nnl:
    outchar r3, r2
    inc r1
    inc r2
    jmp prints_loop

  prints_rts:
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r1
    rts

mystr : string "test\ntest2\nbye"
