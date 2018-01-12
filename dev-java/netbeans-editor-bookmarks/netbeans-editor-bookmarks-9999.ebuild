# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
	~dev-java/netbeans-editor-${PV}:${SLOT}
	~dev-java/netbeans-editor-lib-${PV}:${SLOT}
	~dev-java/netbeans-editor-lib2-${PV}:${SLOT}
	~dev-java/netbeans-editor-mimelookup-${PV}:${SLOT}
	~dev-java/netbeans-editor-settings-${PV}:${SLOT}
	~dev-java/netbeans-editor-util-${PV}:${SLOT}
	~dev-java/netbeans-o-n-swing-outline-${PV}:${SLOT}
	~dev-java/netbeans-openide-actions-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-explorer-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-loaders-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-text-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-windows-${PV}:${SLOT}
	~dev-java/netbeans-projectapi-${PV}:${SLOT}
	~dev-java/netbeans-settings-${PV}:${SLOT}
	~dev-java/netbeans-projectuiapi-${PV}:${SLOT}
	~dev-java/netbeans-projectuiapi-base-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
