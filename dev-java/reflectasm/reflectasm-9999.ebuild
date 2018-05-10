# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/EsotericSoftware/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="High performance Java reflection"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"
SLOT="0"

CP_DEPEND="dev-java/asm:6"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local f

	for f in Constructor Field Method; do
		sed -i -e "s|com.esotericsoftware.asm|org.objectweb.asm|g" \
			src/com/esotericsoftware/reflectasm/${f}Access.java \
			|| die "Failed to sed/swap to external asm"
	done
}
