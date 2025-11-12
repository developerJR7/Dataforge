@echo off
REM Script para executar todos os testes no Windows

echo 🧪 Executando todos os testes...

REM Testes Serverpod
echo 📦 Testando Serverpod...
cd dataforge_server
dart pub get
serverpod generate
dart analyze
dart test
cd ..

REM Testes Flutter
echo 📱 Testando Flutter...
cd dataforge_flutter
flutter pub get
flutter analyze
flutter test
cd ..

REM Testes FastAPI
echo 🐍 Testando FastAPI...
cd fastapi_server
python -m pip install -r requirements.txt
pip install pytest pytest-cov
pytest tests\ -v
cd ..

echo ✅ Todos os testes concluídos!

