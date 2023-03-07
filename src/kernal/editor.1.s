.lib "EDITOR.2"

ScreenInit:
    ldx #$00
    jsr EditorClearLine
    ldx #$01
    jsr EditorClearLine
    ldx #$02
    jsr EditorClearLine
    ldx #$03
    jsr EditorClearLine
    ldx #$04
    jsr EditorClearLine
    ldx #$05
    jsr EditorClearLine
    ldx #$06
    jsr EditorClearLine
    ldx #$07
    jsr EditorClearLine
    rts