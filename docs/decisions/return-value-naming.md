# 函数返回值变量命名方案讨论

## 背景
课程要求 Pascal-S 语言需要支持含有下划线的标识符，这使得原先的将函数返回值变量命名为 `_` 的方案可能导致冲突。

## 参考测试用例
`57_many_params.pas`:

```pascal
function param32_rec(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,
    a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,
    a31,a32: integer): integer;
begin
    if a1 = 0 then
        param32_rec := a2
    else
        param32_rec := param32_rec(a1 - 1, (a2 + a3) mod 998244353, a4, a5, a6, a7, a8, a9,
            a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
            a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
            a32, 0);
end;
```

## 方案对比

| 方案 | 描述                                   | 优点           | 缺点                       | 实现复杂度 | 对调试影响 | 备注             |
| ---- | -------------------------------------- | -------------- | -------------------------- | ---------- | ---------- | ---------------- |
| 1    | 返回值变量命名为 `_`                   | 简洁统一       | 与用户标识符可能冲突       | 低         | 无         | 违反新需求       |
| 2    | 定义与函数名相同的变量存放返回值       | 符合Pascal语义 | 不支持递归调用自身         | 中         | 清晰       | 助教推荐         |
| 3    | 所有原符号前加 `_`，返回值用 `_`       | 无冲突         | 需要修改所有变量，开销大   | 高         | 可读性下降 |                  |
| 4    | 原符号中的 `_` 换成 `__`，返回值用 `_` | 无冲突         | 需要处理源代码中所有下划线 | 中         | 可读性略降 | 可用其他低频字符 |
| 5    | 选不冲突的名字，冲突则重选             | 保证不冲突     | 命名不统一，调试困难       | 中         | 差         |                  |
| 6    | 抛弃命名信息，生成时重分配             | 无冲突         | 丢失名字信息，调试困难     | 高         | 差         |                  |
| 7    | 目标语言改为 C++，用作用域解析         | 递归支持好     | 改变目标语言               | 高         | 清晰       | 可能不符合要求   |

方案1

```c
int param32_rec(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10,
    int a11, int a12, int a13, int a14, int a15, int a16, int a17, int a18, int a19, int a20,
    int a21, int a22, int a23, int a24, int a25, int a26, int a27, int a28, int a29, int a30,
    int a31, int a32)
{
    int _;
    if (a1 == 0)
        _ = a2;
    else
        _ = param32_rec(a1 - 1, (a2 + a3) % 998244353, a4, a5, a6, a7, a8, a9,
            a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
            a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
            a32, 0);
    return _;
}
```

方案2

```c
int param32_rec(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10,
    int a11, int a12, int a13, int a14, int a15, int a16, int a17, int a18, int a19, int a20,
    int a21, int a22, int a23, int a24, int a25, int a26, int a27, int a28, int a29, int a30,
    int a31, int a32)
{
    int param32_rec;
    if (a1 == 0)
        param32_rec = a2;
    else
        param32_rec = param32_rec(a1 - 1, (a2 + a3) % 998244353, a4, a5, a6, a7, a8, a9,
            a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
            a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
            a32, 0);
    return param32_rec;
}
```

方案3

```c
int param32_rec(int _a1, int _a2, int _a3, int _a4, int _a5, int _a6, int _a7, int _a8, int _a9, int _a10,
    int _a11, int _a12, int _a13, int _a14, int _a15, int _a16, int _a17, int _a18, int _a19, int _a20,
    int _a21, int _a22, int _a23, int _a24, int _a25, int _a26, int _a27, int _a28, int _a29, int _a30,
    int _a31, int _a32)
{
    int _;
    if (_a1 == 0)
        _ = _a2;
    else
        _ = param32_rec(_a1 - 1, (_a2 + _a3) % 998244353, _a4, _a5, _a6, _a7, _a8, _a9,
            _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20,
            _a21, _a22, _a23, _a24, _a25, _a26, _a27, _a28, _a29, _a30, _a31,
            _a32, 0);
    return _;
}
```

方案4

```c
int param32__rec(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10,
    int a11, int a12, int a13, int a14, int a15, int a16, int a17, int a18, int a19, int a20,
    int a21, int a22, int a23, int a24, int a25, int a26, int a27, int a28, int a29, int a30,
    int a31, int a32)
{
    int _;
    if (a1 == 0)
        _ = a2;
    else
        _ = param32__rec(a1 - 1, (a2 + a3) % 998244353, a4, a5, a6, a7, a8, a9,
            a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
            a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
            a32, 0);
    return _;
}
```

方案5

```c
int param32_rec(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10,
    int a11, int a12, int a13, int a14, int a15, int a16, int a17, int a18, int a19, int a20,
    int a21, int a22, int a23, int a24, int a25, int a26, int a27, int a28, int a29, int a30,
    int a31, int a32)
{
    int a33;
    if (a1 == 0)
        a33 = a2;
    else
        a33 = param32_rec(a1 - 1, (a2 + a3) % 998244353, a4, a5, a6, a7, a8, a9,
            a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
            a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
            a32, 0);
    return a33;
}
```

方案6

```c
int t0(int t1, int t2, int t3, int t4, int t5, int t6, int t7, int t8, int t9, int t10,
    int t11, int t12, int t13, int t14, int t15, int t16, int t17, int t18, int t19, int t20,
    int t21, int t22, int t23, int t24, int t25, int t26, int t27, int t28, int t29, int t30,
    int t31, int t32)
{
    int t33;
    if (t1 == 0)
        t33 = t2;
    else
        t33 = t0(t1 - 1, (t2 + t3) % 998244353, t4, t5, t6, t7, t8, t9,
            t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20,
            t21, t22, t23, t24, t25, t26, t27, t28, t29, t30, t31,
            t32, 0);
    return t33;
}
```

方案7

```cpp
int param32_rec(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10,
    int a11, int a12, int a13, int a14, int a15, int a16, int a17, int a18, int a19, int a20,
    int a21, int a22, int a23, int a24, int a25, int a26, int a27, int a28, int a29, int a30,
    int a31, int a32)
{
    int param32_rec;
    if (a1 == 0)
        param32_rec = a2;
    else
        param32_rec = ::param32_rec(a1 - 1, (a2 + a3) % 998244353, a4, a5, a6, a7, a8, a9,
            a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
            a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
            a32, 0);
    return param32_rec;
}
```



## 关键约束

1. ✅ 必须支持含下划线的标识符（课程要求）
2. ✅ 必须支持递归调用（Pascal-S支持递归）
3. ✅ 生成代码应便于调试（可读性好）
4. ⚠️ 实现复杂度需在可控范围

## 讨论要点
- 方案2 如何解决递归调用？(可用静态变量？)
- 方案4 中，选择什么转义字符开销最小？
- 是否需要考虑生成代码的用户调试体验？

## 决策
（待讨论后填写）

## 更新记录
- 2026.03.19：首次整理，与助教讨论后提出7种方案