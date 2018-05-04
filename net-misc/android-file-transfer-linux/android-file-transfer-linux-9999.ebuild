# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

BASE_URI="https://github.com/whoozle/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils ${ECLASS}

DESCRIPTION="Reliable MTP client with minimalistic UI"
HOMEPAGE="https://whoozle.github.io/${PN}/"
LICENSE="GPL-2"
SLOT="0"

IUSE="fuse qt5"

RDEPEND="
	fuse? ( sys-fs/fuse:* )
	qt5? (
		|| (
			dev-qt/qtwidgets:5
			dev-qt/qtgui:5
		)
	)
"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT_UI=$(usex qt5)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use qt5; then
		make_desktop_entry android-file-transfer \
			"Android File Transfer For Linux"
	fi
}
