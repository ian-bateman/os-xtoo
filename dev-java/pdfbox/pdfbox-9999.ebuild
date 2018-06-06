# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"
BC_SLOT="1.59"

CP_DEPEND="
	dev-java/bcpkix:${BC_SLOT}
	dev-java/bcprov:${BC_SLOT}
	dev-java/commons-logging:0
	~dev-java/fontbox-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Open source Java tool for working with PDF documents"
HOMEPAGE="https://pdfbox.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${P}/${PN}"
