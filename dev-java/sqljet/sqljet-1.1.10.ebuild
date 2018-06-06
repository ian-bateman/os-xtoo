# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="dev-java/antlr:3"

inherit java-pkg

DESCRIPTION="SQLJet pure Java implementation of SQLite."
SRC_URI="https://${PN}.com/files/${P}-src.zip"
HOMEPAGE="https://${PN}.com/"
KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/${P}/${PN}"
