# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from enlightenment-live overlay
# Copyright 1999-2016 Gentoo Foundation

EAPI="6"

if [[ ${PV} == *9999* ]]; then
	E_TYPE="core"
else
	E_TYPE="libs"
fi

inherit autotools e

DESCRIPTION="Enlightenment Foundation Core Libraries"
HOMEPAGE="https://www.enlightenment.org/"
LICENSE="BSD-2 GPL-2 LGPL-2.1 ZLIB"
SLOT="0"

IUSE="+X avahi +bmp cxx-bindings debug doc drm egl elogind fbcon
	+fontconfig fribidi gif +gles2 glib gnutls gstreamer harfbuzz +ico ibus
	jpeg2k libressl neon oldlua nls opengl ssl pdf physics pixman +png +ppm
	postscript psd pulseaudio rawphoto scim sdl sound static-libs +svg
	systemd test tga tiff tslib v4l2 vlc wayland webp xim xine xpm"

REQUIRED_USE="
	X		( || ( gles2 opengl ) )
	pulseaudio?	( sound )
	opengl?		( || ( X sdl wayland ) )
	|| ( elogind systemd )
	gles2?		( egl !sdl || ( X wayland ) )
	sdl?		( opengl )
	wayland?	( egl gles2 !opengl )
	xim?		( X )
	|| ( X wayland )
"

COMMON_DEP="
	drm? (
		>=dev-libs/libinput-0.8
		media-libs/mesa[gbm]
		>=x11-libs/libdrm-2.4
		>=x11-libs/libxkbcommon-0.3.0
	)
	dev-lang/luajit:2
	sys-apps/dbus
	sys-libs/zlib
	virtual/jpeg:*
	virtual/udev
	X? (
		x11-libs/libX11
		x11-libs/libXScrnSaver
		x11-libs/libXcomposite
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXtst
		gles2? (
			media-libs/mesa[egl,gles2]
			x11-libs/libXrender
		)
		opengl? (
			virtual/opengl
			x11-libs/libXrender
		)
	)
	avahi? ( net-dns/avahi )
	debug? ( dev-util/valgrind )
	elogind? ( sys-auth/elogind )
	fontconfig? ( media-libs/fontconfig )
	fribidi? ( dev-libs/fribidi )
	gif? ( media-libs/giflib )
	glib? ( dev-libs/glib:* )
	gnutls? ( net-libs/gnutls )
	!gnutls? ( ssl? ( dev-libs/openssl:* ) )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
	)
	vlc? ( media-video/vlc )
	harfbuzz? ( media-libs/harfbuzz )
	ibus? ( app-i18n/ibus )
	jpeg2k? ( media-libs/openjpeg:0 )
	nls? ( sys-devel/gettext )
	!oldlua? ( >=dev-lang/luajit-2.0.0 )
	oldlua? ( dev-lang/lua:* )
	pdf? ( app-text/poppler )
	physics? ( sci-physics/bullet )
	pixman? ( x11-libs/pixman )
	postscript? ( app-text/libspectre:* )
	png? ( media-libs/libpng:0= )
	pulseaudio? (
		media-sound/pulseaudio
		media-libs/libsndfile
	)
	rawphoto? ( media-libs/libraw )
	scim?	( app-i18n/scim )
	sdl? (
		>=media-libs/libsdl2-2.0.0:0[opengl?,gles]
	)

	svg? ( gnome-base/librsvg )
	sound? ( media-libs/libsndfile )
	systemd? ( sys-apps/systemd )
	tiff? ( media-libs/tiff:0 )
	tslib? ( x11-libs/tslib )
	wayland? (
		>=dev-libs/wayland-1.3.0:0
		>=x11-libs/libxkbcommon-0.3.1
		egl? ( media-libs/mesa[egl,gles2] )
	)
	webp? ( media-libs/libwebp )
	xine? ( >=media-libs/xine-lib-1.1.1 )
	xpm? ( x11-libs/libXpm )"
DEPEND="${COMMON_DEP}
	doc? ( app-doc/doxygen )
	test? ( dev-libs/check )"
RDEPEND="${COMMON_DEP}"

S="${WORKDIR}/${E_P}"

src_prepare() {
	default
	if use elogind ; then
		eapply "${FILESDIR}/elogind.patch"
		rm configure || die "Remove configure for regeneration"
		eautoreconf
	fi
}

src_configure() {
	local config=()

	# elogind / systemd
	if use elogind || use systemd; then
		config+=( --enable-systemd )
	else
		config+=( --disable-systemd )
	fi

	# gnutls / openssl
	if use gnutls; then
		config+=( --with-crypto=gnutls )
		use ssl && \
			einfo "You enabled both USE=ssl and USE=gnutls, using gnutls"
	elif use ssl; then
		config+=( --with-crypto=openssl )
	else
		config+=( --with-crypto=none )
	fi

	# X
	config+=(
		$(use_with X x)
		$(use_with X x11 xlib)
	)
	if use opengl; then
		config+=( --with-opengl=full )
		use gles2 &&  \
			einfo "You enabled both USE=opengl and USE=gles2, using opengl"
	elif use gles2; then
		config+=( --with-opengl=es )
		if use sdl; then
			config+=( --with-opengl=none )
			ewarn "You enabled both USE=sdl and USE=gles2 which isn't currently supported."
			ewarn "Disabling gl for all backends."
		fi
	else
		config+=( --with-opengl=none )
	fi

	# Handle vlc
	if use vlc; then
		has_version '>=media-video/vlc-3.0.0' && config+=( --enable-libvlc )
		has_version '<media-video/vlc-3.0.0' && config+=( --with-generic_vlc )
	fi

	config+=(
		$(use_enable avahi)
		$(use_enable bmp image-loader-bmp)
		$(use_enable bmp image-loader-wbmp)
		$(use_enable cxx-bindings cxx-bindings)
		$(use_enable drm)
		$(use_enable drm gl-drm)
		$(use_enable doc)
		$(use_enable egl)
		$(use_enable fbcon fb)
		$(use_enable fontconfig)
		$(use_enable fribidi)
		$(use_enable gif image-loader-gif)
		$(use_enable gstreamer gstreamer1)
		$(use_enable harfbuzz)
		$(use_enable ico image-loader-ico)
		$(use_enable jpeg2k image-loader-jp2k)
		$(use_enable neon)
		$(use_enable ibus)
		$(use_enable nls)
		$(use_enable oldlua lua-old)
		$(use_enable pdf poppler)
		$(use_enable physics)
		# bug 501074. Is it still valid?
		# seems so https://phab.enlightenment.org/T4964#80912
		$(use_enable pixman)
		$(use_enable pixman pixman-font)
		$(use_enable pixman pixman-rect)
		$(use_enable pixman pixman-line)
		$(use_enable pixman pixman-poly)
		$(use_enable pixman pixman-image)
		$(use_enable pixman pixman-image-scale-sample)
		$(use_enable png image-loader-png)
		$(use_enable ppm image-loader-pmaps)
		$(use_enable postscript spectre)
		$(use_enable psd image-loader-psd)
		$(use_enable pulseaudio)
		$(use_enable pulseaudio audio)
		$(use_enable pulseaudio multisense)
		$(use_enable rawphoto libraw)
		$(use_enable scim)
		$(use_enable sdl)
		$(use_enable static-libs static)
		$(use_enable svg librsvg)
		$(use_enable tga image-loader-tga)
		$(use_enable tiff image-loader-tiff)
		$(use_enable tslib)
		$(use_enable v4l2)
		$(use_enable wayland)
		$(use_enable webp image-loader-webp)
		$(use_enable xpm image-loader-xpm)
		$(use_enable xim)
		$(use_enable xine)

		# image loaders
		--enable-image-loader-eet
		--enable-image-loader-generic
		--enable-image-loader-ico
		--enable-image-loader-jpeg # required by ethumb
		--enable-image-loader-tga
		--enable-image-loader-wbmp

		--enable-cserve
		--enable-libmount
		--enable-threads
		--enable-xinput22

		--disable-gstreamer # using gstreamer1
		#--disable-lua-old
		--disable-tizen
		--disable-gesture
		--enable-elput
		--disable-xpresent

		--with-profile=$(usex debug debug release)
		--with-glib=$(usex glib yes no)
		--with-tests=$(usex test regular none)

#		--enable-i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba
		--enable-i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-abb
	)

	econf "${config[@]}"
}

src_test() {
	MAKEOPTS+=" -j1"
	default
}

src_install() {
	MAKEOPTS+=" -j1"
	default
	prune_libtool_files
}
