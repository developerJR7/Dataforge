# FastAPI Server

API FastAPI com autenticação JWT para o desafio técnico DataForge.

## Instalação

```bash
pip install -r requirements.txt
```

## Execução

```bash
python main.py
```

Ou usando uvicorn diretamente:

```bash
uvicorn main:app --reload --port 8000
```

## Endpoints

### POST /token
Login e obtenção de token JWT.

**Body (form-data):**
- username: admin
- password: admin123

**Resposta:**
```json
{
  "access_token": "eyJ...",
  "token_type": "bearer"
}
```

### GET /protected-data
Endpoint protegido que retorna dados fictícios. Requer autenticação JWT.

**Headers:**
```
Authorization: Bearer <token>
```

**Resposta:**
```json
[
  {
    "id": 1,
    "title": "Item Fictício 1",
    "description": "Descrição do item 1",
    "value": 100.50
  },
  ...
]
```

## Usuários de Teste

- **admin** / **admin123**
- **user** / **user123**

