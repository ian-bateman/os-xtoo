# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="LZMA library for Java EOL"

SRC_URI="https://github.com/jponge/${PN}/archive/${P}.tar.gz"
HOMEPAGE="https://jponge.github.io/${PN}/"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${PN}-${P}/"

JAVA_SRC_DIR="src/main/java"
