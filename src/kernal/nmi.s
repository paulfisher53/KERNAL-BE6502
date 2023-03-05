.lib "NMI HANDLER"

NMIVector:
    sei                         ; Disable interrupts
    jmp (VNMI)                  ; Go to NMI Vector

NMIHandler:

Breakpoint:
    jsr RestoreVectors          ; Restore vectors
	jsr ScreenInit              ; Restore screen
	jmp ($A002)                 ; Run BASIC
