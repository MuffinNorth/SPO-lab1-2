#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int fractal(int n)
{
  if(n <= 1){
    return 1;
  }
  return n*fractal(n-1);
}

int main() 
{
  int fd[2], nbytes;
  pid_t childpid;
  pipe(fd);

  char readbuffer[80];


  if((childpid = fork()) == -1)
  {
    perror("fork");
    exit(1);
  }

  if(childpid == 0)
  {
    printf("Enter to one process\n");
    close(fd[0]);
    char string[] = "5";
    write(fd[1], string, (strlen(string)+1));
    exit(0);
  }
  else
  {
    printf("Enter to another process\n");
    close(fd[1]);
    nbytes = read(fd[0], readbuffer, sizeof(readbuffer));
    int arg = atoi(readbuffer);
    printf("Fractal %d = %d \n", arg, fractal(arg));
  }
  return 0;
}
