# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}-parent"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/apache/${PN:0:5}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN:0:5}-${MY_P}"
fi

SLOT="0"

TILESREQ_SLOT="0"

CP_DEPEND="
	dev-java/slf4j-api:0
	~dev-java/tiles-api-${PV}:${SLOT}
	dev-java/tiles-request-api:${TILESREQ_SLOT}
	dev-java/tiles-request-servlet:${TILESREQ_SLOT}
	dev-java/tiles-request-velocity:${TILESREQ_SLOT}
	dev-java/velocity-engine-core:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Templating framework for modern Java applications ${PN:6}"
HOMEPAGE="https://tiles.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
