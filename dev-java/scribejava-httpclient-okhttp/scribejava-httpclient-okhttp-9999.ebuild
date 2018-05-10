# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:10}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_PN}-${PV}/${PN}"
fi

inherit java-pkg

DESCRIPTION="Simple OAuth library for Java Http Client using Okhttp"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

CP_DEPEND="
	dev-java/okio:0
	dev-java/okhttp:3
	~dev-java/${MY_PN}-core-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java/"
