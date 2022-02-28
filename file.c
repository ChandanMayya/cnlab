#include<stdio.h>
#include<string.h>
int main()
{
FILE *fp;
char data[10]=("hello");
fp=fopen("prg.c","w");
if(fp== NULL)
{
printf("notopend");
}
else
printf("opend\n");
fclose(fp);
printf("closed\n");
}
