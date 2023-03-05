.lib "INITIALIZATION"

; SysStart
; @description: System reset routine
; @returns: none
; @destroys: A,Y,X
SysStart:
    ldx #$ff                    ; Set X to 0xff for the stack pointer
    sei                         ; Disable interrupts
    txs                         ; Clear the stack
    cld                         ; Clear decimal mode

    jsr LCDInit                 ; Init the LCD

    jsr LCDClearVideoRAM
    lda #<CONST_MESSAGE_2
    ldy #>CONST_MESSAGE_2 
    jsr LCDPrint
    
    jsr RAMTest                 ; Test the RAM and find RAM end
    jsr RestoreVectors          ; Set up vectors
    jsr ScreenInit              ; Init screen - TODO replace with global vector


    jsr LCDClearVideoRAM
    lda #<CONST_MESSAGE_1       ; Display boot message
    ldy #>CONST_MESSAGE_1 
    jsr LCDPrint    

    cli                         ; Enable interrupts
    jmp ($A000)                 ; Goto BASIC

@loop
    jmp @loop                   ; Loop

; Restore kernal vectors (system)
RestoreVectors:
    ldx #<VECTOR_TABLE          ; Load pointer to vector table
	ldy #>VECTOR_TABLE
	clc

; Set kernal vectors (user)
UserVectors:
    stx TEMP2                   ; Save pointer to vector table
	sty TEMP2+1
	ldy #VECTOR_TABLE_END-VECTOR_TABLE-1
@readvector:	
    lda VIRQ,Y                  ; Read vector byte from vectors (user)
	bcs @savevector             ; Save if a byte was read
	lda (TEMP2),Y               ; or load from vectors (system)
@savevector	
    sta (TEMP2),Y               ; Save byte to X Y
	sta VIRQ,Y                  ; Save byte to vector
	dey
	bpl @readvector             ; Loop until finished
	rts

VECTOR_TABLE:
    .word Keyinterrupt,Breakpoint,NMIHandler
VECTOR_TABLE_END:

RAMTest:
    lda #0                      ; Clear A
    tay                         ; Clear Index
@loop
    sta $0000,Y                 ; Clear Page 0
    sta $0200,Y                 ; Clear Page 2
    sta $0300,Y                 ; Clear Page 3
    iny
    bne @loop

    tay                         ; Clear Y
.if CONFIG_EMULATOR == 0
    lda #3                      ; Set RAM Test Pointer (High Byte)
.endif 
.if CONFIG_EMULATOR == 1
    lda #$3E                    ; Set RAM Test Pointer (High Byte)
.endif    
    sta TEMP0+1

@ramloopouter
    inc TEMP0+1      ; Move the pointer through memory
@ramloopinner
    lda (TEMP0),Y    ; Save data to X
    tax

    lda #$55                    ; Do a $55,$AA test
    sta (TEMP0),Y
    cmp (TEMP0),Y
    bne @save
    
    rol A
    sta (TEMP0),Y
    cmp (TEMP0),Y
    bne @save
    
    tax                         ; Restore old data
    sta (TEMP0),Y

    iny
    bne @ramloopinner
    beq @ramloopouter

@save
    tya
    tax
    ldy TEMP0+1
    clc
    jsr SetMemoryTop

    lda #$08                    ; Save OS start of memory (high byte)
    sta MEM_START+1

    lda #$04                    ; Set base of screen
    sta SCREEN_BASE

    rts
    
SetMemoryTop:
    stx MEM_TOP
    sty MEM_TOP+1
    rts