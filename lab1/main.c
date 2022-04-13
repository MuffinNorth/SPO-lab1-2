#include<stdio.h>

int fractal(int n){
  if(n <= 1){
    return 1;
  }
  return n*fractal(n - 1);
}



int main(int argc, char **argv){
  printf("Fractal %d = %d \n", 5, fractal(5));
  return 0;
}
