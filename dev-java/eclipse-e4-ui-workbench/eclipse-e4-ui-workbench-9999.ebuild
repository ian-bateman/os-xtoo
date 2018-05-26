# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipse.platform.ui"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_PV="${MY_PV/A/_a}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

EEMF_SLOT="2"
OSGI_SLOT="6"

CP_DEPEND="
	~dev-java/eclipse-core-commands-${PV}:${SLOT}
	~dev-java/eclipse-core-expressions-${PV}:${SLOT}
	~dev-java/eclipse-core-runtime-${PV}:${SLOT}
	~dev-java/eclipse-e4-core-commands-${PV}:${SLOT}
	~dev-java/eclipse-e4-core-contexts-${PV}:${SLOT}
	~dev-java/eclipse-e4-core-di-${PV}:${SLOT}
	~dev-java/eclipse-e4-core-di-annotations-${PV}:${SLOT}
	~dev-java/eclipse-e4-core-di-extensions-${PV}:${SLOT}
	~dev-java/eclipse-e4-core-services-${PV}:${SLOT}
	~dev-java/eclipse-e4-ui-di-${PV}:${SLOT}
	~dev-java/eclipse-e4-ui-model-workbench-${PV}:${SLOT}
	~dev-java/eclipse-e4-ui-services-${PV}:${SLOT}
	dev-java/eclipse-emf-common:${EEMF_SLOT}
	dev-java/eclipse-emf-ecore:${EEMF_SLOT}
	dev-java/eclipse-emf-ecore-xmi:${EEMF_SLOT}
	~dev-java/eclipse-equinox-common-${PV}:${SLOT}
	~dev-java/eclipse-equinox-registry-${PV}:${SLOT}
	~dev-java/eclipse-osgi-${PV}:${SLOT}
	dev-java/javax-annotation:0
	dev-java/javax-inject:0
	dev-java/osgi-core-api:${OSGI_SLOT}
	dev-java/osgi-compendium:${OSGI_SLOT}
"

inherit java-pkg

DESCRIPTION="Eclipse E4 UI Workbench (org.${PN//-/.})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/bundles/org.${PN//-/.}/"
