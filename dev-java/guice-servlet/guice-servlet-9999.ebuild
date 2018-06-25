# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/google/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/guava:25
	~dev-java/guice-${PV}:${SLOT}
	dev-java/javax-inject:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Guice extensions servlet"
HOMEPAGE="https://github.com/google/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_P}/extensions/${PN##*-}"
