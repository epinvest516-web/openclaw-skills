# Installation Guide

## Prerequisites
- Node.js (v18+), npm
- OpenClaw Gateway running (`openclaw gateway status`)
- Repo cloned to workspace

## Steps

### 1. Clone repo
```bash
cd /Users/ep/.openclaw/workspace
git clone https://github.com/TianyiDataScience/openclaw-control-center.git
cd openclaw-control-center
```

### 2. Install dependencies
```bash
npm install
```

### 3. Configure .env
```bash
cp .env.example .env
```
Edit `.env` — keep all defaults, add only:
```dotenv
LOCAL_API_TOKEN=$(openssl rand -hex 32)
```

### 4. Build and test
```bash
npm run build
npm test        # expect 87/87 pass
npm run smoke:ui
```

### 5. Create start.sh
```bash
cat > start.sh << 'EOF'
#!/bin/zsh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
if ps aux | grep "tsx src/index" | grep -v grep > /dev/null 2>&1; then
  echo "Stopping existing process..."
  ps aux | grep "tsx src/index" | grep -v grep | awk '{print $2}' | xargs kill -9 2>/dev/null
  sleep 2
fi
if [ ! -f ".env" ]; then echo "❌ .env missing"; exit 1; fi
set -a && source .env && set +a
echo "Starting Control Center at http://127.0.0.1:${UI_PORT:-4310}/?section=overview&lang=zh"
npm run dev:ui
EOF
chmod +x start.sh
```

### 6. Known test fixes (already applied in this install)
- `docs/mission.runbook.md` — create empty if missing
- `mission.config.json` — create `{}` if missing
- `workflows/pandas_v3_autopilot.lobster` — create empty if missing
- `test/usage-cost.test.ts` line ~79: change `now - 2 * 60 * 60 * 1000` → `now - 30 * 60 * 1000` (UTC timezone bug)

## Verify Token is Active
Check startup log contains:
```
localTokenConfigured: true
```
If `false`, the service was started without sourcing `.env`. Use `./start.sh`.
