# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="pentaho-commons-xul"
MY_PV="${PV}-R"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/pentaho/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="${BASE_URI}"
LICENSE="LGPL-2.1"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/commons-lang:2
	dev-java/commons-logging:0
	dev-java/dom4j:2
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	sed -i -e '363,366d' \
		src/org/pentaho/ui/xul/impl/AbstractXulLoader.java \
		|| die "Failed to sed/fix cast incompatible types"

	sed -i -e '27iimport org.dom4j.Node;' \
		-e '363i \ \ \ \ List<Node> nodes = xpath.selectNodes( srcDoc );' \
		-e '363i \ \ \ \ for (Node n : nodes) {' \
		-e '363i \ \ \ \ \ \ \ \ Element ele = n.getParent();' \
		src/org/pentaho/ui/xul/impl/AbstractXulLoader.java \
		|| die "Failed to sed/fix cast incompatible types"
}
