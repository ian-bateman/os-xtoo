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

CP_DEPEND="
	~dev-java/tomcat-catalina-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	~dev-java/tomcat-util-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="
	java/org/apache/catalina/webresources/war
	java/org/apache/catalina/security
	java/org/apache/catalina/startup
	java/org/apache/tomcat/util/buf
"
JAVA_RES_DIR="java/resources"

java_prepare() {
	local p

	p="java/org/apache"
	find ${p}/catalina/webresources/war/ -type f \
		-not -name 'Handler*' -not -name 'WarURLConnection*' -delete \
		|| die "Failed to remove sources from webresources"

	find ${p}/catalina/security/ -type f \
		-not -name 'SecurityClassLoad*' -delete \
		|| die "Failed to remove sources from security"

	find ${p}/catalina/startup/ -type f \
		-not -name 'Bootstrap*' -not -name 'CatalinaProperties*' \
		-not -name 'ClassLoader*' -not -name 'SafeForkJoin*' \
		-not -name 'Tool*' -delete \
		|| die "Failed to remove sources from security"

	find ${p}/tomcat/util/buf/ -type f -not -name 'UriUtil*' -delete \
		|| die "Failed to remove sources from util/buf"

	mkdir -p ${JAVA_RES_DIR}/org/apache/catalina/startup \
		|| die "Failed to make resources directory"

	cp conf/catalina.properties \
		${JAVA_RES_DIR}/org/apache/catalina/startup \
		|| die "Failed to copy catalina.properties"
}
