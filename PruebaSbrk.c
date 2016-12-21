#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define READ_END 0
#define WRITE_END 1

int 
main(int argc, char* argv[]) 
{
    int *a=(int*)sbrk(8192);
 	a[150]=10;
	printf(2,"%d\n",a[150]); 
	sbrk(-4096);
	a[10]=11;
	printf(2,"%d\n",a[10]); 
    /*a[1030]=10;
	printf(2,"ASDASD\n"); */
	sbrk(4096);
	char* ls[1];
	ls[0]=argv[1];
	if (fork()==0)
		exec(ls[0],ls);
	exit();
}
