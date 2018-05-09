# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:18}s-binary"
MY_P="${MY_PN}-${PV}"
MY_MOD="${PN:19}"

BASE_URI="https://github.com/FasterXML/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Uber-project for standard Jackson binary format backends"
HOMEPAGE="https://wiki.fasterxml.com/SmileFormat"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="dev-java/jackson-core:${SLOT}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

java_prepare() {
	local my_file
	my_file="${S}/src/main/java/com/fasterxml/jackson/dataformat/${MY_MOD}/PackageVersion.java"
	sed -e "s|@package@|com.fasterxml.jackson.dataformat.${MY_MOD}|g" \
		-e "s|@projectversion@|${PV}|g" \
		-e "s|@projectartifactid@|${MY_PN}|g" \
		-e "s|@projectgroupid@|com.fasterxml.jackson.dataformat|g" \
		"${my_file}.in" > "${my_file}" \
		|| die "Could not set package version"
}
