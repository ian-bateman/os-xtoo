# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Java Transaction API"
HOMEPAGE="https://github.com/javaee/jta-spec"
SRC_URI="https://repo1.maven.org/maven2/${PN:0:5}/${PN:6:11}/${MY_PN}/${PV}/${MY_P}-sources.jar"

LICENSE="CDDL GPL-2-with-classpath-exception"
KEYWORDS="~amd64"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="
	dev-java/cdi-api:0
	dev-java/javax-interceptor-api:0
"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"
