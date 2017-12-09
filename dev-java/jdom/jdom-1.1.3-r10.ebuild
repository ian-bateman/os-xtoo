# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Manipulation of XML made easy"
HOMEPAGE="https://github.com/hunterhacker/jdom"
SRC_URI="${HOMEPAGE}/archive/${P}.tar.gz"
LICENSE="Apache-1.1"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="dev-java/jaxen:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${PN}"

java_prepare() {
	rm src/java/org/jdom/xpath/JaxenXPath.java \
		|| die "Remove circular dep"
}
