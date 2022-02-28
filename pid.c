#include<stdio.h>
#include<sys/types.h>
#include<unistd.h>
int main()
{
pid_t processid,parentid;
processid=getpid();
parentid=getppid();
printf("processid %d\n",processid);
printf("parentid %d\n",parentid);
}


