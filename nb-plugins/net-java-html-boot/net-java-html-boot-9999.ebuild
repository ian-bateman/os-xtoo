# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="incubator-netbeans-html4j"
MY_PV="release-${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

HOMEPAGE="${BASE_URI}"
DESCRIPTION="Builder to launch your Java/HTML based application"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/asm:6
	~nb-plugins/net-java-html-${PV}:${SLOT}
	nb-ide/netbeans-openide-util-lookup:9
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN#*-*-*-}"
