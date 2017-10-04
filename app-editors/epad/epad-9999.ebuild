# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="ePad"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/JeffHoogland/${PN}"
EGIT_REPO_URI="${BASE_URI}.git"
E_PYTHON=1

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit e

DESCRIPTION="A simple text editor written in python and elementary"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	${DEPEND}
	dev-python/python-elm-extensions
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_S}"

DOCS=( README.md ${PN}.1 )

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	dobin epad
	domenu ${MY_PN}.desktop
}
