# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="release"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

inherit java-pkg

DESCRIPTION="Open source compiler compiler grammar as input Java as output"
HOMEPAGE="http://${PN}.org/"
LICENSE="BSD-3-clause"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

# keep bootstrap javacc.jar
JAVA_PKG_NO_CLEAN=1
JAVA_SRC_DIR="src/main/java"

java_prepare() {
	local JDK_VERSION="1.8"

	mv version.properties src/main/resources \
		|| die "Failed to move version.properties"

	java -cp bootstrap/javacc.jar javacc -JDK_VERSION="${JDK_VERSION}" \
		-OUTPUT_DIRECTORY="${JAVA_SRC_DIR}/org/javacc/parser" \
		"src/main/javacc/JavaCC.jj" \
		|| die "javacc JavaCC.jj failed"

	java -cp bootstrap/javacc.jar jjtree -JDK_VERSION="${JDK_VERSION}" \
		-JJTREE_OUTPUT_DIRECTORY="${JAVA_SRC_DIR}/org/javacc/jjtree" \
		"src/main/jjtree/JJTree.jjt" \
		|| die "jjtree JJTree.jjt failed"

	java -cp bootstrap/javacc.jar javacc -JDK_VERSION="${JDK_VERSION}" \
		-OUTPUT_DIRECTORY="${JAVA_SRC_DIR}/org/javacc/jjtree" \
		"${JAVA_SRC_DIR}/org/javacc/jjtree/JJTree.jj" \
		|| die "javacc JJTree.jj failed"

	java -cp bootstrap/javacc.jar javacc -JDK_VERSION="${JDK_VERSION}" \
		-OUTPUT_DIRECTORY="${JAVA_SRC_DIR}/org/javacc/utils" \
		"src/main/javacc/ConditionParser.jj" \
		|| die "javacc ConditionParser.jj failed"
}

src_install() {
	java-pkg-simple_src_install

	local l
	for l in javacc jjdoc jjtree; do
		java-pkg_dolauncher ${l} --main ${l}
	done
}
