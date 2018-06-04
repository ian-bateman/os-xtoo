# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/swaldman/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="
	dev-java/log4j:0
	dev-java/log4j-api:0
	dev-java/log4j-core:0
	dev-java/slf4j-api:0
	dev-java/typesafe-config:0
"

inherit java-pkg

DESCRIPTION="Library used by c3p0"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( LGPL-2.1 EPL-1.0 )"
SLOT="0"

S="${WORKDIR}/${MY_S}"

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher debuggen --main com.mchange.v2.debug.DebugGen
}
