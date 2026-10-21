#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
#
# Configure and build the fork, then install it into the local ./install prefix.
# Run from the repository root.

set -euo pipefail

cmake -S . -B build -G Ninja \
  -DCMAKE_BUILD_TYPE="${BUILD_TYPE:-RelWithDebInfo}" \
  -DCMAKE_INSTALL_PREFIX="$PWD/install" \
  -DCMAKE_C_COMPILER_LAUNCHER=ccache \
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache

# Build the gtkmm/cairo ExternalProjects first when they are part of this
# configuration: they lack a dependency edge in the generated build graph
# (01-01 race). This is a no-op once they are already built.
targets="$(ninja -C build -t targets all)"
if grep -q '^gtkmm:' <<<"$targets"; then
  ninja -C build -j"${JOBS:-$(nproc)}" gtkmm cairo_ext-install
fi

ninja -C build -j"${JOBS:-$(nproc)}"

ninja -C build install
