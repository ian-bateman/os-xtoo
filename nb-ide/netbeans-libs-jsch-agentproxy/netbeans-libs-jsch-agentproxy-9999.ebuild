# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

JAP_SLOT="0"

CP_DEPEND="
	dev-java/jsch-agent-proxy-core:${JAP_SLOT}
	dev-java/jsch-agent-proxy-sshagent:${JAP_SLOT}
	dev-java/jsch-agent-proxy-usocket-jna:${JAP_SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	sed -i -e "23d;66,73d;" \
		src/org/netbeans/libs/jsch/agentproxy/ConnectorFactory.java \
		|| die "Failed to sed/remove Windows Pageant support"
}
