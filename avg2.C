#include<stdio.h>
#include<conio.h>
void main()
{
  int a[50],avg=0,i,count,var=0;
  printf("\nEnter no.of elements:");	
  scanf("%d",&count);
  for(i=0;i<count;i++)
  {
	printf("\nEnter an element:");
	scanf("%d",&a[i]);
   }
			
  i=0;
  mov cx,count
  start:
  var=a[i];
  asm mov ax,var
  asm add avg,ax
  asm inc i 
  asm loop start
  fin=(avg/num);
  printf("average:%f",fin);
  getch();
}	
	
  
 				 











