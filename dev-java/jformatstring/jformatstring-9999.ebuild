# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jFormatString"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/Obsidian-StudiosInc/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Compile time checking of Java format strings"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=virtual/jdk-1.8"

RDEPEND="!~dev-java/jformatstring-2.0.3:0
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"
