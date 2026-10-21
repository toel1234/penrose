---
phase: 01-fork-build
plan: 02
completed: 2026-10-21T01:05:00+02:00
duration: ~1h active (workers ~35min parallel + reviews)
description: "Penrose rebrand applied end-to-end: penrose/penrose-view binaries, io.github.peter.Penrose(+View) IDs, penrose profile/gettext domain, full new artwork set, rebranded strings, man pages, and a one-command AC sweep (verify-branding.sh) — ALL_BRANDING_CHECKS_OK"
type: Summary
about: corel
---

# Phase 1 Plan 02: Apply Penrose rebrand — Summary

Every user-visible and system-integration Inkscape identity is now Penrose, driven from `fork/cmake/ForkBranding.cmake` → `config.h`. Namespaces, extension IDs, data dirs and license/attribution untouched. Coexists with a system Inkscape.

## Identity table

| What | Value |
|------|-------|
| Product | Penrose |
| Binaries | `penrose`, `penrose-view` (CMake targets `inkscape`/`inkview` kept, OUTPUT_NAME changed) |
| App-ids | `io.github.peter.Penrose`, viewer `io.github.peter.PenroseView` (derived this plan) |
| Config/cache dir | `penrose` (`~/.config/penrose`) |
| Gettext domain | `penrose` (via `project(penrose)`; po/ submodule untouched) |

## Upstream files touched (23, +125/−93) — reasons

`CMakeLists.txt` (project name → penrose.mo), `config.h.cmake` (GETTEXT_PACKAGE + FORK_* macros), `src/CMakeLists.txt` (OUTPUT_NAME), `share/CMakeLists.txt` (desktop/metainfo generation from fork templates, icon path, removed GNOME2/xpm installs), `man/CMakeLists.txt` (fork pod glob + pod DEPENDS fix), `share/{icons/application,screens,branding}/CMakeLists.txt` (fork asset globs, +96/128 sizes), 6 UI files (strings/title/icon), 8 `src/` files (app-id literals, profile/cache dir, version string, textdomain alias, INKSCAPE_COMMAND self-call guard, macOS path). Full allow-list enforced by `fork/scripts/verify-branding.sh`.

## Assets (gemini-3.8-flash via agy CLI, 2026-10-21)

14 hand-authored SVGs (tribar motif, indigo/teal/amber; P3 tiling backgrounds): logo ×3, scalable+symbolic icons, about ×3 (light/dark/gzipped pair), 5 startup screens, welcome-text. PNGs rendered deterministically by `install/bin/penrose` at exact sizes (16…256 + upstream-matching screen dims); PNG tEXt metadata stripped; sources archived in `fork/branding/screens/src/`; provenance in `fork/branding/README.md`. Review montage: `/tmp/penrose-montage.png` (opus reviewed source assets directly — sandbox blocked /tmp reads; verdict: no Inkscape/Corel similarity, legible at 16px).

## Verification

- Task 1 verify: 15/15 markers green (CACHE/CONFIG_H/BIN/VERSION/LDD/MO/GETTEXT_RUNTIME/DESKTOP/METAINFO/NO_OLD_DESKTOP_IDS/SRC_APPID/EXT_IDS_KEPT/INKEX_SELFCALL/PROFILE/SUBMODULES_CLEAN).
- Task 2 verify: ASSETS_VALID, NO_FOREIGN_NAMES, ICON_SIZES_OK (8 sizes true-pixel), ICON_SVG_OK, NO_OLD_ICONS, ABOUT_SET_OK, SCREEN_DIMS_OK, UI_STRINGS_OK, TITLE_OK, GUI_ALIVE_OK.
- Task 3 sweep after clean reinstall: `ALL_BRANDING_CHECKS_OK` (`/tmp/penrose-verify.log`), re-confirmed after every review fix.
- gettext runtime: OK (de_DE locale differs from C). msgfmt --xml metainfo: accepted. Pod regeneration: proven (pod edit → man page rebuilt).

## Deviations

1. Metainfo gained `<url type="homepage">https://github.com/peter</url>` so appstreamcli validates — PLACEHOLDER pointing at a GitHub profile the project does not own; 01-03 must replace it and confirm the `io.github.peter` app-id ownership.
2. share/CMakeLists.txt: metainfo + desktop custom_commands lacked template DEPENDS (stale-output bug, also present in upstream's original) — fixed fork-side.
3. man/CMakeLists.txt: Pod2man.cmake lacks pod DEPENDS — fixed fork-side via APPEND DEPENDS (regeneration proven); Pod2man.cmake itself untouched.
4. verify-branding.sh extended: every fork SVG (not only about svgz) must render; allow-list globs (`fork/branding/*` etc.) are wider than files_modified to cover `screens/src/` sources — noted.
5. share/branding glob kept upstream + added fork (upstream glob never installed the .ico that inkscape.rc references; upstream logo SVGs still ship in `branding/` share dir — harmless, recorded).
6. Help-menu manual/tutorial labels rebranded (verify grep forces it) while still linking Inkscape docs.
7. Startup splash/welcome tagline says "Vector print design" (brief asked "Vector & print design"); about credit uses "-" not "—" — cosmetic.

## Deferred (to 01-03 or later)

- `share/inkscape` data dir + `INKSCAPE_*` env var renames (4+ hardcoded sites; high risk, no user gain until system installs exist).
- Crash dialog still points to Inkscape's bug tracker (no fork tracker yet) — MUST fix before public release.
- Homepage/app-id ownership on GitHub; Penrose trademark + domain checks.
- Changed msgids show in English (no .po work); translated man pages/welcome text not ported.
- Tests: `cli_tests/CMakeLists.txt:204` (`user-data-directory`) expects profile dir `inkscape` → will fail; recorded, not weakened.
- Product version still shows Inkscape's `1.5-dev` versioning scheme.

## Task review outcomes

Task 1: opus ISSUES→fixed (metainfo homepage, desktop/metainfo DEPENDS). Task 2: opus ISSUES→fixed (blocker: start-welcome.png had baked text doubling the overlay — background-only now; fund label attribution; About menu icon). Task 3: opus ISSUES→fixed (pod DEPENDS, SVG render check, README refresh). All re-verified green.
