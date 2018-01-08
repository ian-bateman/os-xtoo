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
	elif [[ ${PV} =~ 1.0.1.20170308* ]]; then
		MY_PV="4101806bf73caf25c8ce4e455b154901da1fe788"
		MY_P="${PN}-${MY_PV}"
		MY_PATCH="69e67861cd1026da063e4d86ccdd071fba804fad"
		SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
			https://github.com/Obsidian-StudiosInc/pinentry/commit/${MY_PATCH}.patch -> ${P}-efl.patch"
		KEYWORDS="~amd64"
	else
		MY_P="${P}"
		SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
		KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
	fi
	MY_S="${MY_P}"
fi

inherit autotools qmake-utils multilib flag-o-matic toolchain-funcs ${ECLASS}

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://gnupg.org/aegypten2/index.html"

LICENSE="GPL-2"
SLOT="0"
IUSE="emacs efl gtk ncurses qt4 qt5 caps gnome-keyring static"

CDEPEND="
	>=dev-libs/libgpg-error-1.17
	>=dev-libs/libassuan-2.1
	>=dev-libs/libgcrypt-1.6.3
	ncurses? ( sys-libs/ncurses:0= )
	efl? ( dev-libs/efl:0 )
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
	gnome-keyring? ( app-crypt/libsecret )
"

DEPEND="${CDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="
	${CDEPEND}
	gnome-keyring? ( app-crypt/gcr )
"

REQUIRED_USE="
	|| ( ncurses efl gtk qt4 qt5 )
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
	if use efl && [[ ${PV} == 1.0.1.20170308* ]]; then
		eapply "${DISTDIR}/${P}-efl.patch"
		# delete hack that negates value from pinentry_inq_quality
		sed -i -e '128,131d' efl/pinentry-efl.c \
			|| die "Failed to remove quality hack"
	fi
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
	[[ "$(gcc-major-version)" -ge 5 ]] && append-cxxflags -std=gnu++11

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
