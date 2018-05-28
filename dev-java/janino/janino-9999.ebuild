# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-nullanalysis:0
	~dev-java/janino-commons-compiler-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Super-small, super-fast Java compiler"
HOMEPAGE="https://janino-compiler.github.io/janino/"
LICENSE="BSD"

S="${WORKDIR}/${P}/${PN}"
