# Copyright 2015-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

HOMEPAGE="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Nagios plugin to check a linode's status using the Linode API"
LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="net-misc/curl"

src_install() {
	exeinto /usr/lib/nagios/plugins
	doexe ${PN}.sh
}
