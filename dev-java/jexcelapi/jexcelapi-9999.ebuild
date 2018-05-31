# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/igapyon/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/log4j:0"

inherit java-pkg

DESCRIPTION="Provides the ability to read, write, and modify Excel spreadsheets"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_RES_DIR="resources"
