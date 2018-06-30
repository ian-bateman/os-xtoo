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
MY_MOD="biz.aQute.${PN}"

BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/ant-core:0
	~dev-java/aqute-remote-${PV}:${SLOT}
	~dev-java/aqute-repository-${PV}:${SLOT}
	~dev-java/aqute-resolve-${PV}:${SLOT}
	~dev-java/bnd-annotation-${PV}:${SLOT}
	~dev-java/bndlib-${PV}:${SLOT}
	~dev-java/libg-${PV}:${SLOT}
	dev-java/osgi-compendium:5
	dev-java/osgi-core-api:6
	dev-java/slf4j-api:0
	dev-java/slf4j-simple:0
	dev-java/snakeyaml:0
"

inherit java-pkg

DESCRIPTION="A swiss army knife for OSGi"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

java_prepare() {
	sed -i -e "s|table<Object|table<String|" \
		src/aQute/bnd/ant/BndTask.java \
		|| die "Failed to sed/fix type change"
}

src_install() {
	java-pkg_dolauncher "bnd" --main aQute.bnd.main.bnd
	java-pkg-simple_src_install
}
