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
MY_MOD="org.${PN//-/.}"

BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="OSGi Bundle Repository Indexer cli"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/args4j:0
	dev-java/osgi-compendium:4
	dev-java/osgi-core-api:4
	~dev-java/osgi-impl-bundle-repoindex-api-${PV}:${SLOT}
	~dev-java/osgi-impl-bundle-repoindex-lib-${PV}:${SLOT}
	dev-java/pojosr-framework:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
