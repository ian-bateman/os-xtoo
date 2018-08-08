# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit desktop eapi7-ver eutils java-pkg

RESTRICT="strip"
QA_PREBUILT="
	opt/${PN}/bin/libbreakgen*.so
	opt/${PN}/bin/fsnotifier*
	opt/${PN}/lib/libpty/linux/x86*/libpty.so
	opt/${PN}/plugins/android/lib/libwebp_jni*.so
	opt/${PN}/plugins/android/resources/perfa/*/libperfa.so
	opt/${PN}/plugins/android/resources/perfd/*/perfd
	opt/${PN}/plugins/android/resources/simpleperf/*/simpleperf
"

VER_CMP=( $(ver_rs 1- ' ') )
if [[ ${#VER_CMP[@]} -eq 7 ]]; then
	STUDIO_V=$(ver_cut 1-4)
	BUILD_V=$(ver_cut 6-7)
elif [[ ${#VER_CMP[@]} -eq 6 ]]; then
	STUDIO_V=$(ver_cut 1-4)
	BUILD_V=$(ver_cut 5-6)
else
	STUDIO_V=$(ver_cut 1-3)
	BUILD_V=$(ver_cut 4-5)
fi

MY_PN="${PN/-bin/}"

DESCRIPTION="The Official IDE for Android based on IntelliJ IDEA"
HOMEPAGE="https://developer.android.com/studio/index.html"
SRC_URI="https://dl.google.com/dl/android/studio/ide-zips/${STUDIO_V}/${MY_PN}-ide-${BUILD_V}-linux.zip"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
IUSE="kvm selinux system-jvm"
SLOT="0"

JAVA_SLOT="1.8"

DEPEND="app-arch/unzip"

RDEPEND="
	app-arch/bzip2
	dev-libs/expat
	>=dev-libs/libffi-3.0.13-r1
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	media-libs/mesa
	kvm? ( sys-fs/kvm )
	sys-libs/ncurses
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	>=x11-libs/libXdamage-1.1.4-r1
	x11-libs/libXdmcp
	>=x11-libs/libXext-1.3.2
	x11-libs/libXfixes
	x11-libs/libXrender
	>=x11-libs/libXxf86vm-1.1.3
	x11-libs/libdrm
	x11-libs/libxcb
	>=x11-libs/libxshmfence-1.1
	selinux? ( sec-policy/selinux-android )
	system-jvm? ( dev-java/oracle-jdk-bin:${JAVA_SLOT} )
"

S=${WORKDIR}/${MY_PN}

JAVA_PKG_NO_CLEAN=1
JAVA_PKG_FORCE_VM="dev-java/oracle-jdk-bin-${JAVA_SLOT}"

java_prepare() {
	# This is really a bundled jdk not a jre
	if use system-jvm; then
		 rm -R "${S}/jre" || die \
			"Could not remove bundled jdk posing as jre"
	fi
}

src_compile() {
:
}

src_install() {
	local dir jvm

	dir="/opt/${PN}"

	insinto "${dir}"

	# Replaced bundled jre with system vm/jdk
	if use system-jvm; then
		jvm="$(jem --select-vm=oracle-jdk-bin-${JAVA_SLOT} -O)"
		dosym "..${jvm/#\/opt/}" "${dir}/jre"
	fi

	doins -r *
	fperms 755 "${dir}/bin/studio.sh" "${dir}"/bin/fsnotifier{,64}
	chmod 755 "${D}${dir}"/gradle/gradle-*/bin/gradle || die

	newicon "bin/studio.png" "${PN}.png"
	make_wrapper ${PN} ${dir}/bin/studio.sh
	make_desktop_entry ${PN} "Android Studio" ${PN} "Development;IDE"
}
