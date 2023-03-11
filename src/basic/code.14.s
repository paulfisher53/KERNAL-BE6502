.lib "BASIC.CODE.14"

StringInit:	
    ldx FAC_MO
	ldy FAC_MO+1

	stx DESC_POINTER
	sty DESC_POINTER+1

StringSpace:	
    ;jsr GetStringSpace
	stx TEMP_DESCRIPTOR+1
	sty TEMP_DESCRIPTOR+2
	sta TEMP_DESCRIPTOR
	rts

StringLiteral:	
    ldx #34
	stx SEARCH_CHAR
	stx END_CHAR

PrintStringLiteral:	
    sta STRING_POINTER
	sty STRING_POINTER+1

	sta TEMP_DESCRIPTOR+1
	sty TEMP_DESCRIPTOR+2

	ldy #255

@get:	
    iny
	lda (STRING_POINTER),y
	beq @find1

	cmp SEARCH_CHAR
	beq @find

	cmp END_CHAR
	bne @get

@find:
	cmp #34
	beq @find2

@find1:
    clc

@find2:
	sty TEMP_DESCRIPTOR
	tya
	adc STRING_POINTER
	sta DESC_STRING
	ldx STRING_POINTER+1
	bcc @store
	inx

@store:
    stx DESC_STRING+1
	lda STRING_POINTER+1
	beq @copy
	cmp #CONST_BUFFER_PAGE
	bne PUTNEW
@copy:
	tya
	jsr StringInit
	ldx STRING_POINTER
	ldy STRING_POINTER+1
	jsr MOVSTR

PutNew:
	ldx TEMP_POINTER
	cpx #TEMP_STACK+CONST_STR_SIZE+CONST_STR_SIZE+CONST_STR_SIZE
	bne PutString
	ldx #ERRST

ERRGO2	
    JMP ERROR

PutString:	
    LDA DSCTMP
	STA 0,X
	LDA DSCTMP+1
	STA 1,X
	LDA DSCTMP+2
	STA 2,X
	LDY #0
	STX FAC_MO
	STY FAC_MO+1
	STY FACOV
	DEY
	STY VALTYP
	STX LASTPT
	INX
	INX
	INX
	STX TEMP_POINTER
	RTS

GetStringSpace:
    lsr GARBAGE_FLAG