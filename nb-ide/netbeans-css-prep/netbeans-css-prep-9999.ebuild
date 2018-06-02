# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	dev-java/javax-annotation:0
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-templates-${PV}:${SLOT}
	~nb-ide/netbeans-core-multiview-${PV}:${SLOT}
	~nb-ide/netbeans-csl-api-${PV}:${SLOT}
	~nb-ide/netbeans-csl-types-${PV}:${SLOT}
	~nb-ide/netbeans-css-editor-${PV}:${SLOT}
	~nb-ide/netbeans-css-lib-${PV}:${SLOT}
	~nb-ide/netbeans-css-model-${PV}:${SLOT}
	~nb-ide/netbeans-editor-${PV}:${SLOT}
	~nb-ide/netbeans-editor-codetemplates-${PV}:${SLOT}
	~nb-ide/netbeans-editor-completion-${PV}:${SLOT}
	~nb-ide/netbeans-editor-document-${PV}:${SLOT}
	~nb-ide/netbeans-editor-errorstripe-${PV}:${SLOT}
	~nb-ide/netbeans-editor-errorstripe-api-${PV}:${SLOT}
	~nb-ide/netbeans-editor-fold-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib2-${PV}:${SLOT}
	~nb-ide/netbeans-editor-mimelookup-${PV}:${SLOT}
	~nb-ide/netbeans-extexecution-${PV}:${SLOT}
	~nb-ide/netbeans-extexecution-base-${PV}:${SLOT}
	~nb-ide/netbeans-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-o-n-swing-plaf-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-nb-${PV}:${SLOT}
	~nb-ide/netbeans-openide-io-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-text-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
	~nb-ide/netbeans-options-api-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-api-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-indexing-${PV}:${SLOT}
	~nb-ide/netbeans-project-ant-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-base-${PV}:${SLOT}
	~nb-ide/netbeans-refactoring-api-${PV}:${SLOT}
	~nb-ide/netbeans-spi-navigator-${PV}:${SLOT}
	~nb-ide/netbeans-web-common-${PV}:${SLOT}
	~nb-ide/netbeans-web-common-ui-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
