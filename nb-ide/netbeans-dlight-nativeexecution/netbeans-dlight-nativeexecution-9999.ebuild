# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	dev-java/javax-annotation:0
	dev-java/jsch:0
	dev-java/jna:4
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-extexecution-${PV}:${SLOT}
	~nb-ide/netbeans-keyring-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-io-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-terminal-${PV}:${SLOT}
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
