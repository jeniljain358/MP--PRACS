DATA SEGMENT
       MSG1 DB 10,13,"ENTER NO.OF ELEMENTS:$"
       MSG2 DB 10,13,"ENTER AN ELEMENT:$"
       MSG3 DB 10,13,"1.ASCENDING 2.DESCENDING 3.SEARCH 4.OCCURENCE 5.EXIT ENTER CHOICE:$"
       MSG4 DB 10,13,"SORTED ARRAY IS:$"
       MSG5 DB 10,13,"ENTER ELEMENT TO BE SEARCHED:$"
       MSG6 DB 10,13,"ELEMENT FOUND AT LOC:$"
       MSG7 DB 10,13,"ELEMENT NOT FOUND:$"
       MSG8 DB 10,13,"ENTER ELEMENT TO FIND OCCURENCE:$"
       MSG9 DB 10,13,"OCCURENCE:$"
       CHOICE DB ?
       COUNT DB ?
   DATA ENDS
CODE SEGMENT
 ASSUME CS:CODE,DS:DATA
START:

    MOV AX,DATA
    MOV DS,AX
    
    ;no.of elements
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
    
    ;MOVING COUNT
    MOV COUNT,BL
    
    MOV SI,5000H
    MOV CH,00H
    MOV CL,COUNT
    
 ENTERELEMENT:MOV DX,OFFSET MSG2
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
              MOV [SI],BL  
              INC SI
 LOOP ENTERELEMENT   
                 
    
menu:    
    ;for choice
    MOV DX,OFFSET MSG3
    MOV AH,09H
    INT 21H
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV CHOICE,AL
    
    CMP CHOICE,01H
    JNZ LBLDESC
    CALL MYASC
    JMP MENU
   
LBLDESC:CMP CHOICE,02H
       JNZ LBLSRC
       CALL MYDESC
       JMP MENU
       
LBLSRC:CMP CHOICE,03H
       JNZ LBLOCC
       CALL MYSRC
       JMP MENU

LBLOCC:CMP CHOICE,04H
       JNZ LBLEXIT
       CALL MYOCC
       JMP MENU
             
LBLEXIT:MOV AH,4CH
        INT 21H
 

MYASC PROC
    MOV BL,COUNT
    DEC BL
    MOV DH,00H
    
    LOOP1:MOV SI,5000H
          MOV CH,00H
          MOV CL,COUNT
          DEC CL
          
          LOOP2:MOV AH,[SI]
                INC SI
                MOV AL,[SI]
                
                CMP AH,AL
                JC LAB0
                XCHG AH,AL
                DEC SI
                MOV [SI],AH
                INC SI
                MOV [SI],AL
                LAB0:LOOP LOOP2
         
    INC DH
    CMP DH,BL
    JC  LOOP1   
    
    MOV SI,5000H
    MOV CH,00H
    MOV CL,COUNT

 DISASC:MOV DX,OFFSET MSG4
        MOV AH,09H
        INT 21H
        MOV BL,[SI]
        AND BL,0F0H 
        ROR BL,04H
        CALL OUTPUT
        MOV AH,02H
        INT 21H
        MOV BL,[SI]
        AND BL,0FH
        CALL OUTPUT
        MOV AH,02H
        INT 21H
        INC SI
        LOOP DISASC
    RET
ENDP

MYDESC PROC
    MOV BL,COUNT
    DEC BL
    MOV DH,00H
    
    LOOP3:MOV SI,5000H
          MOV CX,0000H
          MOV CL,COUNT
          DEC CL
          
          LOOP4:MOV AH,[SI]
                INC SI
                MOV AL,[SI]
                
                CMP AH,AL
                JNC LAB1
                XCHG AH,AL
                DEC SI
                MOV [SI],AH
                INC SI
                MOV [SI],AL
                LAB1:LOOP LOOP4
  
         
    INC DH
    CMP DH,BL
    JC  LOOP3   
    
    MOV SI,5000H
    MOV CX,0000H
    MOV CL,COUNT

DISDESC:MOV DX,OFFSET MSG4
        MOV AH,09H
        INT 21H
        MOV BL,[SI]
        AND BL,0F0H 
        ROR BL,04H
        CALL OUTPUT
        MOV AH,02H
        INT 21H
        MOV BL,[SI]
        AND BL,0FH
        CALL OUTPUT
        MOV AH,02H
        INT 21H
        INC SI
        LOOP DISDESC
    RET
ENDP

MYSRC PROC

    MOV DX,OFFSET MSG5
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
    
    MOV SI,5000H
    MOV CX,0000H
    MOV CL,COUNT
    MOV BH,00H
    
    SRC:INC BH
        CMP BL,[SI]
        JE FND
        INC SI
        LOOP SRC
        JMP ERROR1
        
  FND:MOV DX,OFFSET MSG6
      MOV AH,09H
      INT 21H
      
    
        MOV BL,BH
        MOV CL,BL
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
        JMP MENU
        
   ERROR1:MOV DX,OFFSET MSG7
          MOV AH,09H
          INT 21H
          JMP MENU
       RET
ENDP

MYOCC PROC

    MOV DX,OFFSET MSG8
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
    
    MOV SI,5000H
    MOV CX,0000H
    MOV CL,COUNT
    MOV BH,00H
    
    OCC:CMP BL,[SI]
        JNZ LAB5
        INC BH
        LAB5:INC SI
             LOOP OCC
         
    CMP BH,00H
    JNZ FND2
    MOV DX,OFFSET MSG7
    MOV AH,09H
    INT 21H
    
    JMP MENU
    
   FND2:MOV DX,OFFSET MSG9
        MOV AH,09H
        INT 21H
         
    
        MOV BL,BH
        MOV CL,BL
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
        
        RET
 ENDP

INPUT PROC
    CMP AL,41H
    JC LAB7
    SUB AL,07H
    LAB7:SUB AL,30H
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
     
        
           
        
          
             
    
    
   

    
          
   
    
          
     
    
    
    
       
       
       