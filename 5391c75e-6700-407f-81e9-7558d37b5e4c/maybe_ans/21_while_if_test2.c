#include <stdio.h>

int ifWhile()
{
  int a, b;
  int ifWhile_result = 0; // 用于暂存函数返回值
  a = 0;
  b = 1;
  if (a == 5)
  {
    for (b = 1; b <= 3; b++)
    {
      // 循环体为空
    }
    b = b + 25;
    ifWhile_result = b; // 赋值给暂存变量
  }
  else
  {
    for (a = 0; a <= 4; a++)
    {
      b = b * 2;
    }
    ifWhile_result = b; // 赋值给暂存变量
  }
  return ifWhile_result; // 返回暂存变量
}

int main()
{
  printf("%d", ifWhile());
  return 0;
}