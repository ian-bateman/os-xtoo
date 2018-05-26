# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipse.jdt.ui"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_PV="${MY_PV/A/_a}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	~dev-java/eclipse-compare-${PV}:${SLOT}
	~dev-java/eclipse-core-commands-${PV}:${SLOT}
	~dev-java/eclipse-core-expressions-${PV}:${SLOT}
	~dev-java/eclipse-core-filebuffers-${PV}:${SLOT}
	~dev-java/eclipse-core-filesystem-${PV}:${SLOT}
	~dev-java/eclipse-core-jobs-${PV}:${SLOT}
	~dev-java/eclipse-core-resources-${PV}:${SLOT}
	~dev-java/eclipse-core-runtime-${PV}:${SLOT}
	~dev-java/eclipse-equinox-common-${PV}:${SLOT}
	~dev-java/eclipse-equinox-preferences-${PV}:${SLOT}
	~dev-java/eclipse-equinox-registry-${PV}:${SLOT}
	~dev-java/eclipse-jface-${PV}:${SLOT}
	~dev-java/eclipse-jface-text-${PV}:${SLOT}
	~dev-java/eclipse-ltk-core-refactoring-${PV}:${SLOT}
	~dev-java/eclipse-team-core-${PV}:${SLOT}
	~dev-java/eclipse-team-ui-${PV}:${SLOT}
	~dev-java/eclipse-text-${PV}:${SLOT}
	~dev-java/eclipse-osgi-${PV}:${SLOT}
	~dev-java/eclipse-swt-${PV}:${SLOT}
	~dev-java/eclipse-ui-navigator-${PV}:${SLOT}
	~dev-java/eclipse-ui-workbench-${PV}:${SLOT}
	dev-java/icu4j:0
	dev-java/osgi-core-api:6
"

inherit java-pkg

DESCRIPTION="Eclipse Ltk Core Refactoring (org.eclipse.ltk-core.refactoring)"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/org.${PN//-/.}/"

JAVA_SRC_DIR="src"
