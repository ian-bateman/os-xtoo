# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

HOMEPAGE="https://github.com/google/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
	MY_S="${P}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Generic-purpose lossless compression algorithm"
LICENSE="MIT"
SLOT="0"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/java/"

java_prepare() {
	# Remove tests
	find "${S}" -name '*Test.java' -type f -delete \
		|| die "Failed to remove tests"
}
