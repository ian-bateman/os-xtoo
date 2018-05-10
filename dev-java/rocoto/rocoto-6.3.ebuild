# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Rocoto is a small collection of reusable Modules for Google Guice"
SLOT="${PV%%.*}"
SRC_URI="https://github.com/99soft/${PN}/archive/${P}.tar.gz"
HOMEPAGE="https://99soft.github.io/rocoto/"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"

CP_DEPEND="dev-java/guava:24
	dev-java/guice:4
	dev-java/javax-inject:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${PN}-${P}"

JAVA_SRC_DIR="src/main/java"
