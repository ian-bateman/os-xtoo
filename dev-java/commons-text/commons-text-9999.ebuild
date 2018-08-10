# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV^^}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="dev-java/commons-lang:3"

inherit java-pkg

DESCRIPTION="Library focused on algorithms working on strings"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
