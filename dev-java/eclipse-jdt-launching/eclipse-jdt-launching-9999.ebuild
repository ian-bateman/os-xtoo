# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipse.jdt.debug"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_PV="${MY_PV/A/_a}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

OSGI_SLOT="6"

CP_DEPEND="
	~dev-java/eclipse-core-expressions-${PV}:${SLOT}
	~dev-java/eclipse-core-jobs-${PV}:${SLOT}
	~dev-java/eclipse-core-resources-${PV}:${SLOT}
	~dev-java/eclipse-core-runtime-${PV}:${SLOT}
	~dev-java/eclipse-core-variables-${PV}:${SLOT}
	~dev-java/eclipse-debug-core-${PV}:${SLOT}
	~dev-java/eclipse-equinox-common-${PV}:${SLOT}
	~dev-java/eclipse-equinox-preferences-${PV}:${SLOT}
	~dev-java/eclipse-equinox-registry-${PV}:${SLOT}
	~dev-java/eclipse-jdt-core-${PV}:${SLOT}
	~dev-java/eclipse-jdt-debug-${PV}:${SLOT}
	~dev-java/eclipse-osgi-${PV}:${SLOT}
	dev-java/icu4j:0
	dev-java/osgi-compendium:6
	dev-java/osgi-core-api:6
"

inherit java-pkg

DESCRIPTION="Eclipse JDT Launching (org.${PN//-/.})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/org.${PN//-/.}/"

JAVA_SRC_DIR="launching support"

java_prepare() {
	sed -i -e "113d;117,120d" \
		launching/org/eclipse/jdt/internal/launching/SocketListenConnectorProcess.java \
		|| die "Failed to sed/remove IOException from multi-catch"
}
