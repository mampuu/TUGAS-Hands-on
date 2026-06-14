#!/bin/bash

# Konfigurasi
VPS_IP="192.168.1.55"
VPS_USER="enricho"
APP_DIR="~/apps/my-cloud-app"
REPO_URL="https://github.com/mampuu/TUGAS-Hands-on.git"

echo "🚀 Starting deployment to VPS..."

# 1. Push latest code ke GitHub
echo "📤 Pushing code to GitHub..."
git push origin main

# 2. SSH ke VPS dan pull latest code
echo "🖥️ Connecting to VPS and pulling updates..."
ssh $VPS_USER@$VPS_IP << 'REMOTE'
  cd ~/apps/my-cloud-app
  echo "⬇️ Pulling latest code..."
  git pull origin main

  echo "📦 Installing dependencies..."
  npm install --production

  echo "🔄 Restarting application with PM2..."
  pm2 reload my-cloud-app --update-env

  echo "✅ Deployment completed!"
REMOTE

echo "🎉 Deploy finished successfully!"
echo "🌐 Check: http://$VPS_IP"
