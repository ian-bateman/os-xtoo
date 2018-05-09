# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:7}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
MY_MOD="${MY_MOD/-//}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-rel-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="JClouds Driver for ${DRIVER}"
HOMEPAGE="https://jclouds.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/javax-inject:0
	~dev-java/jclouds-core-${PV}:${SLOT}
	dev-java/guava:24
	dev-java/guice:4
	dev-java/okhttp:0
	dev-java/okio:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

# Incomplete okhttp3 patch
#PATCHES=(
#	"${FILESDIR}/${PN}-${SLOT}-okhttp3.patch"
#)
