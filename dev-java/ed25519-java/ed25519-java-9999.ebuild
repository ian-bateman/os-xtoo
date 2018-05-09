# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/str4d/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="This is an implementation of EdDSA in Java"
HOMEPAGE="${BASE_URI}"
LICENSE="CC0-1.0"

if [[ ${PV} == 0.1.0 ]]; then
	SLOT="0"
else
	SLOT="${PV:0:3}"
fi

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/"
