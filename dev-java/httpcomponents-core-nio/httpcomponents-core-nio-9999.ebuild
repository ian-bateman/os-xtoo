# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:19}"
MY_P="${MY_PN}-${PV}"
MY_MOD="${PN/components-/}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

SLOT="${PV/.${PV#*.*.*}/}"
DESCRIPTION="Low level HTTP transport components ${MY_MOD}"
HOMEPAGE="https://hc.apache.org/${PN:0:19}-${SLOT}.x/"
LICENSE="Apache-2.0"

CP_DEPEND="~dev-java/httpcomponents-core-${PV}:${SLOT}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}/${MY_MOD}"

JAVA_SRC_DIR="src/main/java"
