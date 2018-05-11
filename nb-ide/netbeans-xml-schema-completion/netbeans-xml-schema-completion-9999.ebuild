# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	~nb-ide/netbeans-api-xml-${PV}:${SLOT}
	~nb-ide/netbeans-editor-completion-${PV}:${SLOT}
	~nb-ide/netbeans-editor-document-${PV}:${SLOT}
	~nb-ide/netbeans-editor-indent-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib-${PV}:${SLOT}
	~nb-ide/netbeans-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-o-n-swing-plaf-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-xml-axi-${PV}:${SLOT}
	~nb-ide/netbeans-xml-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-xml-retriever-${PV}:${SLOT}
	~nb-ide/netbeans-xml-schema-model-${PV}:${SLOT}
	~nb-ide/netbeans-xml-text-${PV}:${SLOT}
	~nb-ide/netbeans-xml-xam-${PV}:${SLOT}
"
#	~nb-ide/netbeans-xml-catalog-${PV}:${SLOT}

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
