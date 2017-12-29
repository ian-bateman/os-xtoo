# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="spring-framework"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/spring-projects/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.RELEASE.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}/${PN}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Spring Framework ${PN:7}"
HOMEPAGE="https://spring.io/"
LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="
	dev-java/commons-logging:0
	dev-java/glassfish-connector-api:0
	dev-java/javax-transaction-api:0
	~dev-java/spring-aop-${PV}:${SLOT}
	~dev-java/spring-beans-${PV}:${SLOT}
	~dev-java/spring-context-${PV}:${SLOT}
	~dev-java/spring-core-${PV}:${SLOT}
	dev-java/javax-ejb-api:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"

java_prepare() {
	# Webspehere on a Gentoo based system?
	rm "${S}/src/main/java/org/springframework/transaction/jta/WebSphereUowTransactionManager.java" \
		|| die "Could not remove IBM websphere uow transaction manager"
}
