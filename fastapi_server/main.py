from datetime import datetime, timedelta
from typing import Optional, List
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware
from jose import JWTError, jwt
from pydantic import BaseModel
import secrets

# Configuração
SECRET_KEY = secrets.token_urlsafe(32)
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# Dados fictícios para demonstração
FAKE_DATA = [
    {"id": 1, "title": "Item Fictício 1", "description": "Descrição do item 1", "value": 100.50},
    {"id": 2, "title": "Item Fictício 2", "description": "Descrição do item 2", "value": 250.75},
    {"id": 3, "title": "Item Fictício 3", "description": "Descrição do item 3", "value": 500.00},
    {"id": 4, "title": "Item Fictício 4", "description": "Descrição do item 4", "value": 750.25},
    {"id": 5, "title": "Item Fictício 5", "description": "Descrição do item 5", "value": 1000.00},
]

# Usuários fictícios para autenticação
FAKE_USERS = {
    "admin": {
        "username": "admin",
        "password": "admin123",  # Em produção, usar hash
        "email": "admin@example.com",
    },
    "user": {
        "username": "user",
        "password": "user123",
        "email": "user@example.com",
    },
}

app = FastAPI(title="FastAPI Server - DataForge Challenge")

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://127.0.0.1:8080", "http://localhost:8080", "*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: Optional[str] = None


class FakeDataItem(BaseModel):
    id: int
    title: str
    description: str
    value: float


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verifica senha (simplificado - em produção usar bcrypt)"""
    return plain_password == hashed_password


def get_user(username: str):
    """Retorna usuário fictício"""
    return FAKE_USERS.get(username)


def authenticate_user(username: str, password: str):
    """Autentica usuário"""
    user = get_user(username)
    if not user:
        return False
    if not verify_password(password, user["password"]):
        return False
    return user


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    """Cria token JWT"""
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(token: str = Depends(oauth2_scheme)):
    """Obtém usuário atual do token"""
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
        token_data = TokenData(username=username)
    except JWTError:
        raise credentials_exception
    user = get_user(username=token_data.username)
    if user is None:
        raise credentials_exception
    return user


@app.post("/token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    """Endpoint de login - retorna JWT token"""
    user = authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user["username"]}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}


@app.get("/protected-data", response_model=List[FakeDataItem])
async def get_protected_data(current_user: dict = Depends(get_current_user)):
    """Endpoint protegido que retorna dados fictícios"""
    return FAKE_DATA


@app.get("/")
async def root():
    """Endpoint raiz"""
    return {"message": "FastAPI Server - DataForge Challenge", "status": "running"}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001)

