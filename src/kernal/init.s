    .org $8000

; SysStart
; @description: System reset routine
; @returns: none
; @destroys: A,Y,X
SysStart:
    ldx #$ff                    ; Set stack pointer to 0xff
    txs

    jsr LCDInit                 ; Init the LCD

    jsr LCDClearVideoRAM
    lda #<CONST_MESSAGE_2
    ldy #>CONST_MESSAGE_2 
    jsr LCDPrint
    jsr RAMTest                 ; Test the RAM and find RAM end

    jsr LCDClearVideoRAM
    lda #<CONST_MESSAGE_1       ; Display boot message
    ldy #>CONST_MESSAGE_1 
    jsr LCDPrint    

@loop
    jmp @loop                   ; Loop

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
    sta VAR_RAM_TEST_PTR+1

@ramloopouter
    inc VAR_RAM_TEST_PTR+1      ; Move the pointer through memory
@ramloopinner
    lda (VAR_RAM_TEST_PTR),Y    ; Save data to X
    tax

    lda #$55                    ; Do a $55,$AA test
    sta (VAR_RAM_TEST_PTR),Y
    cmp (VAR_RAM_TEST_PTR),Y
    bne @save
    
    rol A
    sta (VAR_RAM_TEST_PTR),Y
    cmp (VAR_RAM_TEST_PTR),Y
    bne @save
    
    tax                         ; Restore old data
    sta (VAR_RAM_TEST_PTR),Y

    iny
    bne @ramloopinner
    beq @ramloopouter

@save
    tya
    tax
    ldy VAR_RAM_TEST_PTR+1
    clc
    jsr SetMemoryTop

    lda #$08                    ; Save OS start of memory (high byte)
    sta VAR_MEM_START+1

    lda #$04                    ; Set base of screen
    sta VAR_SCREEN_BASE

    rts
    
SetMemoryTop:
    stx VAR_MEM_TOP
    sty VAR_MEM_TOP+1
    rts
