# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-pkg

SLOT="${PV%%.*}"
DESCRIPTION="Portlet API version ${SLOT}.0"
HOMEPAGE="https://www.jcp.org/en/jsr/detail?id="
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

MY_PN="${PN%%-*}"
SRC_URI="http://download.oracle.com/otn-pub/jcp"
case ${SLOT} in
	1)
		HOMEPAGE+="168"
		MY_PV="${PV}-fr-spec"
		MY_P="${MY_PN}_${MY_PV}"
		SRC_URI+="/${MY_P^^}-G-F/${MY_PN}-${MY_PV/./_}-api.zip"
		;;
	2)
		HOMEPAGE+="286"
		MY_PV="${PV}-fr"
		MY_P="${MY_PN}-${MY_PV}"
		SRC_URI+="/${MY_P}-oth-JSpec/${MY_P}.zip"
		CP_DEPEND="java-virtuals/servlet-api:4.0"
		JAVA_ENCODING="ISO-8859-1"
		;;
esac

#CP_DEPEND="
#	dev-java/cdi-api:0
#	dev-java/javax-inject:0
#	java-virtuals/servlet-api:4.0
#"

DEPEND="
	app-arch/unzip:*
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

#S="${WORKDIR}/${MY_S}/${PN}"

src_unpack() {
	default
	[[ ${SLOT} == 2 ]] && unpack final/src.zip
}
