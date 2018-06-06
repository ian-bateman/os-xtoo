# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV/pre/preview}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/jsr305:0"

inherit java-pkg

DESCRIPTION="Static analysis to look for bugs in Java code"
HOMEPAGE="https://spotbugs.github.io/"
LICENSE="LGPL-2.1"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
