# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV/_/.}"
MY_PV="${MY_PV^}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN:4}"
BASE_URI="https://github.com/${MY_PN}-spec/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/javax-inject:0
	dev-java/javax-interceptor-api:0
	dev-java/tomcat-servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Contexts and Dependency Injection ${MY_MOD}"
HOMEPAGE="https://${MY_PN}-spec.org/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
