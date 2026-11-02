# std/io

The `std/io` module provides standard input/output functionality, including formatted printing to stdout and robust reading from stdin. 

## Overview

- **Output**: `print`, `println`, `eprint` and `eprintln` write one string to stdout or stderr; `f"..."` and `format()` build formatted strings for them.
- **String Formatting**: Multiple options for formatting into static, user-provided, or heap-allocated buffers.
- **Unicode Aware**: Includes `read_rune` for reading individual UTF-8 characters from stdin.
- **Conversion Utilities**: Simple methods for converting integers and runes to strings.

## Usage

```zc
import "std/io.zc"

fn main() {
    // Basic printing
    println("Hello, Zen-C!");
    
    // Reading a line of input
    print("Enter your name: ");
    let name = readln();
    
    if name != NULL {
        println(f"Greeting, {name}");
        free(name);
    }
}
```

## Methods

### Output

| Method | Signature | Description |
| :--- | :--- | :--- |
| **print** | `print(s: const char*)` | Prints `s` to stdout. |
| **println** | `println(s: const char*)` | Prints `s` to stdout followed by a newline. |
| **eprint** | `eprint(s: const char*)` | Prints `s` to stderr. |
| **eprintln** | `eprintln(s: const char*)` | Prints `s` to stderr followed by a newline. |

### Input

| Method | Signature | Description |
| :--- | :--- | :--- |
| **readln** | `readln() -> char*` | Reads a line from stdin. Returns a heap-allocated string (caller must free). |
| **read_rune** | `read_rune() -> rune` | Reads a single UTF-8 character (rune) from stdin. |

### Formatting

| Method | Signature | Description |
| :--- | :--- | :--- |
| **format** | `format(fmt: char*, ...) -> char*` | Formats into a thread-local buffer. A ring of buffers makes nested `format()` calls safe; each returned pointer stays valid until 4 further `format()` calls on the same thread. |
| **format_into** | `format_into(buf: char*, size: usize, fmt: char*, ...) -> int` | Formats into a user-provided buffer of specific size. |
| **format_new** | `format_new(fmt: char*, ...) -> char*` | Formats into a new heap-allocated buffer. Caller must free. |

### Conversion

| Method | Signature | Description |
| :--- | :--- | :--- |
| **itos** | `itos(n: int) -> char*` | Converts `n` to a string in a static buffer. |
| **itos_new** | `itos_new(n: int) -> char*` | Converts `n` to a heap-allocated string. |
| **utos** | `utos(n: uint) -> char*` | Converts unsigned `n` to a string in a static buffer. |
