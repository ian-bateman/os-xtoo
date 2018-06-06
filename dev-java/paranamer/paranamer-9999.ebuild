# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${PN}-parent-${PV}"

BASE_URI="https://github.com/paul-hammant/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="dev-java/javax-inject:0"

inherit java-pkg

DESCRIPTION="Access to parameter names in Java5+"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
