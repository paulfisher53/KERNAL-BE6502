.lib "BASIC.INIT"

BasicInit:
    ;JSR INITV       ;GO INIT VECTORS
	;JSR INITCZ      ;GO INIT CHARGET & Z-PAGE
	jsr BasicInitMessages
	;LDX #STKEND-256 ;SET UP END OF STACK
	;TXS
	;BNE READY       ;JMP...READY
@loop
    nop
    jmp @loop                   ; Loop

BasicInitMessages:
    lda TXTTAB
	ldy TXTTAB+1
	jsr StorageCheckMemory

	lda #<FREE_MEM_MESSAGE
	ldy #>FREE_MEM_MESSAGE
	jsr PrintString

	;LDA MEMSIZ
	;SEC
	;SBC TXTTAB
	;TAX
	;LDA MEMSIZ+1
	;SBC TXTTAB+1
	;JSR LINPRT
	;LDA #<WORDS
	;LDY #>WORDS
	;JSR STROUT
	;JMP SCRTCH
    rts ;TEMP

FREE_MEM_MESSAGE:	
    .byte 147,13,"    **** COMMODORE 64 BASIC V2 ****"
	.byte 13,13," 64K RAM SYSTEM  ",0
	.byte 0