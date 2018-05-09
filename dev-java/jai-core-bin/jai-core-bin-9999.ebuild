# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN%-*}"
MY_P="${MY_PN}-${PV}"
JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/Obsidian-StudiosInc/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Java Advanced Imaging library"
HOMEPAGE="${BASE_URI}"
LICENSE="sun-bcla-jai"
SLOT="0"

DEPEND="app-arch/unzip
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_P}"

JAVA_CLASSPATH_EXTRA="src/share/mediaLib/mlibwrapper_jai.jar"
JAVA_PKG_NO_CLEAN=0
JAVA_SRC_DIR="src/share/classes"
JAVAC_ARGS+=" --add-exports=java.base/sun.security.action=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=java.desktop/java.awt.peer=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=java.desktop/sun.awt.image=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=java.desktop/com.sun.imageio.plugins.jpeg=ALL-UNNAMED "

src_install() {
	java-pkg-simple_src_install
	java-pkg_dojar src/share/mediaLib/mlibwrapper_jai.jar
	use amd64 && java-pkg_doso src/share/mediaLib/linux/amd64/*.so
}
