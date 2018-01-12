# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

src_compile() {
	NB_NO_PROC=0
	java-pkg-simple_src_compile
	NB_BUNDLE=0
	NB_NO_PROC=
	JAVAC_ARGS+="--processor-path ${PN}.jar"
	java-netbeans_src_compile
}
