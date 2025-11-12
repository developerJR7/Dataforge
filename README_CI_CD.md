# 🚀 CI/CD - GitHub Actions

## 📋 Visão Geral

Este projeto possui pipelines de CI/CD completos configurados no GitHub Actions para:
- ✅ **Serverpod**: Testes, linting e build
- ✅ **Flutter**: Testes, análise e build web
- ✅ **FastAPI**: Testes, linting e segurança
- ✅ **Integração**: Testes end-to-end

---

## 🔄 Workflows Configurados

### 1. CI - Serverpod (`.github/workflows/ci-serverpod.yml`)

**Trigger**: Push/PR em `dataforge_server/`

**Jobs**:
- **test**: Testes com PostgreSQL e Redis
- **lint**: Análise de código
- **build**: Compilação do servidor

**Serviços**:
- PostgreSQL 16
- Redis 6.2.6

### 2. CI - Flutter (`.github/workflows/ci-flutter.yml`)

**Trigger**: Push/PR em `dataforge_flutter/`

**Jobs**:
- **test**: Testes unitários e de widgets
- **build-web**: Build de produção
- **coverage**: Cobertura de código

### 3. CI - FastAPI (`.github/workflows/ci-fastapi.yml`)

**Trigger**: Push/PR em `fastapi_server/`

**Jobs**:
- **test**: Testes em múltiplas versões Python (3.9-3.12)
- **security**: Scan de segurança com Bandit

### 4. CI - Full Stack (`.github/workflows/ci-full.yml`)

**Trigger**: Push/PR em qualquer branch

**Jobs**:
- Executa todos os workflows acima
- Testes de integração

---

## 🎯 Como Funciona

### Push para `main` ou `develop`

1. **Análise de Código**
   - Linting (Dart, Python)
   - Formatação
   - Análise estática

2. **Testes**
   - Testes unitários
   - Testes de integração
   - Testes de widgets

3. **Build**
   - Compilação do Serverpod
   - Build do Flutter Web
   - Verificação de dependências

4. **Segurança**
   - Scan de vulnerabilidades
   - Análise de dependências

### Pull Request

- Executa os mesmos testes
- Bloqueia merge se testes falharem
- Mostra status no PR

---

## 📊 Badges de Status

Adicione ao README.md:

```markdown
![CI Serverpod](https://github.com/seu-usuario/dataforge/workflows/CI%20-%20Serverpod/badge.svg)
![CI Flutter](https://github.com/seu-usuario/dataforge/workflows/CI%20-%20Flutter/badge.svg)
![CI FastAPI](https://github.com/seu-usuario/dataforge/workflows/CI%20-%20FastAPI/badge.svg)
```

---

## 🔧 Configuração Local

### Testar Workflows Localmente

**Usando Act** (opcional):
```bash
# Instalar act
brew install act  # Mac
# ou
choco install act-cli  # Windows

# Executar workflow
act -j test
```

### Executar Mesmos Testes Localmente

```bash
# Serverpod
cd dataforge_server
dart pub get
dart analyze
dart test

# Flutter
cd dataforge_flutter
flutter pub get
flutter analyze
flutter test

# FastAPI
cd fastapi_server
pip install -r requirements.txt
pytest tests/ -v
```

---

## 🐛 Troubleshooting

### Testes Falhando no CI

1. **Verificar logs**: Clique no job falhado no GitHub
2. **Reproduzir localmente**: Execute os mesmos comandos
3. **Verificar dependências**: Certifique-se de que estão atualizadas

### Build Falhando

1. **Verificar versões**: Dart, Flutter, Python
2. **Limpar cache**: `dart pub cache clean`
3. **Reinstalar dependências**: `dart pub get`

---

## 📈 Métricas

### Tempo de Execução (Estimado)

- **Serverpod CI**: ~5-8 minutos
- **Flutter CI**: ~8-12 minutos
- **FastAPI CI**: ~3-5 minutos
- **Full Stack CI**: ~15-20 minutos

### Cobertura de Testes

- **Meta**: > 70%
- **Atual**: Estrutura implementada

---

## 🚀 Próximos Passos

### Deploy Automático

Adicionar workflows de deploy:

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      # ... steps de deploy
```

### Notificações

- Slack
- Email
- Discord

### Cache

Otimizar com cache de dependências (já implementado parcialmente).

---

## 📚 Recursos

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Dart CI](https://dart.dev/guides/testing)
- [Flutter CI](https://docs.flutter.dev/testing)
- [Pytest CI](https://docs.pytest.org/)

---

**Status**: ✅ Configurado e Funcional  
**Última atualização**: 2025-11-11

