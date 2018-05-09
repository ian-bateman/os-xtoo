# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_P="${PN}_${PV/./}"

DESCRIPTION="Converts source code to HTML, RTF, TeX and XHTML with syntax highlighting."
HOMEPAGE="http://www.${PN}.de/"
SRC_URI="http://www.java2html.de/${MY_P}.zip"

LICENSE="|| ( GPL-1 CPL-1.0 )"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="dev-java/ant-core:0"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVA_ENCODING="ISO-8859-1"

src_unpack() {
	default
	unzip java2html_src.zip
	rm java2html_src.zip || die "Failed to remove source zip after unpack"
	rm -r de/tisje de/java2html/demo de/java2html/properties/demo \
		de/java2html/suite de/java2html/plugin \
		|| die "Failed to remove unwanted sources/code"
	find . -name test -type d -exec rm -rv {} + \
		|| die "Failed to remove tests"
}
