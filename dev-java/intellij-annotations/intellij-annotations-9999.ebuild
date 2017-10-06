# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="intellij-community-idea"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/JetBrains/intellij-community"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	# May switch to maven to avoid 400MB+ tarball....
	SRC_URI="${BASE_URI}/archive/idea/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Intellij Community Idea Annotations"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/platform/${PN#*-}"

JAVA_SRC_DIR="common/src java8/src"
