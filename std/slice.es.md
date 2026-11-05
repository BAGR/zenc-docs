# std/slice

`Slice<T>` es una "vista" ligera y sin propiedad sobre una secuencia contigua de elementos. Se utiliza principalmente para proporcionar una interfaz segura y conveniente para trabajar con matrices de tamaño fijo.

## Resumen

- **Sin Propiedad**: Las rodajas (slices) no copian ni poseen los datos subyacentes; simplemente apuntan a ellos.
- **Soporte de Iteración**: Implementa el método `iterator()`, lo que permite usar rodajas directamente en bucles `for-in`.
- **Conversión Automática**: Una matriz de tamaño fijo o un literal de matriz se ve como una rodaja allí donde se espera una: `let s: [int] = [1, 2, 3];`, `sum(arr)`, `sum([1, 2])`, un campo de una estructura. Iterar sobre una matriz de tamaño fijo también usa una rodaja.
- **Acceso Seguro**: `s[i]` da el elemento, con comprobación de límites; `get()` y `at()` devuelven `Option<T>`.
- **No Sirve para Devolver Datos de la Pila**: Una función que devuelve una rodaja no puede devolver un literal de matriz ni una matriz local: sus elementos viven en la pila de la función, que desaparece tras el retorno. Devuelve en su lugar una matriz de tamaño fijo o un `Vec<T>`.

## Uso

```zc
import "std/slice.zc"
import "std/io.zc"

fn main() {
    let arr: int[5] = [10, 20, 30, 40, 50];
    
    // Creación explícita de una rodaja
    let s = Slice<int>::from_array(arr, 5);
    
    // Iteración directa sobre la rodaja
    for val in s {
        println(f"{val}");
    }
    
    // Iteración directa sobre la matriz (importa automáticamente std/slice.zc)
    for val in arr {
        println(f"{val}");
    }
}
```

## Definición de Estructura

`Slice<T>` está integrado en el compilador: `[T]` y `T[]` son el mismo tipo (`[int]` es `Slice<int>`). `std/slice.zc` añade los métodos de abajo.

```zc
struct Slice<T> {
    data: T*;
    len: usize;
}
```

## Métodos

### Construcción

| Método | Firma | Descripción |
| :--- | :--- | :--- |
| **from_array** | `Slice<T>::from_array(ptr: T*, len: usize) -> Slice<T>` | Crea una vista de rodaja sobre un puntero de matriz. |
| **new** | `Slice<T>::new(data: T*, len: usize) -> Slice<T>` | Alias de `from_array`. |

### Iteración

| Método | Firma | Descripción |
| :--- | :--- | :--- |
| **iterator** | `iterator(self) -> SliceIter<T>` | Devuelve un iterador para su uso en bucles `for-in`. |

### Acceso y Consulta

| Método | Firma | Descripción |
| :--- | :--- | :--- |
| **length** | `length(self) -> usize` | Devuelve el número de elementos en la rodaja. |
| **is_empty** | `is_empty(self) -> bool` | Devuelve `true` si la rodaja no contiene elementos. |
| **get** | `get(self, idx: usize) -> Option<T>` | Devuelve el elemento en `idx`, o `None` si está fuera de los límites. |
| **at** | `at(self, idx: usize) -> Option<T>` | Alias de `get`. |

## Notas

- **Auto-importación**: El compilador importa automáticamente `std/slice.zc` al realizar una iteración `for-in` sobre matrices de tamaño fijo y rodajas.
- **Seguridad**: Aunque `data` es un puntero directo, la estructura `Slice` fomenta el uso del método `get()`, que tiene en cuenta la longitud, para un acceso seguro.
