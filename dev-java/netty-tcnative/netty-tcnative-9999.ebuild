# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PV="${PV}.Final"
MY_P="${PN}-parent-${MY_PV}"
BASE_URI="https://github.com/${PN%%-*}/${PN}/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit autotools java-pkg

DESCRIPTION="Fork of Tomcat Native that incorporates various patches"
HOMEPAGE="https://netty.io/wiki/forked-${PN}.html"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CDEPEND="
	dev-libs/apr:1=
	dev-libs/openssl:0=
"

RDEPEND="${CDEPEND}
	>=virtual/jre-9"

DEPEND="${CDEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${MY_S}/openssl-dynamic"
NATIVE_DIR="src/main/native-package"

java_prepare() {
	local sources

	mv src/main/{c,native-package/src} || die "Failed to move directory"
	cd "${NATIVE_DIR}" || die
	sources=( $(find . -name '*.c') )

	 echo "pkglib_LTLIBRARIES = lib${PN}.la
lib${PN/-/_}_la_CFLAGS = -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux
lib${PN/-/_}_la_SOURCES = ${sources[@]}" \
		>> Makefile.am || die

	sed -i -e "s|\[\@PROJECT_NAME\@\]|\[${PN}\]|" \
		-e "s|\@VERSION\@|${PV}|g" \
		-e "s|/error.c||" \
		-e "s|AC_CONFIG_HEADERS|#AC_CONFIG_HEADERS|" \
		-e 's|${CFLAGS="-O3 -Werror"}|LT_INIT([dlopen])|' \
		-e "s|disable-static|libtool shared disable-static|" \
		-e "s|WITH_OSX_UNIVERSAL|#WITH_OSX_UNIVERSAL|" \
		configure.ac || die

	eautoreconf
}

src_configure(){
	cd "${NATIVE_DIR}" || die
	econf --with-apr=/usr/bin/apr-1-config --with-ssl=/usr
}

src_compile() {
	java-pkg-simple_src_compile

	emake -C "${NATIVE_DIR}"
	prune_libtool_files
}

src_install() {
	java-pkg-simple_src_install

	cd "${NATIVE_DIR}" || die
	java-pkg_doso .libs/lib${PN}-${PV}.so
	dosym lib${PN}-${PV}.so /usr/$(get_libdir)/${PN}-${SLOT}/lib${PN}.so
}
