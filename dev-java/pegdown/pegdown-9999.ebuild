# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/sirthias/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Markdown processor based on a parboiled PEG parser supporting extensions"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

PARBOILED_SLOT="0"

CP_DEPEND="
	dev-java/parboiled-core:${PARBOILED_SLOT}
	dev-java/parboiled-java:${PARBOILED_SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"
