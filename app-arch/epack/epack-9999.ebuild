# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

BASE_URI="https://github.com/wfx/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

PYTHON_COMPAT=( python{3_4,3_6} pypy2_0 )

inherit eutils distutils-r1 ${ECLASS}

DESCRIPTION="A tiny file extractor"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	app-arch/libarchive
	dev-python/python-efl
	dev-python/python-elm-extensions
	dev-python/python-magic
"

RDEPEND="${DEPEND}"
