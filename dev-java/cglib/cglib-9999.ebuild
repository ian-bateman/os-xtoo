# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="RELEASE"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:7
"

inherit java-pkg

DESCRIPTION="Byte Code Generation Library"
HOMEPAGE="https://github.com/cglib/cglib/wiki"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	sed -i -e "20d" src/main/java/net/sf/cglib/reflect/MethodDelegate.java \
		|| die "Failed to remove empty package"
}
