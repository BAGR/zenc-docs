+++
title = "13. Comptime (Ejecución en Tiempo de Compilación)"
weight = 13
+++

# 13. Comptime (Ejecución en Tiempo de Compilación)

Comptime permite ejecutar código Zen en tiempo de compilación para generar código fuente, validar constantes y emitir diagnósticos.

```zc
comptime {
    yield("def build_date = \"2024-01-01\";");
}

println(f"Build Date: {build_date}");
```

## 12.1 Funciones Auxiliares

| Función | Descripción |
|:---|---|
| `yield(str)` | Emitir código fuente generado |
| `code(str)` | Alias para `yield()` |
| `compile_error(msg)` | Detener la compilación con error |
| `compile_warn(msg)` | Emitir advertencia en tiempo de compilación |

## 12.2 Variables y Flujo de Control

```zc
comptime {
    let sum = 0;
    for i in 0..5 { sum = sum + i; }
    expect(sum == 10, "bucle funciona");
}
```

## 12.3 Aserciones en Comptime

`expect()` valida condiciones en tiempo de compilación:

```zc
comptime {
    expect(1 + 1 == 2, "matemáticas OK");
}
```

## 12.4 Metadatos de Compilación

| Constante | Tipo | Descripción |
|:---|---:|---|
| `__COMPTIME_TARGET__` | string | Plataforma: `"linux"`, `"windows"`, `"macos"` |
| `__COMPTIME_FILE__` | string | Archivo fuente actual |

## 12.5 Funciones `@comptime`

Las funciones marcadas con `@comptime` pueden usarse tanto en bloques comptime como en tiempo de ejecución.

## 12.6 Consejos

Use cadenas raw (`r"..."`) en comptime para evitar problemas con llaves: `code(r"fn test() { return 42; }")`.
