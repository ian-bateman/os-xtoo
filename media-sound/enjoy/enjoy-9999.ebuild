# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_SNAP="a6c788f62f413219d8913e762650234e52a746b7"
E_TYPE="apps"

inherit e

DESCRIPTION="EFL Music player"
HOMEPAGE="https://git.enlightenment.org/apps/${PN}.git"
LICENSE="GPL-3"
IUSE+="albumart-lastfm mpris"

DEPEND+="
	dev-db/sqlite:3
	media-sound/lightmediascanner[id3]
"

RDEPEND="${DEPEND}"
