#include<stdio.h>
#include<conio.h>
void main()
{
	int a,b,choice,res1,res2,res3,quo,rem;
	printf("\n 1.Addition 2.Subtraction 3.Multiplication 4.Division 5.Exit Enter choice");
	scanf("\n%d",&choice);
	printf("Enter first no.");
	scanf("%d",&a);
	printf("\nEnter second no.");
	scanf("%d",&b);
	asm mov bx,a
	asm mov cx,b
	if(choice==1)
	{
		asm add bx,cx
		asm mov res1,bx
		printf("\nThe addition is:%d",res1);
	}
	else if(choice==2)
	     {	
		asm sub bx,cx
		asm mov res2,bx
		printf("\nThe subtraction is:%d",res2);
	      }
       else if(choice==3)
	      { 
	   	
		asm mov ax,bx
		asm mul cx
		asm mov res3,ax
		printf("\nThe multiplication is:%d",res3);
		}
	else if(choice==4)
	     {
		asm mov ax,bx
		asm div cl
		asm mov bx,ax
		asm mov quo,bx
		asm mov al,00h
		asm mov rem,ax
		printf("\nThe remainder is:%d",rem);
		printf("\nThe quotient is:%d",quo);
		}
	else if(choice==5)
	     {
		asm mov ah,4ch
		asm int 21h
	      }
		
	getch();
}	
		
			
										