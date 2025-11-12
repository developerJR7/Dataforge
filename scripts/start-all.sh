#!/bin/bash

# Script para iniciar todos os serviços
set -e

echo "🚀 Iniciando todos os serviços..."

# Iniciar Docker
echo "🐳 Iniciando Docker containers..."
cd dataforge_server
docker compose up -d
sleep 5
cd ..

# Aplicar migrações
echo "📊 Aplicando migrações..."
cd dataforge_server
serverpod create-migration
serverpod apply-migrations
cd ..

echo "✅ Serviços iniciados!"
echo ""
echo "Para iniciar os servidores:"
echo "  Terminal 1: cd dataforge_server && dart bin/main.dart"
echo "  Terminal 2: cd fastapi_server && python main.py"
echo "  Terminal 3: cd dataforge_flutter && flutter run -d chrome"

