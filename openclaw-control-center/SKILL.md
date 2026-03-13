---
name: openclaw-control-center
description: Install, configure, start, and operate the OpenClaw Control Center — a local-first web UI for monitoring all OpenClaw agents, tasks, token usage, memory, and docs. Use when: installing the Control Center for the first time, starting or restarting the service, configuring LOCAL_API_TOKEN authentication, querying the Control Center API, troubleshooting connectivity or blank panels, or explaining what any panel shows. NOT for: modifying OpenClaw gateway config, managing agent sessions directly, or editing channel plugin settings.
---

# OpenClaw Control Center Skill

Local-first web dashboard for OpenClaw. Shows agent status, task execution, token usage, memory files, and docs.

## Environment (Ethen's Mac mini)

- **Repo**: `/Users/ep/.openclaw/workspace/openclaw-control-center`
- **URL**: `http://127.0.0.1:4310/?section=overview&lang=zh`
- **Token**: stored in `TOOLS.md` under "OpenClaw Control Center"
- **Gateway**: `ws://127.0.0.1:18789`

## Start the Service

```bash
cd /Users/ep/.openclaw/workspace/openclaw-control-center && ./start.sh
```

`start.sh` kills any existing process, sources `.env` (required — no dotenv), then runs `npm run dev:ui`.

**Critical**: always use `./start.sh` or manually `source .env` before starting. Raw `npm run dev:ui` skips env vars and LOCAL_API_TOKEN won't load.

## Stop the Service

Ctrl+C in the terminal, or:
```bash
ps aux | grep "tsx src/index" | grep -v grep | awk '{print $2}' | xargs kill -9
```

## Check Running Status

```bash
curl -s http://127.0.0.1:4310/healthz | python3 -m json.tool
```

Look for `"ok": true` and `"localTokenConfigured": true` in the startup log.

## API Calls (require token)

```bash
TOKEN=$(grep LOCAL_API_TOKEN /Users/ep/.openclaw/workspace/openclaw-control-center/.env | grep -v '#' | cut -d= -f2)

# Health check (no auth required)
curl -s http://127.0.0.1:4310/healthz

# Usage/cost data
curl -s -H "x-local-token: $TOKEN" http://127.0.0.1:4310/api/usage-cost

# Sessions list
curl -s -H "x-local-token: $TOKEN" http://127.0.0.1:4310/sessions

# Agent roster
curl -s -H "x-local-token: $TOKEN" http://127.0.0.1:4310/snapshot
```

## Security Config (`.env`)

```dotenv
GATEWAY_URL=ws://127.0.0.1:18789
READONLY_MODE=true
LOCAL_TOKEN_AUTH_REQUIRED=true
LOCAL_API_TOKEN=<token>          # required — source .env before starting
APPROVAL_ACTIONS_ENABLED=false
APPROVAL_ACTIONS_DRY_RUN=true
IMPORT_MUTATION_ENABLED=false
IMPORT_MUTATION_DRY_RUN=false
UI_MODE=false
UI_PORT=4310
```

## First-time Install

See `references/install.md` for full install steps.

## Panels

| Panel | Purpose |
|-------|---------|
| 总览 Overview | System health, pending items, alerts |
| 用量 Usage | Token burn, cost trend, quota (today/7d/30d) |
| 员工 Staff | Real-time agent status (Working/Standby/Idle) |
| 任务 Tasks | Task board, execution chain, approvals |
| 文档 Docs | Source file workbench for shared docs |
| 记忆 Memory | Per-agent memory files (MEMORY.md, daily logs) |

## Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| Port 4310 in use | Old process still running | Run `./start.sh` (auto-kills) |
| `localTokenConfigured: false` | Started without sourcing .env | Use `./start.sh` |
| Staff/tasks blank | Gateway not connected | `openclaw gateway status` |
| 401 on API | Missing token header | Add `x-local-token: <TOKEN>` |
| Usage panel "未连接" | No Codex subscription data | Normal if using API key; other panels work |
