# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="${PN/-ucode/}"
MY_P="${MY_PN}-${PV}"

BASE_PN="linux-firmware"
BASE_URI="git.kernel.org/pub/scm/linux/kernel/git/firmware/${BASE_PN}.git"

if [[ ${PV} == 9999* ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="git://${BASE_URI}"
	MY_S="${MY_PN}"
else
	GIT_COMMIT="ffdec3f6a5f29eb8a848b6a2417e0a1b45d32fcc"
#https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/ffdec3f6a5f29eb8a848b6a2417e0a1b45d32fcc.tar.gz
	SRC_URI="https://${BASE_URI}/snapshot/${GIT_COMMIT}.tar.gz -> ${BASE_PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}/${PN:0:4}"
fi

inherit savedconfig ${ECLASS}

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://${BASE_URI}"
LICENSE="GPL-1 GPL-2 GPL-3 BSD freedist"
SLOT="0"
IUSE="savedconfig"

DEPEND=""
#RDEPEND="( ! sys-kernel/linux-firmware )"
#add anything else that collides to this

S="${WORKDIR}/${MY_S}"

src_unpack() {
	if [[ ${PV} == 99999999* ]]; then
		git-3_src_unpack
	else
		default
		# rename directory from git snapshot tarball
		mv ${BASE_PN}-*/ ${MY_P} || die
	fi
}

src_prepare() {
	default
	echo "# Remove files that shall not be installed from this list." > ${PN}.conf
	find * \( \! -type d -and \! -name ${PN}.conf \) >> ${PN}.conf

	if use savedconfig; then
		restore_config ${PN}.conf
		ebegin "Removing all files not listed in config"
		find * \( \! -type d -and \! -name ${PN}.conf \) \
			| sort ${PN}.conf ${PN}.conf - \
			| uniq -u | xargs -r rm
		eend $? || die
		# remove empty directories, bug #396073
		find -type d -empty -delete || die
	fi
}

src_install() {
	if use !savedconfig; then
		save_config ${PN}.conf
	fi
	rm ${PN}.conf || die
	insinto /lib/firmware/${MY_PN}
	doins -r *
}

pkg_preinst() {
	if use savedconfig; then
		ewarn "USE=savedconfig is active. You must handle file collisions manually."
	fi
}

pkg_postinst() {
	elog "If you are only interested in particular firmware files, edit the saved"
	elog "configfile and remove those that you do not want."
}
