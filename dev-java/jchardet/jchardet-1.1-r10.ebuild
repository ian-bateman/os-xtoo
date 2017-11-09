# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Port of Mozilla's Automatic Charset Detection algorithm"
HOMEPAGE="https://jchardet.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}.zip"
LICENSE="MPL-1.1"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/unzip
	>=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src"
