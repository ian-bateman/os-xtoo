# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_TYPE="apps"

inherit e

DESCRIPTION="An EFL based / focussed IDE"
HOMEPAGE="https://phab.enlightenment.org/w/projects/${PN}/"
LICENSE="BSD-2"
SLOT="0"

IUSE="doc nls static-libs"

if [[ ${PV} == 0.4.0 ]]; then
	RDEPEND="=dev-libs/efl-1.18.4"
else
	RDEPEND="dev-libs/efl"
fi

DEPEND="${RDEPEND}"
