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

; ASCII MASK
ASCII_MASK = %11100000

; $0000-$00FF
; PAGE 0
; Zero page addressing
SEARCH_CHAR = $0007             ; Search Character for Scanning BASIC Text Input
END_CHAR = $0008                ; Search Character for Statement Termination or Quote
TEMP_POINTER = $0016            ; Pointer to the Next Available Space in the Temporary String Stack
TEMP_STACK = $0019              ; Descriptor Stack for Temporary Strings (4 bytes)
GARBAGE_FLAG = $000F            ; Garbage collector flag
TXTTAB = $002B                  ; Start of BASIC program text (2 bytes)
FREE_MEM_TOP = $0033            ; Top of free memory space (2 bytes)
MEM_TOP = $0037                 ; Highest location in memory
DESC_POINTER = $0050            ; Temporary Pointer to the Current String Descriptor (3 bytes)
HIGHDS = $0058                  ; Destination of highest element
TEMP_DESCRIPTOR = $0062         ; Temp desriptor location  
FAC_MO = $0064                  ; Floating point accumulator, middle order
STRING_POINTER = $006F          ; String pointer
DESC_STRING = $0073             ; Pointer to string or descriptior
INPUT_DEVICE = $0099            ; Default input device (Set to 0 for the keyboard)
OUTPUT_DEVICE = $009A           ; Default output device (Set to 3 for the screen)
TEMP0 = $00C1                   ; 2 bytes
TEMP2 = $00C3                   ; 2 bytes
BLINK_ENABLED = $00CC           ; Blink enabled flag
BLINK_TIMER = $00CD             ; Cursor blink timer
CURSOR_CHAR = $00CE             ; Character under the cursor
BLINK_FLAG = $00CF              ; Cursor blink flag
ROW_POINTER = $00D1             ; Row pointer (2 bytes)
COL_POINTER = $00D3             ; Column pointer
MAX_LINE_LEN = $00D5            ; Max length of screen line
CURSOR_ROW = $00D6              ; Current cursor row pointer
LINE_FLAGS = $00D9              ; Line flags and endspace / editor temp storage (9 bytes)
COLOR_POINTER = $00F3           ; Pointer to screen color
VGA_CHAR_MAP = $00F7            ; Current character map (2 bytes)
VGA_ROW_POINTER = $00F9         ; Current VGA row (2 bytes)
LCD_STR_BUFF = $00FB            ; LCD String Buffer (2 bytes)
LCD_STR_OFFSET = $00FD          ; LCD String Offset

; $0100-$01FF
; PAGE 1
; Enhanced zero page (contains the stack)

; $0200-$02FF
; PAGE 2
; KERNAL and BASIC pointers
MEM_START = $0281               ; Start of memory (2 bytes)
TEXT_COLOR = $0286              ; Current text color
CURSOR_COLOR = $0287            ; Color of character under cursor
SCREEN_BASE = $0288             ; Base location of screen (top)
MAX_KEY_BUFFER = $0289          ; Maximum keyboard buffer size
KEY_REPEAT_TIMER = $028B        ; Key repeat delay counter
KEY_REPEAT_DELAY = $028C        ; Time before a held key is repeated
KEY_LOGIC = $028F               ; Vector to keyboard table setup routine (2 bytes)
MODE = $0291                    ; Allow/disallow switching character sets with a key press
VGA_CHAR = $02A7                ; ASCII character to print
VGA_MAP_ROW = $02A8             ; Character map row
VGA_COL = $02A9                 ; Current VGA column
VGA_ROW = $02AA                 ; Current VGA row
VGA_COLOR = $02AB               ; Current VGA text color

; $0300-$03FF
; PAGE 3
; KERNAL and BASIC pointers
VIRQ = $0314                    ; Interrupt service routine (2 bytes)
VBRK = $0316                    ; BRK interrupts routine (2 bytes)
VNMI = $0318                    ; Non-maskable interrupts routine (2 bytes)

; $0400-$07FF
; PAGE 4 - PAGE 7
; Screen and LCD memory
VGA_SCREEN = $0400               ; VGA Screen Memory - 96 bytes (8 rows, 12 columns) video matrix locations addressed horizontally, then vertically
LCD_SCREEN = $04C0               ; LCD Screen Memory - 32 bytes (2 rows, 16 columns)
VGA_COLORS = $0500               ; VGA Color Memory - 96 bytes (8 rows, 12 columns)

; $0800-$1FFF
; PAGE 8 - PAGE 31
; Free memory (6143 bytes)

; $2000-$3FFF
; PAGE 32 - 64
; VGA memory
VGA_PIXELS = $2000              ; VGA pixel memory (100x75)

; CONSTANTS
CONST_WAIT = $18                ; Sleep multiplicator
CONST_RAM_START = $0200         ; Unused RAM Start Location
CONST_LLEN = 12                 ; Screen Columns (Single line mode)
CONST_NLINES = 8                ; Screen Rows
CONST_PIXELS = 1024             ; Pixels in a 8x8 character row
CONST_ADPRC = 1
CONST_BUFFER_PAGE = 2
CONST_STR_SIZE = 3