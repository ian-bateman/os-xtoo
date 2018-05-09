# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}api"
MY_PV="${PV//./_}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/stevensouza/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Simple, high performance, thread safe API to monitor applications"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD"
SLOT="0"

JETTY_SLOT="9.4"

CP_DEPEND="
	dev-java/javax-interceptor-api:0
	dev-java/jetty-io:${JETTY_SLOT}
	dev-java/jetty-server:${JETTY_SLOT}
	dev-java/jetty-util:${JETTY_SLOT}
	dev-java/log4j:0
	dev-java/tomcat-catalina:9
	dev-java/tomcat-servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_RM_FILES=(
	aop/spring
	distributed/HazelcastFilePersister.java
	distributed/HazelcastPersister.java
	distributed/HazelcastPersisterImp.java
)
JAVA_RM_FILES=( ${JAVA_RM_FILES[@]/#/src/main/java/com/jamonapi/} )

java_prepare() {
	local f

	for f in JAMonJettyHandler JettyHttpMonItem ; do
		sed -i -e "s|org.mortbay.jetty|org.eclipse.jetty.server|" \
			src/main/java/com/jamonapi/http/${f}.java \
			|| die "Failed to sed/change import"
	done

	sed -i -e '30d' \
		-e 's|entConnection()|entConnection().getHttpChannel()|g' \
		-e 's|target, req.*|target, baseRequest, request, response);|' \
		src/main/java/com/jamonapi/http/JAMonJettyHandler.java \
		|| "Failed to sed/delete @Override"

	sed -i -e '116d' src/main/java/com/jamontomcat/JAMonTomcat55Valve.java \
		|| "Failed to sed/delete @Override"

	sed -i -e '119d' src/main/java/com/jamonapi/http/JAMonTomcatValve.java \
		|| "Failed to sed/delete @Override"
}
