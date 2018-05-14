# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/_pre/-M}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/paul-hammant/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Extractor of Java class/interface/method definitions"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

DEPEND="
	dev-java/byaccj:0
	dev-java/jflex:0
"

S="${WORKDIR}/${MY_S}"

java_prepare(){
	jflex -d src/main/java src/grammar/{commentlexer,lexer}.flex \
		|| die "Failed to generate java files via jflex"
	cd src/main/java/com/thoughtworks/qdox/parser/impl \
		|| die "Failed to change directory"
	byaccj -v \
		-Jnorun \
		-Jnoconstruct \
		-Jclass=DefaultJavaCommentParser \
		-Jpackage=com.thoughtworks.qdox.parser.impl \
		"${S}"/src/grammar/commentparser.y \
		|| die "Failed to generate DefaultJavaCommentParser via byaccj"
	byaccj -v \
		-Jnorun \
		-Jnoconstruct \
		-Jclass=Parser \
		-Jimplements=CommentHandler \
		-Jsemantic=Value \
		-Jpackage=com.thoughtworks.qdox.parser.impl \
		"${S}"/src/grammar/parser.y \
		|| die "Failed to generate DefaultJavaCommentParser via byaccj"

	sed -i -e "s|( stream )|(new BufferedReader(new InputStreamReader(stream)))|" \
		-e '/import java.util.*;/i \ import java.io.*;' \
		"${S}"/src/main/java/JFlexLexer.java \
		|| die "Could convert InputStream to Reader"
	sed -i -e "s|( sourceStream )|(new BufferedReader(new InputStreamReader(sourceStream)))|" \
		-e '/import java.io.InputStream;/i \ import java.io.InputStreamReader; \ import java.io.BufferedReader;' \
		"${S}"/src/main/java/com/thoughtworks/qdox/library/ClassLoaderLibrary.java \
		|| die "Could convert InputStream to Reader"
}
