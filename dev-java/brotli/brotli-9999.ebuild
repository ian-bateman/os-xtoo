# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/google/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

inherit java-pkg

DESCRIPTION="Generic-purpose lossless compression algorithm"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}/java/"

java_prepare() {
	# Remove tests
	find "${S}" -name '*Test.java' -type f -delete \
		|| die "Failed to remove tests"
}
