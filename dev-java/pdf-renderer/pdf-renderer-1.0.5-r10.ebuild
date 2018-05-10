# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="A PDF renderer and viewer"
HOMEPAGE="https://repo1.maven.org/maven2/org/swinglabs/${PN}/${PV}/"
SRC_URI="${HOMEPAGE}${P}-sources.jar"
LICENSE="LGPL-3"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/unzip
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"
