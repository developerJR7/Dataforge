# DataForge Challenge

Projeto fullstack que integra **Serverpod (Dart)** para backend, **Flutter Web** como interface e uma **API FastAPI (Python)** protegida por JWT. O repositório reúne tudo que é necessário para rodar, testar e demonstrar as entregas do desafio.

## 📂 Estrutura

```
dataforge/
├── dataforge_server/      # Servidor Serverpod + migrações e endpoints
├── dataforge_client/      # Cliente gerado pelo Serverpod (Dart)
├── dataforge_flutter/     # Aplicação Flutter (Web/Desktop)
└── fastapi_server/        # API FastAPI com autenticação JWT
```

## ✅ Funcionalidades Implementadas

- **Serverpod**
  - Endpoints `auth.register`, `auth.login` e `auth.getCurrentUser`
  - Tabelas `user` e `task` com migração `20251112130756760` (inclui `username` e `passwordHash`)
  - Endpoints `user.getAll`, `user.create`, `task.getAll`, `task.create`
  - Hash de senha via SHA-256
- **Flutter**
  - Tela de autenticação Serverpod (login/registro)
  - Aba para listar/criar usuários e tasks (consumindo os endpoints acima)
  - Aba integrada ao FastAPI (login com JWT + consumo de dados protegidos)
  - Validação de formulário evitando `FormatException` em `User ID`
- **FastAPI**
  - Endpoint `/token` para login e emissão de JWT
  - Endpoint protegido `/protected-data` com dados fictícios
  - Usuários de teste: `admin/admin123` e `user/user123`

## 🔧 Pré-requisitos

| Ferramenta | Versão recomendada |
|------------|---------------------|
| Dart SDK   | 3.5.0+              |
| Flutter    | 3.24.0+             |
| Python     | **3.11** (ou 3.10)  |
| Docker     | Desktop (para Postgres/Redis) |
| Serverpod CLI | `dart pub global activate serverpod_cli` |

> ⚠️ O FastAPI usa bibliotecas (pydantic-core) que ainda não têm wheels para Python 3.14. Utilize Python 3.11 para evitar erros de compilação.

## ⚙️ Preparação dos Ambientes

### 1. Banco de dados e serviços de suporte

```powershell
cd dataforge_server
docker compose up --detach
```

Isso sobe Postgres (`localhost:8090`) e Redis (`localhost:8091`).

### 2. Serverpod

```powershell
cd dataforge_server
dart pub get

# (Opcional) Gerar código caso altere YAMLs
dart pub global run serverpod_cli generate

# Aplicar a migração criada (já versionada no repo)
docker cp migrations\20251112130756760\migration.sql dataforge_server-postgres-1:/tmp/migration.sql
docker exec dataforge_server-postgres-1 psql -U postgres -d dataforge -f /tmp/migration.sql

# Iniciar o servidor
dart bin/main.dart
```

O servidor ficará disponível em `http://localhost:8080/`.

> 💡 Para testar rapidamente o endpoint de registro sem a UI, use:
>
> ```powershell
> cd ..\dataforge_client
> dart run bin/register_check.dart
> ```

### 3. FastAPI

```powershell
cd fastapi_server
py -3.11 -m venv venv
.\venv\Scripts\Activate.ps1
pip install --upgrade pip
pip install -r requirements.txt
python -m uvicorn main:app --reload --port 8001
```

Acesse `http://127.0.0.1:8001/` ou `.../docs` para confirmar que está respondendo.

### 4. Flutter

```powershell
cd dataforge_flutter
flutter pub get
flutter run -d chrome          # ou -d windows
```

A aplicação detecta o servidor Serverpod em `http://localhost:8080/`. Na aba FastAPI, se estiver rodando localmente, deixe o auth em `http://127.0.0.1:8001` (padrão já definido no código).

## 🔐 Credenciais de Teste

- **FastAPI**
  - `admin` / `admin123`
  - `user` / `user123`
- **Serverpod**
  - Registre um usuário pelo Flutter ou usando o script `register_check.dart`.

## 🧪 Testes

- Script de verificação de registro: `dart run bin/register_check.dart`
- (Opcional) Ajustar/rodar testes unitários em `dataforge_server/test/**`

## 📸 Fluxo recomendado de validação

1. Suba Docker, Serverpod e FastAPI.
2. Registre um usuário via Flutter (aba “Login”).
3. Confira a listagem em “Data” > “Users”.
4. Crie uma task informando o `User ID` numérico do card listado.
5. Faça login na aba FastAPI com `admin` / `admin123` e carregue os dados protegidos.
6. Rode `dart run bin/register_check.dart` para confirmar que o endpoint responde via client gerado.

## 🪪 Publicação do Projeto

Caso queira levar os serviços para outro ambiente:
- Execute o SQL da pasta `migrations/20251112130756760/migration.sql` no Postgres alvo antes de iniciar o Serverpod.
- Configure as variáveis/hosts em `dataforge_flutter/lib/main.dart` e `fastapi_server/main.py` conforme necessário.

## 📤 Como criar o repositório no Git

Dentro da pasta `dataforge` (raiz do projeto):

```powershell
git init
git branch -M main
git add .
git commit -m "Initial challenge delivery"
```

Crie o repositório remoto (GitHub, GitLab etc.) e vincule:

```powershell
git remote add origin <URL_DO_REPOSITORIO>
git push -u origin main
```

> Dica: antes do commit final, rode `git status` para garantir que apenas os arquivos relevantes (migrações, README, ajustes de Flutter, script de teste) estão sendo versionados.

Pronto! Com esses passos o avaliador consegue reproduzir toda a solução end-to-end.

