# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	dev-java/ant-core:0
	~nb-ide/netbeans-api-debugger-${PV}:${SLOT}
	~nb-ide/netbeans-api-debugger-jpda-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-java-platform-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	mv antsrc/org/netbeans/modules/debugger/jpda/ant/* \
		src/org/netbeans/modules/debugger/jpda/ant/ \
		|| die "Failed to move sources"
}
