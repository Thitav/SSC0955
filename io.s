; getc   : aguarda e le um caractere do teclado
; out r7 : caractere
getc:
  push r1

  loadn r1, #255

  getc_loop:
    inchar r7
    cmp r7, r1
    jeq getc_loop

  getc_rts:
    pop r1
    rts

; putc  : coloca um caractere na posicao x y da tela
; in r1 : caractere
; in r2 : x
; in r3 : y
putc:
  push r3
  push r4

  loadn r4, #40

  mul r3, r3, r4
  add r3, r3, r2
  outchar r1, r3

  putc_rts:
    pop r4
    pop r3
    rts

; puts    : coloca uma string na posicao x y da tela
; in * r1 : string
; in r2   : x
; in r3   : y
puts:
  push r2
  push r3
  push r4

  loadn r4, #40

  mul r3, r3, r4
  add r2, r3, r2
  call prints

  puts_rts:
    pop r4
    pop r3
    pop r2
    rts

; prints    : imprime uma string
; in * r1   : string
; in mut r2 : posicao para imprimir a string : posicao final da string
prints:
  push r1
  push r3
  push r4
  push r5
  push r6
  push r7

  loadn r5, #0
  loadn r6, #'\n'
  loadn r7, #40

  prints_loop:
    loadi r3, r1

    cmp r3, r5
    jeq prints_rts

    cmp r3, r6
    jne prints_loop_ne
    mod r4, r2, r7
    sub r4, r7, r4
    add r2, r2, r4
    dec r2

    prints_loop_ne:
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

