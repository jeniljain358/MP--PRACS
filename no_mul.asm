DATA SEGMENT
    MSG1 DB,10,13,"ENTER 1ST NUMBER:$"
    MSG2 DB,10,13,"ENTER 2ND NUMBER:$"
    RES DB,10,13,"RESULT IS:$"
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX   
   
   MOV DX,OFFSET MSG1
   MOV AH,09H
   INT 21H
   CALL INPUT 
   MOV CL,BL

   MOV DX,OFFSET MSG2
   MOV AH,09H
   INT 21H
   CALL INPUT 
   MOV BL,AL
   
   MOV AL,CL
   DEC BL
LBL:ADD AL,CL
    DEC BL
    CMP BL,00H
    JNZ LBL 
    
    MOV BL,AL
     
    MOV DX,OFFSET RES
    MOV AH,09H
    INT 21H
    
    CALL DISP
    
    MOV AH,4CH      
    INT 21H
        
INPUT PROC
    MOV AH,01H
    INT 21H
    CALL ASCIITOHEX
    MOV BL,AL
    ROL BL,04H
    MOV AH,01H
    INT 21H
    CALL ASCIITOHEX
    ADD BL,AL
    RET
ENDP

DISP PROC
    MOV CL,BL
    AND BL,0F0H
    ROR BL,04H
    CALL HEXTOASCII
    MOV DL,BL
    MOV AH,02H
    INT 21H
    
    MOV BL,CL
    AND BL,0FH
    CALL HEXTOASCII
    MOV DL,BL
    MOV AH,02H
    INT 21H
    RET
ENDP

ASCIITOHEX PROC
    CMP AL,41H
    JC L1
    SUB AL,07H
    L1:SUB AL,30H
    RET
ENDP

HEXTOASCII PROC
    CMP BL,0AH
    JNZ L2
    ADD BL,07H
    L2:ADD BL,30H
    RET
ENDP
CODE ENDS
END START
    
    
       
   
     