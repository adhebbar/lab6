        .ORG    $0000
        LDI     R0, $0     ; initialize R0 with the value 0
        LDSP    R0         ; write R0 to the SP register
        BRA     INITN      ; branch to the first line of your main code
      
        .ORG    $0100
INITN   LDI     R4, $3     ; store n in R1
        BRA     MAIN       ; branch to main code at $0200
        
        .ORG    $0200
MAIN    CMI     R4, $49    ; compare n with 413
        BRN     FIFT       ; if n < 413 branch to FIFT
        BRA     DONE       ; else branch to DONE

FIFT    .DW     $3100      ; JSRW TET
        .DW     TET

DONE    MOV     R0, R7
        STOP               ; all done

        .ORG    $0600
TRI     LDI     R3, $0
        CMI     R0, $0     ; compare argument with 0
        BRZ     END        ; if R0 is 0 return recursive result
        MOV     R4, R0     ; R1 <- R0
        DECR    R4         ; R0 <- R0 - 1
        .DW     $3100      ; JSRW TRI
        .DW     TRI
        ADD     R7, R0
        MOV     R3, R7
        
END     .DW     $3140      ; RTNW

        .ORG    $1000
TET     LDI     R3, $0
        CMI     R0, $0     ; compare argument with 0
        BRZ     ENDE       ; if R0 is 0 return recursive result
        MOV     R4, R0     ; R1 <- R0
        DECR    R4         ; R0 <- R0 - 1
        .DW     $3100      ; JSRW TET
        .DW     TET
        MOV     R3, R7
        MOV     R4, R0
        .DW     $3100      ; JSRW TRI
        .DW     TRI
        ADD     R3, R7

ENDE    .DW     $3140      ; RTNW


