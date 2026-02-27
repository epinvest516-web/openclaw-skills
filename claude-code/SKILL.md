---
name: claude-code
description: "Use the official Anthropic Claude Code CLI for agentic coding tasks. Supports file editing, command execution, and complex refactoring. Best for: (1) Deep architectural changes, (2) Bug fixing with stack trace analysis, (3) Automating git workflows. Requires 'claude' CLI installed and authenticated."
metadata:
  {
    "openclaw": { "emoji": "🤖", "requires": { "anyBins": ["claude"] } }
  }
---

# Claude Code (Official CLI)

This skill wraps the `@anthropic-ai/claude-code` tool. It provides a powerful, agentic coding experience directly in your terminal.

## 🛠️ Prerequisites

1.  **Install**:
    ```bash
    npm install -g @anthropic-ai/claude-code
    # Or macOS (Homebrew):
    # brew install --cask claude-code
    ```
2.  **Authenticate** (Run once manually):
    ```bash
    claude login
    ```
    *Follow the browser flow to connect your Anthropic account.*

## 🚀 Usage Patterns

**Always use `pty:true`** for `claude` commands to ensure proper interaction and output formatting.

### 1. One-Shot Task (The `-p` flag)
Use the `-p` (print/prompt) flag for single, non-interactive tasks or when piping input. This is best for automation.

```bash
# Direct task
bash pty:true workdir:~/my-project command:"claude -p 'Fix the bug in auth.ts where the token expires too soon'"

# Code Review (Pipe git diff)
bash pty:true workdir:~/my-project command:"git diff main | claude -p 'Review these changes for security vulnerabilities'"
```

### 2. Interactive Session
Start a persistent session where you can give follow-up instructions.

```bash
# Start session
bash pty:true workdir:~/my-project command:"claude"

# In the session (via process tool):
# > Write input: "Refactor the database schema"
# > Write input: "/compact" (to save context)
```

### 3. Project Configuration (`CLAUDE.md`)
Create a `CLAUDE.md` file in your project root to teach Claude about your project's style, build commands, and architecture.

```markdown
# CLAUDE.md
- Build command: `npm run build`
- Test command: `npm test`
- Style: Use TypeScript, functional components, and Tailwind CSS.
```

## 🎛️ Key Commands & Flags

| Command / Flag | Description |
| :--- | :--- |
| `claude` | Start interactive session |
| `claude -p "text"` | **Run one-shot prompt** (Recommended for agents) |
| `/compact` | Reduce context window usage (in session) |
| `/cost` | Show current session cost (in session) |
| `/init` | Initialize a new project with CLAUDE.md |
| `/bug` | Report a bug to Anthropic |

## ⚠️ Best Practices for Agents

1.  **Use `-p` for reliability**: When automating, `claude -p "prompt"` is more predictable than interacting with the shell REPL.
2.  **Safety**: Claude Code can execute shell commands. Ensure you are running in a safe environment or monitoring its output.
3.  **Context**: Always run from the root of the git repository (`workdir:~/project`) so Claude sees the full context.
4.  **Auto-Updates**: The npm package updates frequently. Run `npm update -g @anthropic-ai/claude-code` regularly.

## 🤖 Example Workflow: Feature Implementation

1.  **Plan**:
    ```bash
    bash pty:true command:"claude -p 'Read src/api and plan a rate-limiting feature'"
    ```
2.  **Implement**:
    ```bash
    bash pty:true command:"claude -p 'Implement the rate-limiting plan using Redis'"
    ```
3.  **Verify**:
    ```bash
    bash pty:true command:"claude -p 'Write a test for the rate limiter and run it'"
    ```
