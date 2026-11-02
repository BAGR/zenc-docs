+++
title = "7. Impresión e Interpolación de Cadenas"
weight = 7
+++

# 7. Impresión e Interpolación de Cadenas {#7-impresion-e-interpolacion-de-cadenas}

`print`, `println`, `eprint` y `eprintln` son funciones de `std/io.zc`, así que un programa que imprime importa ese módulo. Cada una recibe una sola cadena.

| Función | Descripción |
|:---|:---|
| `print(s)` | Imprime en `stdout` sin un salto de línea al final. |
| `println(s)` | Imprime en `stdout` **con** un salto de línea al final. |
| `eprint(s)` | Imprime en `stderr` sin un salto de línea al final. |
| `eprintln(s)` | Imprime en `stderr` **con** un salto de línea al final. |

```zc
import "std/io.zc"

fn main() {
    print("Loading... ");
    println("done");
    eprintln("warning: no config file");
}
```

#### Interpolación de Cadenas

Solo interpolan las cadenas con el prefijo `f`: en `f"..."`, cada expresión entre `{}` se sustituye por su valor. En una cadena normal `"..."`, un `{expr}` es un error de compilación que indica usar `f"..."`.

```zc
let x = 42;
let name = "Zen";
println(f"Value: {x}, Name: {name}");
```

**Escapar llaves**: dentro de `f"..."`, usa `{{` para obtener una `{` literal y `}}` para una `}` literal:

```zc
let json = f"JSON: {{\"key\": \"value\"}}";
// Output: JSON: {"key": "value"}
```

**Cadenas Crudas (Raw Strings)**: Para definir una cadena donde la interpolación y las secuencias de escape se ignoran por completo, usa el prefijo `r` (ej. `r"..."`):

```zc
let regex = r"\w+"; // Contiene exactamente \ w +
let raw_json = r'{"clave": "valor"}'; // No es necesario escapar llaves
```

#### Cadenas Multilínea

Zen C soporta bloques de cadenas multilínea crudas usando el delimitador `"""`. Esto es extremadamente útil para escribir lenguajes embebidos (GLSL, HTML) o para generar código C en bloques `comptime` sin tener que escapar manualmente los saltos de línea y las comillas internas.

Las cadenas multilínea siguen las mismas reglas que las normales: un bloque `"""..."""` sin prefijo no interpola, y un `{expr}` dentro es un error. Un prefijo lo cambia:
- `f"""..."""`: interpola `{expr}`, como `f"..."`.
- `r"""..."""`: un bloque crudo (sin secuencias de escape).

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

#### Leer la Entrada

`readln()` de `std/io.zc` lee una línea de `stdin`, sin el salto de línea. Al final de la entrada devuelve `NULL`; quien la llama libera la línea.

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
