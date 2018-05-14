# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
BASE_URI="https://github.com/Obsidian-StudiosInc/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV} -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Super-small, super-fast Java compiler - ${MY_MOD}"
HOMEPAGE="https://janino-compiler.github.io/janino/"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
