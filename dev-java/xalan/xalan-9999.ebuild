# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}-j"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/commons-bcel:0
	dev-java/java-cup:0
	dev-java/xerces:2
"

inherit java-pkg

DESCRIPTION="Transform XML documents using XSLT standard stylesheets"
HOMEPAGE="https://xalan.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND+=" dev-java/jlex:0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	mkdir src/resources || die "Failed to make resources directory"
	mv src/META-INF src/resources || die "Failed to move META-INF"

	cd src/org/apache/xalan/xsltc/compiler \
		|| die "Failed to change directory"

	javacup -parser XPathParser -expect 0 \
		"${S}/src/org/apache/xalan/xsltc/compiler/xpath.cup" \
		|| die "Failed to generate java files via javacup"

	jlex xpath.lex || die "Failed to generate java files via jlex"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher ${PN} --main org.apache.xalan.xslt.Process
}
