# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="source"

MY_PN="bnd"
MY_PV="${PV}"
case ${PV} in
	*_pre) MY_PV="${MY_PV/_pre/.DEV}" ;;
	*_rc) MY_PV="${MY_PV/_rc/.RC}" ;;
	*) MY_PV+=".REL";;
esac
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Lots of small utilities for bnd, a swiss army knife for OSGi"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/osgi-util:0
	dev-java/slf4j-api:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/aQute.${PN}"

if [[ ${PV} == 3.3.0* ]]; then
	# Remove method that conflicts with super correct fix?
	PATCHES=( "${FILESDIR}/${PN}-${SLOT}-rm_remove.patch" )
fi

java_prepare() {
	sed -i -e "s|, List<T>||" src/aQute/lib/collections/SortedList.java \
		|| die "Failed to sed/fix inherits unrelated defaults"
}
