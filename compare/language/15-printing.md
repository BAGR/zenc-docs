+++
title = "Printing & String Interpolation"
weight = 15
+++

# Printing & String Interpolation

The print functions of `std/io.zc`, string interpolation with `f"..."`,
raw strings, multiline strings, and reading input.

## Zen C

```zc
import "std/io.zc"

fn main() {
    let name = "Zen";
    let count = 3;

    println(f"Hello, {name}!");
    println(f"Count: {count}");

    println(f"JSON: {{key: value}}");

    let path = r"C:\Users\{name}\docs";
    println(f"raw path: {path}");

    let story = f"""
    Once upon a time,
    in the land of {name},
    there were {count} warriors.
    """;
    println(f"{story}");

    println("--- user input ---");
    print("What is your name? ");
    let user_name = readln();
    if user_name != NULL {
        println(f"Hello, {user_name}!");
        free(user_name);
    }
}
```

## C

```c
#include <stdio.h>

int main(void) {
    const char* name = "C";
    int count = 3;

    printf("Hello, %s!\n", name);
    printf("Count: %d\n", count);

    printf("JSON: {key: value}\n");

    const char* path = "C:\\Users\\{name}\\docs";
    printf("raw path: %s\n", path);

    printf("Once upon a time,\n");
    printf("in the land of %s,\n", name);
    printf("there were %d warriors.\n", count);

    printf("--- user input ---\n");
    printf("What is your name? ");
    printf(">>> ");
    char buffer[256];
    if (fgets(buffer, sizeof(buffer), stdin)) {
        buffer[strcspn(buffer, "\n")] = '\0';
        printf("Hello, %s!\n", buffer);
    }
    return 0;
}
```

## Key Differences

- `print`, `println`, `eprint` and `eprintln` are functions of `std/io.zc` that take one string
- String interpolation: `f"Hello, {name}!"` vs `printf("Hello, %s!", name)`; a plain `"..."` does not interpolate
- Brace escaping: `{{` and `}}` for literal braces inside `f"..."`
- Raw strings: `r"no \\ escape {interpolation}"`
- Multiline strings: `"""..."""` blocks; `f"""..."""` interpolates
- Input: `readln()` reads a line without the newline; the caller frees it
- C needs `printf` with format specifiers, `fgets` for input, `strcspn` for newline cleanup

## Output


Hello, Zen!
Count: 3
JSON: {key: value}
raw path: C:\Users\{name}\docs

    Once upon a time,
    in the land of Zen,
    there were 3 warriors.

--- user input ---
What is your name?
