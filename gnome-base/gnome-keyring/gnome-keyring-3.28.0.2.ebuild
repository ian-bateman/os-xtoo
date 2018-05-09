# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME2_LA_PUNT="yes"

inherit fcaps gnome2 pam  versionator virtualx

DESCRIPTION="Password and keyring managing daemon"
HOMEPAGE="https://wiki.gnome.org/Projects/GnomeKeyring"
LICENSE="GPL-2+ LGPL-2+"
KEYWORDS="~amd64"
SLOT="0"
IUSE="+caps pam prefix selinux +ssh-agent test"

RDEPEND="
	>=app-crypt/gcr-3.28:=[gtk]
	dev-libs/glib
	app-misc/ca-certificates
	dev-libs/libgcrypt:=
	caps? ( sys-libs/libcap-ng )
	pam? ( virtual/pam )
	selinux? ( sec-policy/selinux-gnome )
	>=app-crypt/gnupg-2.0.28:=
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.5
	dev-libs/libxslt
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
"
PDEPEND="app-crypt/pinentry[gnome-keyring]" #570512

src_prepare() {
	# Disable stupid CFLAGS with debug enabled
	sed -e 's/CFLAGS="$CFLAGS -g"//' \
		-e 's/CFLAGS="$CFLAGS -O0"//' \
		-i configure.ac configure || die

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_with caps libcap-ng) \
		$(use_enable pam) \
		$(use_with pam pam-dir $(getpam_mod_dir)) \
		$(use_enable selinux) \
		$(use_enable ssh-agent) \
		--enable-doc
}

src_test() {
	 "${EROOT}${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/schema" || die
	 GSETTINGS_SCHEMA_DIR="${S}/schema" virtx emake check
}

pkg_postinst() {
	# cap_ipc_lock only needed if building --with-libcap-ng
	# Never install as suid root, this breaks dbus activation, see bug #513870
	use caps && fcaps -m 755 cap_ipc_lock usr/bin/gnome-keyring-daemon
	gnome2_pkg_postinst
}
