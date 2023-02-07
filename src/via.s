; ============================
; VERSITILE INTERFACE ADAPTER PROCEDURES
; ============================

; VIAConfigureDDR
; @description: Configures data direction on the VIA chip
; @param A: Byte for DDRB
; @param X: Byte for DDRA
; @returns: none
VIAConfigureDDR:
    sta DDRB                    ; Configure DDRB from A param
    stx DDRA                    ; Configure DDRA from X param

    rts