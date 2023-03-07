.lib "VGA"

VLINZ0 = VRAM
VLINZ1 = VLINZ0+CONST_PIXELS
VLINZ2 = vLINZ1+CONST_PIXELS
VLINZ3 = VLINZ2+CONST_PIXELS
VLINZ4 = VLINZ3+CONST_PIXELS
VLINZ5 = VLINZ4+CONST_PIXELS
VLINZ6 = VLINZ5+CONST_PIXELS
VLINZ7 = VLINZ6+CONST_PIXELS

VRAM_LINES:
    .byte >VLINZ0
    .byte >VLINZ1
    .byte >VLINZ2
    .byte >VLINZ3
    .byte >VLINZ4
    .byte >VLINZ5
    .byte >VLINZ6
    .byte >VLINZ7

VGAPrintChar:
    
    sta $53

    txa
    pha  

    tya
    pha  

    asl
    asl
    asl    
    sta $55
    tay
    
    lda #$3F
    sta $56

    lda VRAM_LINES,X
    sta VID_PAGE + 1
    lda #$00
    sta VID_PAGE

    jsr VGAPrintCharRow

    pla
    tay

    pla
    tax
    rts

VGAPrintCharRow:
    lda $53
    and #ASCII_CHARMAP
    cmp #%00100000    ;charmap1
    beq @map1

@map1
    clc

    lda $53         ; 2B - 43    
    sbc #$20        ; 20 - 43-32=11    
    asl             ; 22        
    asl             ; 44
    asl             ; 88 - 01011000      
    clc
    adc #$07 ;next char     
    tax               
    lda charmap1,x  
    sta $50    

    ldy $55    
    jsr VGAPrintCharMap
    
    clc
    lda VID_PAGE
    adc #$80
    sta VID_PAGE
    lda VID_PAGE + 1
    adc #$00
    sta VID_PAGE + 1
    inx
    lda charmap1,x  
    sta $50    
    ldy $55        
    jsr VGAPrintCharMap

    clc
    lda VID_PAGE
    adc #$80
    sta VID_PAGE
    lda VID_PAGE + 1
    adc #$00
    sta VID_PAGE + 1
    inx
    lda charmap1,x  
    sta $50    
    ldy $55        
    jsr VGAPrintCharMap

    clc
    lda VID_PAGE
    adc #$80
    sta VID_PAGE
    lda VID_PAGE + 1
    adc #$00
    sta VID_PAGE + 1
    inx
    lda charmap1,x  
    sta $50    
    ldy $55        
    jsr VGAPrintCharMap

    clc
    lda VID_PAGE
    adc #$80
    sta VID_PAGE
    lda VID_PAGE + 1
    adc #$00
    sta VID_PAGE + 1
    inx
    lda charmap1,x  
    sta $50    
    ldy $55        
    jsr VGAPrintCharMap

    clc
    lda VID_PAGE
    adc #$80
    sta VID_PAGE
    lda VID_PAGE + 1
    adc #$00
    sta VID_PAGE + 1
    inx
    lda charmap1,x  
    sta $50    
    ldy $55        
    jsr VGAPrintCharMap

    clc
    lda VID_PAGE
    adc #$80
    sta VID_PAGE
    lda VID_PAGE + 1
    adc #$00
    sta VID_PAGE + 1
    inx
    lda charmap1,x  
    sta $50    
    ldy $55        
    jsr VGAPrintCharMap

    clc
    lda VID_PAGE
    adc #$80
    sta VID_PAGE
    lda VID_PAGE + 1
    adc #$00
    sta VID_PAGE + 1
    inx
    lda charmap1,x  
    sta $50    
    ldy $55        
    jsr VGAPrintCharMap

    rts

VGAPrintCharMap:
    charpix_col1:
      lda $50   ;stored current char from appropriate charmap
      and #PIXEL_COL1   ;look at the first column of the pixel row and see if the pixel should be set
      beq charpix_col2  ;if the first bit is not a 1 go to the next pixel, otherwise, continue and print the pixel
      lda $56	;load color stored above
      sta (VID_PAGE),Y ; write A register to address vidpage + y
    charpix_col2:
      iny   ;shift pixel writing location one to the right
      lda $50
      and #PIXEL_COL2
      beq charpix_col3
      lda $56	;load color stored above
      sta (VID_PAGE),Y ; write A register to address vidpage + y
    charpix_col3:
      iny      
      lda $50
      and #PIXEL_COL3
      beq charpix_col4
      lda $56	;load color stored above
      sta (VID_PAGE),Y ; write A register to address vidpage + y
    charpix_col4:
      iny
      lda $50
      and #PIXEL_COL4
      beq charpix_col5
      lda $56	;load color stored above
      sta (VID_PAGE),Y ; write A register to address vidpage + y
    charpix_col5:
      iny
      lda $50
      and #PIXEL_COL5
      beq charpix_col6
      lda $56	;load color stored above
      sta (VID_PAGE),Y ; write A register to address vidpage + y
    charpix_col6:
      iny
      lda $50
      and #PIXEL_COL6
      beq charpix_col7
      lda $56	;load color stored above
      sta (VID_PAGE),Y ; write A register to address vidpage + y
    charpix_col7:
      iny
      lda $50
      and #PIXEL_COL7
      beq charpix_col8
      lda $56	;load color stored above
      sta (VID_PAGE),Y ; write A register to address vidpage + y
    charpix_col8:
      iny
      lda $50
      and #PIXEL_COL8
      beq charpix_rowdone
      lda $56	;load color stored above
      sta (VID_PAGE),Y ; write A register to address vidpage + y
    charpix_rowdone:
      rts