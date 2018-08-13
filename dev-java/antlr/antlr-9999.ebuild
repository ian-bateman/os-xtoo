# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}${PV%%.*}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/${PN}/${MY_PN}"

# Sources from maven for pre-generated UnicodeData.java
# Temporary, need to generate via stringtemplate
# live will fail without generating UnicodeData.java
if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz
		http://repo1.maven.org/maven2/org/${PN}/${MY_PN}/${PV}/${MY_P}-sources.jar"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/antlr:3
	dev-java/icu4j:0
	dev-java/javax-json-api:0
	dev-java/stringtemplate:4
	dev-java/treelayout:0
"

inherit java-pkg

DESCRIPTION="A parser generator for many languages"
HOMEPAGE="http://www.antlr.org/"
LICENSE="BSD"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}"

java_prepare() {
# Need to process this file to generate UnicodeData.java
# Likely using UnicodeDataTemplateController
#	${S}/tool/resources/org/antlr/v4/tool/templates/unicodedata.st
	cp "${WORKDIR}/src/org/antlr/v4/unicode/UnicodeData.java" \
		"${S}/tool/src/org/antlr/v4/unicode/" \
		|| die "Failed to copy pre-generated UnicodeData.java"

	antlr3 -fo tool/src/ tool/src/org/antlr/v4/codegen/*.g \
		tool/src/org/antlr/v4/parse/*.g \
		|| die "Failed to compile antlr grammar files"

	sed -i -e "s|return children|return (GrammarAST[])children|" \
		tool/src/org/antlr/v4/tool/ast/GrammarAST.java \
		|| die "Failed to sed/fix cast"

	sed -i -e 's|\.insertChild(.*, |\.addChild(|g' \
		-e "s|elements = combined|elements = (GrammarAST[])combined|" \
		-e "s|options = options|options = (GrammarAST[])options|" \
		-e "s|rules = combined|rules = (GrammarASTWithOptions[])combined|" \
		tool/src/org/antlr/v4/tool/GrammarTransformPipeline.java \
		|| die "Failed to sed/fix cast and method renames"

	sed -i -e "s|input.range()|input.index()|g" \
		tool/src/ANTLRParser.java \
		|| die "Failed to sed/fix method rename"
}

src_compile() {
	cd "${S}/runtime/Java/src"
	JAVA_JAR_FILENAME="${S}/${PN}-runtime.jar"
	JAVA_PKG_IUSE="doc"
	java-pkg-simple_src_compile

	cd "${S}/tool/src"
	JAVA_CLASSPATH_EXTRA="${S}/${PN}-runtime.jar"
	JAVA_JAR_FILENAME="${S}/${PN}-tool.jar"
	JAVA_RES_DIR="${S}/tool/resources"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg_dojar *.jar
	java-pkg_dolauncher ${PN}${SLOT} --main org.antlr.v4.Tool
	use doc && java-pkg_dojavadoc runtime/Java/src/target/api
	use source && java-pkg_dosrc runtime/Java/src/org tool/src/org
}
