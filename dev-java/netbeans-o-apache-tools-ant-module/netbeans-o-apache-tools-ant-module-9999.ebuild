# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	dev-java/ant-core:0
	~dev-java/netbeans-api-progress-${PV}:${SLOT}
	~dev-java/netbeans-api-progress-nb-${PV}:${SLOT}
	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
	~dev-java/netbeans-api-xml-${PV}:${SLOT}
	~dev-java/netbeans-api-xml-ui-${PV}:${SLOT}
	~dev-java/netbeans-core-multiview-${PV}:${SLOT}
	~dev-java/netbeans-openide-actions-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-dialogs-${PV}:${SLOT}
	~dev-java/netbeans-openide-execution-${PV}:${SLOT}
	~dev-java/netbeans-openide-explorer-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-nb-${PV}:${SLOT}
	~dev-java/netbeans-openide-io-${PV}:${SLOT}
	~dev-java/netbeans-openide-loaders-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-text-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-windows-${PV}:${SLOT}
	~dev-java/netbeans-options-api-${PV}:${SLOT}
	~dev-java/netbeans-options-java-${PV}:${SLOT}
	~dev-java/netbeans-project-indexingbridge-${PV}:${SLOT}
	~dev-java/netbeans-projectapi-${PV}:${SLOT}
	~dev-java/netbeans-projectuiapi-${PV}:${SLOT}
	~dev-java/netbeans-projectuiapi-base-${PV}:${SLOT}
	~dev-java/netbeans-queries-${PV}:${SLOT}
	~dev-java/netbeans-spi-navigator-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	mv src-bridge/org/apache/tools/ant/module/bridge/impl \
		src/org/apache/tools/ant/module/bridge \
		|| die "Failed to move additional sources"
}
