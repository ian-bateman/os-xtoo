# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/vtorri/etui"
E_GIT_URI="${E_BASE_URI}.git"
E_SNAP="7e29b8e49cb98f33d825d30ea573f154fa584a7d"

inherit e

if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${E_BASE_URI}/archive/${E_SNAP}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Multi-document rendering library using the EFL"
HOMEPAGE="${E_BASE_URI}"
LICENSE="GPL-3"
SLOT="0"
IUSE="cb djvu +pdf postscript tiff"

S="${WORKDIR}/${MY_P}/"

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
	postscript? (
		app-text/ghostscript-gpl
	)
	tiff? ( media-libs/tiff:* )
"
# Needed for postscript
#		app-text/xpost

RDEPEND="${DEPEND}"

src_configure() {
	local u MY_CONF=( --enable-gpl )
	for u in ${IUSE}; do
		if [[ "${u}" == "postscript" ]]; then
			MY_CONF+=( $(use_enable postscript ps) )
		else
			MY_CONF+=( $(use_enable ${u/+/}) )
		fi
	done
	use pdf && MY_CONF+=( --with-mupdf-shared-libs="-lmupdf" )
	econf "${MY_CONF[@]}"
}
