# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

if [[ ${PV} == 9999 ]]; then
	E_TYPE="tools"
else
	E_TYPE="apps"
fi

inherit e

DESCRIPTION="EFL Edje Theme Editor"
HOMEPAGE="https://phab.enlightenment.org/w/projects/${PN}/"
LICENSE="BSD-2"

if [[ ${PV} == 0.7.0 ]]; then
	DEPEND="=dev-libs/efl-1.18.4"
else
	DEPEND="dev-libs/efl"
fi

RDEPEND="${RDEPEND}"
