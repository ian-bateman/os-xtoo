# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}${PV%%.*}"
MY_P="${MY_PN}-${PV}"

CP_DEPEND="dev-java/stringtemplate:4"

inherit java-pkg

DESCRIPTION="A parser generator for many languages"
HOMEPAGE="http://www.antlr.org/"
# jar used for bootstrap not installed
SRC_URI="https://github.com/${PN}/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz
	http://www.antlr3.org/download/${P}-complete.jar"
LICENSE="BSD"
SLOT="3.5"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
}

java_prepare() {
	rm runtime/Java/src/main/java/org/antlr/runtime/tree/DOTTreeGenerator.java \
		|| die "Failed to removing stringtemplate:0 class"
	cd "${S}/tool/src/main" \
		|| die "Failed to change dir to tool/src/main"
	java -jar "${DISTDIR}/${P}-complete.jar" $(find antlr3 -name "*.g") \
		|| die "Failed to compile antlr grammar files"
}

src_compile() {
	JAVA_JAR_FILENAME="${S}/${PN}-runtime.jar"
	JAVA_SRC_DIR="runtime/Java/src/main/java"
	java-pkg-simple_src_compile

	JAVA_CLASSPATH_EXTRA="${S}/${PN}-runtime.jar"
	JAVA_JAR_FILENAME="${S}/${PN}-tool.jar"
	JAVA_SRC_DIR="tool/src/main/"
	JAVA_RES_DIR="${S}/tool/src/main/resources"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg_dojar ${PN}-{runtime,tool}.jar
	java-pkg_dolauncher ${PN}${SLOT} --main org.antlr.Tool
	use doc && java-pkg_dojavadoc runtime/Java/src/target/api
	use source && java-pkg_dosrc runtime/Java/src/org tool/src/org
}
