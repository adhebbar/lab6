        .ORG    $0000
        LDI     R0, $0     ; initialize R0 with the value 0
        LDSP    R0         ; write R0 to the SP register
        BRA     INITN      ; branch to the first line of your main code
      
        .ORG    $0100
INITN   LDI     R4, $A     ; store n in R1
        BRA     MAIN       ; branch to main code at $0200
        
        .ORG    $0200
MAIN    CMI     R4, $49    ; compare n with 413
        BRN     RUN        ; if n < 413 branch to FIFT
        BRA     DONE       ; else branch to DONE

RUN     .DW     $3100      ; JSRW TET
        .DW     TET

DONE    MOV     R0, R7
        STOP               ; all done

        .ORG    $0600
TRI     LDI     R7, $0
        LDI     R1, $0
        .DW     $3180      ; BRW WY
        .DW     WY
        LDI     R3, $0
        CMI     R0, $0     ; compare argument with 0
        BRZ     END        ; if R0 is 0 return recursive result
        MOV     R4, R0     ; R1 <- R0
        DECR    R4         ; R0 <- R0 - 1
        .DW     $3100      ; JSRW TRI
        .DW     TRI
        ADD     R7, R0
        MOV     R3, R7
        BRA     END
WY      .DW     $31C0      ; BRY YY
        .DW     YY
        CMI     R0, $0     ; compare argument with 0
        BRZ     END        ; if R0 is 0 return recursive result
        MOV     R1, R0     ; R1 <- R0
        DECR    R1         ; R0 <- R0 - 1
        PUSH    R1         ; push argument to the stack
        JSR     TRI        ; recursive call of TRI
        POP     R1         ; pop to reset stack pointer
        ADD     R7, R0
        MOV     R3, R7
        BRA     END
YY      PUSH    R0         ; store register value on the stack
        PUSH    R1
        LDSF    R0, $3     ; load n from the stack
        CMI     R0, $0     ; compare argument with 0
        BRZ     END        ; if R0 is 0 return recursive result
        MOV     R1, R0     ; R1 <- R0
        DECR    R1         ; R0 <- R0 - 1
        PUSH    R1         ; push argument to the stack
        JSR     TRI        ; recursive call of TRI
        POP     R1         ; pop to reset stack pointer
        ADD     R7, R0
END     .DW     $31C0      ; BRY Y
        .DW     Y
        .DW     $3140      ; RTNW
Y       POP     R1         
        POP     R0         ; restore register value from the stack
        RTN
        
        .ORG    $1000
TET     .DW     $3180      ; BRW WYT
        .DW     WYT
        LDI     R3, $0
        CMI     R0, $0     ; compare argument with 0
        BRZ     ENDT       ; if R0 is 0 return recursive result
        MOV     R4, R0     ; R1 <- R0
        DECR    R4         ; R0 <- R0 - 1
        .DW     $3100      ; JSRW TET
        .DW     TET
        MOV     R3, R7
        MOV     R4, R0
        .DW     $3100      ; JSRW TRI
        .DW     TRI
        ADD     R3, R7
        BRA     ENDT
WYT     .DW     $31C0      ; BRY YYT
        .DW     YYT
        CMI     R0, $0     ; compare argument with 0
        BRZ     ENDT       ; if R0 is 0 return recursive result
        MOV     R1, R0     ; R1 <- R0
        DECR    R1         ; R0 <- R0 - 1
        PUSH    R1         ; push argument to the stack
        JSR     TET        ; recursive call of TRI
        POP     R1         ; pop to reset stack pointer
        MOV     R2, R7
        LDI     R7, $0
        PUSH    R0
        JSR     TRI
        POP     R0
        ADD     R7, R2
        MOV     R3, R7
        BRA     ENDT
YYT     PUSH    R0         ; store register value on the stack
        PUSH    R1
        PUSH    R2
        LDSF    R0, $4     ; load n from the stack
        CMI     R0, $0     ; compare argument with 0
        BRZ     ENDT       ; if R0 is 0 return recursive result
        MOV     R1, R0     ; R1 <- R0
        DECR    R1         ; R0 <- R0 - 1
        PUSH    R1         ; push argument to the stack
        JSR     TET        ; recursive call of TRI
        POP     R1         ; pop to reset stack pointer
        MOV     R2, R7
        LDI     R7, $0
        PUSH    R0
        JSR     TRI
        POP     R0
        ADD     R7, R2
ENDT    .DW     $31C0      ; BRY YT
        .DW     YT
        .DW     $3140      ; RTNW
YT      POP     R2
        POP     R1
        POP     R0         ; restore register value from the stack
        RTN
