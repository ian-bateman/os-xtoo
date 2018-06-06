# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source examples"

inherit java-pkg

DESCRIPTION="A small, extremely fast XML parser"
HOMEPAGE="https://sourceforge.net/projects/piccolo/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=" app-arch/unzip"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/com"
