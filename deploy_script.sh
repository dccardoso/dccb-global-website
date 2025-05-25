#!/bin/bash

# Deploy Script para DCCB Global Website
# Execute este script para fazer deploy automatizado

echo "🚀 Iniciando deploy do DCCB Global Website..."

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para print colorido
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    print_error "Arquivo index.html não encontrado!"
    print_info "Execute este script na pasta do projeto."
    exit 1
fi

print_status "Pasta do projeto verificada"

# Verificar se git está inicializado
if [ ! -d ".git" ]; then
    print_warning "Git não inicializado. Inicializando..."
    git init
    git branch -M main
    print_status "Git inicializado"
fi

# Adicionar arquivos
print_info "Adicionando arquivos ao git..."
git add .

# Verificar se há mudanças
if git diff --staged --quiet; then
    print_warning "Nenhuma mudança detectada"
    exit 0
fi

# Commit com timestamp
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
commit_message="Deploy: Atualização do site - $timestamp"

print_info "Fazendo commit: $commit_message"
git commit -m "$commit_message"

# Verificar se remote origin existe
if ! git remote get-url origin &>/dev/null; then
    print_warning "Remote 'origin' não configurado."
    print_info "Configure manualmente com:"
    print_info "git remote add origin https://github.com/SEU_USUARIO/dccb-global-website.git"
    exit 1
fi

# Push para GitHub
print_info "Enviando para GitHub..."
if git push origin main; then
    print_status "Deploy enviado com sucesso!"
    print_info "O Cloudflare Pages fará o deploy automaticamente em alguns minutos."
    print_info "Acesse: https://dccbglobal.com para verificar"
else
    print_error "Erro no push. Verifique sua conexão e credenciais."
    exit 1
fi

echo ""
print_status "Deploy concluído! 🎉"
print_info "Próximos passos:"
echo "  1. Aguarde 2-5 minutos para o deploy no Cloudflare Pages"
echo "  2. Acesse https://dccbglobal.com para verificar"
echo "  3. Limpe o cache se necessário (Ctrl+F5)"

---

# package.json (para futuras expansões com npm)
{
  "name": "dccb-global-website",
  "version": "1.0.0",
  "description": "Website oficial DCCB Global - Óleos Essenciais DoTerra",
  "main": "index.html",
  "scripts": {
    "dev": "python3 -m http.server 8000",
    "deploy": "./deploy.sh",
    "build": "echo 'Site estático - nenhum build necessário'",
    "lint": "echo 'Validação HTML pendente'",
    "test": "echo 'Testes pendentes'"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/SEU_USUARIO/dccb-global-website.git"
  },
  "keywords": [
    "oleos-essenciais",
    "doterra",
    "aromaterapia",
    "bem-estar",
    "juridico",
    "tecnologia"
  ],
  "author": "DCCB Global",
  "license": "All Rights Reserved",
  "homepage": "https://dccbglobal.com"
}