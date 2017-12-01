# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	~dev-java/netbeans-api-progress-${PV}:${SLOT}
	~dev-java/netbeans-api-progress-nb-${PV}:${SLOT}
	~dev-java/netbeans-core-multiview-${PV}:${SLOT}
	~dev-java/netbeans-diff-${PV}:${SLOT}
	~dev-java/netbeans-editor-document-${PV}:${SLOT}
	~dev-java/netbeans-editor-errorstripe-${PV}:${SLOT}
	~dev-java/netbeans-editor-fold-${PV}:${SLOT}
	~dev-java/netbeans-editor-lib-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-o-n-swing-outline-${PV}:${SLOT}
	~dev-java/netbeans-openide-explorer-${PV}:${SLOT}
	~dev-java/netbeans-openide-loaders-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-nb-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-text-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-windows-${PV}:${SLOT}
	~dev-java/netbeans-options-api-${PV}:${SLOT}
	~dev-java/netbeans-queries-${PV}:${SLOT}
	~dev-java/netbeans-team-commons-${PV}:${SLOT}
	~dev-java/netbeans-versioning-core-${PV}:${SLOT}
	~dev-java/netbeans-versioning-util-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
