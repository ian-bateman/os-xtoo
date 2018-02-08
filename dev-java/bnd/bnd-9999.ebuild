# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.REL.tar.gz -> bnd-${PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="bnd-${PV}.REL"
fi

inherit java-pkg

DESCRIPTION="A swiss army knife for OSGi"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"
SLOT="$(get_major_version)"

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
	dev-java/slf4j-simple:0
	dev-java/snakeyaml:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/biz.aQute.${PN}"

JAVA_SRC_DIR="src/"

java_prepare() {
	sed -i -e "s|table<Object|table<String|" \
		src/aQute/bnd/ant/BndTask.java || die
}

src_install() {
	java-pkg_dolauncher "bnd" --main aQute.bnd.main.bnd
	java-pkg-simple_src_install
}
