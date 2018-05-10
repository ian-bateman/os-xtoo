# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="metro-xml${PN}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Stream based representation for XML infoset"
HOMEPAGE="https://javaee.github.io/${MY_PN}/"
LICENSE="CDDL GPL-2"
SLOT="0"

CP_DEPEND="
	dev-java/javax-activation:0
	dev-java/stax-ex:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src"

if [[ ${PN} = 9999 ]]; then
	S+="/${PN}"
fi
