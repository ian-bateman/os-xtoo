# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_SNAP="455980eb0bbebb11b8db3c992168cd657315ed52"
E_TYPE="misc"

inherit autotools e

DESCRIPTION="EFL Display manager for the X Window System"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/entrance"
LICENSE="GPL-3"
IUSE="grub2 systemd"

DEPEND="
	x11-apps/xdm
	systemd? ( sys-apps/systemd )
	sys-auth/consolekit
	grub2? ( sys-boot/grub:2 )
	sys-libs/pam
"

RDEPEND="${DEPEND}"

if [[ ${PV} != 9999 ]]; then
	MY_P="${PN}-${E_SNAP}"
	SRC_URI="${HOMEPAGE}/archive/${E_SNAP}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
fi

src_prepare() {
	default
	eautoreconf

}

src_configure() {
	local u MY_CONF=()
	for u in ${IUSE}; do
		MY_CONF+=( $(use_enable ${u/+/}) )
	done
	econf "${MY_CONF[@]}"
}
