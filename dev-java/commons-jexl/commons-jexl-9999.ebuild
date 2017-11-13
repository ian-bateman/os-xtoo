# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

MY_PN="${PN//-/_}"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV^^}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Library to facilitate dynamic and scripting features"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="dev-java/commons-logging:0"

DEPEND="${CP_DEPEND}
	dev-java/javacc:0
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local MY_D
	MY_D="${S}/src/main/java/org/apache/commons/jexl${SLOT}/parser/"

	jjtree -OUTPUT_DIRECTORY="${MY_D}" "${MY_D}Parser.jjt" \
		|| die "jjtree Parser.jjt failed"

	javacc -OUTPUT_DIRECTORY="${MY_D}" "${MY_D}Parser.jj" \
		|| die "javacc Parser.jj failed"

	if [[ ${SLOT} == 3 ]]; then
		sed -i -e "s|interface|abstract class |" \
			-e '/ASTAmbiguous/d' \
			-e '/ASTJexlLambda/d' \
			-e "s|public O|protected abstract O|g" \
			"${MY_D}ParserVisitor.java" \
			|| die "Sed ParserVisitor.java failed"
		# inserted at ramdon location, common blank line number
		local f
		for f in Debugger Interpreter; do
			sed -i -e "95iimport org.apache.commons.jexl3.parser.SimpleNode;" \
				-e "866i\@Override\nprotected Object visit\(SimpleNode node,Object data\) \{ return new Object\(\); \}\n" \
				"src/main/java/org/apache/commons/jexl3/internal/${f}.java" \
				|| die "Failed to add missing method"
		done
	fi
}
