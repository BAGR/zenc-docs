+++
title = "11. Concurrencia"
weight = 11
+++

# 11. Concurrencia {#11-concurrencia}

Los hilos los proporciona `std/thread.zc`, construido sobre pthreads. `Thread::spawn` ejecuta una función o un closure en un hilo nuevo, y `join` espera a que termine.

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
