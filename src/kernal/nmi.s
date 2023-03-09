.lib "NMI HANDLER"

NMIVector:
    sei                         ; Disable interrupts
    jmp (VNMI)                  ; Go to NMI Vector

NMIHandler:

NMIBreakpoint:
    jsr RestoreVectors          ; Restore vectors
	jsr EditorInit              ; Restore editor
	jmp ($A002)                 ; Run BASIC
