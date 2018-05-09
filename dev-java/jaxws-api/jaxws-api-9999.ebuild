# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jax-ws-spec"
MY_PV="${PV%*.*.*}-b${PV#*.*.*.}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PN}-${MY_PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${PN}-${MY_PV}"
fi

inherit java-pkg

DESCRIPTION="JAX-WS (JSR 224) API"
HOMEPAGE="${BASE_URI}"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

CP_DEPEND="
	dev-java/javax-annotation:0
	dev-java/javax-xml-soap:0
	dev-java/jaxb-api:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN##*-}"
