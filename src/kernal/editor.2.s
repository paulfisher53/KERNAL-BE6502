.lib "EDITOR.2"

; Set pointer
EditorSetPointer:
    stx VGA_ROW
    lda SCREEN_LINES,x
    sta ROW_POINTER
    lda LINE_FLAGS,x
    and #$03
    ora SCREEN_BASE
    sta ROW_POINTER+1
    rts

; Clear a line
EditorClearLine:
    ldy #CONST_LLEN-1    
    jsr EditorSetPointer    
@clearcolumn:
    lda #$20
    sta (ROW_POINTER),y

    jsr VGAPrintChar
    
    dey
    bpl @clearcolumn

    rts

EditorDisplayCharacter:	
    tay
	lda #2
	sta BLINK_TIMER
	jsr EditorSaveColorPointer
	tya

EditorSendCharacter:
    ldy COL_POINTER
	sta (ROW_POINTER),y

	txa
	sta (COLOR_POINTER),y

    jsr VGAPrintChar

	rts

EditorSaveColorPointer:	
    lda ROW_POINTER
	sta COLOR_POINTER

	lda ROW_POINTER+1
	and #$03
	ora #>VGA_COLORS
	sta COLOR_POINTER+1

	rts

; Editor interrupt handler.
EditorInterrupt:
    ;JSR $FFEA
    lda BLINK_ENABLED
	bne @scankeys

	dec BLINK_TIMER 
	bne @scankeys

	lda #20
	sta BLINK_TIMER

	ldy COL_POINTER
	lsr BLINK_FLAG
	ldx CURSOR_COLOR
	lda (ROW_POINTER),Y
	bcs @blink

	inc BLINK_FLAG
	sta CURSOR_CHAR
	jsr EditorSaveColorPointer

	lda (COLOR_POINTER),y
	sta CURSOR_COLOR
	ldx TEXT_COLOR
	lda CURSOR_CHAR

@blink	
    eor #$80    
	jsr EditorSendCharacter

@scankeys
    rti

EditorShiftLogic:
    rts