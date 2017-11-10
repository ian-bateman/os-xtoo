# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Commons Discovery: Service Discovery component"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
SRC_URI="mirror://apache/${PN/-///}/source/${P}-src.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="dev-java/commons-logging:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/java"
