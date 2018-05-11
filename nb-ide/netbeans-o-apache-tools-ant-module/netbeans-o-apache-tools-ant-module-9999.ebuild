# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	dev-java/ant-core:0
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-nb-${PV}:${SLOT}
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-xml-${PV}:${SLOT}
	~nb-ide/netbeans-api-xml-ui-${PV}:${SLOT}
	~nb-ide/netbeans-core-multiview-${PV}:${SLOT}
	~nb-ide/netbeans-openide-actions-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-execution-${PV}:${SLOT}
	~nb-ide/netbeans-openide-explorer-${PV}:${SLOT}
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
	~nb-ide/netbeans-options-java-${PV}:${SLOT}
	~nb-ide/netbeans-project-indexingbridge-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-base-${PV}:${SLOT}
	~nb-ide/netbeans-queries-${PV}:${SLOT}
	~nb-ide/netbeans-spi-navigator-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

src_prepare() {
	mv src-bridge/org/apache/tools/ant/module/bridge/impl \
		src/org/apache/tools/ant/module/bridge \
		|| die "Failed to move additional sources"

	java-netbeans_src_prepare
}
