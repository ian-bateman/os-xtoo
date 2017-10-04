# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

BASE_URI="https://github.com/wfx/${PN}"
EGIT_REPO_URI="${BASE_URI}.git"
E_PYTHON=1
if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit e

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
