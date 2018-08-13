# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

SLOT="${PV%%.*}"
MY_PN="${PN#*-}"
if [[ ${SLOT} == 1 ]]; then
	SLOT="0"
elif [[ ${SLOT} == 3 ]]; then
	MY_PN+="${SLOT}"
fi
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV^^}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/commons-logging:0
"

if [[ ${SLOT} == 0 ]]; then
	CP_DEPEND+=" dev-java/commons-collections:0"
elif [[ ${SLOT} == 3 ]]; then
	CP_DEPEND+=" dev-java/cglib:3"
fi

inherit java-pkg

DESCRIPTION="Reads XML configuration files to initialize Java objects"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"
