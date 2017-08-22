# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

[[ ${PV} != 0.2.1* ]] && E_MESON=1

E_TYPE="apps"

inherit e

DESCRIPTION="This is a Video + Audio player mplayer style, based on EFL"
HOMEPAGE="https://www.enlightenment.org/about-rage"
LICENSE="BSD-2"
