#include<stdio.h>
#include<conio.h>

void main()
{

int count,ID;
clrscr();
printf("Enter the size of cursor:");
scanf("%d",&count);
printf("1.Increment\n 2.Decrement\n 3.Disable\n");
scanf("%d",&ID);
if(ID==1)
{
   asm mov cx,count;
   asm mov ah,01h;
   asm inc cl;
   asm int 10h;
   printf("\n\n\n");
}
else if(ID==2)
{
 asm mov cx,count;
 asm mov ah,01h;
 asm dec cl;
 asm int 10h;
 printf("\n\n\n");
}
else
{
 asm mov ah,01h;
 asm int 10h;
}
getch();
}			
		
