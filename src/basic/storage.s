.lib "BASIC.STORAGE"

StorageCheckMemory:	
    cpy FREE_MEM_TOP+1
	bcc @done
	bne @try
	cmp FREE_MEM_TOP
	bcc @done
@try	
	pha
	ldx #8+CONST_ADPRC
	tya
@save	
	pha
	lda HIGHDS-1,x
	dex
	bpl @save
	;jsr GARBA2
	ldx #248-CONST_ADPRC
@saveto	
	pla
	sta HIGHDS+8+CONST_ADPRC,x
	inx
	bmi @saveto
	pla
	tay
	pla
	cpy FREE_MEM_TOP+1
	bcc @done
	;bne OMERR
	cmp FREE_MEM_TOP
	;bcs OMERR
@done:
	rts