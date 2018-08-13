# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="
	dev-java/antlr:0
	dev-java/stringtemplate:0
"

inherit java-pkg

DESCRIPTION="A parser generator for many languages"
HOMEPAGE="http://www.antlr.org/"
SRC_URI="http://www.antlr3.org/download/${P}.tar.gz
	http://www.antlr3.org/download/${P}.jar"
LICENSE="BSD"
SLOT="3"

S="${WORKDIR}/${P}"

PATCHES=( "${FILESDIR}/${SLOT}-inContext.patch" )

src_unpack() {
	unpack ${P}.tar.gz
}

java_prepare() {
	local f

	find  -name '.*' -type f -delete || die "Failed to delete dot files"

	cd tool/src/main || die "Failed to change dir to tool/src/main"

#	antlr -o java/org/antlr/tool/{,serialize.g} \
#		|| die "Failed to compile antlr grammar file"

	for f in antlr antlr.print assign.types buildnfa codegen define; do
		antlr -o antlr2/org/antlr/grammar/v2/{,${f}.g} \
			|| die "Failed to compile antlr v2 grammar files"
	done

	for f in Action{Analysis,Translator} ANTLRv3{,Tree}; do
		java -cp "${DISTDIR}/${P}.jar" org.antlr.Tool \
		-o antlr3/org/antlr/grammar/v3/{,${f}.g}
# Throws error and fails but still generats java files...
#		|| die "Failed to compile antlr v3 grammar files"
	done

	sed -i -e 's|v3.*|v3.ActionAnalysis;|' \
		java/org/antlr/tool/Grammar.java \
		|| die "Failed to sed/delete v3 import"

	# prevent npe
	sed -i -e '222i \\t\tif(!delegates.isEmpty())' \
		java/org/antlr/tool/CompositeGrammar.java \
		|| die "Failed to sed/add conditional"
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
