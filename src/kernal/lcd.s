; ============================
; LCD PROCEDURES
; ============================

; LCDClearVideoRAM
; @description: Clears the video memory
; @returns: none
LCDClearVideoRAM:
    pha                         ; Save A
    
    tya                         ; Save Y
    pha

    ldy #$1f                    ; Set counter to 31
    lda #$20

@loop:
    sta VAR_LCD_SCREEN,Y         ; Store A (space char) at pos Y
    dey
    bne @loop

    sta VAR_LCD_SCREEN           ; Write last location manually

    pla                         ; Restore Y
    tay

    pla                         ; Restore A

    rts

; LCDPrint
; @description: Prints a string to the LCD
; Important: String MUST NOT be zero terminated
; @param A: LSN String Address
; @param Y: MSN String Address
; @returns: none
; @destroys: A,X,Y
LCDPrint:
    ldx #0                      ; set offset to 0 as default
    jsr LCDPrintWithOffset

    rts

; LCDPrintWithOffset
; @description: Prints a string to the LCD
; Important: String MUST NOT be zero terminated
; @param A: LSN String Address
; @param Y: MSN String Address
; @param X: Offset Byte
; @returns: none
; @destroys: A,X,Y
LCDPrintWithOffset:
    sta VAR_LCD_STR_BUFF
    sty VAR_LCD_STR_BUFF+1
    stx VAR_LCD_STR_OFFSET
    ldy #0

@loop:
    clc
    
    tya
    adc VAR_LCD_STR_OFFSET      ; Add offset to loop iterator
    tax                         ; and store in X

    lda (VAR_LCD_STR_BUFF),Y    ; Load character at pos Y
    beq @return                 ; If we reach 0x00 exit loop

    sta VAR_LCD_SCREEN,X         ; Store character to video memory
    iny

    jmp @loop

@return:
    jsr LCDRender               ; Render video memory to LCD

    rts

; LCDInit
; @description: Initialize the LCD
; @returns: none
; @destroys: A,X
LCDInit:
    lda #%11111111              ; Set PORTB pins to output
    ldx #%11100000              ; Set firt 3 pins for PORTA to ouput
    jsr VIAConfigureDDR

    lda #%00111000              ; Set 8 bit mode, 2 lines, 5x8 font
    jsr LCDSendInstruction

    lda #%00001110              ; Set display on, cursor on, no blink
    jsr LCDSendInstruction
    
    lda #%00000110              ; Increment and shift cursor
    jmp LCDSendInstruction

; LCDSetCursor
; @description: Sets the cursor into upper or lower row
; @param A: Byte for upper or lower row
; @returns: none
; @destroys: A
LCDSetCursor:
    jmp LCDSendInstruction

; LCDSetCursor2
; @description: Sets cursor to second row, first column
; @returns: none
LCDSetCursor2:
    pha                         ; Save A

.if CONFIG_EMULATOR == 0
    lda #%11000000              ; Set cursor to line 2    
.endif
.if CONFIG_EMULATOR == 1
    lda #%10100000              ; Set cursor to line 2  
.endif
        
    jsr LCDSendInstruction

    pla                         ; Restore A

    rts

; LCDRender
; @description: Renders video memory to LCD
; @param VAR_LCD_SCREEN: Needs to be loaded with characters 
; @returns: none
; @destroys: A,X,Y
LCDRender:
    lda #%10000000              ; Set cursor to first line
    jsr LCDSetCursor                         
    ldx #0

@writechar:
    lda VAR_LCD_SCREEN,X         ; Load character from memory at pos X
    
    cpx #$10                    ; If x = 16 write next line
    beq @nextline

    cpx #$20                    ; If x = 32 return
    beq @return

    jsr LCDSendData             ; Send the character to LCD
    inx
    jmp @writechar

@nextline:
    jsr LCDSetCursor2           ; Set cursor to second line

    jsr LCDSendData             ; Send the character to LCD  
    inx
    jmp @writechar

@return:
    rts

; LCDCheckBusy
; @description: Returns the LCD busy flag
; @returns A: LCD Busy Flag ($01 = busy, $00 = ready)
; @destroys: A
LCDCheckBusy:
    lda #0                      ; Clear RS/RW/E bits
    sta PORTA

    lda #RW                     ; Set RW mode
    sta PORTA

    bit PORTB                   ; Read LCD data
    bpl @ready

    lda #1                      ; Return busy flag
    rts

@ready:
    lda #0                      ; Return ready flag

@return:
    rts


; LCDSendInstruction
; @description: Sends a control instruction to the LCD display
; @param A: Control byte
; @returns: none
; @destroys: A
LCDSendInstruction:
    pha                         ; Save A

@loop
    jsr LCDCheckBusy
    bne @loop

    pla                         ; Restore A

    sta PORTB                   ; Write the A param (control byte)

    lda #E                      ; Set E mode
    sta PORTA

    lda #0                      ; Clear RS/RW/E bits
    sta PORTA

    rts

; LCDSendData
; @description: Sends data to the LCD controller
; @param A: Content byte
; @returns: none
; @destroys: A
LCDSendData:
    sta PORTB                   ; Write A param to PORTB

    lda #(RS | E)               ; Set RS and E mode
    sta PORTA

    lda #0                      ; Clear RS/RW/E bits
    sta PORTA

    rts
    