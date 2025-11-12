# Script para iniciar o projeto - Execute da pasta raiz
# Execute: cd .. && .\EXECUTAR_AQUI.ps1

Write-Host "Você está na pasta dataforge_flutter" -ForegroundColor Yellow
Write-Host "Navegando para pasta raiz..." -ForegroundColor Yellow
Write-Host ""

# Navegar para pasta raiz
Set-Location ..

# Verificar se o arquivo existe
if (Test-Path "EXECUTAR_AQUI.ps1") {
    Write-Host "Executando script principal..." -ForegroundColor Green
    Write-Host ""
    & ".\EXECUTAR_AQUI.ps1"
} else {
    Write-Host "ERRO: Arquivo EXECUTAR_AQUI.ps1 não encontrado!" -ForegroundColor Red
    Write-Host "Execute este script da pasta raiz do projeto (dataforge)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Pasta atual: $PWD" -ForegroundColor Cyan
    Write-Host "Execute: cd C:\Users\jrmon\dataforge" -ForegroundColor Yellow
}

