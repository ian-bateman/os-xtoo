# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Relational database implemented entirely in Java - ${PN:6}"
HOMEPAGE="https://db.apache.org/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	~dev-java/derby-engine-${PV}:${SLOT}
	~dev-java/derby-shared-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}/java/${PN:6}"
