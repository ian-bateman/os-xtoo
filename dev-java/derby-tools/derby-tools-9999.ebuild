# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/derby-engine-${PV}:${SLOT}
	~dev-java/derby-shared-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Relational database implemented entirely in Java - ${PN:6}"
HOMEPAGE="https://db.apache.org/${PN}/"
LICENSE="Apache-2.0"

DEPEND+=" dev-java/javacc:0"

S="${WORKDIR}/${MY_P}/java/${PN##*-}"

# https://issues.apache.org/jira/browse/DERBY-5125
PATCHES=( "${FILESDIR}/javacc6.diff" )

# Needed to build, but do not include or compile
# Not ideal, but do not want to include in this package
JAVA_CLASSPATH_EXTRA="${S}/../drda/"

java_prepare() {
	local jj jjs

	cd "${S}/org/apache/derby/impl/tools/ij/" || die
	jjs=( mtGrammar ij )
	for jj in ${jjs[@]}; do
		javacc "${jj}.jj" || die "javacc ${jj}.jj failed"
	done

	rm UCode_CharStream.java \
		|| die "Failed to remove generated UCode_CharStream.java"
}
