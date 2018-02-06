# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="mongo-java-driver"
MY_P="${MY_PN}-r${PV}"

BASE_URI="https://github.com/mongodb/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}/${PN}"
else
	SRC_URI="${BASE_URI}/archive/r${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}/${PN}/"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="MongoDB Binary JSON"

SLOT="$(get_major_version)"
HOMEPAGE="https://mongodb.github.io/$(get_version_component_range 1-2)/${MY_PN}/"
LICENSE="Apache-2.0"

CP_DEPEND="dev-java/slf4j-api:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/"

JAVA_SRC_DIR="src/main/"
