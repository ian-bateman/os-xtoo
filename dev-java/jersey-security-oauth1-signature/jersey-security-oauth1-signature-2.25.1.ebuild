# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN: 16}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Jersey RESTful Web Services in Java Security OAuth1 Signature"
HOMEPAGE="https://${PN:0:6}.java.net/"
SRC_URI="https://central.maven.org/maven2/org/glassfish/${PN:0:6}/${PN:7:8}/${MY_PN}/${PV}/${MY_P}-sources.jar"
# Missing .internal.LocalizationMessages
#SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="$(get_major_version)"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/glassfish-hk2-api:0
	dev-java/glassfish-hk2-utils:0
	dev-java/javax-inject:0
	dev-java/jax-rs:2
	~dev-java/jersey-core-common-${PV}:${SLOT}"

DEPEND="
	${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

# Used with sources from github
#S="${WORKDIR}/${MY_P}/${PN:7:8}/${MY_PN}"

#JAVA_SRC_DIR="src/main/java"
