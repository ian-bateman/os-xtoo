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

SLOT="0"

CP_DEPEND="
	dev-java/jnr-constants:0
	dev-java/jnr-enxio:0
	dev-java/jnr-ffi:2
	dev-java/jnr-posix:3
"

inherit java-pkg

DESCRIPTION="UNIX domain sockets (AF_UNIX) for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"
