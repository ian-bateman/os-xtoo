# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

BASE_URI="https://github.com/DaveMDS/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

PYTHON_COMPAT=( python{3_4,3_6} pypy )

inherit eutils distutils-r1 ${ECLASS}

DESCRIPTION="Emotion Media Center"
HOMEPAGE="${BASE_URI}/${PN}/wiki"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-python/beautifulsoup:4
	dev-python/dbus-python
	dev-python/lxml
	dev-python/python-efl
	dev-python/pyudev
	media-libs/libdiscid
	media-libs/mutagen
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

DOCS=( README.md )

src_prepare() {
	default
	sed -i -e "s|/usr/s|s|" setup.py || die "Could not sed setup.py"
	sed -i -e "s|Icon=epymc|Icon=/usr/share/icons/hicolor/64x64/apps/epymc.png|" \
		data/desktop/epymc_xsession.desktop \
		|| die "Failed to sed/fix epymc_xsession.desktop Icon"
}
