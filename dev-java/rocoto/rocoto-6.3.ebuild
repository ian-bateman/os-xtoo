# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

JAVA_PKG_USE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Rocoto is a small collection of reusable Modules for Google Guice"
SLOT="$(get_version_component_range 1)"
SRC_URI="https://github.com/99soft/${PN}/archive/${P}.zip"
HOMEPAGE="http://99soft.github.io/rocoto/"
KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
IUSE=""

CDEPEND="dev-java/guava:18
	dev-java/guice:4
	dev-java/javax-inject:0"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.7"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.7"

S="${WORKDIR}/${PN}-${P}"

JAVA_GENTOO_CLASSPATH="
	guava-18
	guice-4
	javax-inject
"
JAVA_SRC_DIR="src/main/java"

java_prepare() {
	java-pkg_clean
}
