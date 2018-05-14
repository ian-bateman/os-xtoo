# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/virtuald/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

inherit java-pkg

DESCRIPTION="Java implementation of various mathematical curves"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"
SLOT="0"

S="${WORKDIR}/${P}"
