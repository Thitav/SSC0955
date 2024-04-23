; stoi    : converte uma string para um inteiro, seguindo a base especificada
; in * r1 : string
; in r2   : base
; out r7  : numero
stoi:
  push r1
  push r3
  push r4
  push r5
  push r6

  loadn r4, #0
  loadn r5, #'0'
  loadn r6, #'W'
  loadn r7, #0

  stoi_loop:
    loadi r3, r1
    cmp r3, r4
    jeq stoi_rts

    cmp r3, r6
    jeg stoi_loop_eg  
    
    sub r3, r3, r5
    jmp stoi_loop_le
    stoi_loop_eg:
    sub r3, r3, r6
    stoi_loop_le:

    mul r7, r7, r2
    add r7, r7, r3

    inc r1
    jmp stoi_loop

  stoi_rts:
    pop r6
    pop r5
    pop r4
    pop r3
    pop r1
    rts

; itos    : converte um inteiro para uma string, seguindo a base especificada
; in r1   : numero
; in * r2 : string de destino
; in r3   : base
itos:
  push r1
  push r4
  push r5
  push r6
  push r7
  push r2

  loadn r5, #'0'
  loadn r6, #10
  loadn r7, #39

  itos_loop:
    mod r4, r1, r3

    cmp r4, r6
    jle itos_loop_le
    add r4, r4, r7

    itos_loop_le:
    add r4, r4, r5
    storei r2, r4

    inc r2
    div r1, r1, r3
    jnz itos_loop

  storei r2, r1

  pop r2
  mov r1, r2
  call strrev

  itos_rts:
    pop r7
    pop r6
    pop r5
    pop r4
    pop r1
    rts

; memset  : preenche um bloco de memoria continuo com um valor
; in * r1 : endereco do bloco de memoria
; in r2   : valor a ser escrito
; in r3   : tamanho do bloco
memset:
  push r1
  push r3
  push r4

  loadn r4, #0

  memset_loop:
    storei r1, r2

    inc r1
    dec r3
    cmp r3, r4
    jgr memset_loop
  
  memset_rts:
    pop r4
    pop r3
    pop r1
    rts

; memcpy  : copia um bloco de memoria continuo para um endereco de destino
; in * r1 : origem
; in * r2 : destino
; in r3   : tamanho a ser copiado
memcpy:
  push r1
  push r2
  push r3
  push r4
  push r5

  loadn r5, #0

  memcpy_loop:
    loadi r4, r1
    storei r2, r4

    inc r1
    inc r2
    dec r3
    
    cmp r3, r5
    jgr memcpy_loop

  memcpy_rts:
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    rts

; strcmp  : compara duas strings terminadas em '\0'
; in * r1 : primeira string
; in * r2 : segunda string
; out r7  : 0 caso forem diferentes, 1 caso forem iguais
strcmp:
  push r1
  push r2
  push r3
  push r4
  push r5

  loadn r5, #0
  loadn r7, #1

  strcmp_loop:
    loadi r3, r1
    loadi r4, r2

    inc r1
    inc r2

    cmp r3, r4
    jne strcmp_loop_ne
    cmp r3, r5
    jne strcmp_loop

  strcmp_rts:
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    rts
  strcmp_loop_ne:
    loadn r7, #0
    jmp strcmp_rts

; strrev  : reverte uma string (inplace)
; in * r1 : string
strrev:
  push r1 ; copia de r1, usado como iterador para a string
  push r2 ; caracter apontado por r2
  push r3 ; caracter apontado por r7
  push r7 ; tamanho da string (out strlen), iterador reverso

  ; endereco de memoria do fim da string - 1
  ; r1 + (strlen(r1) - 1)
  call strlen
  dec r7
  add r7, r7, r1

  strrev_loop:
    ; troca a posicao entre os caracteres
    loadi r2, r1
    loadi r3, r7
    storei r1, r3 
    storei r7, r2

    dec r7
    inc r1

    ; r1 >= r7 ? return
    cmp r1, r7
    jle strrev_loop

  strrev_rts:
    pop r7
    pop r3
    pop r2
    pop r1
    rts

; strlen  : calcula o numero de caracteres de uma string (ignorando '\0')
; in * r1 : string
; out r7  : numero de caracteres
strlen:
  push r1 ; copia de r1, usado como iterador para a string
  push r2 ; caractere da string apontado por r2
  push r3 ; caractere que termina a string ('\0')

  loadn r3, #0
  loadn r7, #0

  strlen_loop:
    loadi r2, r1

    cmp r2, r3
    jeq strlen_rts
    
    inc r1
    inc r7
    jmp strlen_loop

  strlen_rts:
    pop r3
    pop r2
    pop r1
    rts
