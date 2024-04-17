call prints
halt

prints:
  loadn r0, #Arg0
  loadn r1, #0

  outhcar r0, r1
  rts
