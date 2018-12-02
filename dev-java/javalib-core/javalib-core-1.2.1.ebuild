# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="JavalibCore"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/robotframework/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Base for implementing Java test libraries to be used with Robot Framework"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
IUSE="test"
SLOT="0"

CP_DEPEND="
	dev-java/paranamer:0
	dev-java/commons-collections:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9
	test? (
		dev-java/junit:4
		dev-java/jmock:0
	)
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"
