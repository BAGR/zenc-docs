# std/io

El módulo `std/io` proporciona funcionalidad estándar de entrada/salida, incluyendo la impresión formateada a stdout y la lectura robusta de stdin.

## Resumen

- **Salida**: `print`, `println`, `eprint` y `eprintln` escriben una cadena en stdout o stderr; `f"..."` y `format()` construyen las cadenas con formato.
- **Formateo de Cadenas**: Múltiples opciones para formatear en búferes estáticos, proporcionados por el usuario o asignados en el montón.
- **Consciente de Unicode**: Incluye `read_rune` para leer caracteres UTF-8 individuales de stdin.
- **Utilidades de Conversión**: Métodos sencillos para convertir enteros y runas a cadenas.

## Uso

```zc
import "std/io.zc"

fn main() {
    // Impresión básica
    println("¡Hola, Zen-C!");
    
    // Leer una línea de entrada
    print("Introduce tu nombre: ");
    let name = readln();
    
    if name != NULL {
        println(f"Saludos, {name}");
        free(name);
    }
}
```

## Métodos

### Salida

| Método | Firma | Descripción |
| :--- | :--- | :--- |
| **print** | `print(s: const char*)` | Imprime `s` en stdout. |
| **println** | `println(s: const char*)` | Imprime `s` en stdout seguida de una nueva línea. |
| **eprint** | `eprint(s: const char*)` | Imprime `s` en stderr. |
| **eprintln** | `eprintln(s: const char*)` | Imprime `s` en stderr seguida de una nueva línea. |

### Entrada

| Método | Firma | Descripción |
| :--- | :--- | :--- |
| **readln** | `readln() -> char*` | Lee una línea de stdin. Devuelve una cadena asignada en el montón (el llamador debe liberarla). |
| **read_rune** | `read_rune() -> rune` | Lee un solo carácter UTF-8 (runa) de stdin. |

### Formateo

| Método | Firma | Descripción |
| :--- | :--- | :--- |
| **format** | `format(fmt: char*, ...) -> char*` | Formatea en un búfer estático interno. **Advertencia**: No es seguro para hilos. |
| **format_into** | `format_into(buf: char*, size: usize, fmt: char*, ...) -> int` | Formatea en un búfer proporcionado por el usuario de tamaño específico. |
| **format_new** | `format_new(fmt: char*, ...) -> char*` | Formatea en un nuevo búfer asignado en el montón. El llamador debe liberarlo. |

### Conversión

| Método | Firma | Descripción |
| :--- | :--- | :--- |
| **itos** | `itos(n: int) -> char*` | Convierte `n` a una cadena en un búfer estático. |
| **itos_new** | `itos_new(n: int) -> char*` | Convierte `n` a una cadena asignada en el montón. |
| **utos** | `utos(n: uint) -> char*` | Convierte `n` sin signo a una cadena en un búfer estático. |
