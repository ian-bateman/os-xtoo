# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from tree
# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-pkg

DESCRIPTION="Java Dependency checker"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Java"
LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="
	dev-java/asm:6
	dev-java/commons-cli:1
"
RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

src_unpack() {
	cp "${FILESDIR}/Main-${PV}.java" Main.java || die
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher ${PN} --main javadepchecker.Main
}
