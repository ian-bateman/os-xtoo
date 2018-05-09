# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/FasterXML/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="General data-binding package for Jackson"
HOMEPAGE="https://wiki.fasterxml.com/JacksonHome"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/jackson-annotations-${PV}:${SLOT}
	~dev-java/jackson-core-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/"

java_prepare() {
	local my_file
	my_file="${S}src/main/java/com/fasterxml/jackson/databind/cfg/PackageVersion.java"
	sed -e "s|@package@|com.fasterxml.jackson.databind.cfg|g" \
		-e "s|@projectversion@|${PV}|g" \
		-e "s|@projectartifactid@|${PN}|g" \
		-e "s|@projectgroupid@|com.fasterxml.jackson.core|g" \
		"${my_file}.in" > "${my_file}" \
		|| die "Could not set package version"
}
