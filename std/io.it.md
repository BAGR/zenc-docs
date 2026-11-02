# std/io

Il modulo `std/io` fornisce funzionalità di input/output standard, inclusa la stampa formattata su stdout e la lettura robusta da stdin.

## Panoramica

- **Output**: `print`, `println`, `eprint` ed `eprintln` scrivono una stringa su stdout o stderr; `f"..."` e `format()` costruiscono le stringhe formattate.
- **Formattazione delle Stringhe**: Molteplici opzioni per la formattazione in buffer statici, forniti dall'utente o allocati nell'heap.
- **Consapevolezza di Unicode**: Include `read_rune` per la lettura di singoli caratteri UTF-8 da stdin.
- **Utilità di Conversione**: Semplici metodi per convertire interi e rune in stringhe.

## Utilizzo

```zc
import "std/io.zc"

fn main() {
    // Stampa di base
    println("Hello, Zen-C!");
    
    // Lettura di una riga di input
    print("Inserisci il tuo nome: ");
    let name = readln();
    
    if name != NULL {
        println(f"Saluti, {name}");
        free(name);
    }
}
```

## Metodi

### Output

| Metodo | Firma | Descrizione |
| :--- | :--- | :--- |
| **print** | `print(s: const char*)` | Stampa `s` su stdout. |
| **println** | `println(s: const char*)` | Stampa `s` su stdout seguita da una nuova riga. |
| **eprint** | `eprint(s: const char*)` | Stampa `s` su stderr. |
| **eprintln** | `eprintln(s: const char*)` | Stampa `s` su stderr seguita da una nuova riga. |

### Input

| Metodo | Firma | Descrizione |
| :--- | :--- | :--- |
| **readln** | `readln() -> char*` | Legge una riga da stdin. Restituisce una stringa allocata nell'heap (il chiamante deve liberarla). |
| **read_rune** | `read_rune() -> rune` | Legge un singolo carattere UTF-8 (rune) da stdin. |

### Formattazione

| Metodo | Firma | Descrizione |
| :--- | :--- | :--- |
| **format** | `format(fmt: char*, ...) -> char*` | Formatta in un buffer statico interno. **Attenzione**: Non è thread-safe. |
| **format_into** | `format_into(buf: char*, size: usize, fmt: char*, ...) -> int` | Formatta in un buffer fornito dall'utente di una dimensione specifica. |
| **format_new** | `format_new(fmt: char*, ...) -> char*` | Formatta in un nuovo buffer allocato nell'heap. Il chiamante deve liberarlo. |

### Conversione

| Metodo | Firma | Descrizione |
| :--- | :--- | :--- |
| **itos** | `itos(n: int) -> char*` | Converte `n` in una stringa in un buffer statico. |
| **itos_new** | `itos_new(n: int) -> char*` | Converte `n` in una stringa allocata nell'heap. |
| **utos** | `utos(n: uint) -> char*` | Converte unsigned `n` in una stringa in un buffer statico. |
