.lib "VGA"

VLINZ0 = VGA_PIXELS
VLINZ1 = VLINZ0+CONST_PIXELS
VLINZ2 = vLINZ1+CONST_PIXELS
VLINZ3 = VLINZ2+CONST_PIXELS
VLINZ4 = VLINZ3+CONST_PIXELS
VLINZ5 = VLINZ4+CONST_PIXELS
VLINZ6 = VLINZ5+CONST_PIXELS
VLINZ7 = VLINZ6+CONST_PIXELS

VGA_LINES:
    .byte >VLINZ0
    .byte >VLINZ1
    .byte >VLINZ2
    .byte >VLINZ3
    .byte >VLINZ4
    .byte >VLINZ5
    .byte >VLINZ6
    .byte >VLINZ7

VGAPrintChar:
    
    sta VGA_CHAR

    txa
    pha  

    tya
    pha  

    asl
    asl
    asl    
    sta VGA_COL
    tay
    
    lda #$3F
    sta $56

    lda VGA_LINES,X
    sta VGA_ROW + 1
    lda #$00
    sta VGA_ROW

    jsr VGAPrintCharRow

    pla
    tay

    pla
    tax
    rts

VGANextRow:
    inx
    txa
    tay
    clc
    lda VGA_ROW
    adc #$80
    sta VGA_ROW
    lda VGA_ROW + 1
    adc #$00
    sta VGA_ROW + 1                
    lda (VGA_CHAR_MAP),Y 
    sta VGA_MAP_ROW
    ldy VGA_COL     
    rts

VGAPrintCharRow:
    lda VGA_CHAR
    and #ASCII_CHARMAP
    cmp #%00100000
    beq @map1
    lda VGA_CHAR
    and #ASCII_CHARMAP
    cmp #%01000000
    beq @map2
    lda VGA_CHAR
    and #ASCII_CHARMAP
    cmp #%10000000
    beq @map3

@map1
    lda #<charmap1
    sta VGA_CHAR_MAP
    lda #>charmap1
    sta VGA_CHAR_MAP+1
    clc
    lda VGA_CHAR  
    sbc #$20
    jmp @printrows
@map2
    lda #<charmap2
    sta VGA_CHAR_MAP
    lda #>charmap2
    sta VGA_CHAR_MAP+1
    clc
    lda VGA_CHAR  
    sbc #$40
    jmp @printrows
@map3
    lda #<charmap3
    sta VGA_CHAR_MAP
    lda #>charmap3
    sta VGA_CHAR_MAP+1
    clc
    lda VGA_CHAR  
    sbc #$60

@printrows    
    asl  
    asl
    asl    
    clc
    adc #$07
    tax               
    tay
    lda (VGA_CHAR_MAP),Y  
    sta VGA_MAP_ROW    
    ldy VGA_COL

    jsr VGAPrintCharMap
    jsr VGANextRow        
    jsr VGAPrintCharMap
    jsr VGANextRow      
    jsr VGAPrintCharMap
    jsr VGANextRow
    jsr VGAPrintCharMap
    jsr VGANextRow 
    jsr VGAPrintCharMap
    jsr VGANextRow 
    jsr VGAPrintCharMap
    jsr VGANextRow
    jsr VGAPrintCharMap
    jsr VGANextRow
    jsr VGAPrintCharMap

    rts

VGAPrintCharMap:    
    jsr VGACol1
    iny
    jsr VGACol2
    iny
    jsr VGACol3
    iny
    jsr VGACol4
    iny
    jsr VGACol5
    iny
    jsr VGACol6
    iny
    jsr VGACol7
    iny
    jsr VGACol8
    iny
    rts

VGACol1:
    lda VGA_MAP_ROW
    and #PIXEL_COL1
    beq @black  
    lda $56	
    jmp @set
@black:
    lda #$00
@set:
    sta (VGA_ROW),Y
    rts

VGACol2:
    lda VGA_MAP_ROW
    and #PIXEL_COL2
    beq @black  
    lda $56	
    jmp @set
@black:
    lda #$00
@set:
    sta (VGA_ROW),Y
    rts

VGACol3:
    lda VGA_MAP_ROW
    and #PIXEL_COL3
    beq @black  
    lda $56	
    jmp @set
@black:
    lda #$00
@set:
    sta (VGA_ROW),Y
    rts

VGACol4:
    lda VGA_MAP_ROW
    and #PIXEL_COL4
    beq @black  
    lda $56	
    jmp @set
@black:
    lda #$00
@set:
    sta (VGA_ROW),Y
    rts

VGACol5:
    lda VGA_MAP_ROW
    and #PIXEL_COL5
    beq @black  
    lda $56	
    jmp @set
@black:
    lda #$00
@set:
    sta (VGA_ROW),Y
    rts

VGACol6:
    lda VGA_MAP_ROW
    and #PIXEL_COL6
    beq @black  
    lda $56	
    jmp @set
@black:
    lda #$00
@set:
    sta (VGA_ROW),Y
    rts

VGACol7:
    lda VGA_MAP_ROW
    and #PIXEL_COL7
    beq @black  
    lda $56	
    jmp @set
@black:
    lda #$00
@set:
    sta (VGA_ROW),Y
    rts

VGACol8:
    lda VGA_MAP_ROW
    and #PIXEL_COL8
    beq @black  
    lda $56	
    jmp @set
@black:
    lda #$00
@set:
    sta (VGA_ROW),Y
    rts