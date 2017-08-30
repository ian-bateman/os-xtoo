# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

if [[ ${PV} == *2017* ]]; then
	E_SNAP="13da2313d2abb6a90975ae7153b56b054f8db4cf"
fi
E_TYPE="apps"

inherit e

DESCRIPTION="Feature rich terminal emulator using the EFL"
HOMEPAGE="https://phab.enlightenment.org/w/projects/${PN}/"
LICENSE="BSD-2"
