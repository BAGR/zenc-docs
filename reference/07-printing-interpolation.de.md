+++
title = "7. Ausgabe und String-Interpolation"
weight = 7
+++

# 7. Ausgabe und String-Interpolation {#7-ausgabe-und-string-interpolation}

`print`, `println`, `eprint` und `eprintln` sind Funktionen aus `std/io.zc`; ein Programm, das etwas ausgibt, importiert dieses Modul. Jede nimmt genau einen String.

| Funktion | Beschreibung |
|:---|:---|
| `print(s)` | Gibt auf `stdout` aus ohne nachgestellten Zeilenumbruch. |
| `println(s)` | Gibt auf `stdout` aus **mit** nachgestelltem Zeilenumbruch. |
| `eprint(s)` | Gibt auf `stderr` aus ohne nachgestellten Zeilenumbruch. |
| `eprintln(s)` | Gibt auf `stderr` aus **mit** nachgestelltem Zeilenumbruch. |

```zc
import "std/io.zc"

fn main() {
    print("Loading... ");
    println("done");
    eprintln("warning: no config file");
}
```

#### String-Interpolation

Nur Strings mit dem Präfix `f` werden interpoliert: In `f"..."` wird jeder Ausdruck zwischen `{}` durch seinen Wert ersetzt. In einem normalen `"..."` ist `{expr}` ein Kompilierfehler, der auf `f"..."` verweist.

```zc
let x = 42;
let name = "Zen";
println(f"Value: {x}, Name: {name}");
```

**Klammern escapen**: Innerhalb von `f"..."` erzeugt `{{` ein wörtliches `{` und `}}` ein wörtliches `}`:

```zc
let json = f"JSON: {{\"key\": \"value\"}}";
// Output: JSON: {"key": "value"}
```

**Raw-Strings**: Strings, bei denen Interpolation und Escape-Sequenzen komplett ignoriert werden, werden mit `r` prefixiert (z. B. `r"..."`):

```zc
let regex = r"\w+"; // Enthält exakt \ w +
let raw_json = r'{"key": "value"}'; // Kein Escapen von Klammern nötig
```

#### Mehrzeilige Strings

Zen C unterstützt rohe mehrzeilige Strings mit `"""`-Delimiter. Sehr nützlich für eingebettete Sprachen (GLSL, HTML) oder zum Generieren von C-Code in `comptime`-Blöcken ohne manuelles Escapen.

Mehrzeilige Strings folgen denselben Regeln wie normale Strings: Ein `"""..."""`-Block ohne Präfix interpoliert nicht, und ein `{expr}` darin ist ein Fehler. Ein Präfix ändert das:
- `f"""..."""`: interpoliert `{expr}` wie `f"..."`.
- `r"""..."""`: ein Raw-Block (ohne Escape-Sequenzen).

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

#### Eingabe lesen

`readln()` aus `std/io.zc` liest eine Zeile von `stdin`, ohne den Zeilenumbruch. Am Ende der Eingabe gibt es `NULL` zurück; der Aufrufer gibt die Zeile frei.

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
