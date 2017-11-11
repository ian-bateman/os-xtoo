# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from gentoo main tree
# Copyright 1999-2017 Gentoo Foundation

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}${PV%%.*}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/${PN}/${PN}4"

# Sources from maven for pre-generated UnicodeData.java
# Temporary, need to generate via stringtemplate
# live will fail without generating UnicodeData.java
if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz
		http://repo1.maven.org/maven2/org/${PN}/${MY_PN}/${PV}/${MY_P}-sources.jar"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="A parser generator for many languages"
HOMEPAGE="http://www.antlr.org/"
LICENSE="BSD"
SLOT="${PV%%.*}"

CP_DEPEND="dev-java/antlr:3.5
	dev-java/icu4j:0
	dev-java/javax-json-api:0
	dev-java/stringtemplate:4
	dev-java/treelayout:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${MY_S}"

java_prepare() {
# Need to process this file to generate UnicodeData.java
# Likely using UnicodeDataTemplateController
#	${S}/tool/resources/org/antlr/v4/tool/templates/unicodedata.st
	cp "${WORKDIR}/src/org/antlr/v4/unicode/UnicodeData.java" \
		"${S}/tool/src/org/antlr/v4/unicode/" \
		|| die "Failed to copy pre-generated UnicodeData.java"
}

src_compile() {
	cd "${S}/runtime/Java/src"
	JAVA_JAR_FILENAME="${S}/${PN}-runtime.jar"
	JAVA_PKG_IUSE="doc"
	java-pkg-simple_src_compile

# Needs to bootstrap itself and NOT use antlr3.5 or any
	cd "${S}/tool/src"
	antlr3.5 $(find -name "*.g" -print) \
		|| die "Failed to compile antlr grammar files"
	JAVA_GENTOO_CLASSPATH_EXTRA="${S}/${PN}-runtime.jar"
	JAVA_JAR_FILENAME="${S}/${PN}-tool.jar"
	JAVA_RES_DIR="${S}/tool/resources"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg_dojar ${PN}-{runtime,tool}.jar
	java-pkg_dolauncher ${PN}${SLOT} --main org.antlr.v4.Tool
	use doc && java-pkg_dojavadoc runtime/Java/src/target/api
	use source && java-pkg_dosrc runtime/Java/src/org tool/src/org
}
