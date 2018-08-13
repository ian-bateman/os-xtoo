# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

if [[ ${PV} == 3* ]] || [[ ${PV} == 4.1* ]]; then
	MY_PN="${PN#*-}"
else
	MY_PN="${PN}"
fi
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV^^}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Extends the JCF classes with new interfaces, implementations and utilities"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"

if [[ ${PV} == 3.*  ]]; then
	SLOT="0"
	JAVA_RELEASE="7"
else
	SLOT="${PV%%.*}"
fi

S="${WORKDIR}/${MY_S}"
