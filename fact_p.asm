data segment
    msg0 db 10,13,"Enter a number: $"
    msg1 db 10,13,"Factorial is $"
    num db ?
    res dw ?
data ends
code segment
assume ds:data,cs:code
start:
mov ax,data
mov ds,ax

mov dx,offset msg0
mov ah,09h
int 21h

mov ah,01h
int 21h
call convert
rol al,04h
mov bl,al

mov ah,01h
int 21h
call convert
add bl,al

mov num,bl
call fact

mov dx,offset msg1
mov ah,09h
int 21h

mov bx,res
and bx,0F000H
ror bx,12
call opconvert

mov bx,res
and bx,0F00h
ror bx,08
call opconvert

mov bx,res
and bx,00F0h
ror bx,04
call opconvert

mov bx,res
and bx,000Fh
call opconvert

mov ah,4ch
int 21h

convert proc
cmp al,41h
jc label1
sub al,07h
label1:
sub al,30h
ret 
endp

opconvert proc
cmp bx,000Ah
jc label2
add bx,0007h

label2:
    add bx,0030h

mov dx,0000h
mov dl,bl
mov ah,02h
int 21h
ret
endp



fact proc
mov cx,0000h
mov cl,num
mov ax,0001h

repeat:
mul cx
loop repeat
mov res,ax
ret
endp

code ends
end start


    
    