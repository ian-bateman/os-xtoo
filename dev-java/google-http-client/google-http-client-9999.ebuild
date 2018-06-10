# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="google-http-java-client"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:6}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="
	dev-java/commons-codec:0
	dev-java/guava:25
	dev-java/httpcomponents-client:4.4
	dev-java/httpcomponents-core:4.2
"

inherit java-pkg

DESCRIPTION="Google Http Client Library for Java"
HOMEPAGE="https://developers.google.com/api-client-library/java/${PN}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_P}/${PN}"
