# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="jaxb-istack-commons"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="istack common utility code runtime"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2-with-classpath-exception )"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN%-*}/${PN##*-}"

JAVAC_ARGS+=" --add-modules java.activation "

java_prepare() {
	rm -r src/main/resources || die "Failed to remove empty res dir"
}
