DATA SEGMENT
    MSG1 DB 10,13,"ENTER FIRST NUMBER:$"
    MSG2 DB 10,13,"ENTER SECOND NUMBER:$"
    RES1 DB 10,13,"GCD: $"
    RES2 DB 10,13,"LCM: $"
    NUM1 DB ?
    NUM2 DB ?
    
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE ,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
       
    MOV DX,OFFSET MSG1
    MOV AH,09H
    INT 21H
    
    MOV AH,01H
    INT 21H
    CALL INPUT
    ROL AL,04H
    MOV BL,AL
    
    MOV AH,01H
    INT 21H
    CALL INPUT
    ADD BL,AL
    MOV NUM1,BL
    
    MOV DX,OFFSET MSG2
    MOV AH,09H
    INT 21H
    
    MOV AH,01H
    INT 21H
    CALL INPUT
    ROL AL,04H
    MOV CL,AL

 
    MOV AH,01H
    INT 21H
    CALL INPUT
    ADD CL,AL
    MOV NUM2,CL
    
    MOV AL,BL
    MUL CL
    
    
 L1:CMP BL,CL
    JC L2
    SUB BL,CL
    JMP L3
    L2:SUB CL,BL
 L3:CMP BL,CL
    JNZ L1
   
    MOV CL,BL
  
    MOV DX,OFFSET RES1
    MOV AH,09H
    INT 21H
    
   AND BL,0F0H
   ROR BL,04H
   CALL OUTPUT
   MOV AH,02H
   INT 21H
   
  MOV BL,CL
  AND BL,0FH
  CALL OUTPUT
  MOV AH,02H
  INT 21H
    
 ;LCM
 ;     MOV AL,NUM1
     ;MUL NUM2
     DIV CL
     
     MOV BL,AL
     MOV DX,OFFSET RES2
     MOV AH,09H
    INT 21H
        
   AND BL,0F0H
   ROR BL,04H
   CALL OUTPUT
   MOV AH,02H
   INT 21H
   
   MOV BL,AL
   AND BL,0FH
   CALL OUTPUT
   MOV AH,02H
   INT 21H    
    
   MOV AH,4CH
   INT 21H
    
    
INPUT PROC
    CMP AL,41H
    JC LBL
    SUB AL,07H
    LBL:SUB AL,30H
    RET
ENDP

OUTPUT PROC
    CMP BL,0AH
    JC LBL2
    ADD BL,07H
    LBL2:ADD BL,30H
    MOV DL,BL
    RET
ENDP

CODE ENDS
END START
    
 