+++
title = "11. Concorrência"
weight = 11
+++

# 11. Concorrência {#11-concorrencia}

As threads vêm de `std/thread.zc`, construído sobre pthreads. `Thread::spawn` executa uma função ou um closure numa nova thread, e `join` espera que ela termine.

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
