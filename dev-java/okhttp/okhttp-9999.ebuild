# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/square/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/parent-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="HTTP client that's efficient by default"
HOMEPAGE="https://square.github.io/okhttp/"
LICENSE="Apache-2.0"
SLOT="3"

GUICE_SLOT="4"

CP_DEPEND="
	dev-java/android-util:0
	dev-java/jsr305:0
	dev-java/okio:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

if [[ ${PV} == 9999 ]]; then
	S="${WORKDIR}/${P}/${PN}"
else
	S="${WORKDIR}/${P/${PN}/${PN}-parent}/${PN}"
fi

JAVA_SRC_DIR="
	src/main/java
	src/main/java-templates
"
