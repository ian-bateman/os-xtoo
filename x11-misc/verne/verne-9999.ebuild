# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

CMAKE_MAKEFILE_GENERATOR="emake"

E_BASE_URI="https://github.com/marcelhollerbach/${PN}"
E_BUILD="cmake"
E_SNAP="38a0424d5ee3535abc6d1f6f0beb0cf91c0b7fb7"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="A small efl based filemanager"
HOMEPAGE="${E_BASE_URI}"
LICENSE="BSD-2-clause"
