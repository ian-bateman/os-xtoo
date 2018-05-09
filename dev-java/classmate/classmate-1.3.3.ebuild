# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Zero-dependency library for introspecting type information"

MY_PN="java-${PN}"

SLOT="0"
SRC_URI="https://github.com/FasterXML/${MY_PN}/archive/${P}.tar.gz"
HOMEPAGE="https://fasterxml.com"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="
	${CP_DEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${MY_PN}-${P}/"

JAVA_SRC_DIR="src/main/java"
