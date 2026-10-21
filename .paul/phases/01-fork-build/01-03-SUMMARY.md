---
phase: 01-fork-build
plan: 03
completed: 2026-10-21T02:55:00+02:00
duration: ~2h (incl. 78 min history push)
description: "Final identity io.github.toel1234.*, public URLs, 50M self-contained AppImage, Flatpak manifest skeleton (GNOME 51), GitHub Actions CI, phase committed and published as toel1234/penrose"
type: Summary
about: corel
---

# Phase 1 Plan 03: Packaging, CI, publish — Summary

Phase 1 closed: the fork has its final owned identity, real URLs, a proven self-contained AppImage, a Flatpak skeleton, CI, and a public home at `github.com/toel1234/penrose`.

## Identity + hosting (final)

| What | Value |
|------|-------|
| Product / binaries | Penrose / `penrose`, `penrose-view` |
| App-ids | `io.github.toel1234.Penrose`, `io.github.toel1234.PenroseView` (migrated from io.github.peter.*) |
| Config dir / gettext | `penrose` / `penrose` (unchanged) |
| Repo | `https://github.com/toel1234/penrose` (public) |
| Issues | `https://github.com/toel1234/penrose/issues` |
| CI | GitHub Actions `.github/workflows/build.yml` |

## Verification

- Task 1: BUILD_OK CACHE_OK NO_OLD_APPID NO_OLD_FILENAMES DESKTOP_OK METAINFO_OK URLS_OK ICONS_OK CRASH_URL_OK CRASH_STDERR_OK SWEEP_OK (orchestrator fixed a sweep self-match: the script's own `forknametbd`/`io.github.peter` literals needed `:!self` and `[.]` exclusions).
- Task 2: APPIMAGE_SCRIPT_OK APPIMAGE_BUILT APPIMAGE_VERSION_OK (`Penrose 1.5-dev`) APPIMAGE_EXPORT_OK (100×100) DATADIR_RELOCATED NO_HOST_RPATH BUNDLED_LIBS_INSIDE (gtkmm-4.0/cairo/2geom/inkscape_base resolve inside squashfs-root) TOOLS_PINNED. **AppImage: 50M**.
- Task 3: LINT_OK ACTIONLINT_OK SHELL_SYNTAX_OK FLATPAK_BUILDER_ABSENT SPDX_OK SWEEP_OK.
- Task 4: COMMIT_OK TREE_CLEAN SWEEP_POST_COMMIT_OK REPO_PUBLIC MAIN_PUSHED TAG_PUSHED UPSTREAM_KEPT CI_RUN_STARTED.

## AppImage details

- Manual AppDir (no linuxdeploy): explicit copies + ldd-driven discovery loop (added nothing beyond plan), strip, `$ORIGIN` RUNPATH via patchelf 0.19.2, appimagetool 1.9.1 (asset re-pinned post-tag; embedded "continuous 8c8c91f build 296"), type-2 runtime 20251108 pinned via `--runtime-file` (would otherwise fetch unpinned runtime from network).
- Bundle: lib2geom, libgtkmm-4.0 (4.14), cairo 1.18.6 set, libinkscape_base + full `lib/inkscape`; dev leftovers (pkgconfig/cmake) removed; 12 ELFs stripped.
- `INKSCAPE_DATADIR` means `<prefix>/share` (evidence: `path-prefix.cpp` `get_inkscape_datadir()` requires `$INKSCAPE_DATADIR/inkscape`; `ConfigPaths.cmake:12` default). AppRun sets `INKSCAPE_DATADIR=$HERE/usr/share`, proven via `--system-data-directory`.
- `--no-appstream`: not needed. Log: `/tmp/penrose-appimage.log`.

## Flatpak + CI

- Manifest `io.github.toel1234.Penrose.yml`: GNOME runtime 51 (from gnome-build-meta heads; Flathub Inkscape reference still on 50), 19 archive sources with real sha256 (cairo hash cross-checked against upstream's URL_HASH), Penrose module `cmake-ninja`, `-DWITH_IMAGE_MAGICK=OFF` (deferred), dir-source `skip: [build, install, .git, .ccache]`, libwpd module added (libwpg dependency).
- `FLATPAK_BUILDER_ABSENT` — honest limitation; first real build deferred.
- Lint: `PACKAGING_LINT_OK`, 62 packages checked, 0 missing. `--check-noble` guarded by `/etc/os-release` VERSION_CODENAME (host confirmed noble 24.04.3); packages.ubuntu.com unreachable → local apt metadata used.
- Workflow: checkout v7.0.1, cache v6.1.0, upload-artifact v7.0.2, actionlint v1.7.12 (sha256 8aca8db9…); BUILD_TYPE=Release, 2G ccache, disk cleanup, 150 min timeout. Known follow-up: poppler 25.09 enables GPGME/NSS3/LCMS by default — first real Flatpak build may need those SDK modules.

## Publication

- Commit `1889b0a58` `feat(01): fork Inkscape as Penrose with full rebrand and packaging skeleton` (Co-Authored-By: Claude Opus 5.5), author `55331794+toel1234@users.noreply.github.com` (configured `user.email` was `toel1234@yahoo.de`, untouched).
- Refetch of the partial clone (blob:none → full) added 1.38 GiB size-pack. Push: `fork-base` tag first (78 min uplink), then `main` force-with-lease over the repo's auto-init LICENSE commit (user-created repo; recorded decision).
- CI run: https://github.com/toel1234/penrose/actions/runs/39529303947 (in_progress at UNIFY; result checked later).
- No GH013/GH007 events.

## Deviations

1. Repo pre-created by the user → `gh repo create` skipped, remote wired manually; remote `main` force-with-lease over the auto-init LICENSE commit (the LICENSE content is superseded by the in-tree `COPYING`).
2. Two sweep self-match fixes post-commit (unpushed amend allowed then): `forknametbd` and `io.github.peter` literals inside verify-branding.sh excluded from their own greps.
3. Task 3's `--check-noble` falls back to local apt metadata only when the host IS noble (os-release guard added per review).
4. `src/inkscape.cpp` literals landed at :380-381 (shifted by the config.h include) — consistent with plan.

## Deferred (unchanged or newly recorded)

- CI green confirmation (run in progress); `cli_tests` user-data-directory test; poppler GPGME/NSS3 in Flatpak; real Flatpak build; full-stack AppImage bundling/signing/zsync; `share/inkscape` + `INKSCAPE_*` renames; msgid translations; translated man/welcome; `1.5-dev` version scheme; **Penrose trademark/domain checks (user)**.
