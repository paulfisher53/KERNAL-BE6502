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

; KERNAL RAM
.org $0090
VAR_SLEEP = *                   ; Sleep counter
*=*+1
VAR_LCD_SCREEN = *              ; LCD Screen Memory
*=*+32                            
VAR_LCD_STR_BUFF = *            ; LCD String Buffer
*=*+2
VAR_LCD_STR_OFFSET = *          ; LCD String Offset

; CONSTANTS
CONST_WAIT = $18                ; Sleep multiplicator
