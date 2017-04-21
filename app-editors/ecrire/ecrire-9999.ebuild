# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_CMAKE="yes"
E_TYPE="apps"

inherit e

DESCRIPTION="An EFL based text editor"
HOMEPAGE="https://git.enlightenment.org/apps/ecrire.git"
LICENSE="GPL-3"
if [[ ${PV} != 9999 ]]; then
	SRC_URI="https://github.com/Obsidian-StudiosInc/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
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
