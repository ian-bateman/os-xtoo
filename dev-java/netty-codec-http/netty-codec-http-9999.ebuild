# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN:6}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Netty ${MY_MOD}"
HOMEPAGE="https://${MY_PN}.io/"
LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="
	dev-java/jzlib:0
	~dev-java/netty-buffer-${PV}:${SLOT}
	~dev-java/netty-codec-${PV}:${SLOT}
	~dev-java/netty-common-${PV}:${SLOT}
	~dev-java/netty-handler-${PV}:${SLOT}
	~dev-java/netty-transport-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

JAVA_SRC_DIR="src/main/java"
