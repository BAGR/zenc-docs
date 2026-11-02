+++
title = "11. 并发"
weight = 11
+++

# 11. 并发 {#11-bing-fa}

线程由 `std/thread.zc` 提供，基于 pthreads。`Thread::spawn` 在新线程中运行一个函数或闭包，`join` 等待它结束。

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
