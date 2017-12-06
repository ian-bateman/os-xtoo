# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

JAP_SLOT="0"

CP_DEPEND="
	dev-java/jsch-agent-proxy-core:${JAP_SLOT}
	dev-java/jsch-agent-proxy-pageant:${JAP_SLOT}
	dev-java/jsch-agent-proxy-sshagent:${JAP_SLOT}
	dev-java/jsch-agent-proxy-usocket-jna:${JAP_SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
