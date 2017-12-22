# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	dev-java/jsch:0
	dev-java/jna:4
	~dev-java/netbeans-api-progress-${PV}:${SLOT}
	~dev-java/netbeans-extexecution-${PV}:${SLOT}
	~dev-java/netbeans-keyring-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-io-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-terminal-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	sed -i -e "s|, DEFAULT_OPTIONS||" \
		src/org/netbeans/modules/nativeexecution/support/Win32APISupport.java \
		|| die "Failed to sed/remove extra argument for java 9"
}
