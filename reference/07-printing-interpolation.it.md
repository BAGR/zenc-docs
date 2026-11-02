+++
title = "7. Stampaggio e Interpolazione delle Stringhe"
weight = 7
+++

# 7. Stampaggio e Interpolazione delle Stringhe {#7-stampaggio-e-interpolazione-delle-stringhe}

`print`, `println`, `eprint` ed `eprintln` sono funzioni di `std/io.zc`, quindi un programma che stampa importa questo modulo. Ognuna riceve una sola stringa.

| Funzione | Descrizione |
|:---|:---|
| `print(s)` | Stampa a `stdout` senza aggiunzione di una newline automatica. |
| `println(s)` | Stampa a `stdout` aggiungendo una newline automatica. |
| `eprint(s)` | Stampa a `stderr` senza aggiunzione di una newline automatica. |
| `eprintln(s)` | Stampa a `stderr` aggiungendo una newline automatica. |

```zc
import "std/io.zc"

fn main() {
    print("Loading... ");
    println("done");
    eprintln("warning: no config file");
}
```

#### Interpolazione delle Stringhe

Interpolano solo le stringhe con il prefisso `f`: in `f"..."`, ogni espressione tra `{}` viene sostituita dal suo valore. In una stringa normale `"..."`, un `{expr}` è un errore di compilazione che rimanda a `f"..."`.

```zc
let x = 42;
let name = "Zen";
println(f"Value: {x}, Name: {name}");
```

**Escape delle graffe**: dentro `f"..."`, usa `{{` per ottenere una `{` letterale e `}}` per una `}` letterale:

```zc
let json = f"JSON: {{\"key\": \"value\"}}";
// Output: JSON: {"key": "value"}
```

**Stringhe Grezze (Raw Strings)**: Per definire una stringa in cui le sequenze di interpolazione e di escape vengono completamente ignorate, inserici il prefisso `r` (es. `r"..."`):

```zc
let regex = r"\w+"; // Contiene esattamente \ w +
let raw_json = r'{"chiave": "valore"}'; // Non è necessario l'escape delle parentesi
```

#### Stringhe Multilinea

Zen C supporta blocchi di stringhe multilinea grezzi utilizzando il delimitatore `"""`. Questo è estremamente utile per la scrittura di linguaggi incorporati (GLSL, HTML) o per la generazione di codice C all'interno di blocchi `comptime` senza il bisogno di inserire manualmente l'escape a capo ed alle virgolette all'interno.

Le stringhe multilinea seguono le stesse regole delle stringhe normali: un blocco `"""..."""` senza prefisso non interpola, e un `{expr}` al suo interno è un errore. Un prefisso lo cambia:
- `f"""..."""`: interpola `{expr}`, come `f"..."`.
- `r"""..."""`: un blocco raw (senza sequenze di escape).

```zc
let prompt = """
  Please enter your name:
  Type "exit" to cancel.
""";

let world = "world";
let script = f"""
  fn hello() {{
      println("hello, {world}!");
  }}
""";

let pure_raw = r"""
  Here {braces} are just text, and \n is literally slash-n.
""";
```

#### Leggere l'Input

`readln()` di `std/io.zc` legge una riga da `stdin`, senza il carattere di a capo. Alla fine dell'input restituisce `NULL`; chi la chiama libera la riga.

```zc
import "std/io.zc"

fn main() {
    print("How old are you? ");
    let line = readln();
    if line != NULL {
        let age = atoi(line);
        println(f"You are {age} years old.");
        free(line);
    }
}
```
