# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	~dev-java/netbeans-api-xml-${PV}:${SLOT}
	~dev-java/netbeans-editor-completion-${PV}:${SLOT}
	~dev-java/netbeans-editor-document-${PV}:${SLOT}
	~dev-java/netbeans-editor-indent-${PV}:${SLOT}
	~dev-java/netbeans-editor-lib-${PV}:${SLOT}
	~dev-java/netbeans-lexer-${PV}:${SLOT}
	~dev-java/netbeans-o-n-swing-plaf-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-xml-axi-${PV}:${SLOT}
	~dev-java/netbeans-xml-lexer-${PV}:${SLOT}
	~dev-java/netbeans-xml-retriever-${PV}:${SLOT}
	~dev-java/netbeans-xml-schema-model-${PV}:${SLOT}
	~dev-java/netbeans-xml-text-${PV}:${SLOT}
	~dev-java/netbeans-xml-xam-${PV}:${SLOT}
"
#	~dev-java/netbeans-xml-catalog-${PV}:${SLOT}

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
