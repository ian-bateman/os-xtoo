# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="jaxb-v2"
MY_PV="${PV/.170/-b170}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Java Architecture for XML Binding (JAXB)"
HOMEPAGE="${BASE_URI}"
LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="0"

CP_DEPEND="
	dev-java/javax-activation:0
	dev-java/istack-commons-runtime:0
	~dev-java/txw2-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/jaxb-ri/${PN#*-}"

JAVAC_ARGS=" --add-modules java.xml.bind "
