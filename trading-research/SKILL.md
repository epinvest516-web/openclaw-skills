---
name: trading-research
description: "Research trading strategies from the web, codify them into Python classes, and backtest them against historical data. Uses Brave Search for knowledge and Claude/LLM for logic extraction."
metadata:
  {
    "openclaw": { "emoji": "🧠", "requires": { "tools": ["web_search", "web_fetch", "claude-code"] } }
  }
---

# Trading Researcher (The Scholar)

This skill allows OpenClaw to autonomously learn new trading strategies, convert them into executable Python code, and validate them.

## 🧠 Core Capabilities

### 1. Research (`/research learn`)
Searches the web for high-quality resources on a specific trading strategy (e.g., "Vegas Tunnel", "Turtle Trading").
- **Action**: Uses `web_search` to find tutorials/PDFs.
- **Action**: Uses `web_fetch` to extract the core logic (Entry, Exit, Risk).
- **Output**: A structured summary of the strategy's rules.

### 2. Codify (`/research codify`)
Converts the researched logic into a standardized Python class compatible with the Babata Bot framework.
- **Input**: The logic summary from step 1.
- **Output**: A `class StrategyName(BaseStrategy): ...` Python file.

### 3. Backtest (`/research backtest`)
Runs a historical simulation of the codified strategy.
- **Input**: The Python strategy file + Timeframe + Duration (e.g., "3 months").
- **Action**: Fetches deep history from MT5.
- **Output**: Win rate, Drawdown, Profit Factor.

## 🚀 Usage Examples

```bash
# 1. Learn a new strategy
/research learn "Naked K Price Action Pinbar Strategy"

# 2. Turn it into code
/research codify "Pinbar Strategy"

# 3. Prove it works (3 months)
/research backtest "Pinbar Strategy" --duration "90d"
```

## 🛠️ Integration with Babata Bot
Strategies approved by the backtest are moved to the `strategies/` folder in the main bot, allowing the "Meta-Strategy" selector to use them.
