+++
title = "13. Comptime (Compile-Time-Ausführung)"
weight = 13
+++

# 13. Comptime (Compile-Time-Ausführung)

Comptime erlaubt es, Zen-Code zur Compile-Zeit auszuführen, um Quellcode zu generieren, Konstanten zu validieren und Diagnosen auszugeben.

```zc
comptime {
    yield("def build_date = \"2024-01-01\";");
}

println(f"Build Date: {build_date}");
```

## 12.1 Hilfsfunktionen

| Funktion | Beschreibung |
|:---|---|
| `yield(str)` | Generierten Quellcode ausgeben |
| `code(str)` | Alias für `yield()` |
| `compile_error(msg)` | Compiler mit Fehlermeldung anhalten |
| `compile_warn(msg)` | Compile-Zeit-Warnung ausgeben |

## 12.2 Variablen und Kontrollfluss

```zc
comptime {
    let sum = 0;
    for i in 0..5 { sum = sum + i; }
    expect(sum == 10, "Schleife funktioniert");
}
```

## 12.3 Laufzeit-Assertions

`expect()` in comptime-Blöcken validiert Bedingungen zur Compile-Zeit:

```zc
comptime {
    expect(1 + 1 == 2, "Mathe OK");
}
```

## 12.4 Build-Metadaten

| Konstante | Typ | Beschreibung |
|:---|---:|---|
| `__COMPTIME_TARGET__` | string | Plattform: `"linux"`, `"windows"`, `"macos"` |
| `__COMPTIME_FILE__` | string | Aktuelle Quelldatei |

## 12.5 `@comptime`-Funktionen

Mit `@comptime` markierte Funktionen können sowohl in comptime-Blöcken als auch zur Laufzeit aufgerufen werden.

## 12.6 Tipps

Verwenden Sie Raw-Strings (`r"..."`) in comptime, um Probleme mit geschweiften Klammern zu vermeiden: `code(r"fn test() { return 42; }")`.
