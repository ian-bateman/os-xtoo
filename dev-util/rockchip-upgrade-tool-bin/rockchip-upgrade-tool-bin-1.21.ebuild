# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils versionator

MY_P="Linux_Upgrade_Tool_v${PV}"

DESCRIPTION="Rockchip Flash tool for Linux (upgrade_tool)"
HOMEPAGE="http://linux-rockchip.org/"
SRC_URI="${HOMEPAGE/l/dl.l}/rockchip/Linux_Upgrade_Tool_v${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64"

DEPEND="app-arch/unzip"

RDEPEND=""

S=${WORKDIR}/${MY_P}

src_install() {
	newbin upgrade_tool rkupgrade_tool
	use doc && dodoc *pdf
}

pkg_postinst() {
	elog "Renamed upgrade_tool -> rkupgrade_tool"
}
