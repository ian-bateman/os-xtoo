# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Glassfish JSR196 implementation"
HOMEPAGE="https://www.jcp.org/en/jsr/detail?id=196"
SRC_URI="https://repo1.maven.org/maven2/org/glassfish/${MY_PN}/${PV}/${MY_P}-sources.jar"

LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/unzip:0
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

java_prepare() {
	# Remove or ends up in the jar
	rm pom.xml || die
}
