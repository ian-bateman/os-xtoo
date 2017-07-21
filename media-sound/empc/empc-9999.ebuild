# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

if [[ ${PV} == 9999 ]]; then
	ECLASS="autotools git-r3"
	EGIT_REPO_URI="https://git.enlightenment.org/apps/${PN}.git"
else
	SRC_URI="http://download.enlightenment.org/rel/apps/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit eutils ${ECLASS}

DESCRIPTION="EMPC is a client for the Music Player Daemon written using EFL"
HOMEPAGE="https://phab.enlightenment.org/w/projects/${PN}/"
LICENSE="BSD-2"
SLOT="0"

IUSE="doc glyr id3tag nls static-libs"

RDEPEND="
	dev-libs/efl
	glyr? ( media-libs/glyr )
	id3tag? ( media-libs/libid3tag )
	media-libs/libmpdclient
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
	default
	[[ ${PV} = 9999 ]] && eautoreconf
}

src_configure() {
	local config=(
		$(use_enable glyr)
		$(use_enable id3tag)
		$(use_enable nls)
		$(use_enable static-libs static)
	)

	econf "${config[@]}"
}

src_install() {
	default
	prune_libtool_files
}
