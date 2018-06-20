# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/tomcat-api-${PV}:${SLOT}
	~dev-java/tomcat-coyote-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	~dev-java/tomcat-servlet-api-${PV}:4.0
	~dev-java/tomcat-util-${PV}:${SLOT}
	~dev-java/tomcat-websocket-api-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="java/org/apache/tomcat/websocket/"
JAVA_RES_DIR="java/resources"

java_prepare() {
	local d p

	p="org/apache/tomcat/websocket"
	mkdir -p ${JAVA_RES_DIR}/${p}/{,pojo,server} ${JAVA_RES_DIR}/META-INF \
		|| die "Failed to make resources directories"

	for d in "" pojo/ server/; do
		cp java{,/resources}/${p}/${d}LocalStrings.properties \
			|| die "Failed to copy ${d}/LocalStrings.properties"
	done

	cp -r res/META-INF/${PN}.jar/* ${JAVA_RES_DIR}/META-INF \
                || die "Failed to copy res/META-INF/${PN}.jar/*"
}
