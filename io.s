loadn r0, #mystr
loadn r1, #0

call prints

halt

; prints: imprime uma string terminada em '\0' na posicao em r1
; arg r0: endereco da string
; arg r1: posicao
prints:
  push r2 ; char apontado por r0
  push r3 ; usado para os calculos de nova linha (quando r2==r6)
  push r5 ; tamanho da linha (40)
  push r6 ; char de nova linha ('\n')
  push r7 ; char de terminacao ('\0')

  loadn r5, #40
  loadn r6, #'\n'
  loadn r7, #'\0'

  prints_loop:
    loadi r2, r0
    cmp r2, r7
    jeq prints_rts
    cmp r2, r6
    jne prints_loop_nle

    mod r3, r1, r5
    sub r3, r5, r3
    add r1, r1, r3
    dec r1
    prints_loop_nle:

    outchar r2, r1

    inc r0
    inc r1
    jmp prints_loop

  prints_rts:
    pop r7
    pop r6
    pop r5
    pop r3
    pop r2
    rts

mystr : string "test\ntest\nbye"
