DATA SEGMENT
    MSG1 DB 10,13,"ENTER FIRST STRING: $"
    MSG2 DB 10,13,"ENTER SECOND SRING: $"
    MSG3 DB 10,13,"CONCATENATION: $"
    LEN1 DB ?
    LEN2 DB ?
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    
    MOV DX,OFFSET MSG1
    MOV AH,09H
    INT 21H
    
    MOV SI,5000H
    MOV CH,00H

READ1:MOV AH,01H
     INT 21H
     MOV [SI],AL
     CMP AL,0DH
     JE LBL
     INC SI
     INC LEN1
     JMP READ1
     
LBL: 
    MOV DX,OFFSET MSG1
    MOV AH,09H
    INT 21H
    
MOV DI,7000H
MOV CH,00H

READ2:MOV AH,01H
     INT 21H
     MOV [DI],AL
     CMP AL,0DH
     JE LBL2
     INC DI
     INC LEN2
     JMP READ2

LBL2:MOV DI,7000H     
    MOV CL,LEN2       
    MOV CH,00H
    
 CONCAT:MOV BL,[DI]
        MOV [SI],BL
        INC SI
        INC DI
        LOOP CONCAT
        
     MOV DX,OFFSET MSG3
    MOV AH,09H
    INT 21H
      
      
   MOV CL,LEN1
   ADD CL,LEN2
    
   MOV SI,5000H
    MOV CH,00H
 
 LOOP1:MOV BL,[SI]
       MOV DL,BL
       MOV AH,02H
        INT 21H
        INC SI
        LOOP LOOP1
      
      MOV AH,4CH
      INT 21H
    
  CODE ENDS
END START  