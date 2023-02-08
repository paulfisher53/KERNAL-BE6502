.lib "VECTORS"

    .org $ff87
    jmp RAMTest

    .org $fffc
    .word SysStart
    .word 0000