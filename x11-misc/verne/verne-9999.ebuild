# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_CMAKE="yes"
E_SNAP="70b4c3858a881c15e7a8f04a09c49f23c6762e28"
E_TYPE="apps"

inherit e

DESCRIPTION="A small efl based filemanager"
HOMEPAGE="https://github.com/marcelhollerbach/${PN}"
LICENSE="BSD-2-clause"

if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${HOMEPAGE}/archive/${E_SNAP}.tar.gz -> ${P}.tar.gz"
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
