# std/slice

`Slice<T>` è una "vista" leggera e senza proprietà su una sequenza contigua di elementi. Viene utilizzato principalmente per fornire un'interfaccia sicura e conveniente per lavorare con array a dimensione fissa.

## Panoramica

- **Senza Proprietà**: Gli slice non copiano né possiedono i dati sottostanti; puntano semplicemente ad essi.
- **Supporto all'Iterazione**: Implementa il metodo `iterator()`, consentendo agli slice di essere utilizzati direttamente nei cicli `for-in`.
- **Conversione Automatica**: Un array a dimensione fissa o un letterale di array viene visto come uno slice ovunque ne sia atteso uno: `let s: [int] = [1, 2, 3];`, `sum(arr)`, `sum([1, 2])`, un campo di una struct. Anche l'iterazione su un array a dimensione fissa usa uno slice.
- **Accesso Sicuro**: `s[i]` restituisce l'elemento, con controllo dei limiti; `get()` e `at()` restituiscono un `Option<T>`.
- **Non per Restituire Dati dello Stack**: Una funzione che restituisce uno slice non può restituire un letterale di array né un array locale: i loro elementi vivono sullo stack della funzione, che scompare dopo il ritorno. Restituisci invece un array a dimensione fissa o un `Vec<T>`.

## Utilizzo

```zc
import "std/slice.zc"
import "std/io.zc"

fn main() {
    let arr: int[5] = [10, 20, 30, 40, 50];
    
    // Creazione esplicita dello slice
    let s = Slice<int>::from_array(arr, 5);
    
    // Iterazione diretta sullo slice
    for val in s {
        println(f"{val}");
    }
    
    // Iterazione diretta sull'array (importa automaticamente std/slice.zc)
    for val in arr {
        println(f"{val}");
    }
}
```

## Definizione Struct

`Slice<T>` è integrato nel compilatore: `[T]` e `T[]` sono lo stesso tipo (`[int]` è `Slice<int>`). `std/slice.zc` aggiunge i metodi qui sotto.

```zc
struct Slice<T> {
    data: T*;
    len: usize;
}
```

## Metodi

### Costruzione

| Metodo | Firma | Descrizione |
| :--- | :--- | :--- |
| **from_array** | `Slice<T>::from_array(ptr: T*, len: usize) -> Slice<T>` | Crea una vista slice su un puntatore ad array. |
| **new** | `Slice<T>::new(data: T*, len: usize) -> Slice<T>` | Alias di `from_array`. |

### Iterazione

| Metodo | Firma | Descrizione |
| :--- | :--- | :--- |
| **iterator** | `iterator(self) -> SliceIter<T>` | Restituisce un iteratore per l'uso nei cicli `for-in`. |

### Accesso e Query

| Metodo | Firma | Descrizione |
| :--- | :--- | :--- |
| **length** | `length(self) -> usize` | Restituisce il numero di elementi nello slice. |
| **is_empty** | `is_empty(self) -> bool` | Restituisce `true` se lo slice non contiene elementi. |
| **get** | `get(self, idx: usize) -> Option<T>` | Restituisce l'elemento all'indice `idx`, o `None` se fuori dai limiti. |
| **at** | `at(self, idx: usize) -> Option<T>` | Alias di `get`. |

## Note

- **Auto-import**: `std/slice.zc` viene importato automaticamente dal compilatore quando si esegue l'iterazione `for-in` su array a dimensione fissa e slice.
- **Sicurezza**: Sebbene `data` sia un puntatore grezzo, la struct `Slice` incoraggia l'uso del metodo `get()`, consapevole della lunghezza, per un accesso sicuro.
