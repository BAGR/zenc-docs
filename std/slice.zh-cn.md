# std/slice

`Slice<T>` 是一个轻量级的、非所有权的“视图”，指向一段连续的元素序列。它主要用于为操作固定大小数组提供安全且便捷的接口。

## 概览

- **非所有权**：切片不会拷贝或拥有底层数据；它们仅仅是指向数据。
- **迭代支持**：实现了 `iterator()` 方法，允许切片直接在 `for-in` 循环中使用。
- **自动转换**：在任何期望切片的地方，固定大小数组或数组字面量都会被视为切片：`let s: [int] = [1, 2, 3];`、`sum(arr)`、`sum([1, 2])`、结构体字段。对固定大小数组的迭代同样使用切片。
- **安全访问**：`s[i]` 返回元素并进行边界检查；`get()` 和 `at()` 返回 `Option<T>`。
- **不能返回栈上的数据**：返回切片的函数不能返回数组字面量或局部数组：它们的元素位于函数的栈上，函数返回后栈即失效。请改为返回固定大小数组或 `Vec<T>`。

## 使用方法

```zc
import "std/slice.zc"
import "std/io.zc"

fn main() {
    let arr: int[5] = [10, 20, 30, 40, 50];
    
    // 显式创建切片
    let s = Slice<int>::from_array(arr, 5);
    
    // 直接遍历切片
    for val in s {
        println(f"{val}");
    }
    
    // 直接遍历数组（自动导入 std/slice.zc）
    for val in arr {
        println(f"{val}");
    }
}
```

## 结构体定义

`Slice<T>` 内置于编译器中：`[T]` 和 `T[]` 是同一类型（`[int]` 即 `Slice<int>`）。`std/slice.zc` 提供下面的方法。

```zc
struct Slice<T> {
    data: T*;
    len: usize;
}
```

## 方法

### 构造

| 方法 | 签名 | 说明 |
| :--- | :--- | :--- |
| **from_array** | `Slice<T>::from_array(ptr: T*, len: usize) -> Slice<T>` | 在数组指针上创建一个切片视图。 |
| **new** | `Slice<T>::new(data: T*, len: usize) -> Slice<T>` | `from_array` 的别名。 |

### 迭代

| 方法 | 签名 | 说明 |
| :--- | :--- | :--- |
| **iterator** | `iterator(self) -> SliceIter<T>` | 返回一个用于 `for-in` 循环的迭代器。 |

### 访问与查询

| 方法 | 签名 | 说明 |
| :--- | :--- | :--- |
| **length** | `length(self) -> usize` | 返回切片中的元素数量。 |
| **is_empty** | `is_empty(self) -> bool` | 如果切片不包含元素，则返回 `true`。 |
| **get** | `get(self, idx: usize) -> Option<T>` | 返回索引 `idx` 处的元素，如果越界则返回 `None`。 |
| **at** | `at(self, idx: usize) -> Option<T>" | `get` 的别名。 |

## 注意事项

- **自动导入**：在对固定大小数组和切片进行 `for-in` 迭代时，编译器会自动导入 `std/slice.zc`。
- **安全性**：虽然 `data` 是原始指针，但 `Slice` 结构体鼓励使用感知长度的 `get()` 方法进行安全访问。
