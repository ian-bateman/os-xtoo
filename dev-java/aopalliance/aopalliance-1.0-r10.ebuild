# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Aspect-Oriented Programming"
HOMEPAGE="http://aopalliance.sourceforge.net/"
SRC_URI="https://repo1.maven.org/maven2/${PN}/${PN}/${PV}/${P}-sources.jar"
LICENSE="public-domain"
KEYWORDS="~amd64"
SLOT="1"

DEPEND="app-arch/unzip
	>=virtual/jdk-9"
