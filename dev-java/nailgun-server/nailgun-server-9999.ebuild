# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}-all"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/facebook/${PN%-*}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN%-*}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Server for running Java programs from the cli without the JVM startup"
HOMEPAGE="https://martiansoftware.com/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="dev-java/jna:4"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_RM_FILES=( ServerSocket.java Socket.java Library.java )
JAVA_RM_FILES=(
	${JAVA_RM_FILES[@]/#/src/main/java/com/martiansoftware/nailgun/NGWin32NamedPipe}
)

java_prepare() {
	sed -i -e "417,420d;422d" \
		src/main/java/com/martiansoftware/nailgun/NGServer.java \
		|| die "Failed to remove windows conditional"
}
