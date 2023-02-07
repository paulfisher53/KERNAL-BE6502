; BootUp
; @description: Boot routine
; @returns: none
; @destroys: A,Y,X
BootUp:
    ldx #$ff                    ; Set stack pointer to 0xff
    txs

    jsr LCDInit                 ; Init the LCD

    jsr LCDClearVideoRAM
    lda #<CONST_MESSAGE_1       ; Display boot message
    ldy #>CONST_MESSAGE_1 
    jsr LCDPrint                

.if CONFIG_CLOCK_MODULE == 0
    ldx #$20                    ; Do some sleeps to delay the code
    lda #$ff    
@wait:
    jsr SysSleep
    dex
    bne @wait
.endif

    jmp BootUp                  ; Should not reach here, but just in case...
    