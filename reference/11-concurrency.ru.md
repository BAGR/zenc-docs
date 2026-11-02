+++
title = "11. Параллелизм"
weight = 11
+++

# 11. Параллелизм {#11-parallelizm}

Потоки предоставляет `std/thread.zc`, построенный на pthreads. `Thread::spawn` запускает функцию или замыкание в новом потоке, а `join` ждёт его завершения.

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
