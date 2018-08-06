# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="${BASE_URI}.git"
	inherit git-r3
else
	KEYWORDS="~amd64"
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Version bump or clean individual or groups of related ebuilds"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

S="${WORKDIR}/${P}"

src_install() {
	newbin ${PN}.sh ${PN}
}
