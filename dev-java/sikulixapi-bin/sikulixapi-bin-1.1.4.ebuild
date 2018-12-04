# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

MY_PN="SikuliX1"
MY_JAR="sikulixapi"
BASE_URI="https://raiman.github.io/${MY_PN}/"

inherit java-pkg

DESCRIPTION="Automate what you see on a computer monitor"
HOMEPAGE="https://github.com/rainmanwy/SikuliX1"

SRC_URI="${BASE_URI}/${MY_JAR}.jar"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="app-arch/unzip:0"

RDEPEND="
	>=dev-python/robotframework-2.6.0
	media-libs/libcanberra[gtk,-gtk3]
	dev-db/postgresql[server,-tcl]
	|| (
		dev-java/openjdk-bin:12
		dev-java/icedtea[gtk,-nsplugin,-sunec,-webstart,-pulseaudio] )
	media-gfx/imagemagick
	media-libs/opencv:0/2.4[jpeg,jpeg2k,png]
	app-text/tesseract[jpeg,png,osd]
	media-libs/libpng
	x11-misc/wmctrl
	x11-misc/xdotool
	x11-misc/xvfb-run
	virtual/jpeg
"

S="${WORKDIR}/"

JAVA_PKG_NO_CLEAN=1

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
