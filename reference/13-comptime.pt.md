+++
title = "13. Comptime (Execução em Tempo de Compilação)"
weight = 13
+++

# 13. Comptime (Execução em Tempo de Compilação)

Comptime permite executar código Zen em tempo de compilação para gerar código fonte, validar constantes e emitir diagnósticos.

```zc
comptime {
    yield("def build_date = \"2024-01-01\";");
}

println(f"Build Date: {build_date}");
```

## 12.1 Funções Auxiliares

| Função | Descrição |
|:---|---|
| `yield(str)` | Emitir código fonte gerado |
| `code(str)` | Alias para `yield()` |
| `compile_error(msg)` | Parar a compilação com erro |
| `compile_warn(msg)` | Emitir aviso em tempo de compilação |

## 12.2 Variáveis e Fluxo de Controle

```zc
comptime {
    let sum = 0;
    for i in 0..5 { sum = sum + i; }
    expect(sum == 10, "loop funciona");
}
```

## 12.3 Asserções em Comptime

`expect()` valida condições em tempo de compilação:

```zc
comptime {
    expect(1 + 1 == 2, "matemática OK");
}
```

## 12.4 Metadados de Compilação

| Constante | Tipo | Descrição |
|:---|---:|---|
| `__COMPTIME_TARGET__` | string | Plataforma: `"linux"`, `"windows"`, `"macos"` |
| `__COMPTIME_FILE__` | string | Arquivo fonte atual |

## 12.5 Funções `@comptime`

Funções marcadas com `@comptime` podem ser usadas tanto em blocos comptime quanto em tempo de execução.

## 12.6 Dicas

Use strings raw (`r"..."`) em comptime para evitar problemas com chaves: `code(r"fn test() { return 42; }")`.
