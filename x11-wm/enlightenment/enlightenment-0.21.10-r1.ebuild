# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from gentoo main tree
# Copyright 1999-2017 Gentoo Foundation

EAPI="6"

E_TYPE="apps"

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
"

RDEPEND="${DEPEND}"

# Sanity check to make sure module lists are kept up-to-date.
# Needs to be modified for USE modules, bluetooth, connman, and wifi
check_modules() {
	local detected=$(
		awk -F'[\\[\\](, ]' '$1 == "AC_E_OPTIONAL_MODULE" { print $3 }' \
		configure.ac | sed 's:_:-:g' | LC_COLLATE=C sort
	)
	local sorted=$(
		printf '%s\n' ${IUSE_E_MODULES[@]/#enlightenment_modules_} | \
		LC_COLLATE=C sort
	)
	if [[ ${detected} != "${sorted}" ]] ; then
		local out new old
		eerror "The ebuild needs to be kept in sync."
		echo "${sorted}" > ebuild-iuse
		echo "${detected}" > configure-detected
		out=$(diff -U 0 ebuild-iuse configure-detected | sed -e '1,2d' -e '/^@@/d')
		new=$(echo "${out}" | sed -n '/^+/{s:^+::;p}')
		old=$(echo "${out}" | sed -n '/^-/{s:^-::;p}')
		eerror "Add these modules: $(echo ${new})"
		eerror "Drop these modules: $(echo ${old})"
		die "please update the ebuild"
	fi
}

src_configure() {
#	check_modules

	E_ECONF=(
		--disable-install-sysactions
		$(use_enable bluetooth bluez4)
		$(use_enable connman )
		$(use_enable doc)
		$(use_enable nls)
		$(use_enable pam)
		$(use_enable systemd)
		--enable-device-udev
		$(use_enable udisks mount-udisks)
		$(use_enable egl wayland-egl)
		$(use_enable wayland)
		$(use_enable wifi wireless)
	)
	local u c
	for u in ${IUSE_E_MODULES[@]} ; do
		c=${u#enlightenment_modules_}
		# Disable modules by hand since we default to enabling them all.
		case ${c} in
		wl-*|xwayland)
			if ! use wayland ; then
				E_ECONF+=( --disable-${c} )
				continue
			fi
			;;
		esac
		E_ECONF+=( $(use_enable ${u} ${c}) )
	done
	e_src_configure
}

src_install() {
	e_src_install
	insinto /etc/enlightenment
	newins "${FILESDIR}"/gentoo-sysactions.conf sysactions.conf
}
