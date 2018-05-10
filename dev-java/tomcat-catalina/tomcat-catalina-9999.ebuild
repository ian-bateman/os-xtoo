# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	MY_PV="${PV/_beta/}"
	MY_P="apache-${MY_PN}-${MY_PV}-src"
	SRC_URI="mirror://apache/${MY_PN}/${MY_PN}-${PV%%.*}/v${MY_PV}/src/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

# may need to switch to dummy in sources for non tomcat deps
CP_DEPEND="
	dev-java/eclipse-javax-persistence:2
	dev-java/javamail:0
	dev-java/javax-annotation:0
	dev-java/javax-ejb-api:0
	dev-java/jaxws-api:0
	~dev-java/tomcat-annotations-api-${PV}:${SLOT}
	~dev-java/tomcat-api-${PV}:${SLOT}
	~dev-java/tomcat-coyote-${PV}:${SLOT}
	~dev-java/tomcat-jaspic-api-${PV}:${SLOT}
	~dev-java/tomcat-jni-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	~dev-java/tomcat-servlet-api-${PV}:4.0
	~dev-java/tomcat-util-${PV}:${SLOT}
	~dev-java/tomcat-util-scan-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="java/org/apache/catalina java/org/apache/naming"
JAVA_RES_FIND=" -not -name LocalStrings_*.properties "
JAVA_RM_FILES=( ant ha storeconfig tribes )
JAVA_RM_FILES=(
	${JAVA_RM_FILES[@]/#/java/org/apache/catalina/}
	java/org/apache/naming/factory/webservices
)

java_prepare() {
	sed -i -e "s|@VERSION@|${PV}-os-xtoo|" \
		-e "s|@VERSION_NUMBER@|${PV}|" \
		-e "s|@VERSION_BUILT@|$(date)|" \
		java/org/apache/catalina/util/ServerInfo.properties \
		|| die "Failed to sed version"
}
