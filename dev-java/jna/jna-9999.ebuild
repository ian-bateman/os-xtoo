# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/java-native-access/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Java Native Access"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
IUSE="+awt +nio-buffers"
if [[ ${PV} == 3* ]]; then
	SLOT="0"
else
	SLOT="${PV%%.*}"
fi

CDEPEND="dev-libs/libffi"

DEPEND="${CDEPEND}
	>=virtual/jdk-9
	virtual/pkgconfig"

RDEPEND="${CDEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

src_prepare() {
	default

	sed -i -e 's|all: $(LIBRARY) .*|all: $(LIBRARY)|' native/Makefile \
		|| die "Failed to sed/remove troublesome build of testlib"

	if ! use awt ; then
		sed -i -E "s/^(CDEFINES=.*)/\1 -DNO_JAWT/g" native/Makefile \
			|| die "Failed to sed native/Makefile for AWT"
	fi

	if ! use nio-buffers ; then
		sed -i -E "s/^(CDEFINES=.*)/\1 -DNO_NIO_BUFFERS/g" \
			native/Makefile || die "Failed to sed native/Makefile"
	fi

	java-pkg-2_src_prepare
}

src_compile() {
	java-pkg-simple_src_compile

# Fails no header output needed for 9+ no more javah
#	javac -h native -cp ${PN}.jar src/com/sun/jna/{Function,Native}.java \
	javah -d native -cp ${PN}.jar com.sun.jna.{Function,Native} \
		|| die "Failed to generate jni headers"
	cd native || die "Failed to change directory for native compile"
	emake DYNAMIC_LIBFFI=true || die "Failed to compile native code"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_doso build*/native*/libjnidispatch.so
}
