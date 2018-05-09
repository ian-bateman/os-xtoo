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

inherit java-pkg

DESCRIPTION="aQute Repository"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

# Order matters, fails if libg is further down
CP_DEPEND="
	~dev-java/libg-${PV}:${SLOT}
	dev-java/aqute-jpm-clnt:0
	dev-java/aqute-services-services:0
	dev-java/aqute-services-struct:0
	~dev-java/bnd-annotation-${PV}:${SLOT}
	~dev-java/bndlib-${PV}:${SLOT}
	dev-java/osgi-annotation:0
	dev-java/osgi-compendium:6
	dev-java/osgi-core-api:6
	dev-java/osgi-impl-bundle-bindex:0
	~dev-java/osgi-impl-bundle-repoindex-api-${PV}:${SLOT}
	~dev-java/osgi-impl-bundle-repoindex-lib-${PV}:${SLOT}
	dev-java/osgi-util:0
	dev-java/slf4j-api:0
	dev-java/xz-java:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

if [[ ${PV} == 3.3.0* ]]; then
	JAVA_RM_FILES=( src/test )
fi
