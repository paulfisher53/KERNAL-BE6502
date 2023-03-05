.lib "DECLARE"

; HARDWARE LOCATIONS
PORTB = $6000                   ; VIA Port B
PORTA = $6001                   ; VIA Port A
DDRB = $6002                    ; Data Direction Register B
DDRA = $6003                    ; Data Direction Register A
IER = $600e                     ; VIA Interrupt Enable Register

; LCD FLAGS
E  = %10000000
RW = %01000000
RS = %00100000

MEM_TOP = $37               ; Highest location in memory
MEM_START = $281            ; Start of memory (2 bytes)
SCREEN_BASE = $288          ; Base location of screen (top)

; TEMP VARIABLES
TEMP0 = $C1                 ; 2 bytes
TEMP2 = $C3                 ; 2 bytes

; VECTORS AND INDIRECTS (USER)
VIRQ = $314                 ; interrupts service routine (2 bytes)
VBRK = $316                 ; BRK interrupts routine (2 bytes)
VNMI = $318                 ; Non-maskable interrupts routine (2 bytes)

; LCD VARIABLES
LCD_STR_BUFF = $FB          ; LCD String Buffer (2 bytes)
LCD_STR_OFFSET = $FD        ; LCD String Offset

; LCD SCREEN MEMORY
SCREEN = $400               ; Screen Memory - 96 (8 rows, 12 columns) video matrix locations addressed horizontally, then vertically
LCD_SCREEN = $460           ; LCD Screen Memory - 32 (2 rows, 16 columns)

; CONSTANTS
CONST_WAIT = $18                ; Sleep multiplicator
CONST_RAM_START = $0200         ; Unused RAM Start Location

; BASIC VARIABLES
TXTTAB = $02B                    ; Start of BASIC program text (2 bytes)
