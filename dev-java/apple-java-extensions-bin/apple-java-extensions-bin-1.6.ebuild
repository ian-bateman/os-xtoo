# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="AppleJavaExtensions"
BASE_URI="https://developer.apple.com/legacy/library/samplecode/${MY_PN}/"

inherit java-pkg-2

DESCRIPTION="EOL Stub classes representing Apple eAWT and eIO APIs for OS X"
HOMEPAGE="${BASE_URI}/Introduction/Intro.html"
SRC_URI="${BASE_URI}/${MY_PN}.zip -> ${P}.zip"
LICENSE="Apple"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_PN}"

JAVA_PKG_NO_CLEAN=0

src_install() {
	java-pkg_dojar ${MY_PN}.jar
}

