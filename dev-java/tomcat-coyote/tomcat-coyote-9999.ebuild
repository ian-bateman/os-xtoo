# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	MY_PV="${PV/_beta/}"
	MY_P="apache-${MY_PN}-${MY_PV}-src"
	SRC_URI="mirror://apache/${MY_PN}/${MY_PN}-${PV%%.*}/v${MY_PV}/src/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/tomcat-api-${PV}:${SLOT}
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

JAVA_SRC_DIR="
	java/org/apache/coyote
	java/org/apache/tomcat/util/bcel
	java/org/apache/tomcat/util/http
	java/org/apache/tomcat/util/log
	java/org/apache/tomcat/util/modeler
	java/org/apache/tomcat/util/net
"
JAVA_RES_DIR="java/resources"

java_prepare() {
	local d p

	p="org/apache/coyote"
	mkdir -p ${JAVA_RES_DIR}/${p}/{ajp,http11/filters,http11/upgrade,http2} \
		|| die "Failed to make resources directories"

	cp java{,/resources}/${p}/mbeans-descriptors.xml \
		|| die "Failed to copy mbeans-descriptors.xml"

	for d in "" ajp/ http11/{,filters/,upgrade/} http2/; do
		cp java{,/resources}/${p}/${d}LocalStrings.properties \
			|| die "Failed to copy ${d}/LocalStrings.properties"
	done

	p="org/apache/tomcat/util"
	mkdir -p ${JAVA_RES_DIR}/${p}/{http/parser,modeler,net/jsse,net/openssl/ciphers} \
		|| die "Failed to make resources directories"

	cp java{,/resources}/${p}/modeler/mbeans-descriptors.dtd \
		|| die "Failed to copy mbeans-descriptors.xml"

	for d in http http/parser net{,/jsse,/openssl,/openssl/ciphers}; do
		cp java{,/resources}/${p}/${d}/LocalStrings.properties \
			|| die "Failed to copy ${d}/LocalStrings.properties"
	done
}
