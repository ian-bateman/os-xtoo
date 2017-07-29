# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

[[ ${PV} == *2017* ]] && E_SNAP="932654f53022dcd116f66096482b98e138f1b032"

if [[ ${PV} == 9999 ]] || [[ ${PV} == *2017* ]]; then
	E_TYPE="tools"
else
	E_TYPE="apps"
fi

inherit e

DESCRIPTION="EFL Edje Theme Editor"
HOMEPAGE="https://phab.enlightenment.org/w/projects/${PN}/"
LICENSE="BSD-2"

if [[ ${PV} != 9999 ]] && [[ ${PV} != *2017* ]]; then
	DEPEND="=dev-libs/efl-${PV}"
	RDEPEND="${RDEPEND}"
fi
