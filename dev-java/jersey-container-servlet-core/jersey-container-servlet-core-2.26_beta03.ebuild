# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN:0:6}"
MY_PV="${PV/_beta/-b}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Jersey RESTful Web Services in Java Core Servlet"
HOMEPAGE="https://${MY_PN}.java.net/"
SRC_URI="https://repo1.maven.org/maven2/org/glassfish/${MY_PN}/containers/${PN}/${MY_PV}/${PN}-${MY_PV}-sources.jar"
# Missing org.glassfish.jersey.servlet.internal.LocalizationMessages
#SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="$(get_major_version)"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/eclipse-javax-persistence:2
	dev-java/glassfish-hk2-api:0
	dev-java/glassfish-hk2-utils:0
	dev-java/javax-inject:0
	dev-java/jax-rs:2.1
	~dev-java/jersey-core-common-${PV}:${SLOT}
	~dev-java/jersey-core-server-${PV}:${SLOT}
	~dev-java/jersey-guava-${PV}:${SLOT}
	java-virtuals/servlet-api:4.0"

DEPEND="
	${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

# Used with sources from github
#S="${WORKDIR}/${MY_P}/containers/${MY_PN}${PN: -8}${PN:6:5}"

#JAVA_SRC_DIR="src/main/java"
