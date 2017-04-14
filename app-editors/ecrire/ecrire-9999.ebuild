# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_CMAKE="yes"
E_SNAP="2f09e4083dafa8f6e5a7186a6366de6325209060"
E_TYPE="apps"

inherit e

DESCRIPTION="An EFL based text editor"
HOMEPAGE="https://git.enlightenment.org/apps/ecrire.git"
LICENSE="GPL-3"
if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${HOMEPAGE}/snapshot/${MY_P}.tar.xz"
	S="${WORKDIR}/${MY_P}"
fi

src_configure() {
	local mytype="release"
	use debug && mytype="debug"
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=${mytype}
		-DCMAKE_DOC=$(usex doc)
		-DCMAKE_NLS=$(usex nls)
		-DCMAKE_STATIC=$(usex static-libs)
	)
	cmake-utils_src_configure
}
