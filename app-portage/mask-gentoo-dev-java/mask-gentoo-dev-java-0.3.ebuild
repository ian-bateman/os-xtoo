# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Mask all dev-java/* packages in Gentoo's repo"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/os-xtoo/"
KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}"

src_prepare() {
	default
	echo 'dev-java/*::gentoo' > "${PN}" || die "Failed to create ${PV}"
}

src_install() {
	dodir /etc/portage/package.mask
	insinto /etc/portage/package.mask
	doins "${PN}"
}
