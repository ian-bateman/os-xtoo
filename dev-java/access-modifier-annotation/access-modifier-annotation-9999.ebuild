# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:15}"
MY_P="${MY_PN}-${PV}"

HOMEPAGE="https://github.com/kohsuke/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
	MY_S="${P}/${PN}"
else
	SRC_URI="${HOMEPAGE}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}/${PN}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Enforce access restrictions to deprecated code"
LICENSE="MIT"
SLOT="0"

CP_DEPEND="
	dev-java/annotation-indexer:0
	dev-java/asm:6
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"
