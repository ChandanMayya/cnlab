#include<stdio.h>
void main(){
	int inc,out,buf_siz,store=0,n;
	printf("Enter the number of packets:\t");
	scanf("%d",&n);
	printf("Enter the Outgoing range:\t");
	scanf("%d",&out);
	
	printf("Enter the Buffer size:\t");
	scanf("%d",&buf_siz);
	while(n!=0){
		printf("Incoming packet..\t");
		scanf("%d",&inc);
		if(inc<=(buf_siz-store))
		{
			store+=inc;
			printf("Bucket Buffer size %d out of %d\n",store,buf_siz);
		}else{
			printf("dropped %d\n",inc-(buf_siz-store));
			store=buf_siz;
		}
		store=store-out;
		printf("Stored value%d\n",store);
		n--;
	}
}
