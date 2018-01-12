# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	dev-java/antlr:3
	~dev-java/netbeans-csl-api-${PV}:${SLOT}
	~dev-java/netbeans-csl-types-${PV}:${SLOT}
	~dev-java/netbeans-editor-mimelookup-${PV}:${SLOT}
	~dev-java/netbeans-lexer-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-parsing-api-${PV}:${SLOT}
	~dev-java/netbeans-web-common-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	sed -i -e 's|, decisionCanBacktrack.*|);|g' \
		src/org/netbeans/modules/css/lib/Css3Parser.java \
		|| die "Failed to sed/fix argument length"
	sed -i -e '80d' \
		src/org/netbeans/modules/css/lib/NbParseTreeBuilder.java \
		|| die "Failed to sed/delete non override @Override"
}
