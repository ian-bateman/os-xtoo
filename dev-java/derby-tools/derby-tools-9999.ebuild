# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Relational database implemented entirely in Java - ${PN:6}"
HOMEPAGE="https://db.apache.org/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	~dev-java/derby-engine-${PV}:${SLOT}
	~dev-java/derby-shared-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	dev-java/javacc:0
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}/java/${PN:6}"

# Needed to build, but do not include or compile
# Not ideal, but do not want to include in this package
JAVA_CLASSPATH_EXTRA="${S}/../drda/"

java_prepare() {
	cd "${S}/org/apache/derby/impl/tools/ij/" || die
	local jjs
	jjs=( mtGrammar ij )
	for jj in ${jjs[@]}; do
		javacc "${jj}.jj" || die "javacc ${jj}.jj failed"
	done
}
