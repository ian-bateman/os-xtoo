# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/derby-engine-${PV}:${SLOT}
	~dev-java/derby-shared-${PV}:${SLOT}
	~dev-java/derby-tools-${PV}:${SLOT}
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Relational database implemented entirely in Java - ${PN##*-}"
HOMEPAGE="https://db.apache.org/${PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_P}/java/${PN##*-}"
