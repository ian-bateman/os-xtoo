# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-pkg

MY_PN="jsonp"
MY_PV="${PV/.2m/-M2}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

DESCRIPTION="API module of JSR 374:Java API for Processing JSON"
HOMEPAGE="https://javaee.github.io/jsonp/"
LICENSE="|| ( CDDL GPL-2 )"
SLOT="0"

S="${WORKDIR}/${MY_S}/api"
