# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}-project"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/kohsuke/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="The core of the CodeModel java source code generation library"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2-with-classpath-exception )"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}/${PN}"
