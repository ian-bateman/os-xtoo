# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

[[ ${PV} == *2017* ]] && E_SNAP="b76a54bd3ee93fe9d529e577251a1d5fc6b32d1a"
E_TYPE="apps"

inherit e

DESCRIPTION="Enlightenment image viewer built on the EFL."
HOMEPAGE="http://www.smhouston.us/${PN}/"
LICENSE="BSD-2"
