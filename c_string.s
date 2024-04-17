loadn r1, #teststr
call strrev
mov r0, r1
loadn r1, #0
call prints

halt

; strrev : reverte uma string (inplace)
; in str* r1
strrev:
  push r2 ; copia de r1, usado como iterador para a string
  push r5 ; caracter apontado por r2
  push r6 ; caracter apontado por r7
  push r7 ; tamanho da string (out strlen), iterador reverso

  ; endereco de memoria do fim da string - 1
  ; r1 + (strlen(r1) - 1)
  call strlen
  dec r7
  add r7, r7, r1

  ; copia r1 para r2 para usar r2 como iterador
  mov r2, r1

  strrev_loop:
    ; r2 >= r7 ? return
    cmp r2, r7
    jeg strrev_rts

    ; troca a posicao entre os caracteres
    loadi r5, r2
    loadi r6, r7
    storei r2, r6 
    storei r7, r5

    dec r7
    inc r2
    jmp strrev_loop

  strrev_rts:
    pop r7
    pop r6
    pop r5
    pop r2
    rts

; strlen: calcula o numero de caracteres de uma string terminada em '\0', ignorando o '\0'
; in str* r1 : pointer para a string
; out uint r7 : numero de caracteres
strlen:
  push r2 ; copia de r1, usado como iterador para a string
  push r5 ; caractere da string apontado por r2
  push r6 ; caractere que termina a string ('\0') 

  ; copia r1 para r2 para usar r2 como iterador 
  mov r2, r1

  loadn r6, #'\0'

  ; limpa o output 
  loadn r7, #0

  strlen_loop:
    loadi r5, r2
    cmp r5, r6
    jeq strlen_rts
    inc r2
    inc r7
    jmp strlen_loop

  strlen_rts:
    pop r6
    pop r5
    pop r2
    rts

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

teststr : string "Hello World"
