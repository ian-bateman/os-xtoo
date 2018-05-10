# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/000/}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/kohsuke/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="RELAX NG Object Model / Parser"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

CP_DEPEND="dev-java/relaxng-datatype-java:0"

JV="1.8"

DEPEND="${CP_DEPEND}
	dev-java/javacc:0
	>=virtual/jdk-${JV}"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-${JV}"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src"

java_prepare() {
	cd "${S}/src/org/kohsuke/rngom/parse/compact/" \
		|| die "Failed to change directory"
	javacc -JDK_VERSION="${JV}" CompactSyntax.jj \
		|| die "javacc CompactSyntax.jj failed"
}
