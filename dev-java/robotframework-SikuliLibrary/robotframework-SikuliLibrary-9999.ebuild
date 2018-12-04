# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_4,3_5,3_6} )
JAVA_PKG_IUSE="source examples"

inherit distutils-r1

DESCRIPTION="UI testing library for Robot Framework"
HOMEPAGE="https://github.com/rainmanwy/robotframework-SikuliLibrary
	https://pypi.org/project/robotframework-SikuliLibrary/"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/rainmanwy/robotframework-SikuliLibrary"
	EGIT_BRANCH="master"
	# this commit is supposed to be 1.1.4-snapshot
	EGIT_COMMIT="b29685fded0cae234cd96e135abe5df5398e0cd2"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/rainmanwy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc"

CP_DEPEND="
        dev-java/javalib-core:0
	dev-java/sikulixapi-bin:0
	dev-java/jrobotremoteserver-bin:0
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
		|| die "sed pom.xml failed!"

	sed -i -e "s|DEV|1.1.4|" "${S}"/src/python/version.py \
		|| die "sed version.py failed!"

	eapply "${FILESDIR}/${PN}-add-javalibcore-to-pom_xml.patch"

	java-pkg_src_prepare
	distutils-r1_python_prepare_all
}

src_compile() {
	JAVA_SRC_DIR="src/java"
	JAVA_JAR_FILENAME=SikuliLibrary.jar
	java-pkg-simple_src_compile

	# need to move things around...
	lib_path="${S}/target/src/SikuliLibrary/lib/"
	mkdir -p ${lib_path}
	mv "${S}"/SikuliLibrary.jar ${lib_path}
	cp src/python/*.py "${S}"/target/src/SikuliLibrary/

	python_setup
	distutils-r1_src_compile
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	local DOCS=( README.md )
	use doc && local HTML_DOCS=( docs/. )

	python_export EPYTHON
	distutils-r1_python_install_all
}

src_install() {
	python_install
	python_install_all

	use examples && java-pkg_doexamples demo
	use source && java-pkg_dosrc src/java/
}
