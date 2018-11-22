# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/vtorri/etui"
E_SNAP="eb01bd8f1fa01b1300fb5b41c9c11f7291108847"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="Multi-document rendering library using the EFL"
HOMEPAGE="${E_BASE_URI}"
LICENSE="LGPL-3 djvu? ( GPL-2 ) pdf? ( AGPL-3 )"
SLOT="0"
IUSE="cb djvu +pdf postscript tiff"

DEPEND="
	dev-libs/efl
	cb? ( app-arch/libarchive )
	djvu? ( app-text/djvu )
	pdf? (
		app-text/mupdf
		media-libs/freetype
		media-libs/openjpeg:2
		sys-libs/zlib
	)
	postscript? ( app-text/ghostscript-gpl )
	tiff? ( media-libs/tiff:* )
"
# Needed for postscript
#		app-text/xpost

RDEPEND="${DEPEND}"

src_configure() {
	local u MY_CONF=( )
	for u in ${IUSE}; do
		if [[ "${u}" == "postscript" ]]; then
			MY_CONF+=( $(use_enable postscript ps) )
		else
			MY_CONF+=( $(use_enable ${u/+/}) )
		fi
	done
	use djvu && MY_CONF+=( --enable-gpl ) # hopefully temporary
	use pdf && MY_CONF+=( --with-mupdf-shared-libs="-lmupdf" )
	econf "${MY_CONF[@]}"
}
