# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:14}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}/${PN}"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Set of tools that ease Velocity integration ${PN:15}"
HOMEPAGE="https://velocity.apache.org/tools/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/commons-collections:0
	dev-java/commons-digester:2
	dev-java/commons-lang:2
	dev-java/commons-logging:0
	dev-java/commons-validator:0
	dev-java/dom4j:1
	dev-java/velocity-engine-core:0
	java-virtuals/servlet-api:2.5
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"

java_prepare() {
	# Removing struts, because its struts...
	rm -rv "${S}/${JAVA_SRC_DIR}/org/apache/velocity/tools/struts" || \
		die "Failed to remove struts classes"
}
