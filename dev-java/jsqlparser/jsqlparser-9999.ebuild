# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="JSqlParser"
BASE_URI="https://github.com/JSQLParser/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
#	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	SRC_URI="https://repo1.maven.org/maven2/com/github/${PN}/${PN}/${PV}/${P}-sources.jar"
	KEYWORDS="~amd64"
#	MY_S="${MY_PN}-${P}"
	MY_S=""
fi

#CP_DEPEND="
#	dev-java/javacc:0
#	dev-java/velocity-engine-core:0
#"

inherit java-pkg

DESCRIPTION="Library to perform type arithemtic over the type system"
HOMEPAGE="${BASE_URI}/wiki"
LICENSE="Apache-2.0 LGPL-2.1"
SLOT="0"

JDK_VERSION="1.8"

S="${WORKDIR}/${MY_S}"

#JAVA_SRC_DIR="src/main/java"

#java_prepare() {
#	local jjt
#	jjt="${S}/src/main/jjtree/net/sf/jsqlparser/parser/JSqlParserCC.jjt"
#	javacc -JDK_VERSION="${JDK_VERSION}" -USER_TOKEN_MANAGER \
#		-OUTPUT_DIRECTORY="${S}/${JAVA_SRC_DIR}" "${jjt}" \
#		|| die "javacc ${jjt} failed "
#}
