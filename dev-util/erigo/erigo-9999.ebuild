# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_CMAKE="yes"
E_TYPE="tools"

inherit e

DESCRIPTION="The EFL GUI Builder"
HOMEPAGE="https://phab.enlightenment.org/w/projects/gui_builder/"
LICENSE="BSD-2"

# No version builds or work with EFL 1.18 or 1.19, forcing all to **
KEYWORDS=""

if [[ ${PV} == 1.0.0 ]]; then
	MY_P="${PN}-6dd3deebdad9fc8106f1fe065d2c7062f986320c"
	SRC_URI="https://git.enlightenment.org/tools/erigo.git/snapshot/${MY_P}.tar.xz"
	S="${WORKDIR}/${MY_P}"
fi

DEPEND="${DEPEND}
	media-gfx/graphviz
"

RDEPEND="${RDEPEND}
	dev-libs/libffi
"
