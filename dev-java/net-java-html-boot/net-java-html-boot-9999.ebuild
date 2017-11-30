# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="incubator-netbeans-html4j"
MY_PV="release-${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

HOMEPAGE="${BASE_URI}"
DESCRIPTION="Builder to launch your Java/HTML based application"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/asm:6
	~dev-java/net-java-html-${PV}:${SLOT}
	dev-java/netbeans-openide-util-lookup:9
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN#*-*-*-}"
