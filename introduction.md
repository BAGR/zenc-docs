# Introduction

Zen C is a systems programming language with the ergonomics of a modern one (type inference, pattern matching, generics, traits, automatic cleanup) that compiles to plain, readable C. The C compiler you already have turns that C into a program.

C is the point, not an implementation detail: Zen C uses it the way other compilers use their intermediate representation, as a portable assembly that every platform understands.

## Why Zen C

C is the most universal language there is. Every operating system, every processor and almost every library speaks it, and its compilers have been tuned for decades. Writing it is another matter: no generics, no pattern matching, no modules, error-prone memory handling, and a lot of ceremony for simple things.

Newer systems languages fix much of that, but they bring their own compiler backend, their own ABI, their own build system and their own ecosystem, and leave behind part of what makes C valuable: the targets only a C compiler supports and the libraries you call without bindings.

Zen C takes the other road: a modern language on top of C, so you write with modern syntax and tooling and still get C out.

## Why compile to C

- **Free interoperability with C.** Call any C function and use any C struct directly, with no FFI layer and no bindings. The generated C links with any C code or library, and any C code can call yours.
- **Battle-tested optimizations.** GCC, Clang and the other C compilers have decades of work in their optimizers. Zen C uses all of it without a backend of its own: `-O2` means what it means in C.
- **Every architecture C reaches.** Any system or processor that GCC, Clang or another C11 compiler supports is a target, from servers and desktops to microcontrollers, consoles and old hardware, without porting the Zen C compiler. (Some features use GNU C extensions, which most C compilers accept.)
- **Output you can read.** The generated C is meant to be read: you can inspect what a construct becomes (`zc transpile app.zc`), and debug a program with any C debugger, which shows the lines of your `.zc` files.
- **Your choice of C compiler.** GCC, Clang, TCC, `zig cc`, or Cosmopolitan's `cosmocc` for executables that run on every system (`--cc`).

## Principles

- **Zero cost.** Abstractions compile to the C you would write by hand. Generics are specialized for each type at compile time; trait calls are resolved at compile time unless you ask for a trait object.
- **Safer than C, without becoming Rust.** Values move by default and expensive copies are explicit; `Drop` and `defer` release resources at the end of their scope. That removes the most common mistakes, such as double frees, without a garbage collector or a borrow checker. Zen C stays a systems language: raw pointers and manual memory are still there when you need them.
- **Readability.** Code should say what it does, in Zen C and in the C it becomes.
- **Good ideas from other languages.** Zen C borrows freely (pattern matching, traits, `defer`, generics) and takes what fits a language that compiles to C.
- **A small core.** Features earn their place; what can live in the standard library or a plugin does not go into the language.

## Who it is for

People who write C, or who would like to, and want a more pleasant language without leaving its ecosystem; and people coming from C++, Zig, Rust or Odin who want something between C and those languages. Typical uses are games, high-performance software, embedded systems and kernels: anywhere C runs.

## What it is not

- **Not Rust.** It takes concepts from Rust, but it has no borrow checker and does not aim to be memory-safe by construction.
- **Not garbage-collected.** Memory is yours to manage, with `Drop`, `defer` and move semantics to help.
- **Not its own code generator.** Zen C emits C (or C++, CUDA and Objective-C where you need them) and leaves machine code to the C compiler. There is no LLVM or native backend, and none is planned.

## Next steps

- [Install](https://zenc-lang-ce.github.io/docs/install/) Zen C and a C compiler.
- Take the [Tour of Zen C](https://zenc-lang-ce.github.io/docs/tour/), from variables to traits and generics.
- Set up your [editor](https://zenc-lang-ce.github.io/docs/editors/).
