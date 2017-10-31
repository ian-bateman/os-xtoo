# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BUILD="meson"
E_SNAP="fa4195984a3af7d7a119667ac042dce4a8082e09"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/${PN}"
EGIT_REPO_URI="${HOMEPAGE}"

inherit e

if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${HOMEPAGE}/archive/${E_SNAP}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="A Clipboard module for E21+ desktop"
LICENSE="GPL-3"
