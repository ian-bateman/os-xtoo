# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_TYPE="apps"

inherit e

DESCRIPTION="An EFL based text editor"
HOMEPAGE="https://git.enlightenment.org/apps/ecrire.git"
LICENSE="GPL-3"
SLOT="0"
if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-2f09e4083dafa8f6e5a7186a6366de6325209060"
	SRC_URI="${HOMEPAGE}/snapshot/${MY_P}.tar.xz"
	S="${WORKDIR}/${MY_P}"
fi

IUSE="doc nls static-libs"

DEPEND="dev-libs/efl"

RDEPEND="${DEPEND}"
