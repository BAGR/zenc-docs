+++
title = "7. 打印与字符串插值"
weight = 7
+++

# 7. 打印与字符串插值 {#7-da-yin-yu-zi-fu-chuan-cha-zhi}

`print`、`println`、`eprint` 和 `eprintln` 是 `std/io.zc` 中的函数，因此需要打印的程序要导入该模块。每个函数接受一个字符串。

| 函数 | 描述 |
|:---|:---|
| `print(s)` | 打印到 `stdout`，不带尾随换行符。 |
| `println(s)` | 打印到 `stdout`，带尾随换行符。 |
| `eprint(s)` | 打印到 `stderr`，不带尾随换行符。 |
| `eprintln(s)` | 打印到 `stderr`，带尾随换行符。 |

```zc
import "std/io.zc"

fn main() {
    print("Loading... ");
    println("done");
    eprintln("warning: no config file");
}
```

#### 字符串插值 (String Interpolation)

只有带 `f` 前缀的字符串才会插值：在 `f"..."` 中，`{}` 里的每个表达式都会被替换为它的值。在普通的 `"..."` 中，`{expr}` 是编译错误，并提示改用 `f"..."`。

```zc
let x = 42;
let name = "Zen";
println(f"Value: {x}, Name: {name}");
```

**转义花括号**：在 `f"..."` 中，使用 `{{` 表示字面量 `{`，使用 `}}` 表示字面量 `}`：

```zc
let json = f"JSON: {{\"key\": \"value\"}}";
// Output: JSON: {"key": "value"}
```

**原始字符串 (Raw Strings)**：若要定义完全忽略插值与转义序列的字符串，请在其前加上 `r`（例如 `r"..."`）：

```zc
let regex = r"\w+"; // 包含精确的 \ w +
let raw_json = r'{"key": "value"}'; // 不需要转义大括号
```

#### 多行字符串 (Multiline Strings)

Zen C 使用 `"""` 分隔符支持原始多行字符串块。这对于编写嵌入式语言（如 GLSL、HTML）或在 `comptime` 块生成 C 代码非常有用，此时无需手动转义换行符与内部引号。

多行字符串遵循与普通字符串相同的规则：不带前缀的 `"""..."""` 块不会插值，其中的 `{expr}` 是错误。加上前缀可以改变这一点：
- `f"""..."""`：像 `f"..."` 一样插值 `{expr}`。
- `r"""..."""`：原始块（不处理转义序列）。

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

#### 读取输入

`std/io.zc` 中的 `readln()` 从 `stdin` 读取一行（不含换行符）。输入结束时返回 `NULL`；由调用者释放这一行。

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
