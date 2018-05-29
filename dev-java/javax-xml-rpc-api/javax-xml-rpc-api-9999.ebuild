# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%*-*}"
MY_PN="${MY_PN//-/.}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-api-${MY_PV}"

BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	if [[ ${PV} == 1.1.1 ]]; then
		SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
		MY_S="${MY_P}"
	else

		SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
		MY_S="${MY_PN}-${MY_P}"
	fi
	KEYWORDS="~amd64"
fi

CP_DEPEND="
	dev-java/javax-xml-soap:0
	dev-java/tomcat-servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Project GlassFish Enterprise XML RPC API"
HOMEPAGE="${BASE_URI}"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

S="${WORKDIR}/${MY_S}"
