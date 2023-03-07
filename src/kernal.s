  .target "65C02"

    .include "./config.s"
    .include "./declare.s"  
  .org $8000
    nop 
  .org $D000
    .include "./char/c64.upper.s"
  .org $E000
    .include "./kernal/editor.1.s"
    .include "./kernal/editor.2.s"
    .include "./kernal/editor.3.s"
    .include "./kernal/init.s"
    .include "./kernal/lcd.s"
    .include "./kernal/via.s"    
    .include "./kernal/messages.s"
    .include "./kernal/vga.s"
    .include "./kernal/nmi.s"
    .include "./kernal/vectors.s"
    