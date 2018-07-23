# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils java-vm prefix

SLOT="${PV%%.*}"
[[ ${SLOT} == *_* ]] && SLOT="${PV%%_*}"

BASE_URI="https://download.java.net/java/"
JDK_URI="https://jdk.java.net/${SLOT}/"
RESTRICT="preserve-libs strip"

if [[ ${PV} == *_pre* ]]; then
	BASE_URI+="early_access/jdk${SLOT}/${PV##*_pre}/GPL"
	MY_PV="${PV%%_*}-ea+${PV##*_pre}"
elif [[ ${PV} == *_rc* ]]; then
	BASE_URI+="jdk${SLOT}/archive/${PV##*_rc}/GPL"
	MY_PV="${PV%%_*}+${PV##*_rc}"
else
	BASE_URI+="GA/jdk${SLOT}/${PV}/19aef61b38124481863b1413dce1855f/13"
	MY_PV="${PV}"
fi
if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/openjdk-${MY_PV}_linux-x64_bin.tar.gz"
	KEYWORDS="-* ~amd64"
else
	KEYWORDS="-amd64"
fi

DESCRIPTION="OpenJDK Development Kit"
HOMEPAGE="${JDK_URI}"
LICENSE="GPL-2-with-classpath-exception"

IUSE="alsa cups elibc_glibc +fontconfig headless-awt prefix selinux source"
QA_PREBUILT="*"

RDEPEND="
	!headless-awt? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrender
		x11-libs/libXtst
	)
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	fontconfig? ( media-libs/fontconfig:1.0 )
	!prefix? (
		dev-libs/elfutils
		elibc_glibc? ( sys-libs/glibc:* )
	)
	selinux? ( sec-policy/selinux-java )
	virtual/libelf
"

DEPEND="app-arch/zip"

S="${WORKDIR}/jdk"

check_tarballs_available() {
	local dl unavailable uri

	uri=$1; shift
	for dl in "${@}" ; do
		[[ ! -f "${DISTDIR}/${dl}" ]] && unavailable+=" ${dl}"
	done

	if [[ -n "${unavailable}" ]] ; then
		if [[ -z ${_check_tarballs_available_once} ]] ; then
			einfo
			einfo "Oracle requires you to download the needed files manually after"
			einfo "accepting their license through a javascript capable web browser."
			einfo
			_check_tarballs_available_once=1
		fi
		einfo "Download the following files:"
		for dl in ${unavailable}; do
			einfo "  ${dl}"
		done
		einfo "at '${uri}'"
		einfo "and move them to '${DISTDIR}'"
		einfo
		einfo "If the above mentioned urls do not point to the correct version anymore,"
		einfo "please download the files from Oracle's java download archive:"
		einfo
		einfo "http://www.oracle.com/technetwork/java/javase/archive-139210.html"
		einfo
	fi
}

#pkg_nofetch() {
#	local distfiles=( $(eval "echo \${$(echo AT_${ARCH/-/_})}") )
#	check_tarballs_available "${JDK_URI}" "${distfiles[@]}"
#}

src_unpack() {
	default
	mv "${WORKDIR}"/jdk* "${S}" || die "Failed to move/rename source dir"
}

src_prepare() {
	default
	if ! use alsa && [[ -f lib/libjsoundalsa.* ]]; then
		rm lib/libjsoundalsa.* \
			|| die "Failed to remove unwanted alsa support"
	fi

	if use headless-awt ; then
		rm lib/lib*{awt,splashscreen}* \
			|| die "Failed to remove unwanted UI support"
	fi

	if ! use source ; then
		rm lib/src.zip || die "Failed to remove unwanted src.zip"
	fi
}

src_install() {
	local dest ddest

	dest="/opt/${P}"
	ddest="${ED}${dest#/}"
	# Create files used as storage for system preferences.
#	mkdir .systemPrefs || die
#	touch .systemPrefs/.system.lock || die
#	touch .systemPrefs/.systemRootModFile || die

	dodoc -r legal
	dodir "${dest}"

	cp -pPR bin conf include jmods lib "${ddest}" || die

	# Prune all fontconfig files so libfontconfig will be used and only install
	# a Gentoo specific one if fontconfig is disabled.
	# http://docs.oracle.com/javase/8/docs/technotes/guides/intl/fontconfig.html
	if ! use fontconfig ; then
		cp "${FILESDIR}"/fontconfig.Gentoo.properties \
			"${T}"/fontconfig.properties \
			|| die "Failed to copy fontconfig.properties to tmp dir"
		eprefixify "${T}"/fontconfig.properties
		insinto "${dest}"/lib/
		doins "${T}"/fontconfig.properties
	fi

	# Remove empty dirs we might have copied.
	find "${D}" -type d -empty -exec rmdir -v {} + || die

	java-vm_install-env "${FILESDIR}/${PN}.env"
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}
