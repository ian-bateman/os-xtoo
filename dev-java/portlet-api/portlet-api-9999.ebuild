# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="portals-pluto"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P#*-}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P#*-}"
fi

CP_DEPEND="
	dev-java/cdi-api:0
	dev-java/javax-inject:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

SLOT="${PV%%.*}"
DESCRIPTION="Portlet API version ${SLOT}.0"
HOMEPAGE="https://portals.apache.org/pluto/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
