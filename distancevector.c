#include<stdio.h>
int a[50][50],n;
int min(int a,int b)
{
 return a<b?a:b;
}
 void calculation()
 { 
  int i,j,k;
  for(k=1;k<=n;k++)
  {
   for(i=1;i<=n;i++)
   {
    for(j=1;j<=n;j++)
    {
     a[i][j]=min(a[i][j],a[i][k]+a[k][j]);
    }
   }
  }
 }
 int main()
 {
  int i,j,n;
  printf("Enter the limit of the nodes");
  scanf("%d",&n);
  printf("enter the matrix eliments");
  for(i=1;i<=n;i++)
   for(j=1;j<=n;j++)
   {
    scanf("%d",&a[i][j]);
    if(a[i][j]==0)
     a[i][j]=999;
    if(i==j)
     a[i][j]=0;
   }
  calculation();
   printf("your matrix is\n");
   for(i=1;i<=n;i++)
   {
    for(j=1;j<=n;j++)
    {
     printf("%d",a[i][j]);
    }
      printf("\n");
   }
  return 0;
  }
