# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="RELEASE"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/validator/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Implementation of the HTML parsing algorithm in Java"
HOMEPAGE="https://about.validator.nu/htmlparser/"
LICENSE="W3C"
SLOT="0"

CP_DEPEND="
	dev-java/jchardet:0
	dev-java/icu4j:0
	dev-java/xom:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	sed -i -e "s|final void startTag|void startTag|" \
		-e "s|final void endTag|void endTag|" \
		src/nu/validator/htmlparser/impl/TreeBuilder.java \
		|| die "Failed to remove final from methods"
}
