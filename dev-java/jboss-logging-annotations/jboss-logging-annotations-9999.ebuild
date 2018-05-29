# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:13}-tools"
MY_PV="${PV}.Final"
MY_P="${PN}-${MY_PV}"

BASE_URI="https://github.com/${PN%-*}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="dev-java/jboss-logging:0"

inherit java-pkg

DESCRIPTION="JBoss Logging Annotation"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_PN}-${MY_PV}/${PN##*-}"
