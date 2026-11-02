+++
title = "13. Comptime（编译时执行）"
weight = 13
+++

# 13. Comptime（编译时执行）

Comptime 允许在编译时执行 Zen 代码，用于生成源代码、验证常量和输出诊断信息。

```zc
comptime {
    yield("def build_date = \"2024-01-01\";");
}

println(f"Build Date: {build_date}");
```

## 12.1 辅助函数

| 函数 | 描述 |
|:---|---|
| `yield(str)` | 输出生成的源代码 |
| `code(str)` | `yield()` 的别名 |
| `compile_error(msg)` | 以错误信息停止编译 |
| `compile_warn(msg)` | 输出编译时警告 |

## 12.2 变量与控制流

```zc
comptime {
    let sum = 0;
    for i in 0..5 { sum = sum + i; }
    expect(sum == 10, "循环正常");
}
```

## 12.3 Comptime 中的断言

`expect()` 在编译时验证条件：

```zc
comptime {
    expect(1 + 1 == 2, "数学运算正常");
}
```

## 12.4 构建元数据

| 常量 | 类型 | 描述 |
|:---|---:|---|
| `__COMPTIME_TARGET__` | string | 平台：`"linux"`、`"windows"` 或 `"macos"` |
| `__COMPTIME_FILE__` | string | 当前源文件名 |

## 12.5 `@comptime` 函数

标记为 `@comptime` 的函数可以在 comptime 块和运行时中调用。

## 12.6 提示

在 comptime 中使用原始字符串（`r"..."`）可以避免花括号问题：`code(r"fn test() { return 42; }")`。
