  .target "65C02"

    .include "./config.s"
    .include "./declare.s"    
    .org $8000                  ; Start of the kernal
    .include "./editor.1.s"
    .include "./editor.2.s"
    .include "./init.s"
    .include "./lcd.s"
    .include "./via.s"    
    .include "./messages.s"
    .include "./nmi.s"
    .include "./vectors.s"
    