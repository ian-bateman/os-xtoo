# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from gentoo main tree
# Copyright 1999-2017 Gentoo Foundation

EAPI="6"

E_BUILD="meson"
if [[ ${PV} == *9999* ]]; then
	E_TYPE="core"
else
	E_TYPE="apps"
fi

inherit e

HOMEPAGE="https://docs.enlightenment.org"
DESCRIPTION="Enlightenment Window manager"
LICENSE="BSD-2"
S="${WORKDIR}/${P/_/-}"

__CONF_MODS=(
	applications bindings dialogs display
	interaction intl menus
	paths performance randr shelves theme
	window-manipulation window-remembers
)
__NORM_MODS=(
	appmenu backlight battery
	clock conf cpufreq everything
	fileman fileman-opinfo gadman geolocation
	ibar ibox lokker
	mixer msgbus music-control notification
	pager packagekit pager-plain policy-mobile quickaccess
	shot start syscon systray tasks teamwork temperature tiling time
	winlist wizard wl-desktop-shell wl-drm wl-text-input
	wl-weekeyboard wl-wl wl-x11 xkbswitch xwayland
)
IUSE_E_MODULES=(
	${__CONF_MODS[@]/#/enlightenment_modules_conf-}
	${__NORM_MODS[@]/#/enlightenment_modules_}
)

IUSE="acpi bluetooth connman doc egl nls pam spell static-libs systemd udisks
	wayland wifi ${IUSE_E_MODULES[@]/#/+}"

REQUIRED_USE="
	egl? ( wayland )
	wayland? ( egl )
	wifi? ( connman )
"

DEPEND="
	acpi? ( sys-power/acpid )
	bluetooth? ( net-wireless/bluez )
	connman? ( net-misc/econnman )
	pam? ( sys-libs/pam )
	systemd? ( sys-apps/systemd )
	wayland? (
		!systemd? ( sys-auth/elogind )
		dev-libs/efl[egl,gles2,wayland]
		>=dev-libs/wayland-1.10.0
		>=x11-libs/pixman-0.31.1
		>=x11-libs/libxkbcommon-0.3.1
	)
	>=dev-libs/efl-1.18[X]
	udisks? ( sys-fs/udisks:2 )
	x11-base/xorg-x11
	x11-libs/xcb-util-keysyms
	x11-themes/hicolor-icon-theme
	virtual/udev
"

RDEPEND="${DEPEND}"

if [[ ${PV} == 0.22.0_beta ]]; then
	PATCHES=( "${FILESDIR}/meson-sh.patch" )
fi

src_configure() {
	E_ECONF=(
		-Dbluez4=$(usex bluetooth true false)
		-Dconnman=$(usex connman true false)
		-Ddevice-udev=true
		-Dwayland-egl=$(usex egl true false)
		-Dfiles=true
		-Dinstall-sysactions=false
		-Dinstall-enlightenment-menu=true
		-Dmount-eeze=false
		-Dmount-udisks=$(usex udisks true false)
		-Dpam=$(usex pam true false)
		-Dsystemd=$(usex systemd true false)
		-Dwayland=$(usex wayland true false)
		-Dwireless=$(usex wifi true false)
	)
	local u c
	for u in ${IUSE_E_MODULES[@]} ; do
		c=${u#enlightenment_modules_}
		# Disable modules by hand since we default to enabling them all.
		case ${c} in
		wl-*|xwayland)
			if ! use wayland ; then
				E_ECONF+=( -D${c}=false )
				continue
			fi
			;;
		esac
		E_ECONF+=( -D${c}=$(usex ${u} true false) )
	done
	e_src_configure
}

src_install() {
	e_src_install
	insinto /etc/enlightenment
	newins "${FILESDIR}"/gentoo-sysactions.conf sysactions.conf
}
