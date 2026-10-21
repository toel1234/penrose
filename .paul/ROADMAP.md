---
description: "corel — milestone and phase structure"
type: Roadmap
about: "corel"
---

# Roadmap: corel

## Overview
GPL fork of Inkscape extended with CorelDRAW-style GUI and functionality.

## Current Milestone
**v0.1 Initial Release** (v0.1.0)
Status: In progress
Phases: 1 of 6 complete

## Phases

| Phase | Name | Plans | Status | Completed |
|-------|------|-------|--------|-----------|
| 1 | Fork, build and rebrand | 3 | Complete | 2026-10-21 |
| 2 | CMYK/ICC color pipeline | 4 | Not started | - |
| 3 | Multi-page + PDF/X export | 3 | Not started | - |
| 4 | Corel-style UI and shortcuts | 4 | Not started | - |
| 5 | Corel-style tools | 5 | Not started | - |
| 6 | .cdr import fidelity | 3 | Not started | - |

## Phase Details

- **Phase 1: Fork, build and rebrand.** Pin an upstream Inkscape base, get a reproducible local build on current Ubuntu, then rebrand. 01-01 covers source, dependencies, an unmodified running build, branding groundwork and the name decision. 01-02 applies the chosen name: binary, app-id, desktop/metainfo files, separate config directory, about/splash screens, and replacing Inkscape-trademarked logos. 01-03 adds a packaging skeleton (AppImage first, then a Flatpak manifest) and a CI build.
- **Phase 2: CMYK/ICC color pipeline.** lcms2-based document color management: assign and convert document ICC profiles, CMYK-native fill/stroke values that survive save and reload, soft-proofing, and spot/named colors. Must extend upstream's existing icc-color/CMYK support rather than run alongside it.
- **Phase 3: Multi-page + PDF/X export.** Upstream already has multi-page support (since 1.2), so this phase adds master-page/master-layer semantics and print metadata (bleed, trim, slug). The main risk is PDF/X-1a/X-4 output with real CMYK: cairo's PDF backend is RGB-only, so this needs an evaluated alternative (own PDF writer path, or a post-process with output-intent embedding). Validate with a preflight tool.
- **Phase 4: Corel-style UI and shortcuts.** Workspace layout preset, context property bar, docker-style panels, toolbox order, and a Corel-compatible keyboard scheme. Only our own icons and assets; no Corel artwork, names or screenshots.
- **Phase 5: Corel-style tools.** PowerClip (clip-into-container with edit-contents mode), Artistic Media, dimension tools, Smart Fill and LiveSketch. One plan per tool family, ordered by user value.
- **Phase 6: .cdr import fidelity.** Upstream already imports .cdr through libcdr/librevenge. This phase raises fidelity for real-world files (CMYK values kept through the Phase 2 pipeline, multi-page mapped to Phase 3 pages, PowerClip mapped to Phase 5) and adds a regression corpus. Export is best-effort or out of scope.

---
*Roadmap created: 2026-10-20; phases defined 2026-10-20 by claude-opus-5-5 via /paul:plan*
