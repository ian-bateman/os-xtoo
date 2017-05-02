# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

BASE_URI="https://github.com/wfx/${PN}"
E_SNAP="55b2c82a744e9eb7dfddecbec97874ff913ecd73"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
#	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

PYTHON_COMPAT=( python{3_4,3_6} pypy2_0 )

#inherit eutils python-r1 ${ECLASS}
inherit eutils distutils-r1 ${ECLASS}

DESCRIPTION="A tiny file extractor"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	app-arch/libarchive
	dev-python/python-efl
	dev-python/python-elm-extensions
	dev-python/python-magic
"

RDEPEND="${DEPEND}"

if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${HOMEPAGE}/archive/${E_SNAP}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
fi

#src_install() {
#	default
#	dobin bin/epack
#	domenu data/desktop/${MY_PN}.desktop
#}
