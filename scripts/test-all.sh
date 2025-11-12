#!/bin/bash

# Script para executar todos os testes
set -e

echo "🧪 Executando todos os testes..."

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Testes Serverpod
echo -e "${GREEN}📦 Testando Serverpod...${NC}"
cd dataforge_server
dart pub get
serverpod generate
dart analyze
dart test
cd ..

# Testes Flutter
echo -e "${GREEN}📱 Testando Flutter...${NC}"
cd dataforge_flutter
flutter pub get
flutter analyze
flutter test
cd ..

# Testes FastAPI
echo -e "${GREEN}🐍 Testando FastAPI...${NC}"
cd fastapi_server
python -m pip install -r requirements.txt
pip install pytest pytest-cov
pytest tests/ -v
cd ..

echo -e "${GREEN}✅ Todos os testes concluídos!${NC}"

