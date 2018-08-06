# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

MY_PN="Linux_Upgrade_Tool"
MY_P="${MY_PN}_v${PV}"

DESCRIPTION="Rockchip Flash tool for Linux (upgrade_tool)"
HOMEPAGE="https://github.com/rockchip-linux/tools/tree/master/linux"
SRC_URI="https://github.com/rockchip-linux/tools/raw/master/linux/${MY_PN}/${MY_P}.zip"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"
IUSE="doc"

DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_install() {
	newbin upgrade_tool rkupgrade_tool
	use doc && dodoc *pdf
}

pkg_postinst() {
	elog "Renamed upgrade_tool -> rkupgrade_tool"
}
