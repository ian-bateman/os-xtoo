# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/jfree/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="JCommon class library (used by JFreeChart)"
HOMEPAGE="https://www.jfree.org/jfreesvg"
LICENSE="GPL-3"
SLOT="0"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${P}"

java_prepare() {
	# Drop demos per https://github.com/jfree/jfreesvg/issues/12
	if [[ ${PV} == 3.2 ]]; then
		rm -r src/main/java/org/jfree/graphics2d/demo \
			|| die "Failed to remove demos"
	fi
}
