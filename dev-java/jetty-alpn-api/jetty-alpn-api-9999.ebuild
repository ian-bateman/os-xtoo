# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="org.eclipse.jetty.alpn"
MY_PV="${PV/201/v201}"
MY_P="${MY_PN}-${PN#*-}-${MY_PV}"

BASE_URI="https://git.eclipse.org/gitroot/jetty/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI/gitroot/c}.git/snapshot/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Jetty's ALPN API"
HOMEPAGE="https://www.eclipse.org/${MY_PN}/documentation/current/alpn-chapter.html"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/"
