# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_PN="ePad"
E_BASE_URI="https://github.com/JeffHoogland/${PN}"
E_DISTFILE="${PV}"
E_PYTHON=1
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="A simple text editor written in python and elementary"
HOMEPAGE="${E_BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

S="${WORKDIR}/${E_P}"

DEPEND+="dev-python/python-elm-extensions"
RDEPEND="${DEPEND}"

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
