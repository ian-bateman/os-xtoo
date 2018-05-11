# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	~nb-ide/netbeans-api-debugger-${PV}:${SLOT}
	~nb-ide/netbeans-api-debugger-jpda-${PV}:${SLOT}
	~nb-ide/netbeans-api-io-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-nb-${PV}:${SLOT}
	~nb-ide/netbeans-debugger-jpda-${PV}:${SLOT}
	~nb-ide/netbeans-editor-${PV}:${SLOT}
	~nb-ide/netbeans-editor-completion-${PV}:${SLOT}
	~nb-ide/netbeans-editor-document-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib2-${PV}:${SLOT}
	~nb-ide/netbeans-editor-mimelookup-${PV}:${SLOT}
	~nb-ide/netbeans-java-preprocessorbridge-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-explorer-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-nb-${PV}:${SLOT}
	~nb-ide/netbeans-openide-io-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-text-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
	~nb-ide/netbeans-options-api-${PV}:${SLOT}
	~nb-ide/netbeans-options-java-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-spi-debugger-jpda-ui-${PV}:${SLOT}
	~nb-ide/netbeans-spi-debugger-ui-${PV}:${SLOT}
	~nb-ide/netbeans-spi-viewmodel-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
