# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="NB-CMake-Completion"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/offa/${PN}"

inherit java-netbeans

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="NetBeans plugin providing (code-)completion for CMake files"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

NB_SLOT="9"

CP_DEPEND="
	nb-ide/netbeans-editor-completion:${NB_SLOT}
	nb-ide/netbeans-editor-mimelookup:${NB_SLOT}
	nb-ide/netbeans-openide-filesystems:${NB_SLOT}
	nb-ide/netbeans-openide-util:${NB_SLOT}
	nb-ide/netbeans-openide-util-lookup:${NB_SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"
