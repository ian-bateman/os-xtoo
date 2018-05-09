# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

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

DESCRIPTION="istack common utility code tools"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2-with-classpath-exception )"
SLOT="0"

CP_DEPEND="dev-java/ant-core:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN%-*}/${PN##*-}"

java_prepare() {
	# causes ant to not be found under java 9, need export/module?
	rm src/main/java/module-info.java || die "Failed to remove module-info"
	mv src{14,/main/java}/com/sun/istack/tools/ProtectedTask.java \
		|| die "Failed to move file"
	rm -r src/main/resources || die "Failed to remove empty res dir"
}
