# Estrutura de Testes

Esta pasta contém todos os testes do projeto Aurea App, organizados por tipo.

## Estrutura de Pastas

```
test/
├── helpers/              # Helpers e utilitários para testes
├── unit/                 # Testes unitários
│   ├── repositories/     # Testes de repositórios
│   ├── providers/        # Testes de providers
│   ├── blocs/            # Testes de BLoCs
│   └── cubits/           # Testes de Cubits
├── widget/               # Testes de widgets
│   ├── screens/          # Testes de telas
│   └── widgets/          # Testes de widgets reutilizáveis
└── integration/          # Testes de integração
```

## Como Executar os Testes

### Todos os testes
```bash
flutter test
```

### Testes unitários específicos
```bash
flutter test test/unit/blocs/auth_bloc_test.dart
```

### Testes de widget específicos
```bash
flutter test test/widget/screens/login_page_test.dart
```

### Testes de integração
```bash
flutter test integration_test/app_test.dart
```

### Com cobertura
```bash
flutter test --coverage
```

## Dependências de Teste

- `flutter_test`: Framework de testes do Flutter
- `mocktail`: Biblioteca para criar mocks
- `bloc_test`: Biblioteca para testar BLoCs e Cubits
- `integration_test`: Framework para testes de integração

## Convenções

1. **Nomenclatura**: Use `*_test.dart` para todos os arquivos de teste
2. **Organização**: Agrupe testes relacionados usando `group()`
3. **Mocks**: Use `mocktail` para criar mocks de dependências
4. **Helpers**: Coloque funções auxiliares em `test/helpers/`

