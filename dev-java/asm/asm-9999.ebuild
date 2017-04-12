# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="forge.ow2.org"

if [[ ${PV} == 9999 ]]; then
	ECLASS="subversion"
	ESVN_REPO_URI="svn://svn.${BASE_URI}/svnroot/asm"
else
	SRC_URI="http://download.${BASE_URI}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Java bytecode manipulation framework"
HOMEPAGE="http://${BASE_URI}/projects/asm/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src"
