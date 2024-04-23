loadn r1, #stdinw
loadn r2, #'a'
call swrite

loadn r1, #stdinr
call sread

loadn r1, #stdin_buf
loadn r2, #0
call prints

halt

; sread   : le de uma stream e avanca o ponteiro de leitura
; in * r1 : endereco do ponteiro de leitura da stream
; out r7  : valor lido
sread:
  push r1
  push r3

  loadi r3, r1
  loadi r7, r3

  inc r3
  storei r1, r3

  sread_rts:
    pop r3
    pop r1
    rts

; swrite  : escreve em uma stream e avanca o ponteiro de escrita
; in * r1 : endereco do ponteiro de escrita da stream
; in r2   : valor a ser escrito
swrite:
  push r1
  push r3

  loadi r3, r1
  storei r3, r2
  
  inc r3
  storei r1, r3

  swrite_rts:
    pop r3
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

mystr : string "AAAA"

stdin:
  stdinr       : var #1
  stdinw       : var #1
  stdin_end    : var #1
  stdin_buf    : var #1024
  stdin_buf_end:
  static stdinr, #stdin_buf
  static stdinw, #stdin_buf
  static stdin_end, #stdin_buf_end
