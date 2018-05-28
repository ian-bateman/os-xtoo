# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN}-project"
MY_P="${MY_PN}-${PV}"
JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/fusesource/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/hawtjni-runtime:0
	dev-java/jansi-native:0
	dev-java/jna:4
"

inherit java-pkg

DESCRIPTION="Library for ANSI escape sequences to format console output"
HOMEPAGE="http://fusesource.github.io/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
