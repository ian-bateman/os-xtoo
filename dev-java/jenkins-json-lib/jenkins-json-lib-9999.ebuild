# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

SLOT="${PV: -1}"

MY_PN="${PN:8}"
MY_PV="${PV:0:3}"
MY_P="${MY_PN}-${MY_PV}-${PN:0:7}-${SLOT}"

HOMEPAGE="https://github.com/${PN:0:7}ci/${PN:8}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
	MY_S="${P}"
else
	SRC_URI="${HOMEPAGE}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Jenkins automation server ${PN:8}"
LICENSE="Apache-2.0"

# dev-java/commons-beanutils:0 <- Very bad slotting pulls in 1.9.2
# dev-java/commons-lang:2 <- Bad slotting should be 2 or 2.6
CP_DEPEND="
	dev-java/xom:0
	dev-java/commons-beanutils:0
	dev-java/commons-collections:0
	dev-java/commons-lang:2
	dev-java/commons-logging:0
	dev-java/ezmorph:0
	dev-java/jakarta-oro:2.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java src/main/jdk15"

java_prepare() {
	# Should build vs remove?
	rm -R "${S}/src/main/java/net/sf/json/groovy" \
		|| die "Could not remove groovy"
	rm -R "${S}/src/main/java/net/sf/json/test" \
		|| die "Could not remove tests"
}
