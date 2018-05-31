# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN:0:3}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/jnr-constants:0
	dev-java/jnr-ffi:2
"

inherit java-pkg

DESCRIPTION="Lightweight cross-platform POSIX emulation layer for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2 LGPL-2.1 )"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
