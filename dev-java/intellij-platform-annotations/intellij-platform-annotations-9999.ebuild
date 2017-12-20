# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}-community"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
BASE_URI="https://github.com/JetBrains/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
# Using maven sources to prevent large download for just annotations
#	SRC_URI="${BASE_URI}/archive/%{PV}.tar.gz -> ${MY_P}.tar.gz"
	SRC_URI="http://repo1.maven.org/maven2/com/${PN%%-*}/${PN##*-}/${PV}/${PN##*-}-${PV}-sources.jar -> ${P}.jar"
	KEYWORDS="~amd64"
#	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Annotations for code inspection support and code documentation."
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND="app-arch/unzip
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

#S="${WORKDIR}/${MY_S}/${MY_MOD/-//}"
