# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-nb-${PV}:${SLOT}
	~nb-ide/netbeans-api-search-${PV}:${SLOT}
	~nb-ide/netbeans-api-templates-${PV}:${SLOT}
	~nb-ide/netbeans-apisupport-project-${PV}:${SLOT}
	~nb-ide/netbeans-core-startup-${PV}:${SLOT}
	~nb-ide/netbeans-core-startup-base-${PV}:${SLOT}
	~nb-ide/netbeans-extexecution-${PV}:${SLOT}
	~nb-ide/netbeans-java-api-common-${PV}:${SLOT}
	~nb-ide/netbeans-java-hints-legacy-spi-${PV}:${SLOT}
	~nb-ide/netbeans-java-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-java-platform-${PV}:${SLOT}
	~nb-ide/netbeans-java-platform-ui-${PV}:${SLOT}
	~nb-ide/netbeans-java-project-${PV}:${SLOT}
	~nb-ide/netbeans-java-project-ui-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-o-apache-tools-ant-module-${PV}:${SLOT}
	~nb-ide/netbeans-o-n-swing-outline-${PV}:${SLOT}
	~nb-ide/netbeans-openide-actions-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-execution-${PV}:${SLOT}
	~nb-ide/netbeans-openide-explorer-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-nb-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
	~nb-ide/netbeans-project-ant-${PV}:${SLOT}
	~nb-ide/netbeans-project-ant-ui-${PV}:${SLOT}
	~nb-ide/netbeans-project-libraries-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectui-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-base-${PV}:${SLOT}
	~nb-ide/netbeans-queries-${PV}:${SLOT}
	~nb-ide/netbeans-spi-editor-hints-${PV}:${SLOT}
	~nb-ide/netbeans-whitelist-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	sed -i -e "s|Task _|Task t|" \
		src/org/netbeans/modules/apisupport/project/ui/ModuleActions.java \
		|| die "Failed to fix/sed java 9 underscore keyword"
}
