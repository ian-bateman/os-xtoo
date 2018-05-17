# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/Enlightenment/${PN}"
E_BUILD="meson"
E_DISTFILE="v${PV}"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="An EFL based / focussed IDE"
HOMEPAGE="https://enlightenment.github.io/edi"
LICENSE="BSD-2"
IUSE+="clang"

CLANG_SLOT="6"

DEPEND+=" clang? ( sys-devel/clang:${CLANG_SLOT} )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_beta*/}"

src_configure() {
	local clang_path

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
	e_src_configure
}
