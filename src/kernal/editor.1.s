.lib "EDITOR.2"

EditorInit:
    jsr EditorResetIO
    
    lda #0          
	sta MODE

	sta BLINK_FLAG

    lda #<EditorShiftLogic
	sta KEY_LOGIC
	lda #>EditorShiftLogic
	sta KEY_LOGIC+1

	lda #10
	sta MAX_KEY_BUFFER        
	sta KEY_REPEAT_DELAY

	lda #$E         
	sta TEXT_COLOR
	
    lda #4
	sta KEY_REPEAT_TIMER       
	
    lda #$C
	sta BLINK_TIMER

	lda #$00
	sta BLINK_ENABLED

EditorClearScreen:	
    lda SCREEN_BASE      
	ora #$80
	tay
	lda #0
	tax
@loop
    sty LINE_FLAGS,x
	clc
	adc #CONST_LLEN
	bcc @loop2
	iny            
@loop2	
    inx
	cpx #CONST_NLINES+1  
	bne @loop
	lda #$FF        
	sta LINE_FLAGS,x
	ldx #CONST_NLINES-1
@clear	
    jsr EditorClearLine
	dex
	bpl @clear

EditorHome:	
    ldy #0
	sty COL_POINTER
	sty CURSOR_ROW
    
EditorMoveCursor:
	ldx CURSOR_ROW
	lda COL_POINTER

@findline	
    ldy LINE_FLAGS,X     
	bmi @found
	
    clc
	adc #CONST_LLEN
	sta COL_POINTER

	dex
	bpl @findline

@found	
    jsr EditorSetPointer  
	lda #CONST_LLEN-1
	inx

@findend	
    ldy LINE_FLAGS,X
	bmi @done
	
    clc
	adc #CONST_LLEN
	
    inx
	bpl @findend

@done
	sta MAX_LINE_LEN
	jmp EditorSaveColorPointer        

EditorResetIO:
    lda #3
	sta OUTPUT_DEVICE
	lda #0
	sta INPUT_DEVICE
    rts