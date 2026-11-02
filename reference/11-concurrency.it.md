+++
title = "11. Concorrenza"
weight = 11
+++

# 11. Concorrenza {#11-concorrenza}


I thread vengono da `std/thread.zc`, basato su pthreads. `Thread::spawn` esegue una funzione o una closure in un nuovo thread, e `join` attende che finisca.

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
