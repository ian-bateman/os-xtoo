# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="rt.equinox.framework"
MY_PN="${MY_PN//-/.}"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Eclipse OSGi"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"
SLOT="$(get_version_component_range 1-2)"

OSGI_SLOT="6"

CP_DEPEND="
	dev-java/felix-resolver:0
	dev-java/osgi-core-api:${OSGI_SLOT}
	dev-java/osgi-compendium:${OSGI_SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/bundles/org.${PN//-/.}/"

JAVA_RELEASE="8"
JAVA_SRC_DIR="container supplement"
