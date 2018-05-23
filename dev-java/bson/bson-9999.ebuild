# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="mongo-java-driver"
MY_P="${MY_PN}-r${PV}"

BASE_URI="https://github.com/mongodb/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/r${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/slf4j-api:0"

inherit java-pkg

DESCRIPTION="MongoDB Binary JSON"
HOMEPAGE="https://mongodb.github.io/${MY_PN}/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}/${PN}"
