# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/jfree/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="dev-java/jaxb-api:0"

inherit java-pkg

DESCRIPTION="JCommon class library (used by JFreeChart)"
HOMEPAGE="https://www.jfree.org/jfreesvg"
LICENSE="GPL-3"
SLOT="0"

S="${WORKDIR}/${P}"
