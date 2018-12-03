# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_4,3_5,3_6} )
JAVA_PKG_IUSE=""

inherit distutils-r1

DESCRIPTION="UI testing library for Robot Framework"
HOMEPAGE="https://github.com/rainmanwy/robotframework-SikuliLibrary
	https://pypi.org/project/robotframework-SikuliLibrary/"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/rainmanwy/robotframework-SikuliLibrary"
	EGIT_BRANCH="master"
	EGIT_COMMIT="b29685fded0cae234cd96e135abe5df5398e0cd2"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/rainmanwy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CP_DEPEND="
        dev-java/javalib:0
"

inherit java-pkg

DEPEND="${CP_DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="${CP_DEPEND}
	>=dev-python/robotframework-2.6.0[${PYTHON_USEDEP}]
	media-libs/libcanberra[gtk,-gtk3]
	dev-db/postgresql[server,-tcl]
	|| (
		dev-java/openjdk-bin:12
		dev-java/icedtea[gtk,-nsplugin,-sunec,-webstart,-pulseaudio] )
	media-gfx/imagemagick
	media-libs/opencv:0/2.4[jpeg,jpeg2k,png]
	media-libs/libpng
	x11-misc/wmctrl
	x11-misc/xdotool
	x11-misc/xvfb-run
	virtual/jpeg
"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/java/"

src_prepare() {
	sed -i '0,/1.1.2/{s/1.1.2/1.1.4-SNAPSHOT/}' "${S}"/pom.xml \
		|| die "sed failed!"

	eapply "${FILESDIR}/${PN}-add-javalibcore-to-pom_xml.patch"

	java-pkg_src_prepare
	distutils-r1_python_prepare_all
}

src_compile() {
	#elog $(java-pkg_getjars javalib)
	JAVA_CLASSPATH="javalib"
	JAVA_SRC_DIR="src/java"
	java-pkg_jar-from --into src/java/com/github/rainmanwy/robotframework/sikulilib javalib
	java-pkg-simple_src_compile

	default
}

python_install_all() {
	local DOCS=( README.md )
	use doc && local HTML_DOCS=( docs/. )

	distutils-r1_python_install_all
}
