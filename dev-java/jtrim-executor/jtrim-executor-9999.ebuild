# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="JTrim"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/kelemen/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Executors"
HOMEPAGE="${BASE_URI}/subprojects/${PN}"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	~dev-java/jtrim-collections-${PV}:${SLOT}
	~dev-java/jtrim-concurrent-${PV}:${SLOT}
	~dev-java/jtrim-utils-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/subprojects/${PN}"
