# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
BASE_URI="https://github.com/jibx/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${P}"
fi

ECLIPSE_SLOT="4.7"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-bcel:0
	dev-java/jdom:0
	dev-java/dom4j:2
	dev-java/eclipse-equinox-common:${ECLIPSE_SLOT}
	dev-java/eclipse-jdt-core:${ECLIPSE_SLOT}
	dev-java/eclipse-text:${ECLIPSE_SLOT}
	dev-java/log4j:0
	dev-java/joda-time:0
	dev-java/qdox:0
	dev-java/xmlpull:0
"

inherit java-pkg

DESCRIPTION="JiBX core"
HOMEPAGE="${BASE_URI}"
LICENSE="public-domain"
SLOT="0"

S="${WORKDIR}/${MY_S}/build"

JAVA_SRC_DIR="extras src"
