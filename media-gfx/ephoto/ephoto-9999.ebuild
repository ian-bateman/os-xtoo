# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

[[ ${PV} == 1.5* ]] && SRC_URI="http://www.smhouston.us/stuff/${P}.tar.gz"
E_TYPE="apps"

inherit e

DESCRIPTION="Enlightenment image viewer built on the EFL."
HOMEPAGE="http://www.smhouston.us/${PN}/"
LICENSE="BSD-2"
