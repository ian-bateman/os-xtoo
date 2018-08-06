# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/pre/preview}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Static analysis to look for bugs in Java code aka FindBugs"
HOMEPAGE="https://spotbugs.github.io/"
LICENSE="LGPL-2.1"
SLOT="0"

CP_DEPEND="
	dev-java/apple-java-extensions-bin:0
	dev-java/asm:6
	dev-java/commons-bcel:0
	dev-java/commons-lang:2
	dev-java/dom4j:2
	dev-java/jcip-annotations:0
	<dev-java/jformatstring-2.0:0
	dev-java/jsr305:0
	~dev-java/spotbugs-annotations-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_SRC_DIR="
	src/main/java/
	src/gui
"

java_prepare() {
	# Fix incompatible types
	sed -i -e "s|node.select|(List<T>)node.select|" \
		src/main/java/edu/umd/cs/findbugs/xml/XMLUtil.java \
		|| die "Failed to fix/sed incompatible types"
}
