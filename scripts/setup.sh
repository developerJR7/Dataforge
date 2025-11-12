#!/bin/bash

# Script de setup completo do projeto
set -e

echo "🚀 Configurando projeto DataForge..."

# Verificar dependências
echo "📋 Verificando dependências..."

command -v dart >/dev/null 2>&1 || { echo "❌ Dart não encontrado"; exit 1; }
command -v flutter >/dev/null 2>&1 || { echo "❌ Flutter não encontrado"; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "❌ Python não encontrado"; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "❌ Docker não encontrado"; exit 1; }

echo "✅ Todas as dependências encontradas"

# Setup Serverpod
echo "📦 Configurando Serverpod..."
cd dataforge_server
dart pub get
dart pub global activate serverpod_cli
serverpod generate
cd ..

# Setup Flutter
echo "📱 Configurando Flutter..."
cd dataforge_flutter
flutter pub get
cd ..

# Setup FastAPI
echo "🐍 Configurando FastAPI..."
cd fastapi_server
python3 -m venv venv || python -m venv venv
source venv/bin/activate || venv\Scripts\activate
pip install -r requirements.txt
cd ..

echo "✅ Setup completo!"

