+++
title = "13. Comptime (Esecuzione in Fase di Compilazione)"
weight = 13
+++

# 13. Comptime (Esecuzione in Fase di Compilazione)

Comptime permette di eseguire codice Zen in fase di compilazione per generare codice sorgente, validare costanti ed emettere diagnostiche.

```zc
comptime {
    yield("def build_date = \"2024-01-01\";");
}

println(f"Build Date: {build_date}");
```

## 12.1 Funzioni Ausiliarie

| Funzione | Descrizione |
|:---|---|
| `yield(str)` | Emettere codice sorgente generato |
| `code(str)` | Alias per `yield()` |
| `compile_error(msg)` | Fermare la compilazione con errore |
| `compile_warn(msg)` | Emettere un avviso in fase di compilazione |

## 12.2 Variabili e Flusso di Controllo

```zc
comptime {
    let sum = 0;
    for i in 0..5 { sum = sum + i; }
    expect(sum == 10, "ciclo funziona");
}
```

## 12.3 Asserzioni in Comptime

`expect()` valida condizioni in fase di compilazione:

```zc
comptime {
    expect(1 + 1 == 2, "matematica OK");
}
```

## 12.4 Metadati di Compilazione

| Costante | Tipo | Descrizione |
|:---|---:|---|
| `__COMPTIME_TARGET__` | string | Piattaforma: `"linux"`, `"windows"`, `"macos"` |
| `__COMPTIME_FILE__` | string | File sorgente corrente |

## 12.5 Funzioni `@comptime`

Le funzioni marcate con `@comptime` possono essere usate sia in blocchi comptime che in fase di esecuzione.

## 12.6 Consigli

Usare stringhe raw (`r"..."`) in comptime per evitare problemi con le parentesi graffe: `code(r"fn test() { return 42; }")`.
