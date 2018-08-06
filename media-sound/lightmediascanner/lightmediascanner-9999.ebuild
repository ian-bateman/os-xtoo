# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools

MY_PN="release"
MY_PV="${PV}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/profusion/${PN}"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
	inherit git-r3
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

DESCRIPTION="Lightweight media scanner"
HOMEPAGE="${BASE_URI}"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="asf audio-dummy dummy flac generic id3 jpeg m3u mp4 nls ogg pls png rm video-dummy wave"

DEPEND="
	mp4? ( media-libs/libmp4v2 )
"

S="${WORKDIR}/${MY_S}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local u MY_CONF=( )
	for u in ${IUSE}; do
		MY_CONF+=( $(use_enable ${u/+/}) )
	done
	econf ${MY_CONF[@]}
}
