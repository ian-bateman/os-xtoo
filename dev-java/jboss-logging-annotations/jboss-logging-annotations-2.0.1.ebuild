# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="JBoss Logging Annotation"

MY_PN="${PN:0:13}-tools"
MY_PV="${PV}.Final"
MY_P="${PN}-${MY_PV}"

SLOT="${PV%%.*}"
HOMEPAGE="https://github.com/${PN:0:13}"
SRC_URI="${HOMEPAGE}/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"

CP_DEPEND="dev-java/jboss-logging:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="
	${CP_DEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${MY_PN}-${MY_PV}/${PN:14}"

JAVA_SRC_DIR="src/main/java"
