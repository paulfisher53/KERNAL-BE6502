  .target "65C02"

    .include "./config.s"
    .include "./declare.s"

    .org $8000
    .include "./init.s"
    .include "./lcd.s"
    .include "./via.s"
    .include "./sys.s"
    .include "./messages.s"

    .org $fffc
    .word BootUp
    .word 0000
    