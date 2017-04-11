# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from enlightenment-live overlay
# Copyright 1999-2016 Gentoo Foundation

EAPI="6"

E_PKG_IUSE="examples"
E_PYTHON="yes"

PYTHON_COMPAT=( python{3_2,3_4,3_6} pypy2_0 )

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="https://git.enlightenment.org/bindings/${PN}.git"
else
	SRC_URI="http://download.enlightenment.org/rel/bindings/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit eutils distutils-r1 ${ECLASS}

DESCRIPTION="Python bindings for EFL"
HOMEPAGE="http://www.enlightenment.org/about-epour"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="doc"

if [[ ${PV} == 1.18.0 ]]; then
	RDEPEND="=dev-libs/efl-1.18.4"
else
	RDEPEND="dev-libs/efl"
fi

RDEPEND="
	>=dev-python/cython-0.21
	>=dev-python/dbus-python-1.2.0-r1
	${RDEPEND}
	doc? ( dev-python/sphinx )
	${PYTHON_DEPS}
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"
