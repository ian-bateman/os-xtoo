# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_TYPE="apps"

if [[ "${PV}" == 0.6.1 ]]; then
	E_BUILD="meson"
	SRC_URI="https://github.com/Enlightenment/${PN}/releases/download/v${PV}/${P}.tar.xz"
fi

inherit e

DESCRIPTION="An EFL based / focussed IDE"
HOMEPAGE="https://phab.enlightenment.org/w/projects/${PN}/"
LICENSE="BSD-2"
IUSE+="clang"

CLANG_SLOT="6"

DEPEND+=" clang? ( sys-devel/clang:${CLANG_SLOT} )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_beta*/}"

src_configure() {
	if [[ "${PV}" != 0.6.0 ]]; then
		local clang_path E_ECONF

		clang_path="/usr/lib/llvm/${CLANG_SLOT}"
		E_ECONF=( -Dbear=false )
		if use clang; then
			E_ECONF+=(
				-Dlibclang=true
				-Dlibclang-libdir="${clang_path}/lib64"
				-Dlibclang-headerdir="${clang_path}/include"
			)
		else
			E_ECONF+=( -Dlibclang=false )
		fi
	fi
	e_src_configure
}
