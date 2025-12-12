# Cobertura de Testes

Este documento explica como gerar e visualizar a cobertura de testes do projeto.

## Comandos Básicos

### 1. Gerar relatório de cobertura

Gera o arquivo `coverage/lcov.info` com os dados de cobertura:

```bash
fvm flutter test --coverage
```

### 2. Gerar relatório HTML

Converte o arquivo `lcov.info` em um relatório HTML visual:

```bash
genhtml coverage/lcov.info -o coverage/html
```

**Nota:** Requer o pacote `lcov` instalado. No macOS:
```bash
brew install lcov
```

### 3. Abrir relatório no navegador

```bash
open coverage/html/index.html
```

## Usando o Makefile

Para facilitar, use o Makefile na raiz do projeto:

### Gerar e abrir relatório automaticamente:
```bash
make coverage
```

Este comando:
1. Executa os testes com cobertura
2. Gera o relatório HTML
3. Abre automaticamente no navegador

### Apenas gerar o relatório (sem abrir):
```bash
make coverage-report
```

### Apenas abrir o relatório existente:
```bash
make coverage-open
```

## Visualizar resumo no terminal

Para ver um resumo rápido da cobertura no terminal:

```bash
lcov --summary coverage/lcov.info
```

## Interpretando o Relatório

O relatório HTML mostra:

- **Linhas verdes**: Código coberto por testes
- **Linhas vermelhas**: Código não coberto
- **Linhas amarelas**: Código parcialmente coberto

### Métricas importantes:

- **Lines**: Porcentagem de linhas de código executadas
- **Functions**: Porcentagem de funções testadas
- **Branches**: Porcentagem de branches (if/else) testados

## Status Atual

Execute `make coverage` para ver o status atual da cobertura do projeto.

## Integração com CI/CD

O arquivo `coverage/lcov.info` pode ser usado com serviços como:

- **Codecov**: https://codecov.io
- **Coveralls**: https://coveralls.io
- **SonarQube**: https://www.sonarqube.org

## Dicas

1. **Foque em aumentar a cobertura gradualmente**: Não precisa testar tudo de uma vez
2. **Priorize código crítico**: Teste primeiro as funcionalidades mais importantes
3. **Use o relatório HTML**: É mais fácil identificar o que falta testar visualmente
4. **Execute regularmente**: Rode `make coverage` após adicionar novos testes

## Troubleshooting

### Erro: `genhtml: command not found`

Instale o lcov:
```bash
brew install lcov  # macOS
# ou
sudo apt-get install lcov  # Linux
```

### Relatório não atualiza

Certifique-se de executar os testes novamente:
```bash
fvm flutter test --coverage
```

### Arquivo lcov.info não encontrado

Execute os testes primeiro:
```bash
fvm flutter test --coverage
```

