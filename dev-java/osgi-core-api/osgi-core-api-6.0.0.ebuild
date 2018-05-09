# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="OSGi Service Platform Core API (Companion Code)"
HOMEPAGE="https://www.osgi.org/Specifications/HomePage"
SRC_URI="https://www.osgi.org/download/r${PV%%.*}/osgi.core-${PV}.jar"

LICENSE="Apache-2.0"
SLOT="6"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/osgi-annotation:0"

DEPEND="app-arch/unzip:0
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVA_SRC_DIR="OSGI-OPT/src"

java_prepare() {
	rm -r org || die
}
