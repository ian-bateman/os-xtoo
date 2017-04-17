# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_SNAP="a0886e1a13d431e3bed27492696006100173e81b"
E_TYPE="apps"

inherit autotools e

DESCRIPTION="Utility for taking screenshots of the entire screen, window, or region."
HOMEPAGE="https://git.enlightenment.org/apps/${PN}.git"
LICENSE="GPL-3"

if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${HOMEPAGE}/snapshot/${MY_P}.tar.xz -> ${P}.tar.xz"
	S="${WORKDIR}/${MY_P}"
fi

src_prepare() {
	default
	eautoreconf
}
