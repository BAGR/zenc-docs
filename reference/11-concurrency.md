+++
title = "11. Concurrency"
weight = 11
+++

# 11. Concurrency {#11-concurrency}

Threads come from `std/thread.zc`, built on pthreads. `Thread::spawn` runs a function or a closure in a new thread, and `join` waits for it to finish.

```zc
import "std/thread.zc"
import "std/io.zc"

fn fetch_data(id: int) {
    println(f"Worker {id} running in the background");
}

fn main() {
    let t = Thread::spawn(fn() {
        fetch_data(1);
    }).unwrap();
    t.join();
}
```
