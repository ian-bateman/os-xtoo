# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"
E_BUILD="meson"
E_DISTFILE="v${PV}"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="A Clipboard module for E21+ desktop"
HOMEPAGE="${E_BASE_URI}"
LICENSE="GPL-3"
