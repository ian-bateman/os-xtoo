# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

CMAKE_MAKEFILE_GENERATOR="emake"
E_BUILD="cmake"
E_TYPE="devs/nikawhite"
if [[ ${PV} != 9999 ]]; then
	SRC_URI="https://git.enlightenment.org/${E_TYPE}/${PN//-/_}.git/snapshot/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/v${PV}"
fi

inherit e

DESCRIPTION="Graphical viewer and analyzer of efl_debug log-files"
HOMEPAGE="https://phab.enlightenment.org/w/projects/efl_profiling_viewer/"
LICENSE="GPL-3"

DEPEND="${DEPEND}
	sys-libs/libunwind
"

RDEPEND="${DEPEND}"
