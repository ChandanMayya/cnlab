#include<stdio.h>
#include<string.h>
void main()
{
char a[10],b[20];
printf("enter the charecter");
scanf("%s",&a);
printf("enter the charecter");
scanf("%s",&b);
strcat(a,b);
printf("cancate of two charecter %s",a);
}
