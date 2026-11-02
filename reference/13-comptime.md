+++
title = "13. Comptime (Compile-Time Execution)"
weight = 13
+++

# 13. Comptime (Compile-Time Execution)

Comptime allows running Zen code at compile time to generate source code, validate constants, and emit diagnostics.

```zc
comptime {
    yield("def build_date = \"2024-01-01\";");
}

println(f"Build Date: {build_date}");
```

## 12.1 Helper Functions

Special functions available inside `comptime` blocks:

| Function | Description |
|:---|---|
| `yield(str)` | Emit generated source code |
| `code(str)` | Alias for `yield()` |
| `compile_error(msg)` | Halt compilation with a fatal error message |
| `compile_warn(msg)` | Emit a compile-time warning |

**Example:**
```zc
comptime {
    compile_warn("Generating optimized code...");

    let ENABLE_FEATURE = 1;
    if (ENABLE_FEATURE == 0) {
        compile_error("Feature must be enabled!");
    }

    code(r"let FEATURE_ENABLED = 1;");
}
```

## 12.2 Variables and Control Flow

Comptime blocks support variables, arithmetic, and control flow:

```zc
comptime {
    let x = 10;
    let y = 20;
    let sum = x + y;

    if (sum == 30) {
        yield("def SUM_OK = 1;");
    }

    let total = 0;
    for i in 0..5 {
        total = total + i;
    }
    if (total == 10) {
        yield("def LOOP_OK = 1;");
    }
}
```

## 12.3 Runtime Assertions

Use `expect()` inside comptime blocks to validate conditions at compile time:

```zc
comptime {
    expect(1 + 1 == 2, "basic math verified");
    expect(2 * 3 == 6, "multiplication verified");
    expect(10 > 5,     "comparison verified");
}
```

A failing `expect` halts compilation with an error pointing to the exact expression.

## 12.4 Build Metadata

Access compiler information at compile time:

| Constant | Type | Description |
|:---|---:|---|
| `__COMPTIME_TARGET__` | string | Platform: `"linux"`, `"windows"`, or `"macos"` |
| `__COMPTIME_FILE__` | string | Current source filename being compiled |

**Example:**
```zc
comptime {
    let target = __COMPTIME_TARGET__;
    yield("def PLATFORM = \"");
    yield(target);
    yield("\";");
}

println(f"Running on: {PLATFORM}");
```

## 12.5 `@comptime` Functions

Functions marked with `@comptime` can be called from both comptime blocks and runtime code. They are compiled as regular functions but also available to the comptime interpreter:

```zc
@comptime
fn double_ct(x: int) -> int {
    return x * 2;
}

comptime {
    expect(double_ct(21) == 42, "@comptime function works");
}
```

## 12.6 Tips

{% alert(type="tip") %}
Use raw strings (`r"..."`) in comptime to avoid issues with curly braces in generated code: `code(r"fn test() { return 42; }")`. Raw strings prevent `{` from being interpreted as f-string interpolation markers.
{% end %}

`yield()` is the primary function for code generation. The old `printf`- and `println`-based generation (from the previous subprocess model) no longer works — all code generation must use `yield()` or `code()`.
