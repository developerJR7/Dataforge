# Script PowerShell para verificar tudo que foi criado

Write-Host "🔍 Verificando estrutura do projeto..." -ForegroundColor Cyan

# Verificar estrutura de diretórios
Write-Host "`n📁 Estrutura de Diretórios:" -ForegroundColor Yellow
Get-ChildItem -Directory | Select-Object Name

# Verificar arquivos principais
Write-Host "`n📄 Arquivos de Documentação:" -ForegroundColor Yellow
Get-ChildItem -Filter "*.md" | Select-Object Name

# Verificar workflows CI/CD
Write-Host "`n🔄 Workflows CI/CD:" -ForegroundColor Yellow
if (Test-Path ".github\workflows") {
    Get-ChildItem ".github\workflows" -Filter "*.yml" | Select-Object Name
} else {
    Write-Host "  ❌ Pasta .github/workflows não encontrada" -ForegroundColor Red
}

# Verificar scripts
Write-Host "`n📜 Scripts:" -ForegroundColor Yellow
if (Test-Path "scripts") {
    Get-ChildItem "scripts" | Select-Object Name
} else {
    Write-Host "  ❌ Pasta scripts não encontrada" -ForegroundColor Red
}

# Verificar Serverpod
Write-Host "`n📦 Serverpod:" -ForegroundColor Yellow
if (Test-Path "dataforge_server") {
    Write-Host "  ✅ Pasta dataforge_server encontrada"
    if (Test-Path "dataforge_server\lib\src\endpoints\auth_endpoint.dart") {
        Write-Host "  ✅ auth_endpoint.dart encontrado" -ForegroundColor Green
    }
    if (Test-Path "dataforge_server\test\unit") {
        Write-Host "  ✅ Testes unitários encontrados" -ForegroundColor Green
    }
} else {
    Write-Host "  ❌ Pasta dataforge_server não encontrada" -ForegroundColor Red
}

# Verificar Flutter
Write-Host "`n📱 Flutter:" -ForegroundColor Yellow
if (Test-Path "dataforge_flutter") {
    Write-Host "  ✅ Pasta dataforge_flutter encontrada"
    if (Test-Path "dataforge_flutter\lib\main.dart") {
        Write-Host "  ✅ main.dart encontrado" -ForegroundColor Green
    }
    if (Test-Path "dataforge_flutter\test") {
        Write-Host "  ✅ Testes encontrados" -ForegroundColor Green
    }
} else {
    Write-Host "  ❌ Pasta dataforge_flutter não encontrada" -ForegroundColor Red
}

# Verificar FastAPI
Write-Host "`n🐍 FastAPI:" -ForegroundColor Yellow
if (Test-Path "fastapi_server") {
    Write-Host "  ✅ Pasta fastapi_server encontrada"
    if (Test-Path "fastapi_server\main.py") {
        Write-Host "  ✅ main.py encontrado" -ForegroundColor Green
    }
    if (Test-Path "fastapi_server\tests") {
        Write-Host "  ✅ Testes encontrados" -ForegroundColor Green
    }
} else {
    Write-Host "  ❌ Pasta fastapi_server não encontrada" -ForegroundColor Red
}

Write-Host "`n✅ Verificação completa!" -ForegroundColor Green
Write-Host "`n📚 Para testar tudo, veja: GUIA_TESTE_COMPLETO.md" -ForegroundColor Cyan

