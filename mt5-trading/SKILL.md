---
name: mt5-trading
description: "Automated trading system management using Python and MetaTrader 5 API. V6.0 Multi-Strategy Command Center with Automated Research & Reporting."
metadata:
  {
    "openclaw": { "emoji": "📈", "requires": { "os": "windows", "apps": ["MetaTrader 5"] } }
  }
---

# MT5 Trading System Management (Babata V6.0 Edition)

This skill consolidates the hard-learned experience from deploying gold/silver trading bots on Windows Server 2022 VPS.

## 🚀 V6.0 Core Features (Command Center)

### 1. 🧠 Multi-Strategy Engine (The Arsenal)
Integrated modular strategies:
- **SMC**: Market structure (BOS/CHoCH) and FVG identification.
- **Vegas Tunnel**: Trend following using 144/169 EMA tunnels.
- **Turtle Trading**: Classic 20/55 day Donchian Channel breakouts.
- **Naked Price Action**: High-precision Pinbar and Engulfing patterns at key levels.

### 2. 🚦 Intelligent Strategy Selector (The Brain)
Autonomous logic that judges and selects the highest-probability entry:
- **Consensus Mode**: Triggers high-priority orders when multiple strategies agree on a direction.
- **Regime Filtering**: Automatically adapts to Trending vs. Ranging markets.

### 3. 💰 Aggressive Money Management
Dynamic lot calculation based on account equity:
- **Compounding**: 0.05 lots per $1000 balance ($5k -> 0.25 lots).
- **ATR Stops**: Dynamic SL/TP based on 2x/4x ATR to survive market volatility.

### 4. 📊 Blackbox Reporting (The Analyst)
Every trade is logged with full technical context to `journal.csv`:
- **Daily Summaries**: Automated performance reports sent via Telegram at 23:50.
- **Root Cause Analysis**: Detailed logging of why a trade was opened or hit SL.

## 🛠️ Environment & Deployment

1.  **OS**: Windows-only (for `MetaTrader5` lib).
2.  **Dependencies**: `pip install MetaTrader5 pandas numpy requests pytz`.
3.  **Stability**: Controlled via `START_BOT.cmd` supervisor loop.
4.  **Sync**: Code is version-controlled and pushed to Github for global deployment.

## 🔍 Verification Checklist

- **Heartbeat**: Check Telegram for "📡 V6.0 Scanning" status.
- **Journal**: Review `journal.csv` for trade rationale.
- **Risk**: Confirm "Daily Drawdown" resets automatically at 00:00.
