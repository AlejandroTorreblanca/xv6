#include "types.h"
#include "user.h"


int 
main(int argc, char *argv[]){
	int fd1,fd2;
	fd1=open("cat", 0);	
	if(fd1<0){
		printf(2,"No se ha podido abrir\n");
		exit();
	}
	fd2=-1;
	printf(2,"fd2=-1: %d\n",dup2(fd1,fd2));
	fd2=1000;
	printf(2,"fd2=1000: %d\n",dup2(fd1,fd2));
	fd2=fd1;
	printf(2,"fd2=fd1: %d %d\n",fd1,dup2(fd1,fd2));
	fd2=(fd1+5)%10;
	printf(2,"fd2!=fd1: %d\n",dup2(fd1,fd2));
	fd1=fd1+1;
	printf(2,"fd1 no abierto: %d\n",dup2(fd1,fd2));
	fd1=-1;
	fd2=2;
	printf(2,"fd1=-1: %d\n",dup2(fd1,fd2));	
	exit();
}
