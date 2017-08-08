# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/.05.0/_05}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/javaee/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="JavaMail API Reference Implementation"
HOMEPAGE="https://javaee.github.io/javamail/"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

CP_DEPEND="java-virtuals/servlet-api:4.0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}/jhMaster/"

JAVA_SRC_DIR="
	JavaHelp/src
	JSearch/client
	JSearch/indexer
"

java_prepare() {
	# Requires legacy jdic, abandoned -> https://github.com/gelosie/jdic
	rm "JavaHelp/src/new/javax/help/plaf/basic/BasicNativeContentViewerUI.java" \
		|| die "Could not remove class importing legacy files"
}
