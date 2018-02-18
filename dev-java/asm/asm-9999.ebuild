# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

if [[ ${PV} == 9999 ]]; then
	ECLASS="subversion"
	ESVN_REPO_URI="svn://svn.forge.ow2.org/svnroot/asm"
else
	SRC_URI="http://download.forge.ow2.org/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Java bytecode manipulation framework"
HOMEPAGE="http://forge.ow2.org/projects/asm/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/aqute-jpm-clnt:0
	dev-java/bndlib:4
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"
