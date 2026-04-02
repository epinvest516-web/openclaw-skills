---
name: claude-code
description: "Use the official Anthropic Claude Code CLI for agentic coding tasks. Supports file editing, command execution, and complex refactoring. Best for: (1) Deep architectural changes, (2) Bug fixing with stack trace analysis, (3) Automating git workflows. Requires 'claude' CLI installed and authenticated."
metadata:
  {
    "openclaw": { "emoji": "🤖", "requires": { "anyBins": ["claude"] } }
  }
---

# Claude Code (Official CLI) - Babata Edition 😈

This skill wraps the `@anthropic-ai/claude-code` tool. It provides a powerful, agentic coding experience directly in your terminal.

## 🛠️ Prerequisites & Installation

Based on the official docs (https://code.claude.com/docs):

1.  **Native Install (Recommended)**:
    - **macOS/Linux**: `curl -fsSL https://claude.ai/install.sh | bash`
    - **Windows (PowerShell)**: `irm https://claude.ai/install.ps1 | iex`
2.  **Authenticate**:
    ```bash
    claude login
    ```
    *Follow the browser flow to connect your Anthropic account.*

## 🚀 Usage Patterns (Optimized for Clawdbot)

**Always use `pty:true`** for `claude` commands to ensure proper interaction and output formatting.

### 1. One-Shot Agentic Prompt (Recommended)
Use the `-p` flag for single, non-interactive tasks. This is the primary method for Babata to delegate work.

```bash
# General task
bash pty:true workdir:/path/to/project command:"claude -p 'Fix the bug in auth.ts where the token expires too soon'"

# Analysis task
bash pty:true workdir:/path/to/project command:"claude -p 'Read the src/ directory and summarize the architecture'"
```

### 2. Sub-Agent Orchestration
Claude Code can spawn multiple agents to work on different parts of a task simultaneously.

```bash
bash pty:true command:"claude -p 'Spawn a sub-agent to write tests for the API while I implement the logic'"
```

### 3. Git Workflow Automation
Claude Code understands your git history and can automate commits and PRs.

```bash
bash pty:true command:"claude -p 'Commit my changes with a descriptive message and push to origin/feature-branch'"
```

## 🧠 Memory & Project Context

### `CLAUDE.md`
Create a `CLAUDE.md` file in your project root to teach Claude about your project's style, build commands, and architecture. This is **mandatory** for any complex project.

```markdown
# CLAUDE.md
- Build: `npm run build`
- Test: `npm test`
- Guidelines: Use TypeScript, functional components, and Tailwind.
- Memory: The MT5 bot requires FOK filling mode.
```

### Auto Memory
Claude Code builds "Auto Memory" as it works, saving learnings like build commands and debugging insights across sessions.

## 🎛️ Key Commands & Flags

| Command / Flag | Description |
| :--- | :--- |
| `claude` | Start interactive session |
| `claude -p "text"` | **Run one-shot prompt** (The "Clawdbot Standard") |
| `/compact` | Reduce context window usage (in session) |
| `/cost` | Show current session cost (in session) |
| `/init` | Initialize a new project with CLAUDE.md |

## ⚠️ Best Practices

1.  **Workdir Matters**: Always specify `workdir` to the root of the git repository so Claude has full context.
2.  **Extended Thinking**: For complex logic, Claude Code automatically uses extended thinking.
3.  **Security**: Claude Code can run shell commands. Monitor its plan before it executes.
4.  **Updates**: Run `npm update -g @anthropic-ai/claude-code` regularly or follow the native install update path.
