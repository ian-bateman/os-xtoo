# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="OpenPDF"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/LibrePDF/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P,,}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Java PDF library, forked from iText ${PN:4} module"
HOMEPAGE="${BASE_URI}"
LICENSE="MPL-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/dom4j:2
	~dev-java/openpdf-${PV}:${SLOT}
	dev-java/pdf-renderer:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/${PN:4}"

JAVA_SRC_DIR="src/main/java"
