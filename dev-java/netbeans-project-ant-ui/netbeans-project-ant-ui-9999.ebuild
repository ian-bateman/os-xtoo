# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-dialogs-${PV}:${SLOT}
	~dev-java/netbeans-openide-explorer-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-loaders-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-windows-${PV}:${SLOT}
	~dev-java/netbeans-project-ant-${PV}:${SLOT}
	~dev-java/netbeans-project-libraries-${PV}:${SLOT}
	~dev-java/netbeans-project-libraries-ui-${PV}:${SLOT}
	~dev-java/netbeans-projectapi-${PV}:${SLOT}
	~dev-java/netbeans-projectuiapi-${PV}:${SLOT}
	~dev-java/netbeans-queries-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
