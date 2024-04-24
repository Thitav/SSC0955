jmp vars_e
vars:
  ttybuf : var #1200
  ttybuf_e:

  sout:
  sout_op : var #1
  sout_buf : var #1
  sout_buf_e : var #1
  static sout_op, #ttybuf
  static sout_buf, #ttybuf
  static sout_buf_e, #ttybuf_e
vars_e:

; tflush : descarrega o buffer de saída
; 
tflush:
  push r1
  push r2
  push r3

  loadn r1, #sout
  loadn r2, #1
  loadn r3, #0
  call sseek

  loadn r2, #1200
  tflush_loop:
    call sread
    outhcar r7, r3
    inc r3
    cmp r3, r2
    jne tflush_loop

  tflush_rts:
    pop r3
    pop r2
    pop r1
    rts
