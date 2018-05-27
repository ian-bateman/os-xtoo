# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="google-api-java-client"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:6}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/google-api-client-${PV}:${SLOT}
	~dev-java/google-http-client-${PV}:${SLOT}
	~dev-java/google-http-client-jackson2-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Google APIs Client Library for Java ${PN:18}"
HOMEPAGE="https://developers.google.com/api-client-library/java/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_P}/${PN}"
