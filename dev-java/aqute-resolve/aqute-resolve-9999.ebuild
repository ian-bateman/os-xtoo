# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.REL.tar.gz -> bnd-${PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="bnd-${PV}.REL"
fi

inherit java-pkg

DESCRIPTION="aQute Resolve"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"
SLOT="$(get_major_version)"

OSGI_SLOT="5"

CP_DEPEND="~dev-java/aqute-repository-${PV}:${SLOT}
	~dev-java/bndlib-${PV}:${SLOT}
	dev-java/felix-resolver:0
	~dev-java/libg-${PV}:${SLOT}
	dev-java/osgi-compendium:${OSGI_SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/biz.aQute.resolve"

JAVA_SRC_DIR="src/"
