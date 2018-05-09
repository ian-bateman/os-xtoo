# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN:0:14}/${PN}"

if [[ ${PV} != *9999* ]]; then
	MY_PV="${PV}.Final"
	[[ ${PV} == 1.0.0 ]] && MY_PV="${PV}.GA"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

HOMEPAGE="https://${PN:0:14}.org"
DESCRIPTION="Bean Validation API JSR 303 Slot 1.0 & JSR 380 Slot 1.1"
LICENSE="Apache-2.0"
SLOT="${PV/.${PV#*.*.*}/}"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"
