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

DESCRIPTION="istack common utility code buildtools"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2-with-classpath-exception )"
SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/codemodel:2
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN%-*}/${PN##*-}"

PATCHES=( "${FILESDIR}/cli.patch" )

java_prepare() {
	sed -i -e "s|String dirName|    dirName|" \
		-e "171i\ \ \ \ \ \ \ \ \ \ \ \ String dirName = new String();" \
		-e "171iif(bundleName.indexOf('.')>0)" \
		src/com/sun/istack/build/ResourceGenTask.java \
		|| die "Failed to add conditional to fix java.lang.StringIndexOutOfBoundsException"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher istack-cli --main com.sun.istack.build.ResourceGenCLI
}
