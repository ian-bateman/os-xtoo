# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN}-jdk15on"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="https://www.bouncycastle.org/java.html"
SRC_URI="https://repo1.maven.org/maven2/org/bouncycastle/${MY_PN}/${PV}/${MY_P}-sources.jar"
KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="dev-java/bcprov:${SLOT}"

DEPEND="${CP_DEPEND}
	app-arch/unzip
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

JAVA_ENCODING="ISO-8859-1"
JAVA_SRC_DIR="org"
