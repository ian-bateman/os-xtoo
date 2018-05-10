# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="W3C XPath-Rec implementation for DOM4J"
HOMEPAGE="https://sourceforge.net/projects/werken-xpath/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/antlr:0
	dev-java/jdom:2
"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

java_prepare() {
	local f
	for f in xpath xpath_lexer; do
		antlr -o "src/main/java/com/werken/xpath/parser" \
			"src/main/antlr/${f}.g" \
			|| die "Failed to compile antlr grammar file ${f}.g"
	done
}
