# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/jnr/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

inherit autotools java-pkg

DESCRIPTION="Java Foreign Function Interface"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0 LGPL-3+"
SLOT="0"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "

src_prepare() {
	default
	java-utils-2_src_prepare
	mkdir src/main/resources || die "Failed to make resources directory"
	echo " jffi.boot.library.path = /usr/$(get_libdir)/${PN}" > \
		src/main/resources/boot.properties \
		|| die "Failed create boot.properties resource file"
	cd jni/libffi || die "Failed to change directory to native sources"
	eautoreconf
}

src_configure() {
	cd jni/libffi || die "Failed to change directory to configure sources"
	default
}

src_compile() {
	java-pkg-simple_src_compile
	cd jni/libffi || die "Failed to change directory for native compile"
	default
}

src_install() {
	local so
	java-pkg-simple_src_install
	so="libffi-${PV%*.*}.so"
	mv jni/libffi/x86_64-pc-linux-gnu/.libs/libffi.so\.*\.*\.* "${so}" \
		|| die "Failed to rename .so"
	java-pkg_doso "${so}"
}
