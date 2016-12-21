#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"



int 
main(int argc, char* argv[]) 
{
    int fd = open("ls", O_RDWR);
    int *buf=(int*)sbrk(8192);
    read(fd,buf,100);
    exit();
}
