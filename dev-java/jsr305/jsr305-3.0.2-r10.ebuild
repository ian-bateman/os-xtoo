# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Annotations for Software Defect Detection"
HOMEPAGE="https://jcp.org/en/jsr/detail?id=305"
SRC_URI="https://repo1.maven.org/maven2/com/google/code/findbugs/${PN}/${PV}/${P}-sources.jar"
LICENSE="BSD"
KEYWORDS="~amd64"
SLOT="0"

DEPEND+=" app-arch/unzip"
