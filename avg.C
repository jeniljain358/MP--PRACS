#include<stdio.h>
#include<conio.h>
void main()
{
	int avg=0,count=0,i,j,num;
	printf("\n Enter no.of elements:");
	scanf("%d",&count);
	asm mov si,5000h
	for(i=1;i<=count;i++)
	{
		printf("\nEnter a number:");
		scanf("%d",&num);
		asm mov ax,num
		asm mov [si],ax
		asm inc si
	}

	asm mov si,5000h
	for(j=1;j<=count;j++)
	{
		asm mov bl,[si]
		asm add al,bl
		asm inc si
	}
	 asm mov ah,00h
	 asm div count
	 asm mov avg,ax
	printf("\n Average: %d",avg);
	getch();
}