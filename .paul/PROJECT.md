---
description: "Designers get a CorelDRAW-class vector and print-design app on Linux that is open source, built on Inkscape."
type: Project
about: "corel"
---

# corel

## What This Is

A GPL fork of Inkscape (https://gitlab.com/inkscape/inkscape), extended with CorelDRAW-style GUI and functionality: CMYK/ICC color, multi-page layout, PowerClip, Corel-style UI and shortcuts, and .cdr import.

## Core Value

Designers get a CorelDRAW-class vector and print-design app on Linux that is open source, built on Inkscape.

## Current State

| Attribute | Value |
|-----------|-------|
| Type | Application |
| Version | 0.0.0 |
| Status | Initializing |
| Last Updated | 2026-10-20 22:35 |

## Requirements

### Core Features

- Color: CMYK / ICC / spot color, PDF/X export
- Pages: multi-page documents with master layer
- Corel-style GUI: workspace layout, property bar, dockers, shortcut scheme
- Corel tools: PowerClip, LiveSketch, Artistic Media, dimension tools, smart fill
- Files: .cdr import (libcdr); export best-effort only (proprietary format)

### Validated (Shipped)
None yet.

### Active (In Progress)
None yet.

### Planned (Next)
- Build and rebrand Inkscape fork
- CMYK/ICC color pipeline
- Multi-page + PDF/X
- Corel-style UI and shortcuts
- Corel-specific tools
- .cdr import

### Out of Scope
- Windows and macOS builds
- Photo-Paint and other bundled Corel apps (to confirm)
- Corel name, logo, icons, assets (trademark/copyright)

## Constraints

### Technical Constraints
- Base: Inkscape (C++, GTK4, CMake); keep toolkit, no Qt rewrite
- Target: Linux only; package as Flatpak/AppImage
- Libraries: lcms2 (ICC/CMYK), libcdr (.cdr import)

### Business Constraints
- Must stay GPL-2.0+ (Inkscape license)
- Clone layout, workflow, features only; no Corel branding or assets; fork needs its own name
- Inkscape's own name/logo/icons are trademarked — the fork must ship under its own branding (rebrand is Phase 1, plan 01-02)

## Key Decisions

| Decision | Rationale | Date | Status |
|----------|-----------|------|--------|
| Fork Inkscape, keep GTK4 | Qt rewrite is near-total UI rewrite | 2026-10-20 | Active |
| Linux only | User does not need Windows/macOS | 2026-10-20 | Active |
| Product name "Penrose" (binary `penrose`, app-id `io.github.peter.Penrose` — user decision 2026-10-20, supersedes interim "Pressmark" proposal) | User's choice; Penrose tiling association fits vector/geometry; trademark/domain checks still pending before public release | 2026-10-20 | Active |

## Success Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| v1 end-to-end | Open real .cdr, edit in CMYK, export print-ready PDF/X | - | Not started |
| Build | Builds and runs on current Ubuntu | - | Not started |

## Tech Stack / Tools

| Layer | Technology | Notes |
|-------|------------|-------|
| Language | C++ | Inkscape codebase |
| UI | GTK4 | Inherited |
| Build | CMake | Inherited |
| Color | lcms2 | ICC/CMYK |
| Import | libcdr | .cdr |
| Packaging | Flatpak / AppImage | Linux |

## Links

| Resource | URL |
|----------|-----|
| Upstream | https://gitlab.com/inkscape/inkscape |

---
*PROJECT.md — Updated when requirements or context change*
*Last updated: 2026-10-20*
