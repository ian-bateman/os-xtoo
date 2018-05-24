# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/version-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P/-/-version-}"
fi

CP_DEPEND="
	dev-java/jaxb-api:0
	dev-java/jaxen:0
	dev-java/relaxng-datatype-java:0
	dev-java/xpp:2
	dev-java/xpp:3
	dev-java/xsdlib:0
"

inherit java-pkg

DESCRIPTION="Open source framework for processing XML"
HOMEPAGE="https://${PN}.github.io"
LICENSE="${PN}"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}"

PATCHES=( "${FILESDIR}/xpp3-add-removeAttribute.patch" )
