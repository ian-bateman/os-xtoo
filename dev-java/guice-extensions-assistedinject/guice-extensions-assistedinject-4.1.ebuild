# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="guice"

DESCRIPTION="Guice extensions assisted inject"
HOMEPAGE="https://github.com/google/${MY_PN}/"
SRC_URI="https://github.com/google/${MY_PN}/archive/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="$(get_major_version)"
KEYWORDS="~amd64"

CP_DEPEND="
	dev-java/guava:23
	dev-java/guice:${SLOT}
	dev-java/javax-inject:0
"

RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"

DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}/extensions/assistedinject"

JAVA_SRC_DIR="src/"
