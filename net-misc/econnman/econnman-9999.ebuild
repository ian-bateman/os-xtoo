# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_TYPE="apps"

inherit e

DESCRIPTION="EFL user interface for the connman connection manager"
HOMEPAGE="https://phab.enlightenment.org/w/projects/${PN}/"
LICENSE="BSD-2"
SLOT="0"

IUSE="doc nls static-libs"

RDEPEND="
	dev-libs/efl
	dev-python/python-efl
	net-misc/connman
"

DEPEND="${RDEPEND}"
