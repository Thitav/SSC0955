; estrutura de uma stream
; stream + 0 : endereço de operação (leitura/escrita)
; stream + 1 : endereço do buffer
; stream + 2 : endereço final do buffer

; sread   : lê um byte da stream
; in * r1 : endereço da stream
; out r7  : byte lido
sread:
  push r2

  loadi r2, r1 ; carrega o endereço de leitura (stream + 0)
  loadi r7, r2 ; leitura do byte

  inc r2 ; incrementa o endereço de leitura
  storei r1, r2 ; salva o endereço de leitura incrementado na stream

  sread_rts:
    pop r2 
    rts

; sreadn  : lê n bytes da stream
; in * r1 : endereço da stream
; in * r2 : buffer de destino
; in r3   : quantidade de bytes a serem lidos
sreadn:
  push r2
  push r3
  push r4
  push r5

  loadi r4, r1 ; carrega o endereço de leitura (stream + 0)

  sreadn_loop:
    loadi r5, r4 ; leitura do byte
    storei r2, r5 ; armazena o byte no buffer de destino

    inc r2 ; incrementa o endereço de destino
    inc r4 ; incrementa o endereço de leitura
    dec r3 ; decrementa a quantidade de bytes a serem lidos
    jnz sreadn_loop ; se r3 != 0, loop
  
  storei r1, r4 ; salva o endereço de leitura incrementado na stream  

  sreadn_rts:
    pop r5
    pop r4
    pop r3
    pop r2
    rts

; swrite  : escreve um byte na stream
; in * r1 : endereco da stream
; in r2   : byte a ser escrito
swrite:
  push r3

  loadi r3, r1 ; carrega o endereco de escrita
  storei r3, r2 ; escrita do byte

  inc r3 ; incrementa o endereco de escrita
  storei r1, r3 ; salva o endereco de escrita incrementado na stream

  swrite_rts:
    pop r3
    rts

; swriten : escreve n bytes na stream
; in * r1 : endereco da stream
; in * r2 : buffer de origem
; in r3   : quantidade de bytes a serem escritos
swriten:
  push r2
  push r3
  push r4
  push r5

  loadi r4, r1 ; carrega o endereco de escrita

  swriten_loop:
    loadi r5, r2 ; leitura do byte
    storei r4, r5 ; escrita do byte

    inc r2 ; incrementa o endereco de origem
    inc r4 ; incrementa o endereco de escrita
    dec r3 ; decrementa a quantidade de bytes a serem escritos
    jnz swriten_loop ; se r3 != 0, loop

  storei r1, r4 ; salva o endereco de escrita incrementado na stream

  swriten_rts:
    pop r5
    pop r4
    pop r3
    pop r2
    rts

; sseek   : move o ponteiro de operacao para a posicao de referencia + deslocamento
; in * r1 : endereco da stream
; in r2   : posicao de referencia : 0 = atual, 1 = inicio, != 0 e != 1 = fim
; in r3   : deslocamento
sseek:
  push r4
  push r5
  push r1

  loadn r4, #0
  cmp r2, r4
  jeq sseek_main

  inc r1 ; stream + 1 = endereço do buffer
  loadn r4, #1
  cmp r2, r4
  jeq sseek_main

  inc r1 ; stream + 2 = endereço final do buffer

  sseek_main:
    loadi r5, r1 ; carrega a posicao de referencia
    add r5, r5, r3 ; referencia + deslocamento
    pop r1 ; recupera o endereco de operacao
    storei r1, r5 ; salva o novo endereco de operação na stream

  sseek_rts:
    pop r5
    pop r4
    rts
