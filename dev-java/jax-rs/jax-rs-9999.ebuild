# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PV="${PV/_pre/-m}"
MY_P="${PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/api"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="api-${MY_PV}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Reference implementation of the Java API for RESTful Services"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2 )"
if [[ ${PV} == 2.1* ]]; then
	SLOT="2.1"
else
	SLOT="2"
fi

DEPEND=">=virtual/jdk-1.9"

RDEPEND=">=virtual/jre-1.9"

S="${WORKDIR}/${MY_S}/${PN/-/}-api"
