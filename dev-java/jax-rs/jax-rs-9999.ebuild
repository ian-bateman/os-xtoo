# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jaxrs-api"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}/"
if [[ ${PV} == 2.0* ]]; then
	BASE_URI="https://github.com/${PN}/api"
	MY_S="api-${PV}"
fi

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_PN}-${PV}"
fi

CP_DEPEND="dev-java/jaxb-api:0"

inherit java-pkg

DESCRIPTION="Reference implementation of the Java API for RESTful Services"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2 )"

if [[ ${PV} == 2.1* ]]; then
	SLOT="2.1"
	S="${WORKDIR}/${MY_S}/${PN/-/}-api"
	JAVA_RM_FILES=( src/main/java/module-info.java )
else
	SLOT="2"
	S="${WORKDIR}/${MY_S}/src/${PN}-api"
	JAVA_RM_FILES=( src/test )
fi
