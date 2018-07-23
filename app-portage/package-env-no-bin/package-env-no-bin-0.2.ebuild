# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Install package env files in /etc/portage to prevent making bins"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/os-xtoo/"
KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}"

CONF="no-binpkg.conf"
PKGS="no-binpkgs"

src_prepare() {
	local conf p pkgs

	default

	conf="no-binpkg.conf"
	echo 'FEATURES="-buildpkg"' > "${CONF}" \
		|| die "Failed to create ${CONF}"

	pkgs=(
		app-office/openoffice-bin
		dev-java/openjdk-bin
		dev-java/oracle-jdk-bin
		dev-util/android-studio-bin
		sys-kernel/gentoo-sources
		www-plugins/adobe-flash
	)
	for p in "${pkgs[@]}"; do
		echo "${p} ${CONF}" >> "${PKGS}" \
			|| die "Failed to create ${PKGS}"
	done
}

src_install() {
	dodir /etc/portage/{,package.}env

	insinto /etc/portage/env
	doins "${CONF}"

	insinto /etc/portage/package.env
	doins "${PKGS}"
}
