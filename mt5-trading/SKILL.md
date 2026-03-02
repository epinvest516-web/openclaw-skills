---
name: mt5-trading
description: "Automated trading system management using Python and MetaTrader 5 API. V5.0 Optimized for aggressive compounding, ATR dynamic stops, and Telegram alerting."
metadata:
  {
    "openclaw": { "emoji": "📈", "requires": { "os": "windows", "apps": ["MetaTrader 5"] } }
  }
---

# MT5 Trading System Management (Babata V5.0 Edition)

This skill consolidates the hard-learned experience from deploying gold/silver trading bots on Windows Server 2022 VPS.

## 🛠️ Environment Wisdom

1.  **OS Requirement**: The `MetaTrader5` Python package is **Windows-only**.
2.  **Dependencies**: `pip install MetaTrader5 pandas numpy requests pytz`.
3.  **Filling Mode**: Most brokers for Spot Gold/Silver require **`ORDER_FILLING_FOK`**.

## 🚀 V5.0 Core Features (Aggressive & Safe)

### 1. 💰 Aggressive Compounding (The Engine)
Instead of fixed lots, use dynamic calculation based on equity:
```python
def calc_lot(balance):
    # Rule: 0.05 lots for every $1000 balance
    return (balance / 1000.0) * 0.05
```

### 2. 🛡️ ATR Dynamic Risk (The Shield)
Never use fixed points for SL/TP. Use ATR (Average True Range) to adapt to volatility:
- **SL**: 2.0 * ATR(14) (Wider in volatile markets, tighter in calm)
- **TP**: 4.0 * ATR(14) (Targeting 1:2 R:R)
- **Fixes**: Automatically prevents "Invalid Stops" errors by checking Broker StopLevel.

### 3. 📡 Telegram Alerting (The Radar)
Real-time push notifications for all critical events:
- **Startup**: Balance & Account check.
- **Trade**: Entry price, Lot size, SL/TP.
- **Risk**: Daily Drawdown triggers.

## 📈 24/7 Stability Pattern

- **Supervisor Loop**: Use `START_BOT.cmd` with a `:loop` to auto-restart crashes.
- **Scheduled Task**: Use `INSTALL_24X7_TASK.ps1` for boot-time startup.
- **Log Redirection**: Ensure `stdout` and `stderr` are captured in `bot.log`.

## 🔍 Verification Checklist

- **Process**: `tasklist /FI "IMAGENAME eq python.exe"`
- **Logs**: `Get-Content bot.log -Tail 20`
- **Telegram**: Check your connected chat for "🚀 Startup" message.
