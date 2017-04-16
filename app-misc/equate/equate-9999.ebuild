# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_SNAP="5ee65c6bc64f71198a92244aa6abbb63c122e35d"
E_TYPE="apps"

inherit autotools e

DESCRIPTION="Elementary based calculator"
HOMEPAGE="${E_GIT_URI}/apps/${PN}.git"
LICENSE="BSD-2"

if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${HOMEPAGE}/snapshot/${MY_P}.tar.xz"
	S="${WORKDIR}/${MY_P}"
fi

src_prepare() {
	default
	eautoreconf
}
