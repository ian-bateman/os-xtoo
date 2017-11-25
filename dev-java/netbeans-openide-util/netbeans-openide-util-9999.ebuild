# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

NB_BUNDLE=0

CP_DEPEND="~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

src_compile() {
	java-pkg-simple_src_compile
	JAVA_GENTOO_CLASSPATH_EXTRA="${PN}".jar
	java-netbeans_src_compile
}
