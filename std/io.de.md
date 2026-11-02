# std/io

Das Modul `std/io` bietet Standard-Eingabe/Ausgabe-Funktionen, einschließlich formatierter Ausgabe nach stdout und robustem Lesen von stdin.

## Überblick

- **Ausgabe**: `print`, `println`, `eprint` und `eprintln` schreiben einen String nach stdout oder stderr; `f"..."` und `format()` erzeugen formatierte Strings dafür.
- **String-Formatierung**: Mehrere Optionen zum Formatieren in statische, benutzerdefinierte oder auf dem Heap allokierte Puffer.
- **Unicode-Unterstützung**: Enthält `read_rune` zum Lesen einzelner UTF-8-Zeichen von stdin.
- **Konvertierungs-Hilfsprogramme**: Einfache Methoden zum Konvertieren von Ganzzahlen und Runen in Strings.

## Verwendung

```zc
import "std/io.zc"

fn main() {
    // Grundlegendes Drucken
    println("Hallo, Zen-C!");
    
    // Lesen einer Zeile der Eingabe
    print("Geben Sie Ihren Namen ein: ");
    let name = readln();
    
    if name != NULL {
        println(f"Begrüßung, {name}");
        free(name);
    }
}
```

## Methoden

### Ausgabe

| Methode | Signatur | Beschreibung |
| :--- | :--- | :--- |
| **print** | `print(s: const char*)` | Gibt `s` nach stdout aus. |
| **println** | `println(s: const char*)` | Gibt `s` nach stdout aus, gefolgt von einem Zeilenumbruch. |
| **eprint** | `eprint(s: const char*)` | Gibt `s` nach stderr aus. |
| **eprintln** | `eprintln(s: const char*)` | Gibt `s` nach stderr aus, gefolgt von einem Zeilenumbruch. |

### Eingabe

| Methode | Signatur | Beschreibung |
| :--- | :--- | :--- |
| **readln** | `readln() -> char*` | Liest eine Zeile von stdin. Gibt einen auf dem Heap allokierten String zurück (Aufrufer muss diesen freigeben). |
| **read_rune** | `read_rune() -> rune` | Liest ein einzelnes UTF-8-Zeichen (Rune) von stdin. |

### Formatierung

| Methode | Signatur | Beschreibung |
| :--- | :--- | :--- |
| **format** | `format(fmt: char*, ...) -> char*` | Formatiert in einen internen statischen Puffer. **Warnung**: Nicht threadsicher. |
| **format_into** | `format_into(buf: char*, size: usize, fmt: char*, ...) -> int` | Formatiert in einen vom Benutzer bereitgestellten Puffer spezifischer Größe. |
| **format_new** | `format_new(fmt: char*, ...) -> char*` | Formatiert in einen neuen auf dem Heap allokierten Puffer. Aufrufer muss diesen freigeben. |

### Konvertierung

| Methode | Signatur | Beschreibung |
| :--- | :--- | :--- |
| **itos** | `itos(n: int) -> char*` | Konvertiert `n` in einen String in einem statischen Puffer. |
| **itos_new** | `itos_new(n: int) -> char*` | Konvertiert `n` in einen auf dem Heap allokierten String. |
| **utos** | `utos(n: uint) -> char*` | Konvertiert vorzeichenloses `n` in einen String in einem statischen Puffer. |
