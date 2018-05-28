# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}.Final"
MY_P="${PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="
	dev-java/jboss-logging:0
	dev-java/jboss-logging-annotations:2
"

inherit java-pkg

DESCRIPTION="Hibernate's core"
HOMEPAGE="https://${MY_PN}.org/"
LICENSE="LGPL-2.1"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_P}/"
