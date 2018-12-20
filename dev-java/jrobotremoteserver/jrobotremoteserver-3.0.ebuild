# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/ombre42/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
#	MY_S="${MY_P}"
fi

DESCRIPTION="Serves remote test libraries for Robot Framework that are implemented in Java"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
IUSE="test"
SLOT="0"
JETTY_SLOT="9.4"

CP_DEPEND="
	dev-java/jetty-servlet:${JETTY_SLOT}
	dev-java/jetty-server:${JETTY_SLOT}
	dev-java/jetty-util:${JETTY_SLOT}
	dev-java/jetty-http:${JETTY_SLOT}
	dev-java/commons-lang:3
	dev-java/log4j:0
	dev-java/javalib-core:0
	dev-java/commons-logging:0
	dev-java/xmlrpc:3.1
	java-virtuals/servlet-api:4.0
	dev-java/testng:0
"

inherit java-pkg

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

#S="${WORKDIR}/${MY_S}"