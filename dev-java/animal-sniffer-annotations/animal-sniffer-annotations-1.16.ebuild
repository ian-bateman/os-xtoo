# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN/-annotations/}"

DESCRIPTION="Animal Sniffer Annotations"
HOMEPAGE="https://www.mojohaus.org/animal-sniffer/"
SRC_URI="https://github.com/mojohaus/${MY_PN}/archive/${MY_PN}-parent-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_PN}-${MY_PN}-parent-${PV}/${PN}"

JAVA_SRC_DIR="src/main/java/"
