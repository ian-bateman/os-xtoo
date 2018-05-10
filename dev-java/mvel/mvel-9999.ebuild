# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}2"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="MVFLEX Expression Language"
HOMEPAGE="https://${PN}.documentnode.com/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	sed -i -e "s|_(|make(|g" src/main/java/org/mvel2/util/Make.java \
		|| die "Failed to sed/fix Java 9 keyword _( -> make("
}
