# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:4}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/${MY_PN}tools/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"

CP_DEPEND="dev-java/slf4j-api:0"

inherit java-pkg

DESCRIPTION="Java framework for RSS and Atom feeds ${PN:5}"
HOMEPAGE="https://${MY_PN}tools.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_P}/${PN}"

JAVA_RES_DIR="empty"
