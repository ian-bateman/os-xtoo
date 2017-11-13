# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Tool for managing project dependencies"
HOMEPAGE="https://ant.apache.org/ivy/"
LICENSE="Apache-2.0"
SLOT="0"

BC_SLOT="1.50"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/bcpg:${BC_SLOT}
	dev-java/bcprov:${BC_SLOT}
	dev-java/commons-httpclient:3
	dev-java/commons-vfs:2
	dev-java/jakarta-oro:2.0
	dev-java/jsch:0
	dev-java/jsch-agent-proxy-core:0
	dev-java/jsch-agent-proxy-connector-factory:0
	dev-java/jsch-agent-proxy-jsch:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	# update to commons-vfs:2
	local f
	for f in Resource Repository; do
		sed -i -e "s|commons.vfs|commons.vfs2|g" \
			src/java/org/apache/ivy/plugins/repository/vfs/Vfs${f}.java \
			|| die "Failed to sed vfs -> vfs2"
	done
}
