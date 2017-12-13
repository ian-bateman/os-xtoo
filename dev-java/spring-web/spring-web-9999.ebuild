# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="spring-framework"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/spring-projects/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.RELEASE.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}/${PN}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Spring Framework ${PN:7}"
HOMEPAGE="https://spring.io/"
LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 1-2)"

HTTPCORE_SLOT="4.4"
JACKSON_SLOT="2"
NETTY_SLOT="4.1"

CP_DEPEND="
	dev-java/commons-logging:0
	dev-java/commons-fileupload:0
	dev-java/groovy:0
	dev-java/gson:2.7
	dev-java/hessian:4.0
	dev-java/httpcomponents-client:4.5
	dev-java/httpcomponents-core:${HTTPCORE_SLOT}
	dev-java/httpcomponents-core-nio:${HTTPCORE_SLOT}
	dev-java/httpcomponents-httpasyncclient:0
	dev-java/jackson-core:${JACKSON_SLOT}
	dev-java/jackson-annotations:${JACKSON_SLOT}
	dev-java/jackson-databind:${JACKSON_SLOT}
	dev-java/jackson-dataformat-xml:${JACKSON_SLOT}
	dev-java/jdom:2
	dev-java/log4j:0
	dev-java/myfaces-api:0
	dev-java/netty-buffer:${NETTY_SLOT}
	dev-java/netty-codec:${NETTY_SLOT}
	dev-java/netty-codec-http:${NETTY_SLOT}
	dev-java/netty-common:${NETTY_SLOT}
	dev-java/netty-handler:${NETTY_SLOT}
	dev-java/netty-transport:${NETTY_SLOT}
	dev-java/okhttp:0
	dev-java/okhttp:3
	dev-java/okio:0
	dev-java/javamail:0
	dev-java/portlet-api:2
	dev-java/protobuf-java:0
	dev-java/protobuf-java-format:0
	dev-java/rome:0
	~dev-java/spring-aop-${PV}:${SLOT}
	~dev-java/spring-beans-${PV}:${SLOT}
	~dev-java/spring-beans-groovy-${PV}:${SLOT}
	~dev-java/spring-context-${PV}:${SLOT}
	~dev-java/spring-core-${PV}:${SLOT}
	~dev-java/spring-oxm-${PV}:${SLOT}
	dev-java/beanvalidation-api:1.0
	java-virtuals/servlet-api:3.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"
