# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:9}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/HtmlUnit/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="HtmlUnit's Rhino fork: JavaScript in Java"
HOMEPAGE="https://htmlunit.sourceforge.net/"
LICENSE="MPL-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src"
