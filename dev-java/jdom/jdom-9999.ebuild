# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/hunterhacker/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Manipulation of XML made easy"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-1.1"
SLOT="${PV%%.*}"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}/core"

java_prepare() {
	rm -r src/java/org/jdom2/xpath \
		|| "Failed to remove jaxen sources"
	sed -i -e "62d" src/java/org/jdom2/JDOMConstants.java \
		|| "Failed to remove jaxen import"
}
