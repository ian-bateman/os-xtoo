# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/oblac/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Light open-source Java micro-frameworks and tools"
HOMEPAGE="https://jodd.org"
LICENSE="BSD-2-clause"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
JAVAC_ARGS+=" --add-modules java.activation,java.xml.ws.annotation "
