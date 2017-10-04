# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/wfx/${PN}"
E_GIT_URI="${E_BASE_URI}.git"
E_SNAP="8edf7142d917eecd026d2e298a347897631eeba4"
E_PYTHON=1

inherit e

if [[ ${PV} != *9999* ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${E_BASE_URI}/archive/${E_SNAP}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}/"
fi

DESCRIPTION="Lightdm Greeter in python-efl"
HOMEPAGE="${E_BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-python/python-efl
	x11-misc/lightdm
"

RDEPEND="${DEPEND}"
