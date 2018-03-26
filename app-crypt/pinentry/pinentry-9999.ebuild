# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

BASE_URI="https://github.com/gpg/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	if [[ ${PV} =~ 1.1.0.20180107* ]]; then
		MY_PV="bb1c942d375f3c6667288fd08f27450023f9bc50"
		MY_P="${PN}-${MY_PV}"
		SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64"
	else
		MY_P="${P}"
		SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
		KEYWORDS="~amd64"
	fi
	MY_S="${MY_P}"
fi

inherit autotools qmake-utils multilib flag-o-matic toolchain-funcs ${ECLASS}

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://gnupg.org/aegypten2/index.html"

LICENSE="GPL-2"
SLOT="0"
IUSE="emacs efl fltk gtk ncurses qt4 qt5 caps gnome3 gnome-keyring static"

CDEPEND="
	>=dev-libs/libgpg-error-1.17
	>=dev-libs/libassuan-2.1
	>=dev-libs/libgcrypt-1.6.3
	ncurses? ( sys-libs/ncurses:0= )
	efl? ( dev-libs/efl:0 )
	fltk? ( x11-libs/fltk:1 )
	gnome3? ( app-crypt/gcr )
	gnome-keyring? ( app-crypt/libsecret )
	gtk? ( x11-libs/gtk+:2 )
	qt4? (
		>=dev-qt/qtgui-4.4.1:4
	     )
	qt5? (
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	     )
	caps? ( sys-libs/libcap )
	static? ( >=sys-libs/ncurses-5.7-r5:0=[static-libs,-gpm] )
	app-eselect/eselect-pinentry
"

DEPEND="${CDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${CDEPEND}"

REQUIRED_USE="
	|| ( ncurses efl fltk gnome3 gtk qt4 qt5 )
	gnome-keyring? ( || ( gtk gnome3 ) )
	efl? ( !static )
	gtk? ( !static )
	qt4? ( !static )
	qt5? ( !static )
	static? ( ncurses )
	?? ( qt4 qt5 )
"

S="${WORKDIR}/${MY_S}"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )

src_prepare() {
	default
		echo "
@set UPDATED $(date +"%d %B %Y")
@set UPDATED-MONTH $(date +"%d %B")
@set EDITION ${PV}
@set VERSION ${PV}
" > "${S}"/doc/version.texi
	eautoreconf
}

src_configure() {
	local myconf=()
	use static && append-ldflags -static
	append-cxxflags -std=gnu++11

	if use qt4; then
		myconf+=(
			--enable-pinentry-qt
			--disable-pinentry-qt5
		)
		export MOC="$(qt4_get_bindir)"/moc
		export QTLIB="$(qt4_get_libdir)"
	elif use qt5; then
		myconf+=( --enable-pinentry-qt )
		export MOC="$(qt5_get_bindir)"/moc
		export QTLIB="$(qt5_get_libdir)"
	else
		myconf+=( --disable-pinentry-qt )
	fi

	econf \
		--enable-pinentry-tty \
		$(use_enable emacs pinentry-emacs) \
		$(use_enable efl pinentry-efl) \
		$(use_enable fltk pinentry-fltk) \
		$(use_enable gtk pinentry-gtk2) \
		$(use_enable ncurses pinentry-curses) \
		$(use_enable ncurses fallback-curses) \
		$(use_with caps libcap) \
		$(use_enable gnome-keyring libsecret) \
		$(use_enable gnome-keyring pinentry-gnome3) \
		"${myconf[@]}"
}

src_install() {
	default
	rm -f "${ED}"/usr/bin/pinentry || die

	if use qt4 || use qt5; then
		dosym pinentry-qt /usr/bin/pinentry-qt4
	fi
}

pkg_postinst() {
	if ! has_version 'app-crypt/pinentry' || has_version '<app-crypt/pinentry-0.7.3'; then
		elog "We no longer install pinentry-curses and pinentry-qt SUID root by default."
		elog "Linux kernels >=2.6.9 support memory locking for unprivileged processes."
		elog "The soft resource limit for memory locking specifies the limit an"
		elog "unprivileged process may lock into memory. You can also use POSIX"
		elog "capabilities to allow pinentry to lock memory. To do so activate the caps"
		elog "USE flag and add the CAP_IPC_LOCK capability to the permitted set of"
		elog "your users."
	fi

	eselect pinentry update ifunset
}

pkg_postrm() {
	eselect pinentry update ifunset
}
