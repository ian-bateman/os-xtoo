# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Extractor of Java class/interface/method definitions"
HOMEPAGE="https://github.com/codehaus/qdox"
SRC_URI="${HOMEPAGE}/archive/${P}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="dev-java/ant-core:0"

DEPEND="dev-java/byaccj:0
	dev-java/jflex:0
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${PN}-${P}"

java_prepare(){
	find . -name '*Test*.java' -delete || \
		die "Failed to remove tests"

	jflex -d src/java --skel src/grammar/{skeleton.inner,lexer.flex} \
		|| die "Failed to generate java files via jflex"
	mkdir src/java/com/thoughtworks/qdox/parser/impl \
		|| die "Failed to make directory"
	cd src/java/com/thoughtworks/qdox/parser/impl \
		|| die "Failed to change directory"
	byaccj -v \
		-Jnorun \
		-Jnoconstruct \
		-Jclass=Parser \
		-Jsemantic=Value \
		-Jpackage=com.thoughtworks.qdox.parser.impl \
		"${S}"/src/grammar/parser.y \
		|| die "Failed to generate DefaultJavaCommentParser via byaccj"
}
