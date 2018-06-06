# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="REL"
MY_PV="${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}_${MY_PV}"
[[ ${PV} != *beta* ]] && MY_P+="_FINAL"
BASE_URI="https://github.com/apache/${PN:0:3}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN:0:3}-${MY_P}"
fi

SLOT="0"
BC_SLOT="1.59"

CP_DEPEND="
	dev-java/bcpkix:${BC_SLOT}
	dev-java/bcprov:${BC_SLOT}
	dev-java/commons-codec:0
	dev-java/commons-collections:4
	dev-java/commons-logging:0
	dev-java/curvesapi:0
	dev-java/jaxb-api:0
	dev-java/junit:4
	~dev-java/poi-${PV}:${SLOT}
	~dev-java/poi-ooxml-schemas-${PV}:${SLOT}
	~dev-java/poi-ooxml-scratchpad-${PV}:${SLOT}
	dev-java/xmlbeans:0
	dev-java/xmlsec:0
"

inherit java-pkg

DESCRIPTION="Java API for Microsoft Documents ${PN:4}"
HOMEPAGE="https://poi.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/src/${PN#*-}"

JAVA_SRC_DIR="java"
JAVA_RES_DIR="resources"
