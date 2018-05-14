# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="A parser generator for many languages"
HOMEPAGE="http://www.antlr2.org/"
SRC_URI="http://www.antlr2.org/download/${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="${PN}"

java_prepare() {
	rm Makefile* config* || die "Remove gnu/autotools build system"
	mkdir -p resources/${PN} || die "Failed to make resources dir"
}

src_compile() {
	local f

	JAVA_JAR_FILENAME="${S}/${PN}-bootstrap.jar"
	java-pkg-simple_src_compile

	for f in antlr java/action tokdef; do
		java -cp ${PN}-bootstrap.jar ${PN}.Tool -o antlr \
			"${PN}/${f}.g" \
			|| die "antlr failed to parse ${f}.g"
	done

	mv antlr/{ANTLRTokenTypes,ANTLRTokdefParserTokenTypes}.txt \
		resources/${PN} \
		|| die "Failed to move text files to resources"

	JAVA_JAR_FILENAME="${S}/${PN}.jar"
	JAVA_RES_DIR="resources"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher ${PN} --main ${PN}.Tool
}
