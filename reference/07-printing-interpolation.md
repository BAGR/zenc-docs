+++
title = "7. Printing and String Interpolation"
weight = 7
+++

# 7. Printing and String Interpolation {#7-printing-and-string-interpolation}

`print`, `println`, `eprint` and `eprintln` are functions of `std/io.zc`, so a program that prints imports it. Each one takes a single string.

| Function | Description |
|:---|:---|
| `print(s)` | Prints to `stdout` without a trailing newline. |
| `println(s)` | Prints to `stdout` **with** a trailing newline. |
| `eprint(s)` | Prints to `stderr` without a trailing newline. |
| `eprintln(s)` | Prints to `stderr` **with** a trailing newline. |

```zc
import "std/io.zc"

fn main() {
    print("Loading... ");
    println("done");
    eprintln("warning: no config file");
}
```

#### String Interpolation

Only strings prefixed with `f` interpolate: in `f"..."`, each expression between `{}` is replaced by its value. In a plain `"..."`, a `{expr}` is a compile error that points to `f"..."`.

```zc
let x = 42;
let name = "Zen";
println(f"Value: {x}, Name: {name}");
```

**Escaping Braces**: inside `f"..."`, use `{{` to produce a literal `{` and `}}` for a literal `}`:

```zc
let json = f"JSON: {{\"key\": \"value\"}}";
// Output: JSON: {"key": "value"}
```

**Raw Strings**: To define a string where interpolation and escape sequences are completely ignored, prefix it with `r` (e.g., `r"..."`):

```zc
let regex = r"\w+"; // Contains exactly \ w +
let raw_json = r'{"key": "value"}'; // No brace escaping needed
```

#### Multiline Strings

Zen C supports raw multiline string blocks using the `"""` delimiter. This is extremely useful for writing embedded languages (GLSL, HTML) or generating C-code in `comptime` blocks without manually escaping newlines and interior quotes.

Multiline strings follow the same rules as standard strings: a plain `"""..."""` block does not interpolate, and a `{expr}` in it is an error. A prefix changes that:
- `f"""..."""`: interpolates `{expr}`, like `f"..."`.
- `r"""..."""`: a raw block (no escape sequences).

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

#### Reading Input

`readln()` from `std/io.zc` reads a line from `stdin`, without the newline. It returns `NULL` at the end of the input, and the caller frees the line.

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
