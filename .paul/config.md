# Project Config

**Project:** corel
**Updated:** 2026-10-20

## Project Settings

```yaml
project:
  name: corel
  version: "0.0.0"
```

## Worker Pipeline (multi-model routing)

```yaml
workers:
  orchestrator_subagents:   # task/scout subagents
    model: zai/glm-5.3-flash
    role: worker
  command_code:             # `command-code -p --model deepseek/deepseek-v4.1-flash`
    model: deepseek/deepseek-v4.1-flash
    role: worker
  antigravity_mcp:          # xd://mcp__antigravity_code (agy-gemini38)
    model: gemini-3.8-flash
    role: worker + stills/images
  claude_cli:               # `claude -p --model claude-opus-5-5`
    model: claude-opus-5-5
    role: reviewer + fixer + .paul/plan author
routing:
  - implementation work → workers (subagents, command-code, antigravity)
  - stills/images → antigravity MCP (promptFile for long prompts)
  - every completed slice → claude opus 5.5 review before done
  - plan documents (.paul/plan) authored by claude opus 5.5
```

## Integrations

### SonarQube

```yaml
sonarqube:
  enabled: false
  project_key: corel
```

### Enterprise Plan Audit

```yaml
enterprise_plan_audit:
  enabled: false
```

## Preferences

```yaml
preferences:
  auto_commit: false
  verbose_output: false
```

---
*Config updated: 2026-10-20*
