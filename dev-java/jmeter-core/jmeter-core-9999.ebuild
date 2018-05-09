# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}-${MY_PV^^}"

BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Load test functional behavior and measure performance ${PN#*-}"
HOMEPAGE="https://${PN}.apache.org"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/commons-bsf:0
	dev-java/commons-codec:0
	dev-java/commons-collections:0
	dev-java/commons-io:0
	dev-java/commons-lang:3
	dev-java/commons-math:3
	dev-java/freemarker:0
	dev-java/jakarta-oro:0
	~dev-java/jmeter-jorphan-${PV}:${SLOT}
	dev-java/jodd-props:0
	dev-java/jtidy:0
	dev-java/log4j-api:0
	dev-java/log4j-core:0
	dev-java/rhino:0
	dev-java/rsyntaxtextarea:0
	dev-java/slf4j-api:0
	dev-java/tika-core:0
	dev-java/xalan:0
	dev-java/xstream:0
	dev-java/xml-graphics-commons:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/src/${PN#*-}"
