# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/lz4/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit autotools java-pkg

DESCRIPTION="LZ4 compression for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
IUSE="jni"
SLOT="0"

S="${WORKDIR}/${P}"

JAVA_RM_FILES=( src/test )

java_prepare() {
	if use jni; then
		sed -i -e "s|_state_t|_stateSpace_t|g" \
			-e "s|(XXH32_state_t*)|XXH64_state_t*|g" \
			-e "s|(XXH64_state_t*)|XXH64_state_t*|g" \
			src/jni/net_jpountz_xxhash_XXHashJNI.c \
			|| die "Failed to sed/fix variable"

		echo "AC_INIT([${PN}], [${PV}])
AM_INIT_AUTOMAKE
AC_PROG_CC
AC_PROG_LIBTOOL
AC_OUTPUT(Makefile src/jni/Makefile)
LT_INIT([shared])
" >> configure.ac || die 'Failed to generate configure.ac'

		echo "SUBDIRS = src/jni/" >> Makefile.am \
			|| die "Failed to generate Makefile.am"

		echo "lib_LTLIBRARIES = lib${PN}.la
lib${PN/-/_}_la_CFLAGS = -I../lz4 -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux
lib${PN/-/_}_la_SOURCES = ../lz4/lz4.c, ../lz4/lz4hc.c, ../lz4/xxhash.c, net_jpountz_lz4_LZ4JNI.c, net_jpountz_xxhash_XXHashJNI.c
" >> src/jni/Makefile.am || die 'Failed to generate src/jni/Makefile.am'

		eautoreconf
	fi
}

src_compile() {
	java-pkg-simple_src_compile

	if use jni; then
		javac -h src/jni -cp ${PN}.jar \
			src/java/net/jpountz/{lz4/LZ4JNI,xxhash/XXHashJNI}.java \
			|| die "Failed to generate jni headers"
		default
	fi
}

src_install() {
	java-pkg-simple_src_install

	if use jni; then
		java-pkg_doso src/jni/.libs/lib${PN}.so.0.0.0
		dosym lib${PN}.so.0.0.0 /usr/$(get_libdir)/${PN}/lib${PN}.so
	fi
}
