# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/jdom:2"

inherit java-pkg

DESCRIPTION="Library to create barcodes for printing and display"
HOMEPAGE="${BASE_URI}"
LICENSE="IBC"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	# upgrade jdom -> jdom2
	sed -i -e "s|.jdom.|.jdom2.|g" \
		src/java/net/sourceforge/barbecue/output/SVGOutput.java \
		|| die "Failed to sed/upgrade jdom -> jdom2"
}
