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

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

OSGI_SLOT="6"

CP_DEPEND="
	~dev-java/eclipse-core-runtime-${PV}:${SLOT}
	~dev-java/eclipse-e4-ui-css-core-${PV}:${SLOT}
	~dev-java/eclipse-e4-ui-css-swt-${PV}:${SLOT}
	~dev-java/eclipse-equinox-common-${PV}:${SLOT}
	~dev-java/eclipse-equinox-preferences-${PV}:${SLOT}
	~dev-java/eclipse-equinox-registry-${PV}:${SLOT}
	~dev-java/eclipse-osgi-${PV}:${SLOT}
	~dev-java/eclipse-swt-${PV}:${SLOT}
	dev-java/osgi-compendium:${OSGI_SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
	dev-java/xml-commons-external:0
"

inherit java-pkg

DESCRIPTION="Eclipse E4 UI CSS SWT Theme (org.${PN//-/.})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/bundles/org.${PN//-/.}/"

JAVAC_ARGS+=" --add-modules=jdk.xml.dom "
