# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="JCTools"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}/${PN}"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}/${PN}/"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Java Concurrency Tools"
HOMEPAGE="https://jctools.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

if [[ "$(get_major_version)" == "1" ]]; then
	SLOT="0"
else
	SLOT="2"
fi

RDEPEND=">=virtual/jre-9"
DEPEND=">=virtual/jdk-9"

S="${WORKDIR}/${MY_S}/"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
