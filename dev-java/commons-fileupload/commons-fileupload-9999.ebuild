# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

MY_PN="${PN}"
MY_PV="${PV^^}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="High-performance file upload capability for servlets and web applications"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/portlet-api:1
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"
