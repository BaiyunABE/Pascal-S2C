# 部分翻译规则标注

1. `program`中的变量为全局变量，`printf`根据符号表查找类型填写格式串，故符号表需要存储变量的类型

`00_main.pas`

```pascal
program main;
var
  a: integer;
begin
  a := 3;
  write(a);
end.
```

`00_main.c`

```c
#include <stdio.h>

int a;

int main()
{
  a = 3;
  printf("%d", a);
  return 0;
}
```



2. `const`修饰变量可能不会明确指出类型，需要由词法分析器推断

`04_const_var_defn2.pas`

```pascal
program main;
const
  a = 10;
  b = 5;
begin
  write(b);
end.
```

`04_const_var_defn2.c`

```c
#include <stdio.h>

const int a = 10;
const int b = 5;

int main()
{
  printf("%d", b);
  return 0;
}
```



3. `procedure`/`function`中的变量为局部变量，函数返回值固定存于局部变量`_`，由于Pascal不允许变量名包含下划线，故不会冲突

`06_func_defn.pas`

```pascal
function func(p: integer): integer;
begin
  p := p - 1;
  func := p;
end;
```

`06_func_defn.c`

```c
int func(int p)
{
  int _;
  p = p - 1;
  _ = p;
  return _;
}
```



4. `/`为实数除法，`div`为整数除法

`14_div.pas`

```pascal
c := a / b;
```

`14_div.c`

```c
c = (float)a / (float)b;
```



5. `begin/end`与`{}`等价

`20_if_test5.pas`

```pascal
if (a = 5) then
begin
  if (b = 10) then
    a := 25;
end
else
  a := a + 15;
```

`20_if_test5.c`

```c
if (a == 5)
{
  if (b == 10)
    a = 25;
}
else
  a = a + 15;
```



6. Pascal数组可任意指定下界，需要存储数组的下界`lb`和上界`ub`，数组长度为`ub - lb + 1`，对下标`i`的访问需要修正为`i - lb`

`42_color.pas`

```pascal
cns: array[1..19] of integer;

for i := 0 to n - 1 do
begin
  read(list[i]);
  cns[list[i]] := cns[list[i]] + 1;
end;

ans := dfs(cns[1], cns[2], cns[3], cns[4], cns[5], 0);
```

`42_color.c`

``` c
int cns[19];

for (i = 0; i <= n - 1; i++)
{
  scanf("%d", &list[i]);
  cns[list[i] - 1] = cns[list[i] - 1] + 1;
}

ans = dfs(cns[1 - 1], cns[2 - 1], cns[3 - 1], cns[4 - 1], cns[5 - 1], 0);
```



7. 用指针实现引用传递

`43_exgcd.pas`

```pascal
function exgcd(a, b: integer; var x, y: integer): integer;
var
  t, r: integer;
begin
  if b = 0 then
  begin
    x := 1;
    y := 0;
    exgcd := a;
  end
  else
  begin
    r := exgcd(b, a mod b, x, y);
    t := x;
    x := y;
    y := (t - (a div b) * y);
    exgcd := r;
  end;
end;
```

`43_exgcd.c`

```c
int exgcd(int a, int b, int *x, int *y)
{
  int _;
  int t, r;
  if (b == 0)
  {
    *x = 1;
    *y = 0;
    _ = a;
  }
  else
  {
    r = exgcd(b, a % b, &*x, &*y);
    t = *x;
    *x = *y;
    *y = (t - (a / b) * *y);
    _ = r;
  }
  return _;
}
```

