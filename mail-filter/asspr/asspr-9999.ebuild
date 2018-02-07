# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit autotools ${ECLASS}

DESCRIPTION="Anti-Spam Server Proxy Report"
HOMEPAGE="https://www.o-sinc.com/#!/software/${PN}"

LICENSE="GPL-2"
SLOT="0"

src_prepare() {
	default
	eautoreconf
}
