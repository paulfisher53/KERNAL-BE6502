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

VAR_MEM_TOP = $37               ; Highest location in memory
VAR_MEM_START = $281            ; Start of memory (2 bytes)
VAR_SCREEN_BASE = $288          ; Base location of screen (top)

VAR_RAM_TEST_PTR = $C1          ; Used for RAM Test

; LCD VARIABLES
VAR_LCD_STR_BUFF = $FB          ; LCD String Buffer (2 bytes)
VAR_LCD_STR_OFFSET = $FD        ; LCD String Offset

; LCD SCREEN MEMORY
VAR_SCREEN = $400               ; Screen Memory - 96 (8 rows, 12 columns) video matrix locations addressed horizontally, then vertically
VAR_LCD_SCREEN = $460           ; LCD Screen Memory - 32 (2 rows, 16 columns)

; CONSTANTS
CONST_WAIT = $18                ; Sleep multiplicator
