jmp vars_e
vars:
  tty_s :
    ttyread : var #1
    ttywrite : var #1
    ttychunk : var #1
    ttybuf : var #1
    ttybuf_end : var #1

  buf : var #3
  buf_end :

  static ttyread, #buf
  static ttywrite, #buf
  static ttychunk, #40
  static ttybuf, #buf
  static ttybuf_end, #buf_end
vars_e:

; estrutura de um buffer tty
; 0 : endereço de leitura
; 1 : endereço de escrita
; 2 : tamanho do chunk
; 3 : endereço de início do buffer
; 4 : endereço de fim do buffer

loadn r1, #tty_s
loadn r2, #'A'
call tputc
loadn r2, #'B'
call tputc
loadn r2, #'\0'
call tputc
loadn r2, #'C'
call tputc

loadn r1, #buf
loadn r2, #0
call prints

halt
 
; tputc   : escreve um caractere no buffer tty
; in * r1 : endereco de uma estrutura de buffer tty
; in r2   : caractere a ser escrito
tputc:
  push r1
  push r3
  push r4
  push r5

  inc r1 ; 0 + 1 = 1 : endereco de escrita
  loadi r3, r1 ; carrerga o endereco de escrita
  storei r3, r2 ; salva o caractere no buffer
  inc r3 ; incrementa o endereco de escrita

  loadn r4, #3
  add r4, r4, r1 ; 1 + 3 = 4 : endereco de fim do buffer
  loadi r5, r4 ; carrega o endereco de fim do buffer
  cmp r3, r5 ; se endereco de escrita < endereco de fim do buffer
  jle tputc_rts ; entao retorna

  dec r4 ; 4 - 1 = 3 : endereco de inicio do buffer
  loadi r3, r4 ; carrega o endereco de inicio do buffer

  tputc_rts:
    storei r1, r3 ; salva o novo endereco de escrita
    
    pop r5
    pop r4
    pop r3
    pop r1
    rts
