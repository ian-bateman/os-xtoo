# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_PKG_IUSE="examples"
E_PYTHON="yes"
E_TYPE="bindings"

inherit e

DESCRIPTION="Python bindings for EFL"
HOMEPAGE="https://phab.enlightenment.org/w/projects/python_bindings_for_efl/"
SRC_URI="${SRC_URI/${E_TYPE}\/${PN}/${E_TYPE}/python}"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc"

DEPEND="
	>=dev-python/cython-0.21
	>=dev-python/dbus-python-1.2.0-r1
	${RDEPEND}
	doc? ( dev-python/sphinx )
	${PYTHON_DEPS}
"

RDEPEND="${DEPEND}"
