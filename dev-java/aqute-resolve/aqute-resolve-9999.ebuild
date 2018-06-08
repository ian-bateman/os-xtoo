# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="bnd"
MY_PV="${PV}"
case ${PV} in
	*_pre) MY_PV="${MY_PV/_pre/.DEV}" ;;
	*_rc) MY_PV="${MY_PV/_rc/.RC}" ;;
	*) MY_PV+=".REL";;
esac
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="biz.aQute.${PN##*-}"

BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

OSGI_SLOT="5"

CP_DEPEND="~dev-java/aqute-repository-${PV}:${SLOT}
	~dev-java/bndlib-${PV}:${SLOT}
	dev-java/felix-resolver:0
	~dev-java/libg-${PV}:${SLOT}
	dev-java/osgi-compendium:${OSGI_SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="aQute Resolve"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
