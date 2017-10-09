# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

HOMEPAGE="https://github.com/${PN/j/z}/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Pure Java implementation of libzmq"
LICENSE="MPL-2.0"
SLOT="0"

if [[ "${PV}" != 0.3.6 ]]; then
	CP_DEPEND="dev-java/jnacl:0"
fi

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${P}"
