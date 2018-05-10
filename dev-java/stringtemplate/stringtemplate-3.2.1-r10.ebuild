# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Template engine"
HOMEPAGE="https://www.stringtemplate.org/"
SRC_URI="https://github.com/antlr/website-st4/raw/gh-pages/download/${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

CP_DEPEND="dev-java/antlr:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src"

java_prepare() {
	local f p

	p="org/antlr/stringtemplate/language"
	mv target/classes/${p}/TemplateParserTokenTypes.txt src/${p} \
		|| die "Failed to move/copy TemplateParserTokenTypes.txt"
	for f in action angle.bracket.template eval group interface template; do
		antlr -o src/${p}/{,${f}.g} \
			|| die "Failed to generate java sources via antlr"
	done
}
