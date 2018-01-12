# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}-parent"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN%%-*}/${PN%%-*}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN%%-*}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Java 9 Parser and Abstract Syntax Tree"
HOMEPAGE="https://javaparser.org/"
LICENSE="|| ( Apache-2.0 LGPL-3 )"
SLOT="0"

DEPEND="dev-java/javacc:0
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_SRC_DIR="src/main/java src/main/javacc-support"
JAVAC_ARGS+=" --add-modules java.xml.ws.annotation "

java_prepare() {
	javacc -OUTPUT_DIRECTORY=src/main/java src/main/javacc/java.jj \
		|| die "Failed to generate sources via javacc"
}
