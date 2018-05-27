# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PNL="${PN:0:6}"
MY_PN="${MY_PNL^^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"

BASE_URI="https://github.com/apache/${MY_PNL}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PNL}-${MY_P}"
fi

SLOT="0"

CP_DEPEND="~dev-java/groovy-${PV}:0"

inherit java-pkg

DESCRIPTION="Groovy ${PN:8}"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/subprojects/${PN}"
