.lib "VECTORS"

    .org $FF87
    jmp RAMTest

    .org $FFFA
    .word NMIVector
    .word SysStart
    .word EditorInterrupt
    