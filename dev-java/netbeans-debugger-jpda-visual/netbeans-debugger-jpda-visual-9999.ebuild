# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
	~dev-java/netbeans-api-debugger-${PV}:${SLOT}
	~dev-java/netbeans-api-debugger-jpda-${PV}:${SLOT}
	~dev-java/netbeans-api-io-${PV}:${SLOT}
	~dev-java/netbeans-api-progress-${PV}:${SLOT}
	~dev-java/netbeans-api-progress-nb-${PV}:${SLOT}
	~dev-java/netbeans-debugger-jpda-${PV}:${SLOT}
	~dev-java/netbeans-debugger-jpda-ui-${PV}:${SLOT}
	~dev-java/netbeans-java-source-base-${PV}:${SLOT}
	~dev-java/netbeans-o-n-swing-outline-${PV}:${SLOT}
	~dev-java/netbeans-openide-actions-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-dialogs-${PV}:${SLOT}
	~dev-java/netbeans-openide-explorer-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-nb-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-windows-${PV}:${SLOT}
	~dev-java/netbeans-options-api-${PV}:${SLOT}
	~dev-java/netbeans-options-java-${PV}:${SLOT}
	~dev-java/netbeans-spi-debugger-ui-${PV}:${SLOT}
	~dev-java/netbeans-spi-navigator-${PV}:${SLOT}
	~dev-java/netbeans-spi-viewmodel-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
