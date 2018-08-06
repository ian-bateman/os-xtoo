# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Install package env files in /etc/portage for debug symbols"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/os-xtoo/"
KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}"

CONF="debug.conf"
PKGS="debug"

src_prepare() {
	local p pkgs

	default
	pkgs=(
		dev-libs/efl
		sys-libs/glibc
		x11-wm/enlightenment
	)
	for p in "${pkgs[@]}"; do
		echo "${p} ${CONF}" >> "${PKGS}" \
			|| die "Failed to create ${PKGS}"
	done
}

src_install() {
	dodir /etc/portage/{,package.}env

	insinto /etc/portage/env
	doins "${FILESDIR}/${CONF}"

	insinto /etc/portage/package.env
	doins "${PKGS}"
}
