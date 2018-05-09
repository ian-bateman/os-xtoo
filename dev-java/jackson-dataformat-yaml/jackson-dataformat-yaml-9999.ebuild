# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="jackson-dataformats-text"
MY_PV="${PV/_pre/.pr}"
MY_P="${MY_PN}-${MY_PV}"
JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/FasterXML/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Jackson module to add YAML backend (parser/generator adapters)"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/jackson-core-${PV}:${SLOT}
	~dev-java/jackson-databind-${PV}:${SLOT}
	dev-java/snakeyaml:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/${PN:19}"

java_prepare() {
	local my_file
	my_file="${S}/src/main/java/com/fasterxml/${PN//-//}/PackageVersion.java"
	sed -e "s|@package@|com.fasterxml.${PN//-/.}|g" \
		-e "s|@projectversion@|${PV}|g" \
		-e "s|@projectartifactid@|${PN}|g" \
		-e "s|@projectgroupid@|com.fasterxml.jackson.dataformat|g" \
		"${my_file}.in" > "${my_file}" \
		|| die "Could not set package version"
}
