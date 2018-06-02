# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

#SRC_URI+="
#	http://hg.netbeans.org/releases/raw-file/tip/css.lib/src/org/netbeans/modules/css/lib/Css3.g -> ${MY_P}-Css3.g
#"

CP_DEPEND="
	dev-java/antlr:3
	dev-java/javax-annotation:0
	~nb-ide/netbeans-csl-api-${PV}:${SLOT}
	~nb-ide/netbeans-csl-types-${PV}:${SLOT}
	~nb-ide/netbeans-editor-mimelookup-${PV}:${SLOT}
	~nb-ide/netbeans-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-api-${PV}:${SLOT}
	~nb-ide/netbeans-web-common-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
#	cp "${DISTDIR}/${MY_P}-Css3.g" \
#		resources/org/netbeans/modules/css/lib/Css3.g \
#		|| die "Failed to copy missing Css3.g grammar file"

	sed -i -e 's|, decisionCanBacktrack.*|);|g' \
		src/org/netbeans/modules/css/lib/Css3Parser.java \
		|| die "Failed to sed/fix argument length"
	sed -i -e '80d' \
		src/org/netbeans/modules/css/lib/NbParseTreeBuilder.java \
		|| die "Failed to sed/delete non override @Override"
}
