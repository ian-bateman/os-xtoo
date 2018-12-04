# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

MY_PN="jrobotremoteserver"
MY_JAR="${MY_PN}-${PV}-standalone"
BASE_URI="https://github.com/ombre42/${MY_PN}/"

inherit java-pkg

DESCRIPTION="Serves remote test libraries for Robot Framework that are implemented in Java."
HOMEPAGE="https://github.com/ombre42/jrobotremoteserver/wiki"

SRC_URI="${BASE_URI}/releases/download/${MY_PN}-standalone-${PV}/${MY_JAR}.jar"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="app-arch/unzip:0"

RDEPEND="
	>=dev-python/robotframework-2.6.0
	|| (
		dev-java/openjdk-bin:12
		dev-java/icedtea[gtk,-nsplugin,-sunec,-webstart,-pulseaudio] )
"

S="${WORKDIR}/"

JAVA_PKG_NO_CLEAN=0

src_unpack() {
	:
}

src_compile() {
	:
}

src_install() {
	cp ${DISTDIR}/${MY_JAR}.jar ${S}
	java-pkg_dojar ${MY_JAR}.jar
}
