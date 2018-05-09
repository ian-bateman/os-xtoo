# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN:0:16}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A proxy to ssh-agent and Pageant in Java"
HOMEPAGE="https://github.com/ymnk/${MY_PN}"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="BSD-3-clause"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="
	~dev-java/jsch-agent-proxy-core-${PV}:${SLOT}
	~dev-java/jsch-agent-proxy-sshagent-${PV}:${SLOT}
	~dev-java/jsch-agent-proxy-usocket-jna-${PV}:${SLOT}
	~dev-java/jsch-agent-proxy-usocket-nc-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}/${PN}"

java_prepare() {
	sed -i -e "36d;65,79d;101,102d" -e "s|pageant,||" \
		src/main/java/com/jcraft/jsch/agentproxy/ConnectorFactory.java \
		|| die "Failed to sed/remove Windows PageantConnector"
}
