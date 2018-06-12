# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils java-vm prefix

SLOT="${PV%%.*}"
[[ ${SLOT} == *_* ]] && SLOT="${PV%%_*}"

MY_PN="${PN%%-*}${SLOT}"
BASE_URI="https://download"
RESTRICT="preserve-libs strip"

if [[ ${PV} == *_pre* ]]; then
	JDK_URI="http://jdk.java.net/${SLOT}/"
	BASE_URI+=".java.net/java/early_access/${MY_PN}/${PV##*_pre}/binaries"
	MY_PV="${PV%%_*}-ea+${PV##*_pre}"
elif [[ ${PV} == *_rc* ]]; then
	JDK_URI="http://jdk.java.net/${SLOT}/"
	BASE_URI+=".java.net/java/${MY_PN}/archive/${PV##*_rc}/binaries"
	MY_PV="${PV%%_*}+${PV##*_rc}"
fi
if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/${PN%%-*}-${MY_PV}_linux-x64_bin-sdk.zip"
	KEYWORDS="-* ~amd64"
else
	KEYWORDS="-amd64"
fi

DESCRIPTION="OpenJFX client application platform for desktop and embedded"
HOMEPAGE="https://wiki.openjdk.java.net/display/OpenJFX/Main"
LICENSE="GPL-2-with-classpath-exception"

IUSE="gtk2 gtk3"
REQUIRED_USE="|| ( gtk2 gtk3 )"
QA_PREBUILT="*"

DEPEND="app-arch/zip"

RDEPEND="
	dev-java/oracle-jdk-bin:${SLOT}
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/libxml2:2
	dev-libs/libxslt
	media-libs/freetype:2
	x11-libs/gdk-pixbuf
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/pango
	virtual/opengl
	gtk2? (
		x11-libs/cairo
		x11-libs/gtk+:2
	)
	gtk3? (
		x11-libs/cairo[glib]
		x11-libs/gtk+:3
	)
"

S="${WORKDIR}/javafx-sdk-${SLOT}"

src_prepare() {
	default

	rm lib/libavplugin* || die "Failed to remove libavplugin*.so"

	if ! use gtk2 ; then
		rm lib/libglassgtk2.* || die
	elif ! use gtk3 ; then
		rm lib/libglassgtk3.* || die
	fi
}

src_install() {
	local dest ddest

	dest="/opt/${P}"
	ddest="${ED}${dest#/}"

	dodoc -r legal
	dodir "${dest}"
	cp -pPR lib "${ddest}" || die "Failed to copy pre-built binary files"
}
