# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Java Persistence API ${PV/.${PV#*.*.*}/} JSR-338 Implementation by Eclipselink"

MY_PN="${PN:8}"
MY_PN="${MY_PN/-/.}"
MY_PV="${PV/2013/v2013}"
MY_P="${MY_PN}-${MY_PV}"

HOMEPAGE="https://github.com/eclipse/${MY_PN}"
SRC_URI="https://github.com/eclipse/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
SLOT="${PV%%.*}"
KEYWORDS="~amd64"
LICENSE="EDL-1.0 EPL-1.0"

CP_DEPEND="dev-java/osgi-core-api:6"

DEPEND="
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}"

JAVA_SRC_DIR="src/"
