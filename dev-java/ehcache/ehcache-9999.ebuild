# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}3"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Open source, standards-based cache"
HOMEPAGE="https://www.${PN}.org"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/jcache:0
	dev-java/offheap-store:0
	dev-java/sizeof:0
	dev-java/slf4j-api:0
	dev-java/spotbugs-annotations:0
	dev-java/statistics:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="
	107/src/main/java
	api/src/main/java
	core/src/main/java
	impl/src/main/java
	xml/src/main/java
"

java_prepare() {
	# Alternative to xjc is scomp from beanutils
	xjc -d xml/src/main/java -p org.ehcache.xml.model \
		xml/src/main/resources/ehcache-core.xsd \
		|| die "Failed to generate java source files via xjc"

}
