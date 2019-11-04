Data segment
    msg1 db,0dh,0ah, "Enter the year: $"
    msg2 db,0dh,0ah, "Leap year $"
    msg3 db,0dh,0ah, "Not a leap year $"
Data ends

Code segment
    assume CS:Code, DS:Data
    start:
    mov ax, Data
    mov DS, ax
    
    mov dx, offset msg1
    mov ah,09h
    int 21h
    
    call Input
    call Input
    call Input
    mov ah,00h
    mov bl, 0ah
    mul bl
    mov bx, ax
    call Input
    add bx,ax
    mov ax, bx
    mov bl, 04h
    div bl
    cmp ah,00h
                    ;mov bl,64h
                        ;div bl
    je leap
    mov dx, offset msg3
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
    leap: mov dx, offset msg2
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
    
    
    
    Input proc
    mov ah,01h
    int 21h
    cmp al, 41h
    jc skip
    sub al, 07h
    skip: sub al, 30h
    ret
    endp
    
    Output proc
    cmp al,0ah
    jc skip1
    add al,07h
    skip1: add al, 30h
    mov dl,al
    mov ah,02h
    int 21h
    ret 
    endp
Code ends
end start