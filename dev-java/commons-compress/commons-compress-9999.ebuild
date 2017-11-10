# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

HOMEPAGE="https://github.com/apache/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
	MY_S="${P}"
else
	SRC_URI="${HOMEPAGE}/archive/rel/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-rel-${PV}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Java API for working with archive files"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/brotli:0
	dev-java/xz-java:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"
