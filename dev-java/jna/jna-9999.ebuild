# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/java-native-access/${PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Java Native Access"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
IUSE="+awt +nio-buffers"
SLOT="${PV%%.*}"

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
		-e 's|-W ||' \
		-e 's|CFLAGS=|CFLAGS+= |' \
		-e 's|LDFLAGS=|LDFLAGS+= |' \
		|| die "Failed to sed/modify native/Makefile"

	if ! use awt ; then
		sed -i -E "s/^(CDEFINES=.*)/\1 -DNO_JAWT/g" native/Makefile \
			|| die "Failed to sed native/Makefile for AWT"
	fi

	if ! use nio-buffers ; then
		sed -i -E "s/^(CDEFINES=.*)/\1 -DNO_NIO_BUFFERS/g" \
			native/Makefile || die "Failed to sed native/Makefile"
	fi

	java-pkg_src_prepare

	# java 10+
	eapply "${FILESDIR}/Function.java.patch"
}

src_compile() {
	java-pkg-simple_src_compile

	javac -h native -cp ${PN}.jar src/com/sun/jna/{Function,Native}.java \
		|| die "Failed to generate jni headers"
	cd native || die "Failed to change directory for native compile"
	emake DYNAMIC_LIBFFI=true || die "Failed to compile native code"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_doso build*/native*/libjnidispatch.so
}
