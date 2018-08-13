# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="java-${PN}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/FasterXML/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${MY_PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Zero-dependency library for introspecting type information"
HOMEPAGE="https://fasterxml.com"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/"
