# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

MY_PN="${PN/-/_}"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV^^}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

inherit autotools java-pkg

DESCRIPTION="Tools to allow Java programs to run as UNIX daemons"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

src_prepare() {
	default
	cd "${S}/src/native/unix" || die "Failed to change sources dir"
	eautoreconf
}

src_configure() {
	cd "${S}/src/native/unix" || die "Failed to change sources dir"
	econf ${MY_ECONF} --with-java="${EPREFIX}/etc/jem/vm/"
}

src_compile() {
	java-pkg-simple_src_compile
	cd "${S}/src/native/unix" || die "Failed to change sources dir"
	default
}

src_install() {
	java-pkg-simple_src_install
	dobin src/native/unix/jsvc
}
