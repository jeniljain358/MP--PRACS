DATA SEGMENT
    MSG1 DB 10,13,"1.READ 2.DISPLAY 3.LENGTH 4.REVERSE 5.PALINDROME 6.EXIT ENTER CHOICE: $"
    MSG2 DB 10,13,"ENTER A STRING: $"
    MSG3 DB 10,13,"ENTERED STRING: $"
    MSG4 DB 10,13,"LENGTH OF STRING: $"
    MSG5 DB 10,13,"REVERSE OF STRING: $"
    MSG6 DB 10,13,"PALINDROME! $"
    MSG7 DB 10,13,"NOT A PALINDROME! $"
    CHOICE DB ?
    LEN DB ?
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
MENU:    
    
    MOV DX,OFFSET MSG1
    MOV AH,09H
    INT 21H
    
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV CHOICE,AL
    
    CMP AL,01H
    JNZ DISP
    CALL MYREAD
    JMP MENU
    
DISP:CMP AL,02H
     JNZ LEN1
     CALL MYDISP
     JMP MENU
     
LEN1:CMP AL,03H
    JNZ REV
    CALL MYLEN
    JMP MENU

REV:CMP AL,04H
    JNZ PALIN
    CALL MYREV
    JMP MENU

PALIN:CMP AL,05H
      JNZ EXITP
      CALL MYPALIN
      JMP MENU
      
EXITP:CMP AL,06H
      MOV AH,4CH
      INT 21H
      
JMP MENU  

MYREAD PROC
    MOV DX,OFFSET MSG2
    MOV AH,09H
    INT 21H
    
    MOV SI,5000H
    MOV DI,5000H
    MOV CX,0000H
    
    LOOP1:MOV AH,01H
          INT 21H  
          CMP  AL,0DH
          JE  LBL1
          INC CX  
          MOV [SI],AL
          MOV [DI],AL
          
          INC SI
          INC DI
          JMP  LOOP1
          
         LBL1:MOV LEN,CL 
         RET
ENDP

MYDISP PROC

    MOV DX,OFFSET MSG3
    MOV AH,09H
    INT 21H
    
    MOV SI,5000H
    MOV CH,00H
    MOV CL,LEN
    
    
    LOOP2:MOV BL,[SI]
          MOV DL,BL
          MOV AH,02H
          INT 21H
          INC SI
          LOOP LOOP2
    RET
ENDP

MYLEN PROC
    MOV DX,OFFSET MSG4
    MOV AH,09H
    INT 21H
    
    MOV BL,LEN
    AND BL,0F0H
    ROR BL,04H
    CALL OUTPUT
    MOV DL,BL
    MOV AH,02H
    INT 21H
    
    MOV BL,LEN
    AND BL,0FH
    CALL OUTPUT
    MOV DL,BL
    MOV AH,02H
    INT 21H
    RET
ENDP

MYREV PROC
    
    MOV DX,OFFSET MSG5
    MOV AH,09H
    INT 21H    
    
    MOV SI,5000H
    MOV CH,00H
    MOV CL,LEN
    ADD SI,CX
    DEC SI
    
    LOOP3:MOV DL,[SI]
          MOV AH,02H
          INT 21H
          DEC SI
          LOOP LOOP3
     RET
ENDP

MYPALIN PROC
    MOV SI,5000H
    MOV DI,5000H
    MOV CH,00H 
    MOV CL,LEN
    ADD DI,CX
    DEC DI
    
    LOOP4:MOV AL,[SI]
          CMP AL,[DI]
          JNZ NOTPAL
          INC SI
          DEC DI
          LOOP LOOP4
          
           MOV DX,OFFSET MSG6
           MOV AH,09H
           INT 21H  
           RET
    
        
    NOTPAL:MOV DX,OFFSET MSG7
           MOV AH,09H
           INT 21H 
          RET
ENDP

OUTPUT PROC
    CMP BL,0AH
    JC LAB8
    ADD BL,07H
    LAB8:ADD BL,30H
    MOV DL,BL
    RET
ENDP

CODE ENDS
END START
     
        

   
    
          
       
                    
            
    
        
    
             
    
    
    
    