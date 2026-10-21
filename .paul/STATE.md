---
description: "corel — current position and accumulated context"
type: ProjectState
about: "corel"
---

# Project State

## Project Reference

See: .paul/PROJECT.md (updated 2026-10-20)

**Core value:** CorelDRAW-class open source vector/print app on Linux, built on Inkscape.
**Current focus:** Phase 1 planning complete — PLAN 01-01 awaiting approval

## Current Position

Milestone: v0.1 Initial Release
Phase: 1 of 6 (Fork, build and rebrand) — in progress (2 of 3 plans)
Plan: 01-03 — Packaging (AppImage+Flatpak skeleton), CI, publish (PLAN created by opus, 4 ACs / 4 tasks)
Status: PLAN 01-03 ready, APPLY starting (full-auto)
Last activity: 2026-10-21 01:20 — Plan 01-03 written

Progress:
- Milestone: [██░░░░░░░░] 20%

## Loop Position

```
PLAN ──▶ APPLY ──▶ UNIFY
  ●        ○        ○     [01-03: packaging + CI + publish]
```

## Accumulated Context

### Decisions
- Fork Inkscape, keep GTK4; Linux only
- Worker pipeline: GLM-5.3 subagents + command-code deepseek-v4.1-flash + antigravity gemini-3.8-flash (also stills/images) as workers; claude-opus-5-5 as reviewer/fixer and plan author — recorded in .paul/config.md
- Checkpoint resolved: product name "Penrose", binary `penrose`, app-id `io.github.peter.Penrose` (user decision, supersedes auto-proposed "Pressmark"); trademark/domain checks pending before public release

### Deferred Issues
- Pending before any public release: EUIPO/USPTO trademark + domain checks for "Penrose" (carried from name checkpoint).

### Blockers/Concerns
- None open. Sudo deps install completed by user (14 packages). Build race workaround and all deviations recorded in 01-01-SUMMARY.md.
- Pending before any public release: EUIPO/USPTO trademark + domain checks for "Penrose".

## Session Continuity

Last session: 2026-10-21 01:05
Stopped at: Loop 01-02 closed (SUMMARY + STATE + ledger synced)
Next action: /paul:plan for 01-03 (packaging skeleton: AppImage, Flatpak manifest, CI; fix crash-dialog tracker URL + homepage placeholder)
Resume file: .paul/phases/01-fork-build/01-02-SUMMARY.md

---
*STATE.md — Updated after every significant action*
