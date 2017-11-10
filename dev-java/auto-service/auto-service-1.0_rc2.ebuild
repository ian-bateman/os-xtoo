# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A configuration/metadata generator for service providers"
HOMEPAGE="https://github.com/google/auto/tree/master/service"
SRC_URI="https://github.com/google/auto/archive/${P/_/-}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/auto-common:0
	dev-java/guava:23"

DEPEND="
	${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/auto-${P/_/-}/service/"

JAVA_SRC_DIR="src/main/java/"
