#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
#
# Install Inkscape fork build dependencies on Ubuntu (tested target: Ubuntu 24.04).
#
# Derived from upstream's own dependency sources at fork-base:
#   - install_dependencies.sh from the inkscape-ci-docker image referenced by
#     .gitlab-ci.yml:4 and doc/building/linux.md:12
#   - packaging/debian/control
#   - snap/snapcraft.yaml
#   - CMakeScripts/DefineDependsandFlags.cmake and CMakeLists.txt
#
# Deliberately does NOT enable deb-src or run `apt build-dep inkscape`:
# Ubuntu's packaged Inkscape may target a different GTK major and pull the
# wrong dependency set.
#
# Idempotent: safe to re-run.

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

packages=(
  # Toolchain (CI install script; CMakeScripts/DefineDependsandFlags.cmake:457)
  build-essential
  cmake
  ccache
  pkg-config
  gettext          # UNVERIFIED: exact name absent from upstream package lists; required by CMake find_package(Gettext)
  git
  ninja-build
  python3          # packaging/debian/control:4

  # GTK4 mm stack (fork/UPSTREAM_BASE gtk_major=4;
  # CMakeScripts/DefineDependsandFlags.cmake:307-333)
  libgtk-4-dev
  libgtkmm-4.0-dev
  libglibmm-2.68-dev
  libcairomm-1.16-dev
  libpangomm-2.48-dev
  libsigc++-3.0-dev
  libglib2.0-dev
  libgtksourceview-5-dev   # WITH_GSOURCEVIEW defaults ON (CMakeLists.txt:106)
  libspelling-1-dev        # WITH_LIBSPELLING defaults ON (CMakeLists.txt:105)

  # Source-build fallbacks: Ubuntu 24.04 ships gtkmm 4.10 (< required 4.13.3)
  # and cairo 1.18.0 (< required 1.18.6), so upstream builds both from source.
  # See CMakeScripts/DefineDependsandFlags.cmake:282-304 and :353-362.
  meson
  glslc
  mm-common
  libgstreamer-plugins-bad1.0-dev

  # Libraries (install_dependencies.sh; packaging/debian/control:5-46)
  libboost-dev
  libboost-filesystem-dev
  libboost-stacktrace-dev
  libdouble-conversion-dev
  libgsl-dev
  liblcms2-dev
  libcdr-dev
  libvisio-dev
  libwpg-dev
  librevenge-dev
  libpoppler-glib-dev
  libpoppler-private-dev
  libpotrace-dev
  libxml2-dev
  libxslt1-dev
  libicu-dev        # icu-uc REQUIRED (CMakeScripts/DefineDependsandFlags.cmake:139)
  libharfbuzz-dev   # UNVERIFIED: exact name absent from upstream package lists; required by CMake pkg_check_modules at :120
  libpango1.0-dev
  libcairo2-dev     # UNVERIFIED: exact name absent from upstream package lists; required by CMake pkg_check_modules at :282
  libtiff-dev       # TIFF REQUIRED by internal capypdf (src/3rdparty/CMakeLists.txt:33)
  libfreetype-dev   # Freetype REQUIRED by internal capypdf (src/3rdparty/CMakeLists.txt:34)
  libgraphene-1.0-dev    # REQUIRED in MM block (CMakeScripts/DefineDependsandFlags.cmake:273-279)
  libgdk-pixbuf-2.0-dev  # REQUIRED in MM block (CMakeScripts/DefineDependsandFlags.cmake:273-279)
  libfontconfig-dev
  libepoxy-dev
  libjpeg-dev
  libpng-dev
  libreadline-dev
  libgtest-dev
  libgmock-dev
  libgc-dev         # bdw-gc REQUIRED (CMakeScripts/DefineDependsandFlags.cmake:125)
  zlib1g-dev
  libmagick++-dev   # WITH_IMAGE_MAGICK defaults ON (CMakeLists.txt:100)

  # Python extension runtime (packaging/debian/control:44,84,91)
  python3-lxml
  python3-numpy
  python3-tinycss2

  # Package-file search used by the configure-failure loop
  apt-file          # UNVERIFIED: not an upstream build dependency; tooling for this phase

  # Verification and packaging tooling (verify-branding.sh, build-appimage.sh)
  desktop-file-utils
  appstream
  file
  curl
)

echo "Installing ${#packages[@]} build-dependency packages..."
sudo apt-get update
sudo apt-get install -y --no-install-recommends "${packages[@]}"

# Refresh the apt-file Contents cache so the configure-failure recovery loop
# (plan Task 2 step 3: apt-file search) works on first use. Idempotent.
if [ "${SKIP_APT_FILE:-0}" != "1" ]; then
    sudo apt-file update
fi
