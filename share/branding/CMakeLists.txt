# SPDX-License-Identifier: GPL-2.0-or-later
file(GLOB _FILES "*.svg")
file(GLOB _FORK_FILES "${CMAKE_SOURCE_DIR}/fork/branding/logo/*.svg")
install(FILES ${_FILES} ${_FORK_FILES} DESTINATION ${INKSCAPE_SHARE_INSTALL}/branding)

