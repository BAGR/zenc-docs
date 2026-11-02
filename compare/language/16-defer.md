+++
title = "Defer"
weight = 16
+++

# Defer

Deferred cleanup at scope exit (LIFO order), for files and for heap
allocations.

## Zen C

```zc
import "std/io.zc"

fn process_file(path: char*) {
    let f = fopen(path, "r");
    if f == NULL {
        println(f"cannot open {path}");
        return;
    }
    defer fclose(f);

    println(f"processing {path}...");
    println("done");
}

fn allocate_buffer() {
    let buf = malloc(1024);
    defer free(buf);
    println("buffer allocated");
}

fn main() {
    process_file("test.txt");
    println("---");

    allocate_buffer();
    println("---");
    println("buffer freed by defer");
}
```

## C

```c
#include <stdio.h>
#include <stdlib.h>

void process_file(const char* path) {
    FILE* f = fopen(path, "r");
    if (!f) {
        printf("cannot open %s\n", path);
        return;
    }

    printf("processing %s...\n", path);
    printf("done\n");

    fclose(f);
}

void allocate_buffer(void) {
    char* buf = malloc(1024);
    printf("buffer allocated\n");
    free(buf);
}

int main(void) {
    process_file("test.txt");
    printf("---\n");

    allocate_buffer();
    printf("---\n");
    printf("buffer manually freed\n");
    return 0;
}
```

## Key Differences

- `defer fclose(f)` schedules cleanup at scope exit
- Multiple defers execute in LIFO (last-in, first-out) order
- No control-flow allowed inside defer (no return/break/continue)
- `defer free(buf)` right after `malloc` frees the buffer on every exit path
- C requires manual cleanup at every exit point (goto cleanup pattern)
- Combined with an early `return`, cleanup still runs

## Output









cannot open test.txt
---
buffer allocated
---
buffer freed by defer
