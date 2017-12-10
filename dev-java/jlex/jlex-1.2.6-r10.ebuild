# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A lexical analyzer generator for Java"
HOMEPAGE="https://www.cs.princeton.edu/~appel/modern/java/JLex/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
KEYWORDS="~amd64"
LICENSE="jlex"
SLOT="0"

RDEPEND=">=virtual/jre-9"
DEPEND=">=virtual/jdk-9"

S="${WORKDIR}/${P}"

java_prepare() {
	mkdir -p src/main/java/JLex || die "Failed to make source dir"
	mv Main.java src/main/java/JLex || die "Failed to move Main.java"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher "${PN}" --main JLex.Main "${PN}.jar"
}
