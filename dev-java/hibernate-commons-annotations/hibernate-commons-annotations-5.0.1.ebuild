# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Hibernate's core"

MY_PN="${PN:0:9}"
MY_PV="${PV}.Final"
MY_P="${PN}-${MY_PV}"

SLOT="${PV%%.*}"
SRC_URI="https://github.com/${PN:0:9}/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="https://${MY_PN}.org/"
KEYWORDS="~amd64"
LICENSE="LGPL-2.1"

CP_DEPEND="dev-java/jboss-logging:0
	dev-java/jboss-logging-annotations:2"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="
	${CP_DEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${MY_P}/"

JAVA_SRC_DIR="src/main/java"
