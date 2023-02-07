; SysSleep
; @description: Sleeps for a certain amount of clock cycles
; @param A: Byte representing the sleep duration 
; @returns: none
; @destroys: Y
SysSleep:
    ldy #CONST_WAIT             ; Transfer multipilier to memory        
    sty VAR_SLEEP
@outerloop:
    tay                         ; Transfer A param to Y       
.if CONFIG_EMULATOR == 1
    ldy #0
.endif
@loop:
    dey
    bne @loop                   ; Inner loop (using the A param)

    dec VAR_SLEEP
    bne @outerloop              ; Outer loop (to sync with clock cycle)

    rts