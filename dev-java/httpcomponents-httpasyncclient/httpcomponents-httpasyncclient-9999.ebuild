# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:15}"
MY_P="${MY_PN}-${PV}"
MY_MOD="${MY_PN}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="${PN/-/ }"
HOMEPAGE="https://hc.apache.org/${PN:0:14}-${PN:19}-${PV/.${PV#*.*.*}/}.x/index.html"
LICENSE="Apache-2.0"
SLOT="0"

HTTPCORE_SLOT="4.4"

CP_DEPEND="
	dev-java/commons-logging:0
	dev-java/httpcomponents-client:4.5
	dev-java/httpcomponents-core:${HTTPCORE_SLOT}
	dev-java/httpcomponents-core-nio:${HTTPCORE_SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}/${MY_MOD}"

JAVA_SRC_DIR="src/main/java"
