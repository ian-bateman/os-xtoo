# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="mylyn.docs"
MY_PV="R_${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="org.${PN//-/.}"
BASE_URI="https://github.com/${PN%%-*}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/wikitext.core-${PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-wikitext.core-${PV}"
fi

inherit java-pkg

DESCRIPTION="Eclipse Mylyn Docs (${MY_MOD})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/guava:24
	dev-java/jsoup:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/wikitext/core/${MY_MOD}/"
