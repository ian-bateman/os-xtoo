# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Port of Mozilla's Automatic Charset Detection algorithm"
HOMEPAGE="https://jchardet.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}.zip"
LICENSE="MPL-1.1"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/unzip
	>=virtual/jdk-9"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src"
