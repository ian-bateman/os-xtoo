# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN//-/.}"
MY_PN="${MY_PN/.ap/-ap}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/javaee/jacc-spec"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="jacc-spec-${MY_P}"
fi

CP_DEPEND="java-virtuals/servlet-api:4.0"

inherit java-pkg

DESCRIPTION="Java Authorization Contract For Containers API"
HOMEPAGE="${BASE_URI}"
LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="0"

S="${WORKDIR}/${MY_S}"
