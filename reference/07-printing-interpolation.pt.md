+++
title = "7. Print e Interpolação de Strings"
weight = 7
+++

# 7. Print e Interpolação de Strings {#7-print-e-interpolacao-de-strings}

`print`, `println`, `eprint` e `eprintln` são funções de `std/io.zc`, então um programa que imprime importa esse módulo. Cada uma recebe uma única string.

| Função | Descrição |
|:---|:---|
| `print(s)` | Imprime na saída padrão (sem newline) |
| `println(s)` | Imprime na saída padrão (com newline) |
| `eprint(s)` | Imprime no erro padrão (sem newline) |
| `eprintln(s)` | Imprime no erro padrão (com newline) |

```zc
import "std/io.zc"

fn main() {
    print("Loading... ");
    println("done");
    eprintln("warning: no config file");
}
```

#### Interpolação de Strings

Só interpolam as strings com o prefixo `f`: em `f"..."`, cada expressão entre `{}` é substituída pelo seu valor. Numa string comum `"..."`, um `{expr}` é um erro de compilação que aponta para `f"..."`.

```zc
let x = 42;
let name = "Zen";
println(f"Value: {x}, Name: {name}");
```

**Escapando chaves**: dentro de `f"..."`, use `{{` para obter um `{` literal e `}}` para um `}` literal:

```zc
let json = f"JSON: {{\"key\": \"value\"}}";
// Output: JSON: {"key": "value"}
```

**Strings Brutas (Raw Strings)**: Para definir uma string na qual sequências de extrapolação e metacaracteres são completamente ignorados, utilize o prefixo `r` (e.g., `r"..."`):

```zc
let regex = r"\w+"; // Contêm exatamente \ w +
let raw_json = r'{"chave": "valor"}'; // Não requer escapar chaves
```

#### Strings Multilinha

Zen C suporta blocos puros sem preenchimentos usando strings multilinha com o delimitador `"""`. Isso é extremamente útil para escrever linguagens embarcadas (GLSL, HTML) ou para geração de código C em um bloco `comptime` sem necessidade de interativamente escapar recuos da linha ou interpolação de aspas no interior da string.

Strings multilinha seguem as mesmas regras das strings comuns: um bloco `"""..."""` sem prefixo não interpola, e um `{expr}` dentro dele é um erro. Um prefixo muda isso:
- `f"""..."""`: interpola `{expr}`, como `f"..."`.
- `r"""..."""`: um bloco raw (sem sequências de escape).

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

#### Lendo a Entrada

`readln()` de `std/io.zc` lê uma linha de `stdin`, sem a quebra de linha. No fim da entrada retorna `NULL`; quem chama libera a linha.

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
