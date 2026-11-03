# std/slice

`Slice<T>` é uma "visão" leve e sem propriedade de uma sequência contígua de elementos. É usado principalmente para fornecer uma interface segura e conveniente para trabalhar com arrays de tamanho fixo.

## Visão Geral

- **Sem propriedade**: As fatias não copiam nem possuem os dados subjacentes; elas apenas apontam para eles.
- **Suporte à Iteração**: Implementa o método `iterator()`, permitindo que as fatias sejam usadas diretamente em loops `for-in`.
- **Conversão Automática**: Um array de tamanho fixo ou um literal de array é visto como uma fatia onde quer que se espere uma: `let s: [int] = [1, 2, 3];`, `sum(arr)`, `sum([1, 2])`, um campo de uma estrutura. Iterar sobre um array de tamanho fixo também usa uma fatia.
- **Acesso Seguro**: `s[i]` devolve o elemento, com verificação de limites; `get()` e `at()` retornam `Option<T>`.
- **Não Serve para Retornar Dados da Pilha**: Uma função que retorna uma fatia não pode retornar um literal de array nem um array local: seus elementos vivem na pilha da função, que deixa de existir após o retorno. Retorne em vez disso um array de tamanho fixo ou um `Vec<T>`.

## Uso

```zc
import "std/slice.zc"
import "std/io.zc"

fn main() {
    let arr: int[5] = [10, 20, 30, 40, 50];
    
    // Criação explícita de fatia
    let s = Slice<int>::from_array(arr, 5);
    
    // Iteração direta sobre a fatia
    for val in s {
        println(f"{val}");
    }
    
    // Iterando diretamente sobre o array (importa automaticamente std/slice.zc)
    for val in arr {
        println(f"{val}");
    }
}
```

## Definição da Estrutura

`Slice<T>` é integrado ao compilador: `[T]` e `T[]` são o mesmo tipo (`[int]` é `Slice<int>`). `std/slice.zc` adiciona os métodos abaixo.

```zc
struct Slice<T> {
    data: T*;
    len: usize;
}
```

## Métodos

### Construção

| Método | Assinatura | Descrição |
| :--- | :--- | :--- |
| **from_array** | `Slice<T>::from_array(ptr: T*, len: usize) -> Slice<T>` | Cria uma visão de fatia sobre um ponteiro de array. |
| **new** | `Slice<T>::new(data: T*, len: usize) -> Slice<T>` | Alias para `from_array`. |

### Iteração

| Método | Assinatura | Descrição |
| :--- | :--- | :--- |
| **iterator** | `iterator(self) -> SliceIter<T>` | Retorna um iterador para uso em loops `for-in`. |

### Acesso e Consulta

| Método | Assinatura | Descrição |
| :--- | :--- | :--- |
| **length** | `length(self) -> usize` | Retorna o número de elementos na fatia. |
| **is_empty** | `is_empty(self) -> bool` | Retorna `true` se a fatia não contiver elementos. |
| **get** | `get(self, idx: usize) -> Option<T>` | Retorna o elemento em `idx`, ou `None` se estiver fora dos limites. |
| **at** | `at(self, idx: usize) -> Option<T>` | Alias para `get`. |

## Notas

- **Importação Automática**: `std/slice.zc` é importado automaticamente pelo compilador ao realizar a iteração `for-in` em arrays de tamanho fixo e fatias.
- **Segurança**: Embora `data` seja um ponteiro bruto, a estrutura `Slice` incentiva o uso do método `get()`, que reconhece o comprimento, para um acesso seguro.
