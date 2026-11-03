# std/slice

`Slice<T>` 是一個輕量級的、不具所有權的連續元素序列「視圖」（view）。它主要用於為固定大小的陣列提供一個安全且便捷的介面。

## 概覽

- **不具所有權**：切片（Slices）不會拷貝或擁有底層數據；它們僅是指向數據。
- **迭代支援**：實現了 `iterator()` 方法，允許切片直接用於 `for-in` 迴圈。
- **自動轉換**：在任何預期切片的地方，固定大小陣列或陣列字面量都會被視為切片：`let s: [int] = [1, 2, 3];`、`sum(arr)`、`sum([1, 2])`、結構體欄位。對固定大小陣列的迭代同樣使用切片。
- **安全存取**：`s[i]` 返回元素並進行邊界檢查；`get()` 和 `at()` 返回 `Option<T>`。
- **不能返回堆疊上的數據**：返回切片的函數不能返回陣列字面量或區域陣列：它們的元素位於函數的堆疊上，函數返回後堆疊即失效。請改為返回固定大小陣列或 `Vec<T>`。

## 使用方法

```zc
import "std/slice.zc"
import "std/io.zc"

fn main() {
    let arr: int[5] = [10, 20, 30, 40, 50];
    
    // 顯式建立切片
    let s = Slice<int>::from_array(arr, 5);
    
    // 直接迭代切片
    for val in s {
        println(f"{val}");
    }
    
    // 直接迭代陣列（會自動導入 std/slice.zc）
    for val in arr {
        println(f"{val}");
    }
}
```

## 結構體定義

`Slice<T>` 內建於編譯器中：`[T]` 和 `T[]` 是同一型別（`[int]` 即 `Slice<int>`）。`std/slice.zc` 提供下面的方法。

```zc
struct Slice<T> {
    data: T*;
    len: usize;
}
```

## 方法

### 構造

| 方法 | 簽名 | 說明 |
| :--- | :--- | :--- |
| **from_array** | `Slice<T>::from_array(ptr: T*, len: usize) -> Slice<T>` | 在陣列指標上建立一個切片視圖。 |
| **new** | `Slice<T>::new(data: T*, len: usize) -> Slice<T>` | `from_array` 的別名。 |

### 迭代

| 方法 | 簽名 | 說明 |
| :--- | :--- | :--- |
| **iterator** | `iterator(self) -> SliceIter<T>` | 返回用於 `for-in` 迴圈的迭代器。 |

### 存取與查詢

| 方法 | 簽名 | 說明 |
| :--- | :--- | :--- |
| **length** | `length(self) -> usize` | 返回切片中的元素數量。 |
| **is_empty** | `is_empty(self) -> bool` | 如果切片不包含元素則返回 `true`。 |
| **get** | `get(self, idx: usize) -> Option<T>` | 返回 `idx` 處的元素，如果越界則返回 `None`。 |
| **at** | `at(self, idx: usize) -> Option<T>` | `get` 的別名。 |

## 注意事項

- **自動導入**：當在固定大小陣列和切片上執行 `for-in` 迭代時，編譯器會自動導入 `std/slice.zc`。
- **安全性**：雖然 `data` 是一個原始指標，但 `Slice` 結構體鼓勵使用感知長度的 `get()` 方法進行安全存取。
