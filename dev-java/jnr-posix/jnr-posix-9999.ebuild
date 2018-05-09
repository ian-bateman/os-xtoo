# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN:0:3}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Lightweight cross-platform POSIX emulation layer for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2 LGPL-2.1 )"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/jnr-constants:0
	dev-java/jnr-ffi:2
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
