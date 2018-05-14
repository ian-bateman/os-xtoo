# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="rel"
MY_PV="${PV//./_}"
if [[ ${PV} == *pre* ]]; then
	MY_PV="${MY_PV/pre/cr}"
else
	MY_PV="${MY_PV}_ga"
fi
MY_P="${MY_PN}_${MY_PV}"

BASE_URI="https://github.com/jboss-${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Javassist makes Java bytecode manipulation simple"
HOMEPAGE="https://jboss-javassist.github.io/javassist/"
LICENSE="MPL-1.1"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}"

JAVA_NEEDS_TOOLS=1
