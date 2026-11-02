+++
title = "11. Nebenläufigkeit"
weight = 11
+++

# 11. Nebenläufigkeit {#11-nebenlaufigkeit}

Threads stellt `std/thread.zc` bereit, aufgebaut auf pthreads. `Thread::spawn` führt eine Funktion oder einen Closure in einem neuen Thread aus, und `join` wartet auf dessen Ende.

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
