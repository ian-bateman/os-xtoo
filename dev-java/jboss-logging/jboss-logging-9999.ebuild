# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="JBoss Logging"
HOMEPAGE="http://community.jboss.org/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/jboss-logmanager:0
	dev-java/log4j:0
	dev-java/log4j-api:0
	dev-java/slf4j-api:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
#	sed -i -e "s|map = .*|map = new Map<String, Object>();|" \
	sed -i -e "s|map = .*|map = Collections.<String, Object>emptyMap();|" \
		-e '66i\ \ \ \ \ \ \ \ map.putAll(MDC.getCopyOfContextMap());' \
		src/main/java/org/jboss/logging/Slf4jLoggerProvider.java \
		|| die "Failed to sed/fix type mismatch"
}
