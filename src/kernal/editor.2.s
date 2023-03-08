.lib "EDITOR.2"

; Set pointer
EditorSetPointer:
    lda SCREEN_LINES,X
    sta ROW_POINTER
    lda LINE_FLAGS,X
    and #$03
    ora SCREEN_BASE
    sta ROW_POINTER+1
    rts

; Clear a line
EditorClearLine:
    ldy #CONST_LLEN-1    
    jsr EditorSetPointer    
@clearcolumn:
    lda #$41
    sta (ROW_POINTER),Y
    jsr VGAPrintChar
    dey
    bpl @clearcolumn
    rts

; Key interrupt handler.
EditorKeyInterrupt:
    rti