# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
case "${PV}" in
	*beta*)	MY_PV="${PV/_b/.B}" ;;
	*)	MY_PV="${PV}.Final" ;;
esac
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="A Modular Classloading System"
HOMEPAGE="http://${PN}.github.io/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	cp -r src/main/java{9/org/jboss/${PN##*-}/*,/org/jboss/${PN##*-}/} \
		|| die "Failed to copy over java9+ classes"
}
