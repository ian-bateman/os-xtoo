# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	MY_PV="${PV/_beta/}"
	MY_P="apache-${MY_PN}-${MY_PV}-src"
	SRC_URI="mirror://apache/${MY_PN}/${MY_PN}-${PV%%.*}/v${MY_PV}/src/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="java/org/apache/juli/"
