# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN:0:11}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="This is an implementation of EdDSA in Java"
SLOT="0"
HOMEPAGE="https://github.com/google/${MY_PN}"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}/${PN:12}"

#JAVA_SRC_DIR="src/"
