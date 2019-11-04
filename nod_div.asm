DATA SEGMENT
    count db ?
    MSG1 DB,10,13,"ENTER DIVIDEND:$"
    MSG2 DB,10,13,"ENTER DIVISOR:$"
    RES1 DB 10,13,"QUOTIENT:$"
    RES2 DB 10,13,"REMAINDER:$"
DATA ENDS
CODE SEGMENT
 ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
   MOV DS,AX
  
  MOV DX,OFFSET MSG1
  MOV AH,09H 
  INT 21H
  MOV AH,01H
  INT 21H
  CALL ASCIITOHEX
  ROL AL,04H
   MOV BL,AL
   
   MOV AH,01H
   INT 21H
   CALL ASCIITOHEX
   ADD BL,AL
   
   MOV DX,OFFSET MSG2
   MOV AH,09H
   INT 21H
   MOV AH,01H
   INT 21H
  CALL ASCIITOHEX
   ROL AL,04H
   MOV CL,AL
   
   MOV AH,01H
   INT 21H
   CALL ASCIITOHEX
   ADD CL,AL
   
   MOV COUNT,00H
   
   L1:CMP BL,CL
      JC L2
      SUB BL,CL
      INC COUNT
      JMP L1
    
    L2:  MOV CL,BL
         MOV DX,OFFSET RES2
        MOV AH,09H
        INT 21H
         MOV BL,CL
       CALL DISP
       
        MOV DX,OFFSET RES1
       MOV AH,09H
       INT 21H
        
       MOV BL,COUNT
       CALL DISP
      
       
       MOV AH,4CH
       INT 21H
       
      
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
    JC LBL1
    SUB AL,07H
    LBL1:SUB AL,30H
    RET
ENDP

HEXTOASCII PROC
    CMP BL,0AH
    JNZ LBL2
    ADD BL,07H
    LBL2:ADD BL,30H
    RET
ENDP
CODE ENDS
END START
        
    
        
  
        
      
     
     
           
     
       
  
  
  