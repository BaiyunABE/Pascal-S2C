`program`中的变量映射到全局变量，过程/函数中的变量映射到局部变量，函数返回值固定存于局部变量`_`

`begin/end`与`{}`建立严格映射

`06_func_defn.pas`

```pascal
program main;
var
  a: integer;
  b: integer;
  
function func(p: integer): integer;
begin
  p := p - 1;
  func := p;
end;

begin
  a := 10;
  b := func(a);

  write(b);
end.
```

`06_func_defn.c`

```c
#include <stdio.h>

int a;
int b;

int func(int p)
{
  int _;
  p = p - 1;
  _ = p;
  return _;
}

int main()
{
  a = 10;
  b = func(a);
  printf("%d", b);
  return 0;
}
```

14-10 类型转换

```c
  c = (float)a / (float)b;
```

26-20 输出常量

```c
    printf("%d", 1);
```

