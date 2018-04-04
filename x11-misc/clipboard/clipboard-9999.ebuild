# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BUILD="meson"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/${PN}"
EGIT_REPO_URI="${HOMEPAGE}"

inherit e

DESCRIPTION="A Clipboard module for E21+ desktop"
LICENSE="GPL-3"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
fi
