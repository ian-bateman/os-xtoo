# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
	~dev-java/netbeans-api-java-classpath-${PV}:${SLOT}
	~dev-java/netbeans-core-multiview-${PV}:${SLOT}
	~dev-java/netbeans-csl-api-${PV}:${SLOT}
	~dev-java/netbeans-csl-types-${PV}:${SLOT}
	~dev-java/netbeans-css-lib-${PV}:${SLOT}
	~dev-java/netbeans-css-model-${PV}:${SLOT}
	~dev-java/netbeans-editor-${PV}:${SLOT}
	~dev-java/netbeans-editor-bracesmatching-${PV}:${SLOT}
	~dev-java/netbeans-editor-codetemplates-${PV}:${SLOT}
	~dev-java/netbeans-editor-completion-${PV}:${SLOT}
	~dev-java/netbeans-editor-document-${PV}:${SLOT}
	~dev-java/netbeans-editor-errorstripe-${PV}:${SLOT}
	~dev-java/netbeans-editor-errorstripe-api-${PV}:${SLOT}
	~dev-java/netbeans-editor-fold-${PV}:${SLOT}
	~dev-java/netbeans-editor-indent-${PV}:${SLOT}
	~dev-java/netbeans-editor-lib-${PV}:${SLOT}
	~dev-java/netbeans-editor-lib2-${PV}:${SLOT}
	~dev-java/netbeans-editor-mimelookup-${PV}:${SLOT}
	~dev-java/netbeans-editor-util-${PV}:${SLOT}
	~dev-java/netbeans-lexer-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-dialogs-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-loaders-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-text-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-windows-${PV}:${SLOT}
	~dev-java/netbeans-parsing-api-${PV}:${SLOT}
	~dev-java/netbeans-parsing-indexing-${PV}:${SLOT}
	~dev-java/netbeans-projectapi-${PV}:${SLOT}
	~dev-java/netbeans-refactoring-api-${PV}:${SLOT}
	~dev-java/netbeans-spi-navigator-${PV}:${SLOT}
	~dev-java/netbeans-web-common-${PV}:${SLOT}
	~dev-java/netbeans-web-common-ui-${PV}:${SLOT}
	~dev-java/netbeans-web-indent-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
