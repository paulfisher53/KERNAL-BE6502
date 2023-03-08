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

; VGA FLAGS
ASCII_CHARMAP           = %11100000
PIXEL_COL1              = %10000000
PIXEL_COL2              = %01000000
PIXEL_COL3              = %00100000
PIXEL_COL4              = %00010000
PIXEL_COL5              = %00001000
PIXEL_COL6              = %00000100
PIXEL_COL7              = %00000010
PIXEL_COL8              = %00000001

MEM_TOP = $37                   ; Highest location in memory
MEM_START = $281                ; Start of memory (2 bytes)
SCREEN_BASE = $288              ; Base location of screen (top)
ROW_POINTER = $D1               ; Row pointer (2 bytes)
COL_POINTER = $D3               ; Column pointer
LINE_FLAGS = $D9                ; Line flags and endspace (9 bytes)

; TEMP VARIABLES
TEMP0 = $C1                     ; 2 bytes
TEMP2 = $C3                     ; 2 bytes

; VECTORS AND INDIRECTS (USER)
VIRQ = $314                     ; Interrupt service routine (2 bytes)
VBRK = $316                     ; BRK interrupts routine (2 bytes)
VNMI = $318                     ; Non-maskable interrupts routine (2 bytes)

; LCD VARIABLES
LCD_STR_BUFF = $FB              ; LCD String Buffer (2 bytes)
LCD_STR_OFFSET = $FD            ; LCD String Offset

; SCREEN MEMORY
VGA_SCREEN = $400               ; VGA Screen Memory - 96 bytes (8 rows, 12 columns) video matrix locations addressed horizontally, then vertically
VGA_COLORS = $460               ; VGA Color Memory - 96 bytes (8 rows, 12 columns)
LCD_SCREEN = $4C0               ; LCD Screen Memory - 32 bytes (2 rows, 16 columns)

; VGA
VGA_CHAR = $7E8                 ; ASCII character to print
VGA_ROW = $F9                   ; Current VGA row (2 bytes)
VGA_CHAR_MAP = $F7              ; Current character map (2 bytes)
VGA_MAP_ROW = $7ED              ; Character map row
VGA_COL = $7EE                  ; Current VGA column

VGA_PIXELS = $2000              ; VGA pixel memory (100x75)

; CONSTANTS
CONST_WAIT = $18                ; Sleep multiplicator
CONST_RAM_START = $0200         ; Unused RAM Start Location
CONST_LLEN = 12                 ; Screen Columns (Single line mode)
CONST_NLINES = 8                ; Screen Rows
CONST_PIXELS = 1024             ; Pixels in a 8x8 character row

; BASIC VARIABLES
TXTTAB = $02B                    ; Start of BASIC program text (2 bytes)