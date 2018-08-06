# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Mask EFL dependent packages in Gentoo's repo"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/os-xtoo/"
KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}"

src_prepare() {
	local p pkgs

	default
	pkgs=(
		dev-libs/efl
		dev-python/python-efl
		media-gfx/ephoto
		x11-terms/terminology
		x11-wm/enlightenment
	)
	for p in ${pkgs[@]/%/::gentoo}; do
		echo "${p}" >> "${PN}" \
			|| die "Failed to add ${pkg} to ${PN}"
	done
}

src_install() {
	dodir /etc/portage/package.mask
	insinto /etc/portage/package.mask
	doins "${PN}"
}
