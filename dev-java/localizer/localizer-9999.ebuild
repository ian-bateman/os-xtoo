# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}-parent"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/kohsuke/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}/lib"
fi

inherit java-pkg

DESCRIPTION="Type-safe localization message access for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"
