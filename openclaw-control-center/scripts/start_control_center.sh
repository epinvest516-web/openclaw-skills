#!/bin/zsh
# OpenClaw Control Center - Start Script
# Usage: ./start_control_center.sh [repo-path]

REPO="${1:-/Users/ep/.openclaw/workspace/openclaw-control-center}"

if [ ! -d "$REPO" ]; then
  echo "❌ Repo not found at $REPO"
  echo "   Run: git clone https://github.com/TianyiDataScience/openclaw-control-center.git $REPO"
  exit 1
fi

cd "$REPO"

# Kill existing process
if ps aux | grep "tsx src/index" | grep -v grep > /dev/null 2>&1; then
  echo "⚠️  Stopping existing process..."
  ps aux | grep "tsx src/index" | grep -v grep | awk '{print $2}' | xargs kill -9 2>/dev/null
  sleep 2
fi

# Check .env
if [ ! -f ".env" ]; then
  echo "❌ .env not found. Run: cp .env.example .env and configure LOCAL_API_TOKEN"
  exit 1
fi

# Load env vars (critical - no dotenv in this project)
set -a && source .env && set +a

PORT="${UI_PORT:-4310}"
echo "🚀 OpenClaw Control Center starting..."
echo "   URL: http://127.0.0.1:${PORT}/?section=overview&lang=zh"

npm run dev:ui
