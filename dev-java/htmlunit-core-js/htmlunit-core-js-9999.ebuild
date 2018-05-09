# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:9}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/HtmlUnit/${PN}"

if [[ ${PV} != *9999* ]]; then
#	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	SRC_URI="https://repo1.maven.org/maven2/net/sourceforge/${PN:0:8}/${PN}/${PV}/${P}-sources.jar"
	KEYWORDS="~amd64"
#	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

#DESCRIPTION="Tests and packaging for htmlunit-rhino-fork"
DESCRIPTION="HtmlUnit adaptation of Mozilla Rhino Javascript engine for Java."
HOMEPAGE="${BASE_URI}"
LICENSE="MPL-2.0"
SLOT="0"

#CP_DEPEND="
#	dev-java/junit:4
#	dev-java/htmlunit-rhino-fork:0
#"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

#S="${WORKDIR}/${MY_S}"

#JAVA_SRC_DIR="src"
