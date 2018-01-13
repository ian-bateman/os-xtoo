# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	dev-java/antlr:3
	~dev-java/netbeans-api-progress-${PV}:${SLOT}
	~dev-java/netbeans-api-progress-nb-${PV}:${SLOT}
	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
	~dev-java/netbeans-api-java-${PV}:${SLOT}
	~dev-java/netbeans-api-java-classpath-${PV}:${SLOT}
	~dev-java/netbeans-api-templates-${PV}:${SLOT}
	~dev-java/netbeans-autoupdate-services-${PV}:${SLOT}
	~dev-java/netbeans-editor-util-${PV}:${SLOT}
	~dev-java/netbeans-extexecution-${PV}:${SLOT}
	~dev-java/netbeans-java-platform-${PV}:${SLOT}
	~dev-java/netbeans-java-platform-ui-${PV}:${SLOT}
	~dev-java/netbeans-java-preprocessorbridge-${PV}:${SLOT}
	~dev-java/netbeans-java-project-${PV}:${SLOT}
	~dev-java/netbeans-java-project-ui-${PV}:${SLOT}
	~dev-java/netbeans-java-source-${PV}:${SLOT}
	~dev-java/netbeans-java-source-base-${PV}:${SLOT}
	~dev-java/netbeans-java-sourceui-${PV}:${SLOT}
	~dev-java/netbeans-o-apache-tools-ant-module-${PV}:${SLOT}
	~dev-java/netbeans-openide-actions-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-dialogs-${PV}:${SLOT}
	~dev-java/netbeans-openide-execution-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-nb-${PV}:${SLOT}
	~dev-java/netbeans-openide-loaders-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-text-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-windows-${PV}:${SLOT}
	~dev-java/netbeans-queries-${PV}:${SLOT}
	~dev-java/netbeans-project-ant-${PV}:${SLOT}
	~dev-java/netbeans-project-ant-ui-${PV}:${SLOT}
	~dev-java/netbeans-project-libraries-${PV}:${SLOT}
	~dev-java/netbeans-project-libraries-ui-${PV}:${SLOT}
	~dev-java/netbeans-projectapi-${PV}:${SLOT}
	~dev-java/netbeans-projectuiapi-${PV}:${SLOT}
	~dev-java/netbeans-projectuiapi-base-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
