+++
title = "13. Comptime（編譯時執行）"
weight = 13
+++

# 13. Comptime（編譯時執行）

Comptime 允許在編譯時執行 Zen 程式碼，用於產生原始碼、驗證常數和輸出診斷資訊。

```zc
comptime {
    yield("def build_date = \"2024-01-01\";");
}

println(f"Build Date: {build_date}");
```

## 12.1 輔助函式

| 函式 | 描述 |
|:---|---|
| `yield(str)` | 輸出產生的原始碼 |
| `code(str)` | `yield()` 的別名 |
| `compile_error(msg)` | 以錯誤訊息停止編譯 |
| `compile_warn(msg)` | 輸出編譯時警告 |

## 12.2 變數與控制流程

```zc
comptime {
    let sum = 0;
    for i in 0..5 { sum = sum + i; }
    expect(sum == 10, "迴圈正常");
}
```

## 12.3 Comptime 中的斷言

`expect()` 在編譯時驗證條件：

```zc
comptime {
    expect(1 + 1 == 2, "數學運算正常");
}
```

## 12.4 構建元資料

| 常數 | 型別 | 描述 |
|:---|---:|---|
| `__COMPTIME_TARGET__` | string | 平台：`"linux"`、`"windows"` 或 `"macos"` |
| `__COMPTIME_FILE__` | string | 目前原始檔名 |

## 12.5 `@comptime` 函式

標記為 `@comptime` 的函式可以在 comptime 區塊和執行時中呼叫。

## 12.6 提示

在 comptime 中使用原始字串（`r"..."`）可以避免大括號問題：`code(r"fn test() { return 42; }")`。
