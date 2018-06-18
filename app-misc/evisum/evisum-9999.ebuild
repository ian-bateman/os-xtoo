# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_TYPE="apps"

inherit desktop e

DESCRIPTION="A process viewer in EFL"
HOMEPAGE="${E_GIT_URI}/apps/${PN}.git"
LICENSE="BSD-2"

src_configure() {
:
}

src_install() {
	domenu data/evisum.desktop
	doicon data/evisum.png
	dobin evisum
}
