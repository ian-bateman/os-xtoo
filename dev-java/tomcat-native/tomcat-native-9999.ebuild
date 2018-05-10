# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN^^}"
MY_PN="${MY_PN/-/_}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != 9999 ]]; then
	KEYWORDS="~amd64"
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

inherit autotools java-pkg

DESCRIPTION="Allows Tomcat to use native resources for performance, compatibility, etc"
HOMEPAGE="https://tomcat.apache.org/native-doc/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	dev-libs/apr:1
	dev-libs/openssl:=
	>=virtual/jdk-9:*
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_S}/native"

src_prepare() {
	local p

	eapply_user

	p="$(apr-1-config --installbuilddir)"
	cp "${p}"/{apr_common,find_apr}.m4 build \
		|| die "Failed to copy apr m4 files"

	sed -i -e "s|configure.in|[${PN}],[${PV}]|" \
		-e "24iAC_CONFIG_FILES(Makefile src/Makefile)" \
		-e "28iAM_INIT_AUTOMAKE" \
		configure.in \
		|| die "Failed to sed configure.ac -> configure.in"
	mv configure.{in,ac} || die "Failed to rename configure.in -> .ac"

	p=libtcnative
	echo "SUBDIRS = src" > Makefile.am || die "Failed to create Makefile.am"
	echo "lib_LTLIBRARIES = ${p}.la
${p}_la_CFLAGS = -I ../include $(apr-1-config --includes) \$(TCNATIVE_PRIV_INCLUDES)
${p}_la_SOURCES = address.c file.c misc.c os.c shm.c sslinfo.c thread.c bb.c info.c mmap.c poll.c ssl.c sslnetwork.c user.c dir.c jnilib.c multicast.c pool.c sslconf.c sslutils.c error.c lock.c network.c proc.c sslcontext.c stdlib.c
" >> src/Makefile.am || die 'Failed to create src/Makefile.am'

	# temp hack copy missing file...
	cp /usr/share/libtool/build-aux/ltmain.sh build \
		|| die "Failed to copy missing ltmain.sh"

	eautoreconf
}

src_configure() {
	econf --with-apr=/usr/bin/apr-1-config --with-ssl=/usr
}

src_compile() {
	default
	prune_libtool_files
}

src_install() {
	default
}
