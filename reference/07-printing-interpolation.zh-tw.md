+++
title = "7. 打印與字符串插值"
weight = 7
+++

# 7. 打印與字符串插值 {#7-da-yin-yu-zi-fu-chuan-cha-zhi}

`print`、`println`、`eprint` 和 `eprintln` 是 `std/io.zc` 中的函數，因此需要列印的程式要匯入該模組。每個函數接受一個字串。

| 函數 | 描述 |
|:---|:---|
| `print(s)` | 打印到 `stdout`，不帶尾隨換行符。 |
| `println(s)` | 打印到 `stdout`，帶尾隨換行符。 |
| `eprint(s)` | 打印到 `stderr`，不帶尾隨換行符。 |
| `eprintln(s)` | 打印到 `stderr`，帶尾隨換行符。 |

```zc
import "std/io.zc"

fn main() {
    print("Loading... ");
    println("done");
    eprintln("warning: no config file");
}
```

#### 字符串插值 (String Interpolation)

只有帶 `f` 前綴的字串才會插值：在 `f"..."` 中，`{}` 裡的每個表達式都會被替換為它的值。在普通的 `"..."` 中，`{expr}` 是編譯錯誤，並提示改用 `f"..."`。

```zc
let x = 42;
let name = "Zen";
println(f"Value: {x}, Name: {name}");
```

**跳脫大括號**：在 `f"..."` 中，使用 `{{` 表示字面量 `{`，使用 `}}` 表示字面量 `}`：

```zc
let json = f"JSON: {{\"key\": \"value\"}}";
// Output: JSON: {"key": "value"}
```

**原始字串 (Raw Strings)**：若要定義完全忽略插值與轉義序列的字串，請在其前加上 `r`（例如 `r"..."`）：

```zc
let regex = r"\w+"; // 包含精確的 \ w +
let raw_json = r'{"key": "value"}'; // 不需要跳脫大括號
```

#### 多行字串 (Multiline Strings)

Zen C 使用 `"""` 分隔符支持原始多行字串區塊。這對於編寫嵌入式語言（如 GLSL、HTML）或在 `comptime` 區塊生成 C 程式碼非常有用，你無需手動轉義換行符與內部引號。

多行字串遵循與普通字串相同的規則：不帶前綴的 `"""..."""` 區塊不會插值，其中的 `{expr}` 是錯誤。加上前綴可以改變這一點：
- `f"""..."""`：像 `f"..."` 一樣插值 `{expr}`。
- `r"""..."""`：原始區塊（不處理跳脫序列）。

```zc
let prompt = """
  Please enter your name:
  Type "exit" to cancel.
""";

let world = "world";
let script = f"""
  fn hello() {{
      println("hello, {world}!");
  }}
""";

let pure_raw = r"""
  Here {braces} are just text, and \n is literally slash-n.
""";
```

#### 讀取輸入

`std/io.zc` 中的 `readln()` 從 `stdin` 讀取一行（不含換行符）。輸入結束時回傳 `NULL`；由呼叫者釋放這一行。

```zc
import "std/io.zc"

fn main() {
    print("How old are you? ");
    let line = readln();
    if line != NULL {
        let age = atoi(line);
        println(f"You are {age} years old.");
        free(line);
    }
}
```
