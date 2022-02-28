#include<stdio.h>
#include<sys/types.h>
#include<string.h>
void main ()
{
char databit[240];
int i=0,count=0;
printf("enter the  bitchar");
scanf("%s",databit);
for(i=0;i<strlen(databit);i++)
{
if(databit[i]=='1')
count ++;
else
count=0;
printf("%c",databit[i]);
if(count==5)
{
printf("0");
count=0;
}
}
}


