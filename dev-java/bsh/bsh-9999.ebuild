# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="beanshell"
MY_PV="${PV/_beta/b}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="A small embeddable Java source interpreter"
HOMEPAGE="${BASE_URI}"
LICENSE="LGPL-2.1"
SLOT="0"

CP_DEPEND="
	dev-java/commons-bsf:0
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	dev-java/javacc:0
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src asm/src bsf/src"

java_prepare() {
	cd src/bsh || die "Failed to change directory"
	jjtree -JDK_VERSION="1.8" bsh.jjt \
		|| die "Failed jjtree bsh.jjt"
	javacc -JDK_VERSION="1.8" bsh.jj \
		|| die "Failed javacc bsh.jj"
	sed -i -e "s|stream, encoding|stream, Integer.parseInt(encoding)|g" \
		-e "s|java.io.UnsupportedEncoding||g" \
		"${S}"/src/bsh/Parser.java \
		|| die "Failed to convert InputStream to Reader"
	sed -i -e "s|, curChar,|, (char) curChar,|g" \
		"${S}"/src/bsh/ParserTokenManager.java \
		|| die "Failed to cast char to int"
}

src_install() {
	java-pkg-simple_src_install

	java-pkg_dolauncher "${PN}-console" --main bsh.Console
	java-pkg_dolauncher "${PN}-interpreter" --main bsh.Interpreter
}
