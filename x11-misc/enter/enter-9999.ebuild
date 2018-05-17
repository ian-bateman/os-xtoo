# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/wfx/${PN}"
E_PYTHON=1
E_SNAP="8edf7142d917eecd026d2e298a347897631eeba4"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="Lightdm Greeter in python-efl"
HOMEPAGE="${E_BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-python/python-efl
	x11-misc/lightdm
"

RDEPEND="${DEPEND}"
