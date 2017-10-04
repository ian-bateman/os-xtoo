# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

BASE_URI="https://github.com/JeffHoogland/${PN}"
EGIT_REPO_URI="${BASE_URI}.git"
E_PYTHON=1

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit e

DESCRIPTION="Library with complex elementary objects for easy importing/usage"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"
SLOT="0"

src_prepare() {
	default
	cd "${S}" || die

	echo "#!/usr/bin/env python

from distutils.core import setup

setup(name='${PN}',
	version='${PV}',
	description='${DESCRIPTION}',
	url='${HOMEPAGE}',
	packages=['elmextensions'],
	py_modules=['sortedlistother.sortedlist'],
	)" > setup.py || die "Failed to write setup.py"
}
