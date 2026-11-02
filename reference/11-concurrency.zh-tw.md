+++
title = "11. 並發"
weight = 11
+++

# 11. 並發 {#11-bing-fa}

執行緒由 `std/thread.zc` 提供，基於 pthreads。`Thread::spawn` 在新執行緒中執行一個函數或閉包，`join` 等待它結束。

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
