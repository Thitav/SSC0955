loadn r1, #str1
loadn r2, #str2
loadn r3, #11
call memcopy

loadn r2, #0
loadn r1, #str1
call prints
loadn r1, #str2
call prints

halt

; memcopy : copia um bloco continuo de memoria de um endereco para outro
; in * r1 : origem
; in * r2 : destino
; in * r3 : tamanho a ser copiado
memcopy:
  push r4
  push r5
  push r6
  push r7

  mov r4, r1
  mov r5, r2

  loadn r7, #0

  memcopy_loop:
    cmp r3, r7
    jeq memcopy_rts

    loadi r6, r4
    storei r5, r6

    inc r4
    inc r5
    dec r3
    jmp memcopy_loop

  memcopy_rts:
    pop r7
    pop r6
    pop r5
    pop r4
    rts

; strrev  : reverte uma string (inplace)
; in * r1 : endereco da string
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

; strlen  : calcula o numero de caracteres de uma string terminada em '\0' (ignorando o '\0')
; in * r1 : endereco da string
; out r7  : numero de caracteres
strlen:
  push r2 ; copia de r1, usado como iterador para a string
  push r5 ; caractere da string apontado por r2
  push r6 ; caractere que termina a string ('\0')

  ; copia r1 para r2 para usar r2 como iterador 
  mov r2, r1

  loadn r6, #'\0'
  loadn r7, #0 ; limpa o output

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
str1 : string "Hello World\n"
str2 : string "World Helkn\n"
