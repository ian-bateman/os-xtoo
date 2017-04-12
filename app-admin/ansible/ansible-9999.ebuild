# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from gentoo main tree
# Copyright 1999-2017 Gentoo Foundation

EAPI="6"

MY_PV="v${PV/.${PV: -1}/-${PV: -1}}"
MY_PV="${MY_PV/_rc/-0.${PV: -1}.rc}"
MY_P="${PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	EGIT_BRANCH="devel"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P/v/}"
fi

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils ${ECLASS}

DESCRIPTION="Deployment, config management, and command execution framework"
HOMEPAGE="https://${PN}.com/"
LICENSE="GPL-3"
SLOT="0"
IUSE="keyczar test"

RDEPEND="
	keyczar? ( dev-python/keyczar[${PYTHON_USEDEP}] )
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	app-text/asciidoc
	net-misc/sshpass
	virtual/ssh
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.6[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		<dev-python/mock-1.1[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/unittest2[${PYTHON_USEDEP}]
		dev-vcs/git
	)"

S="${WORKDIR}/${MY_S}"

python_test() {
	nosetests -d -w test/units -v --with-coverage --cover-package=ansible --cover-branches || die
}

python_compile_all() {
	local _man
	for _man in ansible{,-{galaxy,playbook,pull,vault}}; do
		a2x -f manpage docs/man/man1/${_man}.1.asciidoc.in || die "Failed generating man page (${_man})"
	done
}

python_install_all() {
	distutils-r1_python_install_all

	doman docs/man/man1/*.1
}
