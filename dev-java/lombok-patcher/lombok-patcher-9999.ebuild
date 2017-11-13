# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

LOM_PN="${PN%%-*}"
LOM_PV="1.16.16"
LOM_P="${LOM_PN}-${LOM_PV}"

MY_PN="${PN/-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/rzwitserloot/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	# Nasty binary jar needed :(
	# https://github.com/rzwitserloot/lombok/issues/1391
	# https://github.com/rzwitserloot/lombok.patcher/issues/2
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		http://repo1.maven.org/maven2/org/project${LOM_PN}/${LOM_PN}/${LOM_PV}/${LOM_P}.jar
	"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Framework for easily patching JVM programs"
HOMEPAGE="https://projectlombok.org/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/asm:6
	dev-java/jna:4
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/src"

JAVA_SRC_DIR="injector patcher"
# Remove when circular deps resolved...
JAVA_GENTOO_CLASSPATH_EXTRA="${DISTDIR}/${LOM_P}.jar"
