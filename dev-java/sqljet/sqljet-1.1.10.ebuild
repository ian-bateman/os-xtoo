# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="SQLJet pure Java implementation of SQLite."
SLOT="0"
SRC_URI="https://${PN}.com/files/${P}-src.zip"
HOMEPAGE="https://${PN}.com/"
KEYWORDS="~amd64"
LICENSE="GPL-2"

CP_DEPEND="dev-java/antlr:3"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="${PN}/src/main/java"
