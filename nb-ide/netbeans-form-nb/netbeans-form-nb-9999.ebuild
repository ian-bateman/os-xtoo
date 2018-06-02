# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	dev-java/javax-annotation:0
	~nb-ide/netbeans-api-java-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-nb-${PV}:${SLOT}
	~nb-ide/netbeans-autoupdate-services-${PV}:${SLOT}
	~nb-ide/netbeans-autoupdate-ui-${PV}:${SLOT}
	~nb-ide/netbeans-classfile-${PV}:${SLOT}
	~nb-ide/netbeans-core-multiview-${PV}:${SLOT}
	~nb-ide/netbeans-editor-fold-${PV}:${SLOT}
	~nb-ide/netbeans-editor-guards-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib2-${PV}:${SLOT}
	~nb-ide/netbeans-java-project-${PV}:${SLOT}
	~nb-ide/netbeans-java-project-ui-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-form-${PV}:${SLOT}
	~nb-ide/netbeans-openide-actions-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-explorer-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-text-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
	~nb-ide/netbeans-options-api-${PV}:${SLOT}
	~nb-ide/netbeans-project-libraries-${PV}:${SLOT}
	~nb-ide/netbeans-project-libraries-ui-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-base-${PV}:${SLOT}
	~nb-ide/netbeans-queries-${PV}:${SLOT}
	~nb-ide/netbeans-spi-palette-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
