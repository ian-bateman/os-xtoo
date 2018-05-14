# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/clarkware/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Package dependency analyzer that generates design quality metrics."
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"
SLOT="0"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src"
