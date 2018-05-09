# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="glassfish-corba"
MY_PV="${PV/_beta/-b}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="IDL compiler"
HOMEPAGE="https://javaee.github.io/glassfish-corba/"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

DEPEND=">=virtual/jdk-10"
RDEPEND=">=virtual/jre-10"

S="${WORKDIR}/${MY_S}/${PN}"

src_install() {
	java-pkg-simple_src_install

	java-pkg_dolauncher ${PN} \
		--main com.sun.tools.corba.ee.idl.toJavaPortable.Compile
}
