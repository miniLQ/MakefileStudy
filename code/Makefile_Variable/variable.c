#include <stdio.h>
#include "defs.h"

int main()
{
    int a = 10;
    int b = 2;
    int c1,c2;
    c1 = add(a, b);
    c2 = minus(a, b);
    printf("a+b=%d\n", c1);
    printf("a-b=%d\n", c2);
}    