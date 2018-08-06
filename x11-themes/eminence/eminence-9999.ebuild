# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="${BASE_URI}.git"
	inherit git-r3
else
	SRC_URI="
		elementary? ( ${BASE_URI}/releases/download/v${PV}/${PN}-elementary.edj -> ${PN}-elementary-${PV}.edj )
		terminology? ( ${BASE_URI}/releases/download/v${PV}/${PN}-terminology.edj -> ${PN}-terminology-${PV}.edj )
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}"
fi

DESCRIPTION="Eminence theme for Enlightement and/or Terminology"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

IUSE="+elementary +terminology"
REQUIRED_USE="|| ( elementary terminology )"

RDEPEND="
	elementary? ( dev-libs/efl )
	terminology? ( x11-terms/terminology )
"

src_unpack() {
	if [[ "${PV}" =~ 9999 ]]; then
		die "Live not implemented yet"
	fi
}

src_compile() {
	local do_nothing
}

src_install() {
	local u MY_USE
	MY_USE=( elementary terminology )
	for u in "${MY_USE[@]}"; do
		if use ${u}; then
			insinto "/usr/share/${u}/themes/"
			newins "${DISTDIR}/${PN}-${u}-${PV}.edj" "${PN}.edj"
		fi
	done
}
