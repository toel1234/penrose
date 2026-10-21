---
phase: 01-fork-build
plan: 01
completed: 2026-10-21T00:20:00+02:00
duration: ~3h (including user sudo wait)
description: "Upstream Inkscape pinned at 3d6e954a (GTK4 master), builds in 267s, passes all smoke tests; branding placeholders wired; 13-category rebrand inventory; product name Penrose"
type: Summary
about: corel
---

# Phase 1 Plan 01: Pinned base, local build, rebrand groundwork — Summary

The empty project repo became a working GPL fork base: upstream Inkscape master pinned with full history, reproducible deps/build/run scripts, a locally installed running binary, branding placeholders, and a complete rebrand touchpoint inventory.

## What Was Built

| File | Purpose |
|------|---------|
| git repo (upstream remote, tag `fork-base`, branch `main`) | GPL fork base at `3d6e954a0a5d5d71371044103be63e9e5503fdd2`, 29,794 commits, submodules initialized |
| `fork/UPSTREAM_BASE` | Pinned sha/ref/gtk_major=4/fetched record (SPDX header) |
| `fork/README.md` | Fork conventions, rebase procedure, credit, name-TBD note |
| `fork/scripts/install-build-deps-ubuntu.sh` | Idempotent apt dep install, derived from upstream CI sources |
| `fork/scripts/build-local.sh` | cmake+Ninja into `./install`, ccache, JOBS override |
| `fork/scripts/run-local.sh` | Isolated `INKSCAPE_PROFILE_DIR` launcher |
| `fork/cmake/ForkBranding.cmake` + 1-line `CMakeLists.txt` include | Branding placeholder vars (ForkNameTBD), status message on configure |
| `.paul/phases/01-fork-build/branding-inventory.md` | 13 categories, counts verified, must/should/keep classification |

## Acceptance Criteria Results

| AC | Description | Status |
|----|-------------|--------|
| AC-1 | Pinned upstream base, full history, submodules | PASS (BASE_OK, SUBMODULES_OK, HISTORY_OK, gtk_major=4) |
| AC-2 | Unmodified base builds and runs locally | PASS (--version ✓, LDD_OK, EXPORT_OK 100×100 PNG, GUI_ALIVE_OK 20s) |
| AC-3 | Rebrand groundwork without behavior/license change | PASS (SCOPE_OK, LICENSE_OK, SPDX_OK, placeholder in configure, rebuild ✓, INVENTORY_OK) |

## Verification Results

- Binary: `Inkscape 1.5-dev (3d6e954a0, 2026-10-20)` at `install/bin/inkscape`.
- Full build after deps: BUILD_EXIT=0 in 267 s (JOBS=24), install prefix `./install`.
- Task 3 verify block green end-to-end on reconfigure + rebuild.
- gtkmm 4.14.0 + cairo 1.18.6 source-built into `build/deps/` + `build/deps-cairo/` (system 4.10/1.18.0 below master gates). Keep `build/` — RPATH points into it.

## Deviations

1. `fork/UPSTREAM_BASE` SPDX header added (opus review, AC-3 binding).
2. Deps script: +libicu/libtiff/libfreetype (REQUIRED by internal capypdf/ICU), +libgraphene/libgdk-pixbuf (REQUIRED MM gate), +`apt-file update` (opus review).
3. Gemini MCP returned empty output twice → Task 3 executed via `agy-gemini38` CLI (same engine).
4. Name checkpoint: auto-decided "Pressmark" under the user's no-confirmation directive; user superseded with **Penrose** (binary `penrose`, app-id `io.github.peter.Penrose`).
5. Upstream build-graph race worked around without source changes: gtkmm ExternalProject lacks the dependency edge cairo has (`DefineDependsandFlags.cmake:339-350` vs `:292-293`); deps built explicitly first (`ninja -C build gtkmm cairo_ext-install`).
6. UNIFY phase-completion heuristic (PLAN==SUMMARY file count) would falsely declare Phase 1 complete; ROADMAP defines 3 plans (01-01..01-03) → phase stays in progress, next plan 01-02.

## Key Decisions

- Product name **Penrose** (user), recorded in PROJECT.md Key Decisions; trademark/domain checks pending before public release.
- Base-selection rule (GTK4 preferred) worked as designed; PROJECT.md's GTK4 constraint **verified correct** — no PROJECT.md change needed.
- `Inkscape::` namespace, license headers, and `org.inkscape.<type>.*` extension IDs are `keep` (rebaseability + prefs/ext compat); only `org.inkscape.Inkscape`/`org.inkscape.Inkview` app-ids and user-visible strings change in 01-02.

## Next Phase

Plan 01-02: apply the Penrose rebrand (binary, app-id, desktop/metainfo, config dir, gettext domain, about/splash, logo replacement — worker gemini generates image assets). Then 01-03: packaging skeleton (AppImage, Flatpak manifest) + CI.
