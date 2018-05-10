# Copyright 2016-2018 Obsidian-Studios, Inc.
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

inherit java-pkg

DESCRIPTION="Templating framework for modern Java applications ${PN:6}"
HOMEPAGE="https://tiles.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

TILESREQ_SLOT="0"

CP_DEPEND="
	dev-java/guava:21
	dev-java/mvel:0
	dev-java/ognl:0
	dev-java/slf4j-api:0
	~dev-java/tiles-api-${PV}:${SLOT}
	~dev-java/tiles-core-${PV}:${SLOT}
	~dev-java/tiles-compat-${PV}:${SLOT}
	~dev-java/tiles-el-${PV}:${SLOT}
	~dev-java/tiles-freemarker-${PV}:${SLOT}
	~dev-java/tiles-mvel-${PV}:${SLOT}
	~dev-java/tiles-ognl-${PV}:${SLOT}
	~dev-java/tiles-servlet-${PV}:${SLOT}
	dev-java/tiles-request-api:${TILESREQ_SLOT}
	dev-java/tiles-request-freemarker:${TILESREQ_SLOT}
	dev-java/tiles-request-mustache:${TILESREQ_SLOT}
	dev-java/tiles-request-servlet:${TILESREQ_SLOT}
	dev-java/tiles-request-servlet-wildcard:${TILESREQ_SLOT}
	dev-java/tiles-request-velocity:${TILESREQ_SLOT}
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"
