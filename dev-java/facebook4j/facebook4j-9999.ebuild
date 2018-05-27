# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/roundrop/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="
	dev-java/commons-logging:0
	dev-java/log4j:0
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="Easily usable Facebook Graph API binding library"
HOMEPAGE="https://${PN}.github.io"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${P}/${PN}-core"

PATCHES=(
	"${FILESDIR}/hashmap-linkedhashmap.patch"
)
