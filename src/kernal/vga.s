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

COLOR_MAP:
    .byte %00000000 // 0 - Black
    .byte %00111111 // 1 - White
    .byte %00100101 // 2 - Red
    .byte %00101111 // 3 - Cyan
    .byte %00100110 // 4 - Violet
    .byte %00011001 // 5 - Green    
    .byte %00010111 // 6 - Blue
    .byte %00111101 // 7 - Yellow 
    .byte %00100100 // 8 - Orange 
    .byte %00010100 // 9 - Brown 
    .byte %00110101 // 10 - Light Red
    .byte %00010101 // 11 - Dark Grey 
    .byte %00101010 // 12 - Grey  
    .byte %00101110 // 13 - Light Green    
    .byte %00101011 // 14 - Light Blue 
    .byte %00101010 // 15 - Light Grey    

VGAPrintChar:
    
    sta VGA_CHAR

    txa
    pha  

    tya
    pha  

    asl
    asl
    asl    
    adc #2
    sta VGA_COL
    tay
    
    lda COLOR_MAP+14
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
    txa
    pha

    lda #$8    
    tax

    clc
    lda VGA_MAP_ROW
@loop        
    asl
    bcs @pixel
    pha
    lda COLOR_MAP+6
    jmp @set
@pixel:
    pha
    lda $56
@set:
    sta (VGA_ROW),Y
    iny
    pla
    dex
    bne @loop

    pla
    tax

    rts