# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-pkg

DESCRIPTION="A lexical analyzer generator for Java"
HOMEPAGE="https://www.cs.princeton.edu/~appel/modern/java/JLex/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
KEYWORDS="~amd64"
LICENSE="jlex"
SLOT="0"

S="${WORKDIR}/${P}"

java_prepare() {
	mkdir -p src/main/java/JLex || die "Failed to make source dir"
	mv Main.java src/main/java/JLex || die "Failed to move Main.java"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher "${PN}" --main JLex.Main "${PN}.jar"
}
