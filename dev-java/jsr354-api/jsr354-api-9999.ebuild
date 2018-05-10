# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/JavaMoney/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="JSR 354 - Money and Currency API"
HOMEPAGE="https://javamoney.github.io/"
LICENSE="JSR-354"
SLOT="0"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/main/java"
