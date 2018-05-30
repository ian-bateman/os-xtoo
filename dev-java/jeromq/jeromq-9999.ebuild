# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN/j/z}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="dev-java/jnacl:0"

inherit java-pkg

DESCRIPTION="Pure Java implementation of libzmq"
HOMEPAGE="${BASE_URI}"
LICENSE="MPL-2.0"
SLOT="0"

S="${WORKDIR}/${P}"
