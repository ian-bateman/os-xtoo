# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/google/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Guice is a lightweight dependency injection framework for Java 5 and above"
HOMEPAGE="https://github.com/google/guice/"
LICENSE="Apache-2.0"
SLOT="4"

CP_DEPEND="
	dev-java/asm:6
	dev-java/aopalliance:1
	dev-java/cglib:3
	dev-java/guava:24
	dev-java/javax-inject:0
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="${CP_DEPEND}
	dev-java/bnd:4
	>=virtual/jdk-9"

S="${WORKDIR}/${P}/core"
